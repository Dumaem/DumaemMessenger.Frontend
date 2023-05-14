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

class Margin10 extends StatelessWidget {
  const Margin10({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}

class Margin20 extends StatelessWidget {
  const Margin20({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}

class Margin40 extends StatelessWidget {
  const Margin40({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 40);
  }
}
