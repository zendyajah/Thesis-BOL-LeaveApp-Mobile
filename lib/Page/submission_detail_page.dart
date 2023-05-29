import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:submission_application/repository.dart';

class SubmissionDetailPage extends StatefulWidget {
  const SubmissionDetailPage({super.key});

  @override
  State<SubmissionDetailPage> createState() => _SubmissionDetailPageState();
}

class _SubmissionDetailPageState extends State<SubmissionDetailPage> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String?>;
    if (args[1] == 'Not Yet Approved') {
      isVisible = true;
    }
    if (args[4] == '1') {
      isVisible = false;
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Submission Detail')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildText('Doc Date : '),
            TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              readOnly: true,
              controller:
                  TextEditingController(text: args[3]?.substring(0, 10)),
            ),
            buildText('No Document : '),
            TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                readOnly: true,
                controller: TextEditingController(text: args[0])),
            buildText('Document Status : '),
            TextField(
                style: TextStyle(color: Colors.red),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                readOnly: true,
                controller: TextEditingController(text: args[1])),
            buildText('Note :'),
            TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                readOnly: true,
                controller: TextEditingController(text: args[2])),
            const SizedBox(height: 10),
            Text("Selected leave Days: ${args[5]}"),

            const SizedBox(height: 10),
            Text("Start Day : ${args[6]}"), // Display the selected start day
            Text("End Day   : ${args[7]}"), // Display the selected end day
            Visibility(
                visible: isVisible,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: buildButton(
                    context, "APPROVE", Colors.blue, args[0]!, 'approve/')),
            Visibility(
                visible: isVisible,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: buildButton(
                    context, "REJECT", Colors.red, args[0]!, 'reject/')),
          ],
        )),
      ),
    );
  }

  Widget buildButton(BuildContext context, String txt, Color warna,
      String docid, String selectedSubmit) {
    double screenWidth = MediaQuery.of(context).size.width;
    Repository repo = Repository();
    return ElevatedButton(
      onPressed: () async {
        bool response = await repo.putData(docid, selectedSubmit);
        if (response) {
          isVisible = true;
          // ignore: use_build_context_synchronously
          Navigator.of(context).popAndPushNamed('/approvallistpage');
          // ignore: use_build_context_synchronously
          MotionToast.success(
            title: Text("INFO $docid"),
            description: Text("$txt SUCCESSFULLY"),
            position: MotionToastPosition.center,
          ).show(context);
        } else {
          isVisible = false;
          // ignore: use_build_context_synchronously
          Navigator.of(context).popAndPushNamed('/approvallistpage');
          // ignore: use_build_context_synchronously
          MotionToast.success(
            title: Text("INFO $docid"),
            description: Text("$txt FAILED"),
            position: MotionToastPosition.center,
          ).show(context);
        }
      },
      style: ElevatedButton.styleFrom(
          minimumSize: Size(screenWidth, 40), primary: warna),
      child: Text(txt),
    );
  }

  Widget buildText(String text) => Container(
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Text(text,
            style:
                const TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
      );
}
