import 'package:get/get.dart';
import 'package:todo2/models/task.dart';

class TaskController extends GetxController {
  final taskList = <Task>[
    Task(
        title: 'Title1',
        note: 'Note body',
        isCompleted: 0,
        startTime: '12:15',
        endTime: '12:30',
        color: 2),
    Task(
        title: 'Title3',
        note: '1Note body',
        isCompleted: 1,
        startTime: '12:15',
        endTime: '12:30',
        color: 1),
    Task(
        title: 'Title2',
        note: '2Note body',
        isCompleted: 0,
        startTime: '12:15',
        endTime: '12:30',
        color: 0)
  ];
  getTask() {}
}
