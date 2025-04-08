import 'package:image_picker/image_picker.dart';

class ImagePickers {
  ImagePicker imagePicker = ImagePicker();

  Future<XFile?> imageFromGallery() => imagePicker.pickImage(source: ImageSource.gallery);

  Future<XFile?> imageFromCamera() => imagePicker.pickImage(source: ImageSource.camera);
}
