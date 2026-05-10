import 'package:flutter/material.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            alignment: Alignment.center,
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              color: Colors.grey,
            ),
            child: Text('Photos'),
          ),
          Text('Select Photo'),
        ],
      ),
    );
  }
}
