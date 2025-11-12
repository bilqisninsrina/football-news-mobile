// lib/widgets/news_entry_card.dart

import 'package:flutter/material.dart';
import 'package:football_news/models/news_entry.dart';

// Ganti URL Sesuai Kebutuhan
const String baseUrl = "https://bilqis-nisrina-footballnews.pbp.cs.ui.ac.id";
// const String baseUrl = "http://10.0.2.2:8000"; // Untuk emulator Android
// const String baseUrl = "http://localhost:8000"; // Untuk Chrome

class NewsEntryCard extends StatelessWidget {
  final NewsEntry news;
  final VoidCallback onTap;

  const NewsEntryCard({
    super.key,
    required this.news,
    required this.onTap,
  });

  // Fungsi untuk mendapatkan URL proxy
  String getProxyImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      // Kembalikan URL placeholder atau kosong jika tidak ada thumbnail
      return 'https://via.placeholder.com/150'; // Contoh placeholder
    }
    return '$baseUrl/proxy-image/?url=${Uri.encodeComponent(imageUrl)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    getProxyImageUrl(news.thumbnail),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                // Category
                Text('Category: ${news.category}'),
                const SizedBox(height: 6),
                // Content preview
                Text(
                  news.content.length > 100
                      ? '${news.content.substring(0, 100)}...'
                      : news.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 6),
                // Featured indicator
                if (news.isFeatured)
                  const Text(
                    'Featured',
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}