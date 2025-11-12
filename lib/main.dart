// lib/main.dart

import 'package:flutter/material.dart';
import 'package:football_news/screens/login.dart'; // UBAH IMPORT INI
import 'package:pbp_django_auth/pbp_django_auth.dart'; // TAMBAHKAN IMPORT INI
import 'package:provider/provider.dart'; // TAMBAHKAN IMPORT INI

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BUNGKUS DENGAN PROVIDER
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Football News',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.blueAccent[400]),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}