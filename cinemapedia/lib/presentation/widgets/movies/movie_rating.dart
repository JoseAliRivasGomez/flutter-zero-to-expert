import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {

  final double voteAverage; 
  final double popularity; 

  const MovieRating({
    super.key,
    required this.voteAverage, required this.popularity
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Icon(Icons.star_half_outlined, color: Colors.yellow.shade900),
          const SizedBox(width: 3),
          Text(HumanFormats.number(voteAverage, 1),
              style: textStyles.bodyMedium
                  ?.copyWith(color: Colors.yellow.shade900)),
          const Spacer(),
                Text(HumanFormats.number(popularity),
                    style: textStyles.bodySmall),
          
        ],
      ),
    );
  }
}
