import 'dart:convert';

import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'http://192.168.1.2:5031/api/c/documents/';
  final _baseUrlLogin = 'http://192.168.1.2:5031/Account/loginmobile';

  Future postLogin(String userName, String password) async {
    String body = json.encode({'name': userName, 'password': password});
    try {
      final response = await http.post(
          Uri.parse('$_baseUrlLogin?name=$userName&password=$password'),
          headers: {"Content-Type": "application/json"},
          body: body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'LoginFailure';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String userId, String note, String selectedSubmit, leaveCount,
      startDate, endDate) async {
    String body = json.encode({
      'docId': "1",
      'note': note,
      'comment': "",
      'docStatus': "Not Yet Approved",
      "approvalId": "ApprovalDefault",
      "id": userId,
      "leaveCount": leaveCount,
      "startLeaveDate": startDate,
      "endLeaveDate": endDate
    });
    try {
      final response = await http.post(Uri.parse(_baseUrl + selectedSubmit),
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(String docId, String selectedSubmit) async {
    String body = json.encode({'docId': docId});

    try {
      final response = await http.put(
          Uri.parse(_baseUrl + selectedSubmit + Uri.encodeComponent(docId)),
          headers: {"Content-Type": "application/json"},
          body: body);
      if (response.statusCode == 200) {
        print(
            'Response ${response.statusCode} ${Uri.parse(_baseUrl + Uri.encodeComponent(docId))}');
        return true;
      } else {
        print(
            'Response ${response.statusCode} ${Uri.parse(_baseUrl + Uri.encodeComponent(docId))}');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
