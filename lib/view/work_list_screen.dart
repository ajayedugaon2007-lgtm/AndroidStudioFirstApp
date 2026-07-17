import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/work_controller.dart';
import '../model/work_model.dart';

class WorkListScreen extends StatelessWidget {
  const WorkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workController = Provider.of<WorkController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Services"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<WorkModel>>(
        stream: workController.allWorks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No work available"));
          }

          final works = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: works.length,
            itemBuilder: (context, index) {
              final work = works[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.work, color: Colors.white),
                  ),
                  title: Text(work.title ?? "No Title", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(work.category ?? ""),
                      const SizedBox(height: 5),
                      Text(work.description ?? "", maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  trailing: Text(
                    "\$${work.price}",
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onTap: () {
                    // Show details
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
