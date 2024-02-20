import 'package:flutter/cupertino.dart';
import 'package:meme_generator/model/meme_image.dart';

class MemeGeneratorManager with ChangeNotifier {

  MemeImage get memeImage => _memeImage;
  String get title => _title;
  String? get subtitle => _subtitle;
  MemeImage _memeImage = MemeImage(imagePath: 'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg');
  String _title = 'Демотиватор';
  String? _subtitle;

  changeText({String? title, String? subtitle}) {
    if (title != null) _title = title;
    if (subtitle != null) _subtitle = subtitle;
    notifyListeners();
  }

  changeImage({bool fromNetwork = true, required String imagePath}) {

  }

  void _getImageFromGallery() {

  }
}