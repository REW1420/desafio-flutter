import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DogImagesResponse {
  final List<String> images;

  DogImagesResponse({required this.images});

  factory DogImagesResponse.fromJson(Map<String, dynamic> json) {
    return DogImagesResponse(
      images: List<String>.from(json['message']),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> dogImages = [];

  Future<void> fetchDogImages(String searchText) async {
    final url =
        Uri.parse('https://dog.ceo/api/breed/$searchText/images/random/3');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final dogImagesResponse = DogImagesResponse.fromJson(responseData);

        setState(() {
          dogImages = dogImagesResponse.images;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Buscar por raza...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String searchText = _searchController.text;
              await fetchDogImages(searchText);
            },
            child: Text("Buscar"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dogImages.length,
              itemBuilder: (context, index) {
                final imageUrl = dogImages[index];
                return Image.network(imageUrl);
              },
            ),
          ),
        ],
      ),
    );
  }
}
