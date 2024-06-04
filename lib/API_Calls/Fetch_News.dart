import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kaz_trans_oil/Language/Language.dart';

Future<Map<String, dynamic>> fetchNews(int category, int page) async {
  final List<dynamic> allNews = [];
  int totalPages = 1;
  int code = Language.languageCode;
  try {
    final response = await http.get(Uri.parse(
        'https://www.mbportal.kz/api/news?NewsCategory=$category&Language=$code&Page=$page'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data['items'] != null) {
        final List<dynamic> pageNews = data['items'] as List<dynamic>;
        allNews.addAll(pageNews);

        totalPages = data['totalPages'] as int;
      } else {
        throw Exception('Failed to load news');
      }
    } else {
      throw Exception('Failed to load news');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to load news');
  }

  return {'newsList': allNews, 'totalPages': totalPages};
}
Future<Map<String, dynamic>> fetchNewsData(String id) async {
  final url = Uri.parse('https://www.mbportal.kz/api/news/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    return responseBody;
  } else {
    throw Exception('Failed to fetch news data');
  }
}


