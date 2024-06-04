import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kaz_trans_oil/Language/Language.dart';

Future<Map<String, dynamic>> fetchVideos(int year, int page) async {
  final List<dynamic> allVideos = [];
  int totalPages = 1;
  int code=Language.languageCode;
  try {
    final response = await http.get(Uri.parse('https://www.mbportal.kz/api/videoGalleries?Year=$year&Page=$page'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data['items'] != null) {
        final List<dynamic> pageVideos = data['items'] as List<dynamic>;
        allVideos.addAll(pageVideos);

        totalPages = data['totalPages'] as int;
      } else {
        throw Exception('Failed to load videos');
      }
    } else {
      throw Exception('Failed to load videos');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to load videos');
  }

  return {'videosList': allVideos, 'totalPages': totalPages};
}

Future<Map<String, dynamic>> fetchMedia(int type, int page) async {
  final List<dynamic> allVideos = [];
  int totalPages = 1;
  int code=Language.languageCode;
  try {
    final response = await http.get(Uri.parse('https://www.mbportal.kz/api/videoGalleries?VideoGalleryCategory=$type&Page=$page'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data['items'] != null) {
        final List<dynamic> pageVideos = data['items'] as List<dynamic>;
        allVideos.addAll(pageVideos);

        totalPages = data['totalPages'] as int;
      } else {
        throw Exception('Failed to load videos');
      }
    } else {
      throw Exception('Failed to load videos');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to load videos');
  }

  return {'videosList': allVideos, 'totalPages': totalPages};
}