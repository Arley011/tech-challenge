import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.isLoading = false,
    required this.child,
    this.isError = false,
    this.onRetry,
  });

  final bool isLoading;
  final bool isError;
  final VoidCallback? onRetry;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Opacity(
          opacity: isLoading || isError ? 0.5 : 1.0,
          child: child,
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
        else if (isError)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Something went wrong',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                if (onRetry != null)
                  TextButton(
                    onPressed: onRetry,
                    child: const Text('Retry'),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
