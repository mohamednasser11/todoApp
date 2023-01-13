import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo2/controllers/task_controller.dart';
import 'package:todo2/services/notification_services.dart';
import 'package:todo2/services/theme_services.dart';
import 'package:todo2/ui/pages/add_task_page.dart';
import 'package:todo2/ui/size_config.dart';
import 'package:todo2/ui/theme.dart';
import 'package:todo2/ui/widgets/button.dart';
import 'package:todo2/ui/widgets/input_field.dart';
import '';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            const SizedBox(
              height: 6,
            ),
            _showTasks(),
          ],
        ));
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
          NotifyHelper()
              .displayNotification(title: 'ThemeChanged', body: 'NotifyBody');
        },
        icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
            color: Get.isDarkMode ? Colors.white : darkGreyClr),
      ),
      backgroundColor: context.theme.backgroundColor,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
        )
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () async {
                await Get.to(() => const AddTaskPage());

                // _taskController.getTask();
              })
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dayTextStyle: dateStyle,
        dateTextStyle: dayStyle,
        monthTextStyle: monthStyle,
        onDateChange: (newDate) => setState(() {
          _selectedDate = newDate;
        }),
      ),
    );
  }

  _showTasks() {
    return Expanded(child: _noTaskMSg()
        // child: Obx(() {
        //   if (_taskController.taskList.isEmpty) {
        //   } else {
        //     return Container(
        //       height: 0,
        //     );
        //   }
        // }),
        );
  }

  _noTaskMSg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(
                        height: 6,
                      )
                    : const SizedBox(
                        height: 120,
                      ),
                SvgPicture.asset(
                  'images/task.svg',
                  height: 90,
                  semanticsLabel: 'Task',
                  color: primaryClr.withOpacity(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "You don't have any tasks yet \nCreate new task..",
                    style: subHeadingStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
