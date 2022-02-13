import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:parkline/Blocs/Application_Blocs.dart';
import 'package:parkline/Screens/Home2.dart';
import 'package:parkline/Screens/Home_Screen.dart';
import 'package:parkline/Screens/Log_And_Sign/login_screen.dart';
import 'package:parkline/Screens/status_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //initialisation de Firebase au demarage de l'app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    ChangeNotifierProvider(
      create: (context) => ApplicationBlocs(),
      child: 
      MaterialApp(
        title: 'ParkLine',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // supportedLocales: L10n.all,
        // localizationsDelegates: [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        home: StatutAuth(),
        // home: HomeScreen(),
        // home: HomeScreen2(),
        // home: FlutterZoomDrawerDemo(),
        // home: Home(),
        // home: LoginPage(),
      ),
    );
  }
}
