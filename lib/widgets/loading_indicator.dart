import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Loading Indicator Widget
/// 
/// Shows a circular progress indicator during page loading.
/// Uses iOS-style indicator for better platform consistency.
class LoadingIndicator extends StatelessWidget {
  final double progress;
  
  const LoadingIndicator({
    super.key,
    this.progress = 0.0,
  });
  
  @override
  Widget build(BuildContext context) {
    if (progress >= 1.0) {
      return const SizedBox.shrink();
    }
    
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress > 0 ? progress : null,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF2196F3),
            ),
          ),
          if (progress < 0.1)
            const Expanded(
              child: Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
