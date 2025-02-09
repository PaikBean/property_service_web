import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:property_service_web/widgets/rotating_house_indicator.dart';

class ImageSliderDialog extends StatefulWidget {
  @override
  _ImageSliderDialogState createState() => _ImageSliderDialogState();
}

class _ImageSliderDialogState extends State<ImageSliderDialog> {
  late Future<List<String>> _imageUrls;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _imageUrls = fetchImageUrls();
  }

  Future<List<String>> fetchImageUrls() async {
    final response = await http.get(Uri.parse('https://api.example.com/images')); // 여기에 API URL을 넣으세요.

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item['imageUrl'] as String).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void _prevPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 600,
          maxWidth: 600
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(onPressed: () {Navigator.pop(context);},
                icon: Icon(
                    Icons.close,
                  size: 36,
                  color: Colors.black,
                )
            ),
            FutureBuilder<List<String>>(
              future: _imageUrls,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: RotatingHouseIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text('이미지를 불러오지 못했습니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: Colors.white),)),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text('이미지가 없습니다.',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: Colors.white),)),
                  );
                }

                final images = snapshot.data!;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 300,
                      height: 400,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.network(images[index], fit: BoxFit.cover);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: _prevPage,
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: _nextPage,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('닫기'),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
