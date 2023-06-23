import 'package:flutter/material.dart';
import 'package:r2d/CameraInputWidget.dart';
import 'DrawerWidget.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

String _classificationText = "";
late Uint8List lastImage;
Uint8List imageConverted = Uint8List.fromList([]);

class ObjectClassificationWidget extends StatelessWidget {
  const ObjectClassificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Object Classification")),
    drawer: const DrawerWidget(),
    body: const Center(
      child: Column(children: [CameraInputWidget(), ImageLabelling()],),

    ),);
  }
  
  void setLastImage(Uint8List inputImage){
      lastImage = inputImage;
  }
}

class ImageLabelling extends StatefulWidget {
  const ImageLabelling({Key? key}) : super(key: key);

  @override
  State<ImageLabelling> createState() => _ImageLabellingState();
}

class _ImageLabellingState extends State<ImageLabelling> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 250, child: SingleChildScrollView(child: Text(_classificationText))),
        ElevatedButton (onPressed: () {setState(() {
          onButtonPressed(lastImage);
        },);}, child: const Text('Label Image')),
      ]),
    );
  }


  void onButtonPressed(Uint8List imageData){  
      Uint8List nv21Image = Uint8List.fromList(convertJpegToNV21(imageData, 640, 480));
      _ImageLabellingState().identifyImage(InputImage.fromBytes(bytes: nv21Image, metadata: InputImageMetadata(size: const Size(640, 480), rotation: InputImageRotation.rotation0deg, format: InputImageFormat.nv21, bytesPerRow: 1920)));
      imageConverted = nv21Image;
  }


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
        
        _classificationText = "Cannot identify the image";
      
        return;
      }
      _classificationText = "";
      for (ImageLabel img in image) {
        
        _classificationText += "Label : ${img.label}\nConfidence : ${img.confidence}\n\n";
      
      }
      imageLabeler.close();

    }
    
}