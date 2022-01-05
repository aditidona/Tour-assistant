import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wonderlust/utilities/bottom_drawer.dart';
import 'package:wonderlust/utilities/side_drawer.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  File? selectedImage;
  String? message = "";
  String? prediction = "";
/*
void queryPage(prediction) async {
  var wiki = Wikipedia();
  var results = await wiki.search(prediction);
  var queryResults = await wiki.getPage(results.searchResults[0].title);
  print(queryResults);
}
*/
  _launchURL(prediction) async {
    var url = 'https://en.wikipedia.org/wiki/' + prediction;
    Uri.encodeFull(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _detectLandmark() async {
    final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(_image!.path);
    });
    print(_image!.path);
    File _file = File(_image.path);
    print(_file);

    final req = http.MultipartRequest(
        "POST", Uri.parse('http://192.168.188.242:5000/landmark'));

    final headers = {"Content-type": "multipart/form-data"};

    req.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split('/').last));

    req.headers.addAll(headers);
    final response = await req.send();
    http.Response res = await http.Response.fromStream(response);

    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    prediction = resJson['landmark'];

    print(message);
    print(prediction);

    //queryPage(prediction);
    prediction = prediction!.replaceAll(' ', '_');
    _launchURL(prediction);
  }

  //pick an image
  /*
    final _image = await ImagePicker().pickImage(source: ImageSource.camera);
    print(_image!.path);
    File _file = File(_image.path);
    print(_file);

    //landmark detection using flask api
    var response = await getLandmark(_file.path);
    var decodedData = jsonDecode(response);
    print(decodedData);

    //open the wikipedia of the landmark detected
    */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Click a picture to know more !'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedImage == null
                ? Text("Please Click an Image")
                : Image.file(selectedImage!),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Click a Picture'),
        onPressed: _detectLandmark,
        icon: Icon(Icons.camera),
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: BottomDrawer(),
    );
  }
}
