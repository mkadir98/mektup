import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/letter_data.dart';
import '../../models/enums.dart';
import '../letter_preview_screen.dart';

class JobFormScreen extends StatefulWidget {
  final Language language;

  const JobFormScreen({Key? key, required this.language}) : super(key: key);

  @override
  _JobFormScreenState createState() => _JobFormScreenState();
}

class _JobFormScreenState extends State<JobFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController(
    text: DateFormat('dd.MM.yyyy').format(DateTime.now()),
  );
  final _senderAddressController = TextEditingController();
  final _recipientAddressController = TextEditingController();
  final _recipientNameController = TextEditingController();
  final _senderNameController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final letterData = JobLetterData(
        date: _dateController.text,
        senderAddress: _senderAddressController.text,
        recipientAddress: _recipientAddressController.text,
        recipientName: _recipientNameController.text,
        senderName: _senderNameController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LetterPreviewScreen(
            letterData: letterData,
            letterType: LetterType.job,
            language: widget.language,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İş Başvuru Bilgileri'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Tarih',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senderNameController,
                decoration: const InputDecoration(
                  labelText: 'Gönderen İsmi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senderAddressController,
                decoration: const InputDecoration(
                  labelText: 'Gönderen Adresi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _recipientNameController,
                decoration: const InputDecoration(
                  labelText: 'Alıcı İsmi',
                  helperText: 'İnsan Kaynakları Müdürü, Departman Yöneticisi vb.',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _recipientAddressController,
                decoration: const InputDecoration(
                  labelText: 'Şirket Adresi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Mektup Oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _senderAddressController.dispose();
    _recipientAddressController.dispose();
    _recipientNameController.dispose();
    _senderNameController.dispose();
    super.dispose();
  }
} 