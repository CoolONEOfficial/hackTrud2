import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
  var scrollController = ScrollController();

  @override
  void initState() {
    _addMessage(ResumeMessage((output) => _sendInput(context, output)),
        MessageFrom.Bot);

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
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: from == MessageFrom.Me
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              width: min(340, MediaQuery.of(context).size.width / 5 * 4),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: rad,
                  topRight: rad,
                  bottomRight: from == MessageFrom.Bot ? rad : Radius.zero,
                  bottomLeft: from == MessageFrom.Me ? rad : Radius.zero,
                ),
                child: content is MessageContent
                    ? Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: content.buildMessageContent(),
                      )
                    : content as Widget,
              ),
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
          child: attachEnabled
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: buildAnimatedList(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 8.0,
                        left: attachEnabled ? 0.0 : 12.0,
                      ),
                      child: Row(
                        children: [
                          PlatformIconButton(
                            icon: Icon(Icons.attach_file),
                            onPressed: () async {
                              FilePickerResult result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['txt'],
                              );
                              if (result != null) {
                                var path = result.files.single.path;
                                var file = File(path);
                                _sendInput(context, file);
                              }
                            },
                          ),
                          Expanded(
                            child: PlatformTextField(
                              maxLines: 4,
                              minLines: 2,
                              controller: textController,
                              material: (context, platform) =>
                                  MaterialTextFieldData(
                                decoration: InputDecoration(
                                  hintText: replyable.hintText,
                                ),
                              ),
                              cupertino: (context, platform) =>
                                  CupertinoTextFieldData(
                                placeholder: replyable.hintText,
                                placeholderStyle: TextStyle(
                                  decorationColor:
                                      Color.fromRGBO(153, 153, 153, 1.0),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "ProximaNova",
                                  fontSize: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                            ),
                          ),
                          PlatformIconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              var text = textController.text;
                              if (replyable.textValidate(text)) {
                                textController.clear();
                                _sendInput(context, text);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : buildAnimatedList(),
        ),
      ),
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
    switch (input.runtimeType) {
      case ResumeType:
        var resumeType = input as ResumeType;
        reply = TypeMessage(resumeType);
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
    _addMessage(await lastMessage?.didInput(context, input), MessageFrom.Bot);
  }

  static const rad = Radius.circular(10.0);

  _addMessage(dynamic content, MessageFrom from) {
    items.add(Tuple2(content, from));
    listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 200),
    );

    Timer(
      Duration(milliseconds: 200),
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      },
    );
  }
}
