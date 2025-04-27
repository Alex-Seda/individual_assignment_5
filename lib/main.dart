import 'package:flutter/material.dart';
import 'themes.dart'; // Import the file where the themes are stored

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget Demo',
      theme: isDarkMode ? darkMode : lightMode,
      home: HomeScreen(toggleTheme: toggleTheme,),
    );
  }

  toggleTheme(){
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  HomeScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
        actions:[
          IconButton(
            onPressed: () {
              toggleTheme();
            },
            icon: Icon(Icons.settings),
          )
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello flutter!',
              style: TextStyle(fontSize:24),
            ),
          ],
        ),
      ),
    );
  }
}