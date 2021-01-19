import 'dart:math';

import 'package:flutter/material.dart';

class ColorPalette {
  static final ColorPalette primary = ColorPalette(<Color>[
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.teal,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.tealAccent,
    Colors.purpleAccent,
    Colors.cyanAccent,
    Colors.pinkAccent,
  ]);

  ColorPalette(List<Color> colors) : _colors = colors {
    assert(colors.isNotEmpty);
  }

  final List<Color> _colors;

  Color operator [](int index) => _colors[index % length];

  int get length => _colors.length;

  Color random(Random random) => this[random.nextInt(length)];
}
