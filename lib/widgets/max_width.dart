import 'package:flutter/material.dart';

/// Centres page content and caps how wide it grows.
///
/// Without this the layout stretches edge to edge on iPad, leaving a narrow
/// column of controls stranded in a very wide, mostly empty screen.
class MaxWidth extends StatelessWidget {
  const MaxWidth({super.key, required this.child, this.maxWidth = 640});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
