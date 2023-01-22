import 'package:flutter/material.dart';
import 'package:policesystem/adminPanels/home_panel.dart';

// import 'component/admin_table_components.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Pick_panel());
}

class Pick_panel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => UserPanel(),
      },
    );
  }
}
