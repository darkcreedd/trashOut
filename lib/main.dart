import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash_out/config/router.dart';
import 'package:trash_out/firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) => MaterialApp.router(
        themeMode: ThemeMode.system,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Sen',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Sen',
              fontSize: 22.sp,
            ),
          ),
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        routerConfig: RouterConfig(
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider),
      ),
    );
  }
}
