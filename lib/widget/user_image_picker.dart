
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedimage) fnImagePick;


  UserImagePicker(this.fnImagePick);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedimage;
  final ImagePicker _picker = ImagePicker();

   _pickImage(ImageSource src) async{
    final PickedImageFile = await _picker.pickImage(source: src,imageQuality: 50,maxWidth: 150,maxHeight: 150);
    if(PickedImageFile != null){
      setState(() {
        _pickedimage = File(PickedImageFile.path);
      });
      widget.fnImagePick(_pickedimage!);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedimage != null ?   FileImage(_pickedimage!) : null,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.add_a_photo_outlined),
              label: const Text('Add Image',textAlign: TextAlign.center,style:TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),),
            ),
            TextButton.icon(
              onPressed: ()  => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Select Image',textAlign: TextAlign.center,style:TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),),
            )
          ],
        )
      ],
    );
  }
}
