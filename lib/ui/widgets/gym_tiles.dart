import 'package:flutter/material.dart';
import 'package:gymbro/constants/appcolors.dart';
import 'package:gymbro/extensions/context_extension.dart';
import 'package:gymbro/models/gym_model.dart';
import 'package:gymbro/ui/gym_detail_page.dart';

class GymTiles extends StatefulWidget {
  const GymTiles(
      {super.key,
      required this.records,
      required this.index,
      required this.userID});

  final List<GymModel> records;
  final int index;
  final int userID;

  @override
  State<GymTiles> createState() => _GymTilesState();
}

class _GymTilesState extends State<GymTiles> {
  String request = 'Send Request';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(GymDetailPage(
          gymID: widget.records[widget.index].id,
          userID: widget.userID,
          gymName: widget.records[widget.index].gymName,
          gymImage: widget.records[widget.index].gymImage,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: AppColors.thirdWhite,
          elevation: 10,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        widget.records[widget.index].gymImage,
                        width: 100,
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
                                widget.records[widget.index].gymName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.firstBlack),
                              ),
                              Text(
                                'No: ${widget.records[widget.index].id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Text(widget.records[widget.index].gymAddress),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
