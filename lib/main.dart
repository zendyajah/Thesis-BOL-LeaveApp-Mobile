import 'package:flutter/material.dart';
import 'package:submission_application/Page/about_page.dart';
import 'package:submission_application/Page/approval_list_page.dart';
import 'package:submission_application/Page/my_submission_page.dart';
import 'package:submission_application/Page/submission_detail_page.dart';
import 'package:submission_application/model/documentsubmit.dart';
import 'Page/apply_proposal_page.dart';
import 'Page/login_page.dart';
import 'Page/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      initialRoute: '/loginpage',
      routes: {
        '/loginpage': (context) => const LoginPage(),
        '/mainpage': (context) => const MainPage(),
        '/applyproposalpage': (context) => ApplyProposalPage(),
        '/mysubmissionpage': (context) => MySubmissionPage(),
        '/approvallistpage': (context) => const ApprovalListPage(),
        '/detailpage': (context) => SubmissionDetailPage(),
        '/aboutpage': (context) => AboutPage()
      },
    );
  }
}
