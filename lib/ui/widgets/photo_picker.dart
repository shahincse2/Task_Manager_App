import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key, required this.pickedImage, this.base64Image});

  final XFile? pickedImage;
  final String? base64Image;

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
          Expanded(child: _buildPhotoNamingWidget()),
        ],
      ),
    );
  }

  Widget _buildPhotoNamingWidget() {
    if (pickedImage != null) {
      return Text(
        pickedImage!.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    if (base64Image != null && base64Image!.isNotEmpty) {
      return Text(
        'Photo Uploaded',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Text('Select Photo', style: TextStyle(color: Colors.grey));
  }
}
