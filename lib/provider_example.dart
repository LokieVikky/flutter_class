import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProviderExample());
}

class ProviderExample extends StatelessWidget {
  const ProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: ChangeNotifierProvider(
            create: (BuildContext context) {
              return User();
            },
            child: CounterApp()),
      ),
    );
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          Text(Provider.of<User>(context).age.toString()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Provider.of<User>(context,listen: false).increaseAge();
        },
      ),
    );
  }
}

class User extends ChangeNotifier {
  String name = 'Someone';
  int age = 27;

  void increaseAge() {
    age++;
   notifyListeners();
  }

  void decreaseAge() {
    age--;
    notifyListeners();
  }
}
