import 'package:flutter/material.dart';
import 'package:property_service_web/models/photo_item_model.dart';

class PhotoList extends StatelessWidget {
  final List<PhotoItemModel> photoList;
  const PhotoList({super.key, required this.photoList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 196,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photoList.length,
        itemBuilder: (context, index) {
          final PhotoItemModel photo= photoList[index];
          return SizedBox(
            width: 150,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                photo.photo,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(width: 8),
      ),
    );
  }
}
