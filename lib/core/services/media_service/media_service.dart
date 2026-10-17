import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../common_widgets/app_toast.dart';

/// Utility service for handling media selection (images/videos) and file size constraints.
class MediaService {
  final ImagePicker _imagePicker = ImagePicker();

  /// Picks an image from the specified [source] (camera/gallery) with size validation.
  Future<File?> pickImage({
    required ImageSource source,
    int imageQuality = 85,
    int maxBytes = 5 * 1024 * 1024, // Default 5MB limit
  }) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileSizeInBytes = await file.length();

        if (fileSizeInBytes > maxBytes) {
          AppToast.showToast(
            isSuccess: false,
            message: 'Image size must be less than 5MB.',
          );
          return null;
        }

        return file;
      }
    } catch (e) {
      AppToast.showToast(isSuccess: false, message: 'Failed to select image.');
    }
    return null;
  }
}
