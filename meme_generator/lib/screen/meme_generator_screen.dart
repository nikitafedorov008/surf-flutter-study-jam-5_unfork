import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/manager/meme_generator_manager.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class MemeGeneratorScreen extends StatelessWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ScreenshotController screenshotController = ScreenshotController();

    void _getImageFromNetwork() {

    }

    Future<dynamic> _ShowCapturedWidget(BuildContext context, Uint8List capturedImage) {
      return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Captured widget screenshot"),
          ),
          body: Center(child: Image.memory(capturedImage)),
        ),
      );
    }

    void _captureImage() async {
      var imageResponse = await screenshotController.capture(
        delay: const Duration(milliseconds: 10),
      );
      if (imageResponse != null) {
        _ShowCapturedWidget(context, imageResponse!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error while capturing'),
          ),
        );
      }
    }

    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );

    Widget _body() => Consumer<MemeGeneratorManager>(
      builder: (BuildContext context, memeGeneratorState, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: ColoredBox(
              color: Colors.black,
              child: DecoratedBox(
                decoration: decoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: DecoratedBox(
                          decoration: decoration,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: memeGeneratorState.memeImage.isNetwork ? Image.network(
                              memeGeneratorState.memeImage.imagePath,
                              fit: BoxFit.cover,
                            ) : Image.file(
                              File.fromUri(
                                Uri.parse(memeGeneratorState.memeImage.imagePath,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        memeGeneratorState.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Impact',
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      if (memeGeneratorState.subtitle != null) Text(
                        memeGeneratorState.subtitle!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Impact',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    return Screenshot(
      controller: screenshotController,
      child: _body(),
    );
  }
}