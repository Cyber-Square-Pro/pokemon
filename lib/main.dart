import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/getit/getit.dart';
import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/providers/signup_provider.dart';
import 'package:app/shared_preferences_provider.dart';
import 'package:app/theme/dark/dark_theme.dart';
import 'package:app/theme/light/light_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/routes/router.dart' as router;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Making the statusbar transparent initially
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
        ],
        child: MaterialApp(
          title: 'Pokedex',
          builder: (context, child) {
            child = botToastBuilder(context, child);
            return child;
          },
          theme: lightTheme,
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          routes: router.Router.getRoutes(context),
          initialRoute: "/splash",
          onGenerateRoute: (settings) {
            final authProvider = Provider.of<AuthProvider>(context, listen: false);

            // Check if the user is authenticated
            if (!authProvider.isAuthenticated) {
              // If not authenticated, redirect to the login screen
              return MaterialPageRoute(
                builder: (context) =>
                    router.Router.getRoutes(context)[router.Router.login] as Widget,
              );
            }

            // If authenticated, allow access to the requested route
            return MaterialPageRoute(
              builder: (context) => router.Router.getRoutes(context)[router.Router.home] as Widget,
            );
          },
        ),
      ),
    );
  }
}
