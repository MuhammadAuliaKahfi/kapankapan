import 'package:flutter/material.dart';
import 'package:M07/MyAnalyticsHelper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();
    return Scaffold(
      appBar: AppBar(
        title: Text("Working With Analytics"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      fbAnalytics.testEventLog('send_event');
                    },
                    child: Text("Send Event")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      fbAnalytics.testEventLog('send_property');
                    },
                    child: Text("Send Property")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      fbAnalytics.testEventLog('send_error');
                    },
                    child: Text("Send Error")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      fbAnalytics.testSetUserId();
                    },
                    child: Text("Send User Id")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
