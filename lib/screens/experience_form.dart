import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyController = TextEditingController();

  final TextEditingController _positionController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  String _experienceType = 'Internship';

  final List<String> _experienceTypes = [
    'Internship',
    'Work',
    'Organization',
    'Volunteer',
    'Other',
  ];

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Format tanggal menjadi DD/MM/YYYY
  String _formatDate(DateTime? date) {
    if (date == null) return '';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  // Memilih tanggal mulai
  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;

        // Hapus tanggal selesai jika lebih awal
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = null;
        }
      });
    }
  }

  // Memilih tanggal selesai
  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  // Menampilkan ringkasan pengalaman
  void _showSummary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pengalaman Berhasil Disimpan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nama Perusahaan/Organisasi: '
                  '${_companyController.text}',
                ),
                const SizedBox(height: 8),
                Text('Posisi: ${_positionController.text}'),
                const SizedBox(height: 8),
                Text('Jenis: $_experienceType'),
                const SizedBox(height: 8),
                Text('Tanggal Mulai: ${_formatDate(_startDate)}'),
                const SizedBox(height: 8),
                Text('Tanggal Selesai: ${_formatDate(_endDate)}'),
                const SizedBox(height: 8),
                Text('Deskripsi: ${_descriptionController.text}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeftDrawer(),
      appBar: AppBar(
        title: const Text('Add Experience'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama perusahaan atau organisasi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _companyController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Perusahaan/Organisasi',
                    hintText: 'Masukkan nama perusahaan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama perusahaan tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Posisi atau jabatan
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _positionController,
                  decoration: const InputDecoration(
                    labelText: 'Posisi/Jabatan',
                    hintText: 'Contoh: Software Engineer',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Posisi tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Jenis pengalaman
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  initialValue: _experienceType,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Pengalaman',
                    border: OutlineInputBorder(),
                  ),
                  items: _experienceTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _experienceType = value;
                      });
                    }
                  },
                ),
              ),

              // Tanggal mulai
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<DateTime>(
                  validator: (value) {
                    if (_startDate == null) {
                      return 'Tanggal mulai harus dipilih!';
                    }
                    return null;
                  },
                  builder: (field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Tanggal Mulai',
                        border: const OutlineInputBorder(),
                        errorText: field.errorText,
                      ),
                      child: InkWell(
                        onTap: () async {
                          await _selectStartDate();
                          field.didChange(_startDate);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _startDate == null
                                  ? 'Pilih tanggal mulai'
                                  : _formatDate(_startDate),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Tanggal selesai
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<DateTime>(
                  validator: (value) {
                    if (_endDate == null) {
                      return 'Tanggal selesai harus dipilih!';
                    }

                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return 'Tanggal selesai tidak boleh sebelum tanggal mulai!';
                    }

                    return null;
                  },
                  builder: (field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Tanggal Selesai',
                        border: const OutlineInputBorder(),
                        errorText: field.errorText,
                      ),
                      child: InkWell(
                        onTap: () async {
                          await _selectEndDate();
                          field.didChange(_endDate);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _endDate == null
                                  ? 'Pilih tanggal selesai'
                                  : _formatDate(_endDate),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Deskripsi pengalaman
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi Pengalaman',
                    hintText: 'Jelaskan pengalaman dan tanggung jawab',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Tombol Simpan
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showSummary();
                      }
                    },
                    child: const Text('Simpan Pengalaman'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
