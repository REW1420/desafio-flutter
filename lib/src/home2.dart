import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DogImageResponse {
  final List<String> images;

  DogImageResponse({required this.images});

  factory DogImageResponse.fromJson(Map<String, dynamic> json) {
    return DogImageResponse(images: List<String>.from(json['message']));
  }
}

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home2> {
  List<String> randomImage = [];

  String image1 =
      "https://images.dog.ceo/breeds/terrier-fox/n02095314_2256.jpg";

  Future<void> getImage() async {
    final url = Uri.parse("https://dog.ceo/api/breeds/image/random/3");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final dogResponse = DogImageResponse.fromJson(responseData);
        setState(() {
          randomImage = dogResponse.images;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                getImage();
              },
              child: const Text("Get random image"),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: randomImage.length,
            itemBuilder: (context, index) {
              final imageUrl = randomImage[index];
              return Image.network(imageUrl);
            },
          ))
        ],
      ),
    ));
  }
}
