import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/getit/getit.dart';
import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/providers/favourites_provider.dart';
import 'package:app/shared/providers/otp_provider.dart';
import 'package:app/shared/providers/password_obscure_provider.dart';
import 'package:app/shared/providers/signup_provider.dart';
import 'package:app/shared/providers/timer_provider.dart';
import 'package:app/shared/utils/connectivity_wrapper.dart';
import 'package:app/shared_preferences_provider.dart';
import 'package:app/theme/dark/dark_theme.dart';
import 'package:app/theme/light/light_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/routes/router.dart' as router;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Making the statusbar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) async {
    WidgetsFlutterBinding.ensureInitialized();

    final initializer = MyAppInitializer();
    final prefs = await initializer.initialize();
    runApp(MyApp(prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    GetItRegister.register();

    final botToastBuilder = BotToastInit();

    return ThemeProvider(
      initTheme: prefs.getBool("darkTheme") ?? false ? darkTheme : lightTheme,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => SignupProvider()),
          ChangeNotifierProvider(create: (context) => OtpProvider()),
          ChangeNotifierProvider(create: (context) => TimerProvider()),
          ChangeNotifierProvider(create: (context) => ObscureProvider()),
          ChangeNotifierProvider(create: (context) => FavouritesProvider()),
        ],
        child: ScreenUtilInit(
          ensureScreenSize: true,
          designSize: const Size(400, 800),
          minTextAdapt: true,
          builder: (context, child) => Builder(
            builder: (context) {
              return ConnectivityWrapper(
                child: MaterialApp(
                  title: 'Pokedex By Team B',
                  builder: (context, child) {
                    child = botToastBuilder(context, child);

                    return child;
                  },
                  theme: lightTheme,
                  navigatorObservers: [BotToastNavigatorObserver()],
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
                  routes: router.Router.getRoutes(context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
