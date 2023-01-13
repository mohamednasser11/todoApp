import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo2/services/notification_services.dart';
import 'package:todo2/services/theme_services.dart';
import 'package:todo2/ui/pages/home_page.dart';
import 'package:todo2/ui/theme.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().initializationNotification();
  NotifyHelper().requestingPermission();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      //NotificationScreen(payload: 'Notification|Title|DESC|12:00'),
    );
  }
}
