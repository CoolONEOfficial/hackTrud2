import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hacktrud/models/job_model.dart';
import 'package:hacktrud/types/resume.dart';
import 'package:http/http.dart' as http;

class NetworkProvider {
  static NetworkProvider shared = NetworkProvider();

  static const _baseUrl = "130.193.36.228:8000";

  Future<ResumeType> uploadResume(String resume) async {
    var queryParameters = {
      'input': resume,
    };
    var uri = Uri.http(_baseUrl, '/upload', queryParameters);
    var resp = await http.get(
      uri,
      headers: {
        HttpHeaders.acceptHeader: '*/*',
      },
    );

    if (resp.statusCode == HttpStatus.ok) {
      var json = jsonDecode(resp.body);
      var jobModel = JobModel.fromJson(json);
      return ResumeType.values.firstWhere(
        (r) => r.engName == jobModel.name,
      );
    } else {
      debugPrint("resp code ${resp.statusCode}");
      return null;
    }
  }
}
