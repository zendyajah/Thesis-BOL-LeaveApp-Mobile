import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository.dart';

import 'package:intl/intl.dart'; // Import the intl package

class ApplyProposalPage extends StatefulWidget {
  ApplyProposalPage({super.key});

  @override
  State<ApplyProposalPage> createState() => _ApplyProposalPageState();
}

class _ApplyProposalPageState extends State<ApplyProposalPage> {
  final _noteController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateFormat dateFormat = DateFormat(
      'EEE, d-MMM-yyyy'); // Date format for displaying the selected days
  int leaveCount = 0;
  String formattedStartDate = "";
  String formattedEndDate = "";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: _prefs,
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          String username = "";
          String id = "";
          String remainingLeave = "";
          if (snapshot.hasData) {
            final SharedPreferences prefs = snapshot.data!;
            id = prefs.getString('id') ?? '';
            username = prefs.getString('username') ?? '';
            remainingLeave = prefs.getString('remainingDaysOff') ?? '';
          }
          return Scaffold(
              appBar: AppBar(title: const Text("Apply Leave")),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText('Name :'),
                      TextField(
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        readOnly: true,
                        controller: TextEditingController(
                          text: username,
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      buildText('Note :'),
                      TextField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                            hintText: 'type something here',
                            border: OutlineInputBorder()),
                        maxLines: 10,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () async {
                            final DateTimeRange? dateTimeRange =
                                await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(DateTime.now().year),
                                    lastDate: DateTime(3000));
                            if (dateTimeRange != null) {
                              setState(() {
                                selectedDates = dateTimeRange;
                                // Retrieve leavecount
                                leaveCount = selectedDates.end
                                        .difference(selectedDates.start)
                                        .inDays +
                                    1;

                                // Retrieve startdate
                                DateTime startDate = selectedDates.start;
                                formattedStartDate =
                                    dateFormat.format(startDate);

                                // Retrieve enddate
                                DateTime endDate = selectedDates.end;
                                formattedEndDate = dateFormat.format(endDate);
                              });
                            }
                          },
                          child: const Text("Choose Dates")),

                      const SizedBox(height: 10),
                      Text(
                        "Remaining Leave: $remainingLeave",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text("Selected leave Days: $leaveCount"),

                      const SizedBox(height: 5),
                      Text(
                          "Start Day : $formattedStartDate"), // Display the selected start day
                      Text(
                          "End Day   : $formattedEndDate"), // Display the selected end day
                      const SizedBox(height: 10),
                      buildButton(
                          context,
                          id,
                          _noteController.text,
                          "create/",
                          leaveCount,
                          formattedStartDate,
                          formattedEndDate,
                          remainingLeave)
                    ],
                  )),
                ),
              ));
        });
  }
}

Widget buildText(String text) => Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
    );

Widget buildButton(
    BuildContext context,
    String userId,
    String note,
    String selectedSubmit,
    leaveCount,
    leaveStartDate,
    leaveEndDate,
    remainingLeave) {
  double screenWidth = MediaQuery.of(context).size.width;
  Repository repo = Repository();
  return ElevatedButton(
    onPressed: () async {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Are you sure you want to submit?"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                child: const Text("OK"),
                onPressed: () async {
                  if (leaveCount < int.parse(remainingLeave)) {
                    if (leaveCount != 0 &&
                        leaveStartDate != null &&
                        leaveEndDate != null) {
                      Navigator.of(dialogContext).pop();
                      bool response = await repo.postData(
                          userId,
                          note,
                          selectedSubmit,
                          leaveCount,
                          leaveStartDate,
                          leaveEndDate);

                      if (response == null) {
                        // ignore: use_build_context_synchronously
                        MotionToast.error(
                          title: const Text("Info"),
                          description: const Text("Submit Failed"),
                          position: MotionToastPosition.center,
                        ).show(context);
                      }
                      if (response) {
                        Navigator.of(context).popAndPushNamed('/mainpage');
                        // ignore: use_build_context_synchronously
                        MotionToast.success(
                          title: const Text("Info"),
                          description: const Text("Submit Successfully"),
                          position: MotionToastPosition.center,
                        ).show(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        MotionToast.error(
                          title: const Text("Info"),
                          description: const Text("Submit Failed"),
                          position: MotionToastPosition.center,
                        ).show(context);
                      }
                    } else {
                      MotionToast.error(
                        title: const Text("Info"),
                        description: const Text(
                            "Submit Failed, please check all required"),
                        position: MotionToastPosition.center,
                      ).show(context);
                    }
                  } else {
                    MotionToast.error(
                      title: const Text("Info"),
                      description: const Text("Submit Failed, leave limit"),
                      position: MotionToastPosition.center,
                    ).show(context);
                  }
                },
              ),
            ],
          );
        },
      );
    },
    style: ElevatedButton.styleFrom(
      minimumSize: Size(screenWidth, 40),
    ),
    child: const Text("SUBMIT"),
  );
}
