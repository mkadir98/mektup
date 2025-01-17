import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

enum LetterType {
  job('İş Başvurusu'),
  masters('Yüksek Lisans Başvurusu'),
  visa('Turistik Vize Başvurusu');

  final String displayName;
  const LetterType(this.displayName);
}

enum Language {
  turkish('Türkçe'),
  english('İngilizce'),
  german('Almanca'),
  french('Fransızca'),
  spanish('İspanyolca'),
  italian('İtalyanca'),
  russian('Rusça'),
  chinese('Çince'),
  japanese('Japonca'),
  arabic('Arapça');

  final String displayName;
  const Language(this.displayName);
}

class LetterForm extends StatefulWidget {
  const LetterForm({Key? key}) : super(key: key);

  @override
  _LetterFormState createState() => _LetterFormState();
}

class _LetterFormState extends State<LetterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _recipientAddressController =
      TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _generatedLetter;
  bool _isLoading = false;
  LetterType _selectedLetterType = LetterType.job;
  Language _selectedLanguage = Language.turkish;

  String _getPromptForLetterType() {
    String languagePrompt =
        'Lütfen mektubu ${_selectedLanguage.displayName} dilinde oluştur.\n\n';

    switch (_selectedLetterType) {
      case LetterType.job:
        return languagePrompt +
            '''Lütfen aşağıdaki bilgileri kullanarak profesyonel bir iş başvurusu motivasyon mektubu oluştur:
          
          Gönderen Adresi: ${_addressController.text}
          Alıcı Adresi: ${_recipientAddressController.text}
          Alıcı İsmi: ${_recipientNameController.text}
          Gönderen İsmi: ${_nameController.text}
          Tarih: ${DateFormat('dd.MM.yyyy').format(DateTime.now())}
          
          Lütfen mektubu şu bölümlerle oluştur:
          1. Tanıtım paragrafı
          2. Teknik beceriler paragrafı
          3. Sosyal beceriler paragrafı
          4. Motivasyon paragrafı
          5. Teşekkür metni''';
      case LetterType.masters:
        return languagePrompt +
            '''Lütfen aşağıdaki bilgileri kullanarak profesyonel bir yüksek lisans başvurusu motivasyon mektubu oluştur:
          
          Gönderen Adresi: ${_addressController.text}
          Alıcı Adresi: ${_recipientAddressController.text}
          Alıcı İsmi: ${_recipientNameController.text}
          Gönderen İsmi: ${_nameController.text}
          Tarih: ${DateFormat('dd.MM.yyyy').format(DateTime.now())}
          
          Lütfen mektubu şu bölümlerle oluştur:
          1. Akademik geçmiş ve hedefler
          2. Araştırma ilgi alanları
          3. Akademik başarılar
          4. Neden bu program ve üniversite
          5. Gelecek planları
          6. Teşekkür metni''';
      case LetterType.visa:
        return languagePrompt +
            '''Lütfen aşağıdaki bilgileri kullanarak profesyonel bir turistik vize başvurusu motivasyon mektubu oluştur:
          
          Gönderen Adresi: ${_addressController.text}
          Alıcı Adresi: ${_recipientAddressController.text}
          Alıcı İsmi: ${_recipientNameController.text}
          Gönderen İsmi: ${_nameController.text}
          Tarih: ${DateFormat('dd.MM.yyyy').format(DateTime.now())}
          
          Lütfen mektubu şu bölümlerle oluştur:
          1. Kişisel ve profesyonel tanıtım
          2. Seyahat amacı ve planı
          3. Konaklama ve finansal detaylar
          4. Dönüş garantileri
          5. Teşekkür metni''';
    }
  }

  Future<void> _savePDF() async {
    if (_generatedLetter == null) return;

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                DateFormat('dd.MM.yyyy').format(DateTime.now()),
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                _recipientNameController.text,
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.Text(
                _recipientAddressController.text,
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 40),
              pw.Text(
                _generatedLetter!,
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 40),
              pw.Text(
                _nameController.text,
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.Text(
                _addressController.text,
                style: pw.TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/motivasyon_mektubu.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF kaydedildi: ${file.path}'),
        action: SnackBarAction(
          label: 'Klasörü Aç',
          onPressed: () async {
            // Windows için klasör açma komutu
            Process.run('explorer.exe', ['/select,', file.path]);
          },
        ),
      ),
    );
  }

  Future<void> _generateLetter() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      debugPrint('API isteği gönderiliyor...');
      final response = await http.post(
        Uri.parse('https://9sz3o0y7.repcl.net/api/v1/workspace/mektup/chat'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}',
        },
        body: jsonEncode({
          'message': _getPromptForLetterType(),
          'mode': 'chat',
          'sessionId': 'mektup-${DateTime.now().millisecondsSinceEpoch}',
        }),
      );

      debugPrint('API yanıtı: ${response.statusCode}');
      debugPrint('API yanıt içeriği: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Çözümlenen veri: $data');

        if (data['textResponse'] != null) {
          setState(() {
            _generatedLetter = data['textResponse'];
          });
        } else {
          throw Exception('API yanıtında mektup bulunamadı: $data');
        }
      } else {
        throw Exception(
            'API yanıt vermedi: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('Hata oluştu: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata oluştu: $e'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Kapat',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motivasyon Mektubu Oluştur'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<LetterType>(
                      value: _selectedLetterType,
                      decoration: const InputDecoration(
                        labelText: 'Mektup Türü',
                        border: OutlineInputBorder(),
                      ),
                      items: LetterType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLetterType = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<Language>(
                      value: _selectedLanguage,
                      decoration: const InputDecoration(
                        labelText: 'Mektup Dili',
                        border: OutlineInputBorder(),
                      ),
                      items: Language.values.map((language) {
                        return DropdownMenuItem(
                          value: language,
                          child: Text(language.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Gönderen Adresi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen adresinizi girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _recipientAddressController,
                decoration: const InputDecoration(
                  labelText: 'Alıcı Adresi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen alıcı adresini girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _recipientNameController,
                decoration: const InputDecoration(
                  labelText: 'Alıcı İsmi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen alıcı ismini girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Gönderen İsmi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen isminizi girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _generateLetter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: _isLoading
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text('Mektup Oluşturuluyor...'),
                        ],
                      )
                    : const Text('Mektup Oluştur'),
              ),
              if (_generatedLetter != null) ...[
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Oluşturulan Mektup:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _savePDF,
                      icon: const Icon(Icons.save),
                      label: const Text('PDF Olarak Kaydet'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _generatedLetter!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _recipientAddressController.dispose();
    _recipientNameController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
