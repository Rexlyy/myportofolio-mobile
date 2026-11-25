import 'package:flutter/material.dart';

import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/screens/project_detail.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final ApiClient apiClient = ApiClient();

  late Future<List<Project>> projectsFuture;

  @override
  void initState() {
    super.initState();

    // Mengambil data project ketika halaman pertama kali dibuka.
    projectsFuture = apiClient.getProjects();
  }

  // Mengambil ulang data ketika pengguna melakukan refresh.
  Future<void> refreshProjects() async {
    final newFuture = apiClient.getProjects();

    setState(() {
      projectsFuture = newFuture;
    });

    await newFuture;
  }

  // Membuka halaman detail project.
  void openProjectDetail(Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(project: project),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: FutureBuilder<List<Project>>(
        future: projectsFuture,
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error State
          if (snapshot.hasError) {
            return RefreshIndicator(
              onRefresh: refreshProjects,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 150),
                  Center(
                    child: Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 12),
                  Center(child: Text('Gagal mengambil data project.')),
                  Center(
                    child: Text('Tarik layar ke bawah untuk mencoba lagi.'),
                  ),
                ],
              ),
            );
          }

          // 3. Mengambil data project.
          final List<Project> projects = snapshot.data ?? [];

          // 4. Empty State
          if (projects.isEmpty) {
            return RefreshIndicator(
              onRefresh: refreshProjects,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 150),
                  Center(child: Icon(Icons.folder_open, size: 50)),
                  SizedBox(height: 12),
                  Center(child: Text('Belum ada project.')),
                ],
              ),
            );
          }

          // 5. Success State
          return RefreshIndicator(
            onRefresh: refreshProjects,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      project.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      project.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      openProjectDetail(project);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
