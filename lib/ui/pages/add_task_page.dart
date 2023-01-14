import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo2/controllers/task_controller.dart';
import 'package:todo2/ui/theme.dart';
import 'package:todo2/ui/widgets/button.dart';
import 'package:todo2/ui/widgets/input_field.dart';

import '../../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedReminder = 5;
  List<int> reminderTimeList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                'Add Task',
                style: headingStyle,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter Title',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter Note',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate).toString(),
                widget: IconButton(
                  onPressed: () => _getDateFromUser(),
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Get.isDarkMode ? Colors.white : Colors.black45,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    title: 'Start Time',
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () => _getTimefromUser(isStartTime: true),
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Get.isDarkMode ? Colors.white : Colors.black45,
                      ),
                    ),
                  )),
                  Expanded(
                      child: InputField(
                    title: 'End Time',
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () => _getTimefromUser(isStartTime: false),
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Get.isDarkMode ? Colors.white : Colors.black45,
                      ),
                    ),
                  )),
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedReminder minutes early',
                widget: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: Colors.blueGrey,
                    items: reminderTimeList
                        .map<DropdownMenuItem<String>>(
                          (int e) => DropdownMenuItem(
                            value: e.toString(),
                            child: Text(
                              '$e',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 0,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedReminder = int.parse(value!);
                      });
                    }),
              ),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: Colors.blueGrey,
                    items: repeatList
                        .map<DropdownMenuItem<String>>(
                          (String e) => DropdownMenuItem(
                            value: e.toString(),
                            child: Text(
                              e,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 0,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedRepeat = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(
                    label: 'Create Task',
                    onTap: () {
                      _validateDate();
                      _taskController.getTask();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios, color: primaryClr),
      ),
      backgroundColor: context.theme.backgroundColor,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
        )
      ],
    );
  }

  Column _colorPallete() {
    return Column(
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
            direction: Axis.horizontal,
            children: List<Widget>.generate(
              3,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr,
                    radius: 14,
                    child: _selectedColor == index
                        ? const Icon(
                            Icons.done,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasksToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required', 'Please fill all the fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } else {
      print('#####SOMTHING BAD HAPPENED#####');
    }
  }

  _addTasksToDB() async {
    int value = await _taskController.addTask(
      task: Task(
          title: _titleController.text,
          note: _noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          color: _selectedColor,
          remind: _selectedReminder,
          repeat: _selectedRepeat),
    );
    print(value);
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      print('null Date Value');
    }
  }

  _getTimefromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String _formatedTime = _pickedTime!.format(context);
    if (isStartTime) {
      if (_pickedTime != null) {
        setState(() {
          _startTime = _formatedTime;
        });
      } else {
        print('null Date Value');
      }
    } else if (!isStartTime) {
      if (_pickedTime != null) {
        setState(() {
          _endTime = _formatedTime;
        });
      } else {
        print('null Date Value');
      }
    } else {
      print('###NO TIME SELECTED###');
    }
  }
}
