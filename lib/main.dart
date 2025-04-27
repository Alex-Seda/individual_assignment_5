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

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft, // Align the title to the left
          child: const Text('Welcome', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
        ),
        actions:[
          IconButton(
            onPressed: () {
              toggleTheme();
            },
            icon: Icon(Icons.contrast),
          )
        ]
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'Welcome to my Profile App!',
                style: TextStyle(fontSize:26, fontWeight: FontWeight.w700),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }, 
              child: const Text('View Profile', style: TextStyle(fontSize:18, fontWeight:FontWeight.w500)),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft, // Align the title to the left
          child: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w600)),
        )
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                radius: 50,  // Adjust the size of the avatar
                backgroundImage: AssetImage('assets/flowers.jpg'), // Image URL
                backgroundColor: Colors.grey,  // Background color if the image fails to load
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text(
                'John Doe',
                style: TextStyle(fontSize:24, fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child:const Opacity(
                opacity: 0.5,
                child: Text(
                  'Flutter Developer | CS Student',
                  style: TextStyle(fontSize:12, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },  
              child: const Text('Go Back', style: TextStyle(fontSize:18, fontWeight:FontWeight.w500)),
            )
          ],
        ),
      ),
    );
  }
}