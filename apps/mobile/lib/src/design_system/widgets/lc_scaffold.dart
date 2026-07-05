import 'package:flutter/material.dart';

/// Standard scaffold for the LifeCircle app.
class LcScaffold extends StatelessWidget {
  /// Creates an [LcScaffold].
  const LcScaffold({
    required this.body,
    this.appBar,
    super.key,
  });

  /// Optional app bar.
  final PreferredSizeWidget? appBar;

  /// Main body content.
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
