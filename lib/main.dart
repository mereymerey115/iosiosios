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
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  int _followerCount = 999;
  int _likesCount = 789;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Profile'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Center(
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.lime,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Merey Sharipkhan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text('Student'),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$_followerCount',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Followers'),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          '$_likesCount',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Likes'),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),


                ElevatedButton(
                  onPressed: _follow,
                  child: const Text('Follow'),
                ),

                ElevatedButton(
                  onPressed: _unfollow,
                  child: const Text('Unfollow'),
                ),


                ElevatedButton(
                  onPressed: _like,
                  child: const Text('Like'),
                ),


                ElevatedButton(
                  onPressed: _dislike,
                  child: const Text('Dislike'),
                ),

                // RESET
                TextButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _follow() {
    setState(() {
      _followerCount++;
    });
  }

  void _unfollow() {
    setState(() {
      _followerCount--;
    });
  }

  void _like() {
    setState(() {
      _likesCount++;
    });
  }

  void _dislike() {
    setState(() {
      _likesCount--;
    });
  }

  void _reset() {
    setState(() {
      _followerCount = 999;
      _likesCount = 789;
    });
  }
}