import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhotoTab extends StatefulWidget {
  @override
  _PhotoTabState createState() => _PhotoTabState();
}

class _PhotoTabState extends State<PhotoTab> {
  final String apiKey =
      '9qHlnnUf7DZiKjOLbGX8Pp8xVX11egOuZhy7sQRTbt5Ulu28M0xgeSqk';
  List<String> photoUrls = [];
  bool isGrid = false;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=10'),
        headers: {
          'Authorization':
              ' 9qHlnnUf7DZiKjOLbGX8Pp8xVX11egOuZhy7sQRTbt5Ulu28M0xgeSqk'
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> photos = data['photos'];
      List<String> urls =
          photos.map((photo) => (photo['src']['original'] as String)).toList();

      setState(() {
        photoUrls = urls;
      });
    } else {
      throw Exception('something went wrog');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(isGrid ? Icons.list : Icons.grid_on),
              onPressed: () {
                setState(() {
                  isGrid = !isGrid;
                });
              },
            ),
          ],
        ),
        Expanded(
          child: isGrid ? buildList() : buildGrid(),
        ),
      ],
    );
  }

  Widget buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: photoUrls.length,
      itemBuilder: (context, index) {
        return Image.network(photoUrls[index], fit: BoxFit.cover);
      },
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: photoUrls.length,
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
            child: Image.network(photoUrls[index], fit: BoxFit.cover));
      },
    );
  }
}
