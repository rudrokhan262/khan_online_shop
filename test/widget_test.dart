import 'package:flutter_test/flutter_test.dart';

import 'package:khan_online_shop/main.dart';

void main() {
  testWidgets('Khan Commerce App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KhanCommerceApp());

    // Verify that login screen renders correctly.
    expect(find.text('Khan Commerce Limited'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
