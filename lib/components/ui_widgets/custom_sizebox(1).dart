import 'package:flutter/material.dart';

import 'package:grs/di.dart';
import 'package:grs/helpers/dimension_helper.dart';
import 'package:grs/models/dummy/dimension.dart';

class SizeBoxHeight extends StatelessWidget {
  final Dimension dimension;
  const SizeBoxHeight({required this.dimension});

  @override
  Widget build(BuildContext context) => SizedBox(height: sl<DimensionHelper>().dimensionSizer(dimension));
}

class SizeBoxWidth extends StatelessWidget {
  final Dimension dimension;
  const SizeBoxWidth({required this.dimension});

  @override
  Widget build(BuildContext context) => SizedBox(width: sl<DimensionHelper>().dimensionSizer(dimension));
}
