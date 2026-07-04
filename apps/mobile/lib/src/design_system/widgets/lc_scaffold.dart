import 'package:flutter/material.dart';

/// A standardized scaffold for LifeCircle OS following the design tokens.
class LcScaffold extends StatelessWidget {
  /// Creates an [LcScaffold].
  const LcScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    super.key,
  });

  /// The primary content of the scaffold.
  final Widget body;

  /// An optional app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// An optional floating action button to display in the scaffold.
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
