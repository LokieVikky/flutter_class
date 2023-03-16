import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AlbumApp());
}

class AlbumApp extends StatelessWidget {
  const AlbumApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PhotosApp(),
    );
  }
}

class PhotosApp extends StatefulWidget {
  const PhotosApp({Key? key}) : super(key: key);

  @override
  State<PhotosApp> createState() => _PhotosAppState();
}

class _PhotosAppState extends State<PhotosApp> {
  List<Album> albums = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(albums[index].url ?? ''),
                    title: Text(albums[index].title ?? ''),
                  ),
                );
              },
              itemCount: albums.length,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                albums = await getPhotos();
                setState(() {});
              },
              child: const Text('Get Photos')),
        ],
      ),
    );
  }

  Future<List<Album>> getPhotos() async {
    String url = 'https://jsonplaceholder.typicode.com/photos';
    http.Response response = await http.get(Uri.parse(url));
    List body = jsonDecode(response.body);
    return body.map((e) {
      return Album.fromJson(e);
    }).toList();
  }
}

class Album {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Album.fromJson(dynamic json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
