import 'package:flutter/cupertino.dart';

class MarginWidget extends StatelessWidget {
  const MarginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

class SmallMarginWidget extends StatelessWidget {
  const SmallMarginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    );
  }
}
