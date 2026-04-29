import 'dart:math';

import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sliderThemeData = SliderTheme.of(context).copyWith(trackHeight: 2.0);
  }

  Duration get _remaining => widget.duration - widget.position;

  void _emitChange(double value) {
    setState(() => _dragValue = value);
    widget.onChanged?.call(Duration(milliseconds: value.round()));
  }

  void _emitChangeEnd(double value) {
    widget.onChangeEnd?.call(Duration(milliseconds: value.round()));
    _dragValue = null;
  }

  @override
  Widget build(BuildContext context) {
    final maxMs = widget.duration.inMilliseconds.toDouble();
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: _HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: maxMs,
              value: min(widget.bufferedPosition.inMilliseconds.toDouble(), maxMs),
              onChanged: _emitChange,
              onChangeEnd: _emitChangeEnd,
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(inactiveTrackColor: Colors.transparent),
          child: Slider(
            min: 0.0,
            max: maxMs,
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(), maxMs),
            onChanged: _emitChange,
            onChangeEnd: _emitChangeEnd,
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch('$_remaining')
                    ?.group(1) ??
                '$_remaining',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}
