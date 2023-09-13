import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_ducafecat_news_getx/common/langs/translation_service.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/pages.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'common/overlays/true_caller_overlay.dart';


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
      home: TrueCallerOverlay(),
    ),
  );
}

//启动图延时移除方法
void initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (c, w) => RefreshConfiguration(
        headerBuilder: () => ClassicHeader(),
        footerBuilder: () => ClassicFooter(),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80,
        maxOverScrollExtent: 100,
        footerTriggerDistance: 150,
        child: GetMaterialApp(
          title: 'News',
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
        ),
      ),
    );
  }
}
