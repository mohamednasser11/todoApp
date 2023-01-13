import 'package:flutter/material.dart';
import 'package:todo2/ui/size_config.dart';
import 'package:todo2/ui/theme.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            padding: const EdgeInsets.only(left: 5),
            margin: const EdgeInsets.only(top: 10, bottom: 8),
            height: 40,
            width: SizeConfig.screenWidth,
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  cursorColor: Get.isDarkMode ? Colors.black45 : Colors.black,
                  controller: controller,
                  autofocus: false,
                  style: subtitleStyle,
                  readOnly: widget != null ? true : false,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subtitleStyle,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 2)),
                  ),
                )),
                widget ?? Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
