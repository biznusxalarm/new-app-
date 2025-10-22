import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.size = 16,
    this.color = AppColors.warning,
  });

  final double rating;
  final int starCount;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final stars = List<Widget>.generate(starCount, (index) {
      final starValue = index + 1;
      IconData icon;
      if (rating >= starValue) {
        icon = Icons.star;
      } else if (rating + 0.5 >= starValue) {
        icon = Icons.star_half;
      } else {
        icon = Icons.star_border;
      }
      return Icon(icon, size: size, color: color);
    });
    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
