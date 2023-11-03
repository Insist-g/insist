import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_ducafecat_news_getx/common/langs/translation_service.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/pages.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'common/widgets/overlay.dart';

Future<void> main() async {
  await Global.init();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initialization(null);
  runApp(MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverLayView(),
    ),
  );
}

//启动图延时移除方法
void initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      translations: TranslationService(),
      navigatorObservers: [AppPages.observer],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: ConfigStore.to.languages,
      locale: ConfigStore.to.locale,
      fallbackLocale: Locale('en', 'US'),
      enableLog: true,
      logWriterCallback: write,
    );
  }
}
