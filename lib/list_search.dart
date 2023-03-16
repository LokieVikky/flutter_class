import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_class/home.dart';
import 'package:flutter_class/todo.dart';
import 'package:flutter_class/user/item.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Item> items = [];
  List<Item> filteredItems = [];
  TextEditingController controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heading'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (String val) async {
                  if(val.isEmpty){
                    filteredItems.clear();
                    filteredItems.addAll(items);
                    setState(() {

                    });
                    return;
                  }
                  List<Item> temp = items.where((element) {
                    return element.itemId.toString().toLowerCase().contains(val.toLowerCase());
                  }).toList();
                  filteredItems.clear();
                  filteredItems.addAll(temp);
                  setState(() {});
                },
                controller: controller,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Enter text to continue";
                    }
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(filteredItems[index].toString() ?? 'No Title'),
                        leading: Image.network(filteredItems[index].url ??
                            'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png'),
                      ),
                      const Divider(),
                    ],
                  );
                },
                itemCount: filteredItems.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  items = await getItems();
                  filteredItems.clear();
                  filteredItems.addAll(items);
                  setState(() {});
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Icon(Icons.cloud),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  if (await postData()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Post success")));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Icon(Icons.upload),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> postData() async {
    Map<String, dynamic> data = {
      "userId": 6,
      "id": 52,
      "title": "qui enim et consequuntur quia animi quis voluptate quibusdam",
      "body":
          "iusto est quibusdam fuga quas quaerat molestias\na enim ut sit accusamus enim\ntemporibus iusto accusantium provident architecto\nsoluta esse reprehenderit qui laborum"
    };
    String url = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.post(Uri.parse(url), body: jsonEncode(data));
    return response.statusCode == 201;
  }

  Future<List<Item>> getItems({String searchText = ''}) async {
    String url =
        'http://1.6.37.107/TNPC/apicontroller.php?action=getallitemsbasedsearch&search=$searchText';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception("Server Error");
    }
    Map body = jsonDecode(response.body);
    List items = body['data'];
    return items.map((e) {
      return Item.fromJson(e);
    }).toList();
  }

// Future<List<Todo>> getTodos() async {
//   String url = 'https://jsonplaceholder.typicode.com/todos/';
//   http.Response response = await http.get(Uri.parse(url));
//   if (response.statusCode != 200) {
//     throw Exception("Server Error");
//   }
//   String responseBody = response.body;
//   List todosMap = jsonDecode(responseBody);
//   users = todosMap.map((e) {
//     return Todo(e['id'], e['userId'], e['title'], e['completed']);
//   }).toList();
//   return users;
// }
}
