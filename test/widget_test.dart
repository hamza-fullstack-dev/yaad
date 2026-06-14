import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yaad/app.dart';

void main() {
  testWidgets('YaadApp renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: YaadApp()),
    );
    await tester.pumpAndSettle();
  });
}
