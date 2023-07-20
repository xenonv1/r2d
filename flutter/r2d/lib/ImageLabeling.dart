import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:ui';

String _classificationText = "";

class ImageLabeling {

String labelImage(Uint8List inputImage) {
  Uint8List nv21Image =
      Uint8List.fromList(convertJpegToNV21(inputImage, 640, 480));
  identifyImage(InputImage.fromBytes(
      bytes: nv21Image,
      metadata: InputImageMetadata(
          size: const Size(640, 480),
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.nv21,
          bytesPerRow: 1920)));
  return _classificationText;
}

// Convert the received Jpeg image to a nv21 image that can be used for the ml kit labeler

Uint8List convertJpegToNV21(Uint8List jpegData, int width, int height) {
  final nv21Data = Uint8List(width * height * 3 ~/ 2);

  // Convert JPEG to RGB
  final image = img.decodeImage(jpegData);
  final rgbImage = img.copyResize(image!, width: width, height: height);
  final rgbImageData = rgbImage.getBytes();

  // Convert RGB to NV21
  int uvIndex = width * height;
  int yIndex = 0;
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      final r = rgbImageData[yIndex++];
      final g = rgbImageData[yIndex++];
      final b = rgbImageData[yIndex++];

      final y = ((66 * r + 129 * g + 25 * b + 128) >> 8) + 16;
      final u = ((-38 * r - 74 * g + 112 * b + 128) >> 8) + 128;
      final v = ((112 * r - 94 * g - 18 * b + 128) >> 8) + 128;

      nv21Data[yIndex ~/ 3] = y;
      if (j % 2 == 0 && i % 2 == 0) {
        nv21Data[uvIndex++] = u;
        nv21Data[uvIndex++] = v;
      }
    }
  }
  return nv21Data;
}

static final ImageLabelerOptions _options =
    ImageLabelerOptions(confidenceThreshold: 0.7);

final imageLabeler = ImageLabeler(options: _options);

void identifyImage(InputImage inputImage) async {
  final List<ImageLabel> image = await imageLabeler.processImage(inputImage);

  if (image.isEmpty) {
    _classificationText = "";
    return;
  }
  _classificationText = "";
  for (ImageLabel img in image) {
    _classificationText += "${img.label}\n";
  }
  imageLabeler.close();
}
}
