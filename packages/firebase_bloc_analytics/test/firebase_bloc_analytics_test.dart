import 'dart:async';

import 'package:bloc_analytics/bloc_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_bloc_analytics/firebase_bloc_analytics.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  Tracker subject;
  FirebaseAnalytics analytics;

  setUp(() {
    analytics = MockFirebaseAnalytics();
    subject = FirebaseTracker(analytics);

    when(
      analytics.logEvent(
        name: anyNamed('name'),
        parameters: anyNamed('parameters'),
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    when(
      analytics.setCurrentScreen(
        screenName: anyNamed('screenName'),
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    when(
      analytics.setUserProperty(
        name: anyNamed('name'),
        value: anyNamed('value'),
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    when(
      analytics.setUserId(any),
    ).thenAnswer(
      (_) => Future.value(),
    );
  });

  test('logEvent', () {
    final event = AnalyticsEvent(
      eventName: 'test event',
      parameters: {'test parameter': 'value'},
    );

    subject.logEvent(event);

    verify(
      analytics.logEvent(
        name: 'test_event',
        parameters: {'test_parameter': 'value'},
      ),
    );
  });

  test('logPageView', () {
    final pageName = 'test';

    subject.logPageView(pageName);

    verify(analytics.setCurrentScreen(screenName: pageName));
  });

  test('setUserProperty', () {
    final property = 'key';
    final value = 'value';

    subject.setUserProperty(property, value);

    verify(analytics.setUserProperty(name: property, value: value));
  });

  test('setUserId', () {
    final id = '97e7d993-745a-455f-aeac-0d04d5f0a035';

    subject.setUserId(id);

    verify(analytics.setUserId(id));
  });
}
