import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_missions/main.dart';

void main() {
  testWidgets("Initial main screen state", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final appBarTitle = find.text("SpaceX Missions");
    final textFieldLabel = find.text("Type your search query");

    expect(appBarTitle, findsOneWidget);
    expect(textFieldLabel, findsOneWidget);
  });
}
