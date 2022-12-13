import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/constants/appcolors.dart';

import '../services/api_service.dart';

class GymDetailPage extends ConsumerStatefulWidget {
  GymDetailPage(
      {super.key,
      required this.gymID,
      required this.userID,
      required this.gymImage,
      required this.gymName});
  int userID;
  int gymID;
  String gymImage;
  String gymName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GymDetailPageState();
}

class _GymDetailPageState extends ConsumerState<GymDetailPage> {
  String requesText = 'Üye İsteği Yolla';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spor Salonu Detayı'),
        backgroundColor: AppColors.firstBlack,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.gymName,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.network(
                widget.gymImage,
                width: 300,
              ),
              ElevatedButton(
                onPressed: () async {
                  var bla = await api.sendRequest(widget.gymID, widget.userID);
                  setState(() {
                    bla == true
                        ? requesText = 'İstek Yollandı'
                        : requesText = 'İstek yollanmış';
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.primaryWhite,
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  requesText,
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
