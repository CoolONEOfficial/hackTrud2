import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hacktrud/components/bool_message.dart';
import 'package:hacktrud/components/file_message.dart';
import 'package:hacktrud/components/message/resume.dart';
import 'package:hacktrud/components/reply_message.dart';
import 'package:hacktrud/components/type_message.dart';
import 'package:hacktrud/types/message.dart';
import 'package:hacktrud/types/resume.dart';
import 'package:tuple/tuple.dart';

class ChatPage extends StatefulWidget {
  static const path = "/";

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Tuple2<dynamic, MessageFrom>> items = [];
  var textController = TextEditingController();
  var textInvalid = false;
  var sendingInProgress = false;
  var scrollController = ScrollController();

  @override
  void initState() {
    _addMessage(
      ResumeMessage((output) => _sendInput(context, output)),
      MessageFrom.Bot,
    );

    super.initState();
  }

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  Widget sizeIt(BuildContext context, int index, animation) {
    var item = items[items.length - 1 - index];
    var content = item.item1;
    var from = item.item2;
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.all(20.0).subtract(EdgeInsets.only(bottom: 20.0)),
        child: Row(
          mainAxisAlignment: from == MessageFrom.Me
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: rad,
                topRight: rad,
                bottomRight: from == MessageFrom.Bot ? rad : Radius.zero,
                bottomLeft: from == MessageFrom.Me ? rad : Radius.zero,
              ),
              child: content is MessageContent
                  ? Wrap(
                      direction: Axis.vertical,
                      spacing: 6,
                      runSpacing: 6,
                      children: content.buildMessageContent(),
                    )
                  : content as Widget,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lastMessage = items.last.item1;
    var replyable = lastMessage is Replyable ? lastMessage : null;
    var attachEnabled = replyable?.attachable ?? false;
    return PlatformScaffold(
      body: SafeArea(
        child: GestureDetector(
          onTapDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: buildAnimatedList(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom / 6 +
                      (MediaQuery.of(context).size.width < 500 ? 8.0 : 16.0),
                  top: MediaQuery.of(context).size.width < 500 ? 8.0 : 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAttachButton(context, attachEnabled),
                    Expanded(
                      child: buildReplyField(replyable),
                    ),
                    buildSendButton(replyable, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReplyField(Replyable replyable) {
    var enabled = replyable?.replyable ?? false;
    var hint = replyable?.hintText ?? "";
    var fillColor = enabled ? Colors.white : Color.fromRGBO(98, 98, 98, 1);
    return PlatformTextField(
      enabled: enabled,
      maxLines: 4,
      minLines: kIsWeb ? 4 : 2,
      controller: textController,
      material: (context, platform) {
        var border = OutlineInputBorder(
          borderSide: BorderSide(
            color: enabled
                ? Color.fromRGBO(238, 238, 238, 1)
                : Color.fromRGBO(98, 98, 98, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: rad,
            topLeft: rad,
            topRight: rad,
          ),
        );
        return MaterialTextFieldData(
          decoration: InputDecoration(
            errorText: textInvalid ? "Слишком мало текста" : null,
            border: border,
            disabledBorder: border,
            enabledBorder: border,
            filled: true,
            fillColor: fillColor,
            hintText: hint,
            hintStyle: TextStyle(
              color: Color.fromRGBO(153, 153, 153, 1.0),
            ),
          ),
          style: TextStyle(
            color: Colors.black,
          ),
        );
      },
      cupertino: (context, platform) => CupertinoTextFieldData(
        placeholder: hint,
        placeholderStyle: TextStyle(
          decorationColor: Color.fromRGBO(153, 153, 153, 1.0),
          fontWeight: FontWeight.w400,
          fontFamily: "ProximaNova",
          fontSize: 17,
        ),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.only(
            bottomLeft: rad,
            topLeft: rad,
            topRight: rad,
          ),
        ),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildAttachButton(BuildContext context, bool attachEnabled) =>
      PlatformIconButton(
        icon: Icon(Icons.attach_file),
        onPressed: attachEnabled
            ? () async {
                FilePickerResult result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['txt'],
                );
                if (result != null) {
                  var path = result.files.single.path;
                  var file = File(path);
                  _sendInput(context, file);
                }
              }
            : null,
      );

  Widget buildSendButton(Replyable replyable, BuildContext context) {
    var iconSize = Theme.of(context).iconTheme.size;
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      firstChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: PlatformCircularProgressIndicator(
            cupertino: (_, __) => CupertinoProgressIndicatorData(
              radius: iconSize / 2,
            ),
            material: (context, platform) => MaterialProgressIndicatorData(
              strokeWidth: 1,
            ),
          ),
        ),
      ),
      secondChild: PlatformIconButton(
        icon: Icon(
          Icons.send,
          size: Theme.of(context).iconTheme.size,
        ),
        onPressed: replyable != null
            ? () {
                var text = textController.text;
                if (replyable.textValidate(text)) {
                  textController.clear();
                  _sendInput(context, text);
                } else {
                  setState(() {
                    textInvalid = true;
                  });
                }
              }
            : null,
      ),
      crossFadeState: sendingInProgress
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }

  AnimatedList buildAnimatedList() => AnimatedList(
        key: listKey,
        reverse: true,
        initialItemCount: items.length,
        itemBuilder: sizeIt,
        controller: scrollController,
      );

  MessageContent get lastMessage =>
      items.map((i) => i.item1).lastWhere((i) => i is MessageContent);

  _sendInput(BuildContext context, input) async {
    Widget reply;
    if (input is Tuple2<ResumeType, String>) {
      var resumeType = input;
      reply = TypeMessage(resumeType.item1);
    } else
      switch (input.runtimeType) {
        case bool:
          reply = BoolMessage(input as bool);
          break;
        case String:
          reply = ReplyMessage(input as String);
          break;
        case File:
          var file = input as File;
          var path = file.path;
          reply = FileMessage(path.substring(path.lastIndexOf('/') + 1));
          break;
      }
    if (reply != null) {
      _addMessage(reply, MessageFrom.Me);
    }
    setState(() {
      sendingInProgress = true;
    });
    _addMessage(
      await lastMessage?.didInput(context, input),
      MessageFrom.Bot,
    );
    setState(() {
      sendingInProgress = false;
    });
  }

  static const rad = Radius.circular(10.0);

  _addMessage(dynamic content, MessageFrom from) {
    items.add(Tuple2(content, from));
    listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 200),
    );

    Timer(
      Duration(milliseconds: 320),
      () {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
    );
  }
}
