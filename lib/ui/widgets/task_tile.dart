import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo2/ui/size_config.dart';

import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      child: Container(
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
        child: Container(
          child: Row(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(task.title!),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${task.startTime} - ${task.endTime}',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(task.note!),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(task.isCompleted == 0 ? 'TODO' : 'Completed',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
