import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular(
      {this.width = double.infinity, this.height = double.infinity})
      : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular(
      {this.width = double.infinity,
      this.height = double.infinity,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
