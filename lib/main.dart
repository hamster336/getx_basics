import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_basics/models/local_storage.dart';
import 'package:getx_basics/models/note_controller.dart';
import 'package:getx_basics/models/select_controller.dart';
import 'package:getx_basics/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await LocalStorage.init();
  Get.put(NotesController());
  Get.put(SelectController());
  Get.put(SearchController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Home(),
      theme: ThemeData(
        // primaryColor: Colors.orange,
        useMaterial3: true,
        appBarTheme: AppBarThemeData(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
