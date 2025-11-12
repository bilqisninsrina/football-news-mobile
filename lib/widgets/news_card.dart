// lib/widgets/news_card.dart

import 'package:flutter/material.dart';
import 'package:football_news/screens/menu.dart';
import 'package:football_news/screens/newslist_form.dart';
import 'package:football_news/screens/news_entry_list.dart'; // TAMBAHKAN IMPORT
import 'package:football_news/screens/login.dart'; // TAMBAHKAN IMPORT
import 'package:pbp_django_auth/pbp_django_auth.dart'; // TAMBAHKAN IMPORT
import 'package:provider/provider.dart'; // TAMBAHKAN IMPORT

// Ganti URL Sesuai Kebutuhan
const String baseUrl = "https://bilqis-nisrina-footballnews.pbp.cs.ui.ac.id";
// const String baseUrl = "http://10.0.2.2:8000"; // Untuk emulator Android
// const String baseUrl = "http://localhost:8000"; // Untuk Chrome

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // TAMBAHKAN BARIS INI
    final request = context.watch<CookieRequest>();

    return Material(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // UBAH onTap MENJADI ASYNC
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          if (item.name == "Tambah Berita") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewsFormPage(),
              ),
            );
          }
          // TAMBAHKAN KONDISI ELSE IF DI BAWAH INI
          else if (item.name == "See Football News") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewsEntryListPage(),
              ),
            );
          }
          // TAMBAHKAN KONDISI LOGOUT
          else if (item.name == "Logout") {
            final response =
                await request.logout("$baseUrl/auth/logout/");
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            }
          }
        },
        child: Container(
          // ... (SISA DARI CONTAINER - TIDAK ADA PERUBAHAN) ...
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}