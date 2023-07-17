import 'package:device_preview/device_preview.dart';
import 'package:dtt/logic/navigation_providers/navigation_provider.dart';
import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/ui/screens/extra_views/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'logic/info_scr_providers/info_screen_provider.dart';
import 'model/overview_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(OverviewModelAdapter());
  await Hive.openBox('systemPreferences');
  await Hive.openBox<OverviewModel>('DttAppBox');
  await Hive.openBox<OverviewModel>('Favorites');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('nl', 'NL'),
          Locale('es', 'ES')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => const DTTApp(),
        ),
      )));
}

class DTTApp extends StatelessWidget {
  const DTTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (context) => NavigationProvider(),
        ),
        ChangeNotifierProvider<InfoProvider>(
          create: (context) => InfoProvider(),
        ),
        ChangeNotifierProvider<ParentProvider>(
          create: (context) => ParentProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          Provider.of<ParentProvider>(context).themeSwitchCaller();
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: Provider.of<ParentProvider>(context).themePreference
                ? ThemeData.dark(useMaterial3: true)
                : ThemeData.light(useMaterial3: true),
            home: const Splash(),
          );
        },
      ),
    );
  }
}
