import 'package:app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  testWidgets('Find', (tester) async {
    tester.pumpWidget(MyApp(prefs));
    expect(find.text('Pokedex By Team B'), findsOneWidget);
  });
}
