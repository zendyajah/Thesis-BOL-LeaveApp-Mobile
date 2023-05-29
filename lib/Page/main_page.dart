import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: FutureBuilder(
          future: _prefs,
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            if (snapshot.hasData) {
              final SharedPreferences prefs = snapshot.data!;
              final String username = prefs.getString('username') ?? '';
              final String id = prefs.getString('id') ?? '';
              final String userRoleId = prefs.getString('userRoleId') ?? '';
              return Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: buildText('Welcome, $username')),
                  Expanded(
                      child: GridView.builder(
                          itemCount: menuList.length,
                          itemBuilder: (context, index) {
                            Menu menu = menuList[index];
                            return MyMenu(
                                title: menu.title,
                                icon: menu.myicon,
                                colorf: Colors.blue,
                                menu: menu,
                                userRoleId: userRoleId);
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1 / 1,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20))),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildText(String text) => Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      );
}

class MyMenu extends StatelessWidget {
  final Menu menu;
  final String userRoleId;
  const MyMenu(
      {super.key,
      required this.title,
      required this.icon,
      required this.colorf,
      required this.menu,
      required this.userRoleId});

  final String title;
  final Icon icon;
  final MaterialColor colorf;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0.0),
      child: InkWell(
        onTap: () {
          if (menu.myurl == "/approvallistpage" && userRoleId == "User") {
            MotionToast.warning(
              title: const Text("Warning"),
              description: const Text("no access, only admin"),
              position: MotionToastPosition.center,
            ).show(context);
          } else {
            Navigator.of(context).pushNamed(menu.myurl);
          }
        },
        splashColor: Colors.amber,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon,
            Text(
              title,
              style: TextStyle(fontSize: 17.0),
            )
          ],
        )),
      ),
    );
  }
}
