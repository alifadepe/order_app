import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:order_app/config/string_config.dart';
import 'package:order_app/config/theme_config.dart';
import 'package:order_app/di/injector.dart';
import 'package:order_app/ui/input_order/input_order_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjector();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.mainThemeData(),
      home: const InputOrderPage(),
    );
  }
}
