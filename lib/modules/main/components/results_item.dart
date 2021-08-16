import 'package:flutter/material.dart';

class ResultsItem extends StatelessWidget {
  final String missionName;
  final String? missionDetails;

  const ResultsItem({required this.missionName, required this.missionDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 3),
                  blurRadius: 3,
                  spreadRadius: 3)
            ]),
        child: Column(
          children: [
            Text(missionName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text(missionDetails ?? "No details", style: TextStyle(fontSize: 18))
          ],
        ));
  }
}
