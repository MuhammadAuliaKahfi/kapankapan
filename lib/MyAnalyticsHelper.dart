import 'package:firebase_analytics/firebase_analytics.dart';

class MyAnalyticsHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> testEventLog(_value) async {
    await analytics
        .logEvent(name: '${_value}_click', parameters: {'value': _value});

    print('send Event');
  }

  Future<void> testSetUserId() async {
    await analytics.setUserId(id: 'some-user');
    testEventLog("setUserId");
    print('setUserId succeeded');
  }

  Future<void> testSetUserProperty() async {
    await analytics.setUserProperty(name: 'regular', value: 'indeed');

    testEventLog("setUserProperty");

    print('setUserProperty succeeded');
  }
}
