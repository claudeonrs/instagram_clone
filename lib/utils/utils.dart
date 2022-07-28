import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes(); // return Uint8List
    // using the File class from dart:io is not recommended
    // because inaccessible on web
  }
  print('No image selected');
}
