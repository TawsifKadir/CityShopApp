import 'package:flutter/material.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/constants/colors.dart';

class CustomRefreshContainer extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefreshContainer({
    required this.onRefresh, required this.child, Key? key,
  }) : super(key: key);

  @override
  _CustomRefreshContainerState createState() => _CustomRefreshContainerState();
}

class _CustomRefreshContainerState extends State<CustomRefreshContainer> {
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    try {
      await widget.onRefresh();
    } finally {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content with RefreshIndicator
        RefreshIndicator(
          onRefresh: _handleRefresh,
          child: widget.child,
        ),

        // Disable interaction with background during refresh
        if (_isRefreshing)
          Positioned.fill(
            child: AbsorbPointer(
              child: Container(
                width: SizeConfig.width,
                height: SizeConfig.height,
                alignment: Alignment.center,
                color: white.withOpacity(0.6),
              ),
            ),
          ),
      ],
    );
  }
}
