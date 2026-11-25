import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;

  // Variabel untuk menyimpan input
  String _projectName = "";
  String _description = "";
  String _category = "Web Development";
  String _technologies = "";
  String _projectLink = "";

  // Daftar kategori proyek
  final List<String> _categories = [
    'Web Development',
    'Mobile App',
    'UI/UX Design',
    'Data Science',
    'Other',
  ];

  // Fungsi untuk mengirim data proyek ke Django
  Future<void> _submitProject() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authState = context.read<AuthState>();
    final token = authState.token;

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan login terlebih dahulu.')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final project = Project(
        id: '',
        title: _projectName,
        description: _description,
        techStack: _technologies
            .split(',')
            .map((technology) => technology.trim())
            .where((technology) => technology.isNotEmpty)
            .toList(),
        projectUrl: _projectLink,
        projectImageUrl: '',
      );

      await context.read<ApiClient>().createProject(project, token: token);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proyek berhasil ditambahkan!')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menambahkan proyek: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Project')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Nama Proyek
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Nama Proyek",
                    labelText: "Nama Proyek",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    _projectName = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Deskripsi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Deskripsi Proyek",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onChanged: (String value) {
                    _description = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Kategori
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Kategori Proyek",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _category,
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _category = newValue;
                      });
                    }
                  },
                ),
              ),

              // Teknologi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Contoh: Flutter, Django, Python",
                    labelText: "Teknologi yang Digunakan",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    _technologies = value;
                  },
                ),
              ),

              // Tautan Proyek
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "https://github.com/username/project",
                    labelText: "Tautan Proyek",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (String value) {
                    _projectLink = value;
                  },
                ),
              ),

              // Tombol Save
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitProject,
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
