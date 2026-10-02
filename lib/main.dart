import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false;
  bool isLiked = false;
  int likes = 10;

  void follow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  void like() {
    setState(() {
      if (isLiked == false) {
        isLiked = true;
        likes++;
      } else {
        isLiked = false;
        likes--;
      }
    });
  }

  void reset() {
    setState(() {
      isFollowing = false;
      isLiked = false;
      likes = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 60,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Merey',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text('Flutter Student'),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: follow,
              child: Text(
                isFollowing ? 'Following' : 'Follow',
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: like,
              child: Text(
                isLiked ? 'Unlike ❤️' : 'Like 🤍',
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Likes: $likes',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}