import 'package:get/get.dart';
import 'package:todo2/db/db_helper.dart';
import 'package:todo2/models/task.dart';

class TaskController extends GetxController {
  RxList<Task> taskList = <Task>[].obs;

//get data from database
  Future<void> getTask() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
  }

//delete data from database
  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTask();
  }

//update data from database
  void markAsCompleted(int id) async {
    await DBHelper.update(id);
    getTask();
  }

  Future<int> addTask({required Task task}) {
    return DBHelper.insert(task);
  }
}
