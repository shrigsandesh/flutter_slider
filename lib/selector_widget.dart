import 'package:flutter/material.dart';

class SelectorWidget extends StatefulWidget {
  const SelectorWidget(
      {super.key, required this.initialWidth, required this.height});
  final double initialWidth;
  final double height;

  @override
  State<SelectorWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  final Color borderColor = Colors.orange;

  late var _containerWidth = widget.initialWidth;
  final double _minWidth = 60;
  late double _maxWidth = widget.initialWidth;
  double _left = 0;
  bool _draggingFromLeft = false;

  void _updateWidth(DragUpdateDetails details, [bool fromLeftToright = false]) {
    if (fromLeftToright) {
      setState(() {
        // Reduce the width based on the drag distance
        _draggingFromLeft = true;
        _containerWidth -= details.delta.dx;
        _left += details.delta.dx;
        _maxWidth -= details.delta.dx;
        // Clamp the width to a minimum value
        if (_containerWidth < _minWidth) {
          _containerWidth = _minWidth;
        }
        // Clamp the width to a minimum value
        if (_containerWidth.toInt() > _maxWidth) {
          _containerWidth = _maxWidth;
        }
      });
    }

    setState(() {
      // Reduce the width based on the drag distance
      if (details.delta.dx < 0 || _containerWidth < _maxWidth) {
        _containerWidth += details.delta.dx;
        // Clamp the width to a minimum value
        if (_containerWidth < _minWidth) {
          _containerWidth = _minWidth;
        }
        // Clamp the width to a minimum value
        if (_containerWidth.toInt() > _maxWidth) {
          _containerWidth = _maxWidth;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: _draggingFromLeft
              ? EdgeInsets.only(left: _left.isNegative ? 0 : _left)
              : null,
          width: _containerWidth,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border(
                left: BorderSide(color: borderColor, width: 20),
                right: BorderSide(color: borderColor, width: 20),
                top: BorderSide(color: borderColor, width: 2),
                bottom: BorderSide(color: borderColor, width: 2)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned(
          left: _left.isNegative ? 0 : _left,
          top: widget.height / 2 - 12,
          child: GestureDetector(
            onHorizontalDragUpdate: (dragdetails) =>
                _updateWidth(dragdetails, true),
            child: const Icon(
              Icons.chevron_left,
              size: 24,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: widget.height / 2 - 12,
          child: GestureDetector(
            onHorizontalDragUpdate: _updateWidth,
            child: const Icon(
              Icons.chevron_right,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
