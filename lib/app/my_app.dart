import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../core/enum/connectivity_status.dart';
import '../core/translation/app_translation.dart';
import '../ui/shared/utils.dart';
import '../ui/views/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
        create: (context) =>
            connectivityService.connectivityStatusController.stream,
        initialData: ConnectivityStatus.ONLINE,
        child: GetMaterialApp(
            defaultTransition: GetPlatform.isAndroid
            ? Transition.fadeIn
            : Transition.cupertino,
            transitionDuration: Duration(milliseconds: 300),
            translations: AppTranslation(),
            locale: getLocal(),
            fallbackLocale: getLocal(),
            builder: BotToastInit(), //1. call BotToastInit
            navigatorObservers: [BotToastNavigatorObserver()], //2
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: SplashScreenView()));
  }
}

Locale getLocal() {
  if (storage.getAppLanguage() == 'ar') {
    return Locale('ar', 'SA');
  } else {
    return Locale('en', 'US');
  }
}
