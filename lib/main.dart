// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_login/auth/auth_gate.dart';
import 'package:supabase_login/pages/login_page.dart';

void main() async {
  //supabase setup
  await Supabase.initialize(
      url: "https://taejpcevvgiznuccfwli.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRhZWpwY2V2dmdpem51Y2Nmd2xpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5NzM1NDgsImV4cCI6MjA0ODU0OTU0OH0.VXJXtQevr_Sk0QYyBp98RpgLiWi_Tbv91bndVIn0qvg");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
