import 'package:flutter/material.dart';

class Menu {
  String title;
  Icon myicon;
  String myurl;
  Menu({required this.title, required this.myicon, required this.myurl});
}

List<Menu> menuList = [
  Menu(
      title: 'Apply Leave',
      myicon: const Icon(
        Icons.subject,
        color: Colors.lightBlue,
        size: 60.0,
      ),
      myurl: "/applyproposalpage"),
  Menu(
      title: 'Approval List',
      myicon: const Icon(
        Icons.approval,
        color: Colors.red,
        size: 60.0,
      ),
      myurl: "/approvallistpage"),
  Menu(
      title: 'My Submission',
      myicon: const Icon(
        Icons.subject,
        color: Colors.lightBlue,
        size: 60.0,
      ),
      myurl: "/mysubmissionpage"),
  Menu(
      title: 'About',
      myicon: const Icon(
        Icons.subject,
        color: Colors.lightBlue,
        size: 60.0,
      ),
      myurl: "/aboutpage"),
];
