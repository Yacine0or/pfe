import 'package:file_picker/file_picker.dart';

class mediaService {
  mediaService() {}
  Future<PlatformFile?> pickimage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      return result.files[0];
    } else {
      return null;
    }
  }
}
