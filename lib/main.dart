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
  Profile user = Profile();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget Demo',
      theme: isDarkMode ? darkMode : lightMode,
      home: HomeScreen(toggleTheme: toggleTheme,user: user),
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
  final Profile user;

  const HomeScreen({super.key, required this.toggleTheme, required this.user});

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
                  MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
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

// ProfileScreen must be stateful so it can update when we come back from the profile edit menu
class ProfileScreen extends StatefulWidget {
  final Profile user;
  
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft, // Align the title to the left
          child: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        actions:[
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen(user: widget.user)),
              );
              setState(() {}); // <<< Rebuild after coming back from Edit
            },
            icon: Icon(Icons.edit),
          )
        ] 
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                radius: 50,  // Adjust the size of the avatar
                backgroundImage: AssetImage('assets/${widget.user.profilePicture}.jpg'), // Image URL
                backgroundColor: Colors.grey,  // Background color if the image fails to load
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                widget.user.profileName,
                style: TextStyle(fontSize:24, fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Opacity(
                opacity: 0.7,
                child: Text(
                  '${widget.user.devType} Developer | ${widget.user.major} Student',
                  style: TextStyle(fontSize:14, fontWeight: FontWeight.w300),
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

// Edit Profile Screen must be stateful so you can save profile info and the content updates as you change it
class EditProfileScreen extends StatefulWidget {
  final Profile user;
  
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController devTypeController;
  late TextEditingController majorController;

  int choiceNum = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.profileName);
    devTypeController = TextEditingController(text: widget.user.devType);
    majorController = TextEditingController(text: widget.user.major);
    choiceNum = widget.user.profilePictureChoice;
  }

  @override
  void dispose() {
    nameController.dispose();
    devTypeController.dispose();
    majorController.dispose();
    super.dispose();
  }

  // Function to allow us to save the fields to the user profile
  void saveProfile() {
    setState(() {
      widget.user.set(
        choiceNum,
        nameController.text,
        devTypeController.text,
        majorController.text,
      );
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft, // Align the title to the left
          child: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.w600)),
        )
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Image options
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ProfileIconOption(image: 'flower', number: '1'),
                  ProfileIconOption(image: 'spaceship', number: '2'),
                  ProfileIconOption(image: 'car', number: '3')
                ]
              ),
            ),

            // Dropdown for selecting profile picture
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: DropdownButton<int>(
                value: choiceNum,
                onChanged: (int? newValue) {
                  setState(() {
                    choiceNum = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Flower (1)'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('Spaceship (2)'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('Car (3)'),
                  ),
                ],
                isExpanded: true,
                hint: Text('Select Profile Picture'),
              ),
            ),

            // Name input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),

            // Dev type Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: devTypeController,
                decoration: const InputDecoration(
                  labelText: 'Developer Type',
                ),
              ),
            ),

            // Major input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: majorController,
                decoration: const InputDecoration(
                  labelText: 'Major',
                ),
              ),
            ),

            // Save button
            ElevatedButton(
              onPressed: () {
                saveProfile();
              },  
              child: const Text('Save', style: TextStyle(fontSize:18, fontWeight:FontWeight.w500)),
            ),

            // Explanation of how to exit without saving
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Text(
                '(To exit without saving changes, just tap the back button at the top)',
                style: TextStyle(fontSize:10, fontWeight: FontWeight.w300),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}

// This is the class that will allow us to have a saveable profile
class Profile{
  int profilePictureChoice = 1;
  String profilePicture = 'flower';
  String profileName = "John Doe";
  String devType = "Flutter";
  String major = "CS";

  set(int choice, String name, String dev, String maj){
    profilePictureChoice = choice;
    switch (choice){
      case 2: profilePicture = 'spaceship';
      break;
      case 3: profilePicture = 'car';
      break;
      default: profilePicture = 'flower';
    }
    profileName = name;
    devType = dev;
    major = maj;
  }
}

// This class cleans up the code for Icon Options for the Profile Picture in the EditProfile screen
class ProfileIconOption extends StatelessWidget {
  final String image;
  final String number;
  
  const ProfileIconOption({super.key, required this.image, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          CircleAvatar(
            radius: 50,  // Adjust the size of the avatar
            backgroundImage: AssetImage('assets/${image}.jpg'), // Image URL
            backgroundColor: Colors.grey,  // Background color if the image fails to load
          ),
          Text('${number}')
        ]
      ),
    );
  }
}