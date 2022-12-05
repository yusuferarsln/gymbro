import 'package:flutter/material.dart';
import 'package:gymbro/models/gym_model.dart';

class GymTiles extends StatelessWidget {
  const GymTiles({super.key, required this.records, required this.index});

  final List<GymModel> records;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.network(
                  records[index].gymImage,
                  width: 75,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          records[index].gymName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(records[index].id.toString()),
                      ],
                    ),
                    Text(records[index].gymAddress)
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
