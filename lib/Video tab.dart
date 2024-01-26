import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:task/videoplayer.dart';

class VideoTab extends StatefulWidget {
  @override
  _VideoTabState createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  final String apiKey =
      '9qHlnnUf7DZiKjOLbGX8Pp8xVX11egOuZhy7sQRTbt5Ulu28M0xgeSqk';
  List<String> videoUrls = [];
  int page = 1;

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/videos/popular?per_page=5&page=$page'),
      headers: {'Authorization': apiKey},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> videos = data['videos'];
      List<String> urls = videos
          .map((video) => video['video_files'][0]['link'] as String)
          .toList();

      setState(() {
        videoUrls.addAll(urls);
        page++;
      });
    } else {
      throw Exception('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: videoUrls.length,
      itemBuilder: (context, index) {
        return VideoPlayerWidget(videoUrl: videoUrls[index]);
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
