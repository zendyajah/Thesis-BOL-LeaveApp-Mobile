import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/documentsubmit_bloc.dart';
import '../model/documentsubmit.dart';

class MySubmissionPage extends StatefulWidget {
  const MySubmissionPage({super.key});

  @override
  State<MySubmissionPage> createState() => _MySubmissionPageState();
}

class _MySubmissionPageState extends State<MySubmissionPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String _apiUrl = "http://192.168.1.2:5031/api/c/documents/";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: _prefs,
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            final SharedPreferences prefs = snapshot.data!;
            final String id = prefs.getString('id') ?? '';

            _apiUrl = _apiUrl + id;
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return BlocProvider(
            create: (context) =>
                DocumentsubmitBloc(_apiUrl)..add(GetDocumentEvent()),
            child: Scaffold(
                appBar: AppBar(title: const Text("My Submission List")),
                body: BlocBuilder<DocumentsubmitBloc, DocumentsubmitState>(
                  builder: (context, state) {
                    if (state is DocumentLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DocumentSuccess) {
                      return ListView.builder(
                          itemCount: state.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSubmit docSubmit = state.documents[index];
                            return MyListView(docSubmit: docSubmit);
                          });
                    }

                    return const Center(
                      child: Text('No Data'),
                    );
                  },
                )),
          );
        });
  }
}

class MyListView extends StatelessWidget {
  final DocumentSubmit docSubmit;
  const MyListView({required this.docSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.amber[50],
      child: InkWell(
        onTap: () {
          Navigator.of(context).popAndPushNamed('/detailpage', arguments: [
            docSubmit.docId,
            docSubmit.docStatus,
            docSubmit.note,
            docSubmit.dateCreated.toString(),
            "1",
            docSubmit.leaveCount.toString(),
            docSubmit.startLeaveDate,
            docSubmit.endLeaveDate
          ]);
        },
        child: Stack(
          children: [
            SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(DateFormat.yMd()
                            .add_jm()
                            .format(docSubmit.dateCreated)
                            .toString())
                      ],
                    )
                  ],
                )),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                          ),
                          const Icon(Icons.person_outline_outlined),
                          buildText(docSubmit.userDb!.name)
                        ],
                      )),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          const Icon(Icons.analytics_outlined),
                          buildTextChild('Document Id: ${docSubmit.docId}')
                        ],
                      )),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          const Icon(Icons.analytics_outlined),
                          buildText('Status: ${docSubmit.docStatus}')
                        ],
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                          ),
                          const Icon(
                            Icons.notes_outlined,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 70,
                            child: buildText('${docSubmit.note}'),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text) => Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        maxLines: 1,
        softWrap: false,
      );

  Widget buildTextChild(String text) => Text(
        text,
        style: const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 14),
      );
}
