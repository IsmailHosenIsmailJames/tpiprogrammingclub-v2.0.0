import 'package:flutter/material.dart';

import '../home/home_page.dart';
import 'delete_post.dart';
import 'pending_post.dart';
import 'restore.dart';
import 'update_rank.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Admin Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: elevatedStyle,
                minimumSize: const Size(270, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PendingPost(),
                  ),
                );
              },
              child: const Text('All Pending Post'),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: elevatedStyle,
                minimumSize: const Size(270, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeletePost(),
                  ),
                );
              },
              child: const Text('Delete a Post'),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: elevatedStyle,
                minimumSize: const Size(270, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Restore(),
                  ),
                );
              },
              child: const Text('Restore a Post'),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: elevatedStyle,
                minimumSize: const Size(270, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateRank(),
                  ),
                );
              },
              child: const Text('Update All The Rank'),
            ),
          ],
        ),
      ),
    );
  }
}
