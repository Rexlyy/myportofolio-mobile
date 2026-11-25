import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            if (project.projectImageUrl.isNotEmpty)
              Image.network(
                project.projectImageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Icon(Icons.broken_image, size: 60)),
                  );
                },
              ),

            const SizedBox(height: 20),

            // Project Title
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 12),

            // Project Description
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 20),

            // Tech Stack
            Text('Tech Stack', style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.techStack.map((technology) {
                return Chip(label: Text(technology));
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Project URL
            Text('Project URL', style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 8),

            SelectableText(
              project.projectUrl,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
