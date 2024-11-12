import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'AuthService.dart';
import 'LoginPage.dart';
import 'HomePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: TurtleSkateparkApp(),
    ),
  );
}
//this change
class TurtleSkateparkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turtle Skatepark App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.tealAccent[700],
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: Consumer<AuthService>(
        builder: (context, authService, child) {
          return authService.isAuthenticated ? HomePage() : LoginPage();
        },
      ),
    );
  }
}
