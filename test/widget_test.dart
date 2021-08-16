import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('TextScaleFactorClamper', () {
    double? effectiveTextScaleFactor;

    setUp(() {
      effectiveTextScaleFactor = 0;
    });

    Future<void> pumpWithTextScaleFactor(WidgetTester tester, double factor) {
      return tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(textScaleFactor: factor),
          child: TextScaleFactorClamper(
            child: Builder(builder: (context) {
              // Obtain the effective textScaleFactor in this context and assign
              // the value to a variable, so that we can check if it's what we
              // want.
              effectiveTextScaleFactor = MediaQuery.of(context).textScaleFactor;

              // We don't care about what's rendered, so let's just return the
              // most minimal widget we can.
              return const SizedBox.shrink();
            }),
          ),
        ),
      );
    }

    testWidgets('constrains the text scale factor to always be between 1.0-1.5',
        (tester) async {
      await pumpWithTextScaleFactor(tester, 5);
      expect(effectiveTextScaleFactor, 0.9);

      await pumpWithTextScaleFactor(tester, 0.1);
      expect(effectiveTextScaleFactor, 0.8);

      await pumpWithTextScaleFactor(tester, -5.0);
      expect(effectiveTextScaleFactor, 0.8);

      await pumpWithTextScaleFactor(tester, 1.25);
      expect(effectiveTextScaleFactor, 1.25);
    });
  });
}

class TextScaleFactorClamper extends StatelessWidget {
  const TextScaleFactorClamper({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final constrainedTextScaleFactor =
        mediaQueryData.textScaleFactor.clamp(0.8, 0.9);

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaleFactor: constrainedTextScaleFactor,
      ),
      child: child,
    );
  }
}