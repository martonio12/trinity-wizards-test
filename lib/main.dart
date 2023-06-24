import 'package:flutter/material.dart';
import 'package:trinity_wizards_test/contact_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Color(0xFFff8c00),
          ),
          color: Colors.white,
        ),
      ),
      title: 'Contacs',
      home: const ContactList(),
    );
  }
}
