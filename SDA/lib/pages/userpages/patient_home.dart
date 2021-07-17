import 'package:flutter/material.dart';
import 'package:file/file.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class PateintHOmePage extends StatefulWidget {
  @override
  _PateintHOmePageState createState() => _PateintHOmePageState();
}

class _PateintHOmePageState extends State<PateintHOmePage> {
  bool loading = false;
  File imageFile;
  List output;

  @override
  void initState() {
    super.initState();
    loading = true;
    loadModel().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  Future<dynamic> chooseImg() async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) return null;
    setState(() {
      loading = true;
      imageFile = img;
    });
    classifyImage(img);
  }

  classifyImage(File image) async {
    var _output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      loading = false;
      output = _output;
    });
  }

  Future<dynamic> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        "FORM",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
