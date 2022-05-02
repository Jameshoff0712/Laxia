import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:laxia/provider/question_provider.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'models/m_settings.dart';
import 'routes.dart';
import 'services/geolocation-service.dart';
import 'services/settings_service.dart' as settingRepo;
import 'package:global_configuration/global_configuration.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized(); //async program
  await GlobalConfiguration().loadFromAsset("configurations");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
      ChangeNotifierProvider<SurGeryProvider>.value(value: SurGeryProvider()),
      ChangeNotifierProvider<QuestionProvider>.value(value: QuestionProvider()),
    ], child: MyApp()));
  }); //lotation stop
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    settingRepo.initSettings();
    super.initState();
  }

  Future<bool> checkIsFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("seen")) {
      return true;
    } else {
      prefs.setBool("seen", true);
      return false;
    }
  }

  final locationService = GeoLocationService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => locationService.getLocation(),
      initialData: 0,
      child: ValueListenableBuilder(
        valueListenable: settingRepo.setting,
        builder: (context, Setting _setting, _) {
          return MaterialApp(
            theme: ThemeData(fontFamily: 'Hiragino Kaku Gothic Pro W6'),
            navigatorKey: settingRepo.navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: '/pages',
            onGenerateRoute: RouteGenerator.generateRoute,
            locale: _setting.mobileLanguage.value,
            localizationsDelegates: const [
              Trans.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: Trans.delegate.supportedLocales,
            title: Helper.appTitle,
          );
        },
      ),
    );
  }
}
