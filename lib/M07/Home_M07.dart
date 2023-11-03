import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:M07/M07/AuthFirebase.dart';
import 'package:M07/M07/Login_Screen.dart';

class HomeM07 extends StatefulWidget {
  const HomeM07({super.key, required this.wid, this.email});
  final String? wid;
  final String? email;

  @override
  State<HomeM07> createState() => _HomeM07State();
}

class _HomeM07State extends State<HomeM07> {
  late AuthFirebase auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = AuthFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await auth.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            },
            icon: Icon(Icons.logout_sharp),
            tooltip: 'Logout',
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [Text("Welcome ${widget.email}"), Text("Id ${widget.wid}")],
        ),
      ),
    );
  }
}
