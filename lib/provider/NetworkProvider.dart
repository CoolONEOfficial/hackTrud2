import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hacktrud/models/answer_model.dart';
import 'package:hacktrud/models/job_model.dart';
import 'package:hacktrud/models/question_model.dart';
import 'package:hacktrud/types/resume.dart';
import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';

class NetworkProvider {
  static NetworkProvider shared = NetworkProvider();

  static const _baseUrl = "130.193.36.228:8000";

  Dio dio;

  NetworkProvider() {
    dio = Dio();
    dio.options.baseUrl = "http://130.193.36.228:8000/";
    dio.options.headers = {
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: ContentType.json.value,
    };
  }

  Future<Tuple2<ResumeType, String>> uploadResume(String resume) async {
    Map<String, String> query = {'input': resume};
    var resp = await dio.get(
      "upload",
      queryParameters: query,
    );

    if (resp.statusCode == HttpStatus.ok) {
      var json = resp.data;
      var jobModel = JobModel.fromJson(json);
      return Tuple2(
        ResumeType.values.firstWhere(
          (r) => r.engName == jobModel.name,
        ),
        jobModel.udpipeName,
      );
    } else {
      debugPrint("resp code ${resp.statusCode}");
      return null;
    }
  }

  Future<List<QuestionModel>> getQuestions(
    String modelName,
    String udpipeName,
  ) async {
    Map<String, String> body = {
      'modelName': modelName,
      'udpipeName': udpipeName,
    };
    var resp = await dio.post(
      "model",
      data: body,
    );

    if (resp.statusCode == HttpStatus.ok) {
      var json = resp.data;
      var jobModel =
          json.map<QuestionModel>((e) => QuestionModel.fromJson(e)).toList();
      return jobModel;
    } else {
      debugPrint("resp code ${resp.statusCode}");
      return null;
    }
  }

  Future saveQuestions(List<AnswerModel> answerList) async {
    Map<String, dynamic> body = {
      'answers': answerList.map((e) => e.toJson()).toList(),
    };
    var resp = await dio.put(
      "model",
      data: body,
    );

    if (resp.statusCode == HttpStatus.ok) {
      var json = resp.data;
      var jobModel = json.map((e) => QuestionModel.fromJson(e)).toList();
      return jobModel;
    } else {
      debugPrint("resp code ${resp.statusCode}");
      return null;
    }
  }
}
