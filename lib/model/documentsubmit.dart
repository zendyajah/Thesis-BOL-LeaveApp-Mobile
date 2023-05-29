// To parse this JSON data, do
//
//     final documentSubmit = documentSubmitFromJson(jsonString);

import 'dart:convert';

List<DocumentSubmit> documentSubmitFromJson(String str) =>
    List<DocumentSubmit>.from(
        json.decode(str).map((x) => DocumentSubmit.fromJson(x)));

String documentSubmitToJson(List<DocumentSubmit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DocumentSubmit {
  final String? docId;
  final String? note;
  final String? comment;
  final String? docStatus;
  final String? approvalId;
  final DateTime dateCreated;
  final String? approvedId;
  final dynamic? approvedItem;
  final int? id;
  final UserDb? userDb;
  final int? leaveCount;
  final String? startLeaveDate;
  final String? endLeaveDate;

  DocumentSubmit(
      {required this.docId,
      required this.note,
      required this.comment,
      required this.docStatus,
      required this.approvalId,
      required this.dateCreated,
      required this.approvedId,
      required this.approvedItem,
      required this.id,
      required this.userDb,
      required this.leaveCount,
      required this.startLeaveDate,
      required this.endLeaveDate});

  factory DocumentSubmit.fromJson(Map<String, dynamic> json) => DocumentSubmit(
      docId: json["docId"],
      note: json["note"],
      comment: json["comment"],
      docStatus: json["docStatus"],
      approvalId: json["approvalId"],
      dateCreated: DateTime.parse(json["dateCreated"]),
      approvedId: json["approvedId"],
      approvedItem: json["approvedItem"],
      id: json["id"],
      userDb: UserDb.fromJson(json["userDb"]),
      leaveCount: json["leaveCount"],
      startLeaveDate: json["startLeaveDate"],
      endLeaveDate: json["endLeaveDate"]);

  Map<String, dynamic> toJson() => {
        "docId": docId,
        "note": note,
        "comment": comment,
        "docStatus": docStatus,
        "approvalId": approvalId,
        "dateCreated": dateCreated,
        "approvedId": approvedId,
        "approvedItem": approvedItem,
        "id": id,
        "userDb": userDb?.toJson(),
      };
}

class UserDb {
  final int id;
  final String email;
  final String name;
  final String userRoleId;

  UserDb({
    required this.id,
    required this.email,
    required this.name,
    required this.userRoleId,
  });

  factory UserDb.fromJson(Map<String, dynamic> json) => UserDb(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        userRoleId: json["userRoleId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "userRoleId": userRoleId,
      };
}












// class DocumentSubmit {
//   late String DocId;
//   late String RequesterId;
//   late String Note;
//   late String DocType;
//   late String DocStatus;
//   late String ApprovalId;
//   late DateTime dateCreated;

//   DocumentSubmit({
//     required this.DocId,
//     required this.RequesterId,
//     required this.Note,
//     required this.DocType,
//     required this.DocStatus,
//     required this.ApprovalId,
//     required this.dateCreated,
//   });
// }

// List<DocumentSubmit> listDoc = [
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/01',
//       RequesterId: 'U0001',
//       Note: 'Note1',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-01")),
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/02',
//       RequesterId: 'U0002',
//       Note: 'Note2',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-02")),
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/03',
//       RequesterId: 'U0003',
//       Note: 'Note3',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-03")),
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/03',
//       RequesterId: 'U0003',
//       Note: 'Note3',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-03")),
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/03',
//       RequesterId: 'U0003',
//       Note: 'Note3',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-03")),
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/03',
//       RequesterId: 'U0003',
//       Note: 'Note3',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-03")),
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/03',
//       RequesterId: 'U0003',
//       Note: 'Note3',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-03")),
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/03',
//       RequesterId: 'U0003',
//       Note: 'Note3',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-03")),
//   DocumentSubmit(
//       DocId: 'DOC001/2023/01/03',
//       RequesterId: 'U0003',
//       Note: 'Note3',
//       DocType: 'CUTI',
//       DocStatus: 'Not Yet Approved',
//       ApprovalId: 'APPROVAL_1',
//       dateCreated: DateTime.parse("2022-01-03")),
// ];
