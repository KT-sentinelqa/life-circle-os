import 'package:flutter/material.dart';

class LcScaffold extends StatelessWidget {
  const LcScaffold({super.key, this.appBar, required this.body});
  
  final PreferredSizeWidget? appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
