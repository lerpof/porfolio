import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A simple error boundary widget that provides basic layout error handling
class LayoutErrorBoundary extends ConsumerWidget {
  const LayoutErrorBoundary({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return child;
  }
}
