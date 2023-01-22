import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policesystem/adminPanels/home_panel.dart';
import 'package:policesystem/cashier/cashier_panel/cashier_panel.dart';
import 'package:policesystem/clerk/home.dart';
import 'package:policesystem/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  doWhenWindowReady(() {
    var initialSize = const Size(900, 620);
    appWindow.size = initialSize;
    appWindow.minSize = initialSize;
  });
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.aero,
    color: const Color.fromARGB(50, 0, 0, 0),
  );
  //This is for the window app effect i guess
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Police System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const MainPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = true;
  bool isLoggedIn = false;
  User? user;

  @override
  void initState() {
    setState(() {
      isLoggedIn = false;
    });
    checkUser();
    super.initState();
  }

  void checkUser() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedUser = prefs.getString('user');

    if (savedUser != null) {
      try {
        setState(() {
          user = User.fromJson(jsonDecode(savedUser));
          isLoggedIn = true;
        });
      } catch (_) {}
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (isLoggedIn && user != null) {
      if (user!.isAdmin) {
        return const UserPanel();
      } else if (user!.isCashier) {
        return const CashierPanel();
      } else {
        return const ClerkHome();
      }
    }
    return const HomePage();
  }
}
