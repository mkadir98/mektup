import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:convert';
import '../models/letter_data.dart';
import '../models/enums.dart';
import '../widgets/ai_loading_animation.dart';
import '../widgets/ad_banner.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LetterPreviewScreen extends StatefulWidget {
  final dynamic letterData;
  final LetterType letterType;
  final Language language;

  const LetterPreviewScreen({
    Key? key,
    required this.letterData,
    required this.letterType,
    required this.language,
  }) : super(key: key);

  @override
  _LetterPreviewScreenState createState() => _LetterPreviewScreenState();
}

class _LetterPreviewScreenState extends State<LetterPreviewScreen> {
  final TextEditingController _letterController = TextEditingController();
  bool _isLoading = true;
  String? _error;
  bool _isEditing = false;
  String _letterContent = '';

  @override
  void initState() {
    super.initState();
    _generateLetter();
  }

  String _getPromptForLetterType() {
    String languagePrompt =
        'Lütfen mektubu ${widget.language.displayName} dilinde oluştur.\n\n';

    switch (widget.letterType) {
      case LetterType.visa:
        final data = widget.letterData as VisaLetterData;
        return languagePrompt +
            '''Lütfen aşağıdaki bilgileri kullanarak profesyonel bir turistik vize başvurusu motivasyon mektubu oluştur:
          
          Kişisel Bilgiler: ${data.personalInfo}
          Başvurulan Konsolosluk: ${data.recipientName}

          Seyahat Detayları:
          ${data.travelPurpose}

          Geri Dönüş Garantileri:
          ${data.travelPlan}

          Gönderen Adresi: ${data.senderAddress}
          Gönderen İsmi: ${data.senderName}''';

      case LetterType.masters:
        final data = widget.letterData as MastersLetterData;
        return languagePrompt +
            '''Lütfen aşağıdaki bilgileri kullanarak profesyonel bir yüksek lisans başvurusu motivasyon mektubu oluştur:
          
          Tarih: ${data.date}
          Ad Soyad: ${data.fullName}
          Adres: ${data.address}
          Başvurulan Üniversite: ${data.university}
          Başvurulan Bölüm: ${data.department}
          Eğitim Bilgileri: ${data.educationInfo}
          Akademik Başarılar: ${data.academicAchievements}
          Yetenekler: ${data.skills}
          Ek Bilgiler: ${data.additionalInfo}''';

      case LetterType.job:
        final data = widget.letterData as JobLetterData;
        return languagePrompt +
            '''Lütfen aşağıdaki bilgileri kullanarak profesyonel bir iş başvurusu motivasyon mektubu oluştur:
          
          Gönderen Adresi: ${data.senderAddress}
          Alıcı Adresi: ${data.recipientAddress}
          Alıcı İsmi: ${data.recipientName}
          Gönderen İsmi: ${data.senderName}
          Tarih: ${data.date}''';
    }
    return '';
  }

  Future<void> _generateLetter() async {
    try {
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['textResponse'] != null) {
          setState(() {
            _letterController.text = data['textResponse'];
            _letterContent = data['textResponse'];
            _isLoading = false;
          });
        } else {
          throw Exception('API yanıtında mektup bulunamadı');
        }
      } else {
        throw Exception('API yanıt vermedi: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<pw.Document?> _generatePDF() async {
    try {
      final pdf = pw.Document();

      // Use a font that supports Unicode characters
      final font = await pw.Font.ttf(
          await rootBundle.load('fonts/NotoSans-Regular.ttf'));

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  _letterController.text,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          },
        ),
      );

      return pdf;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF oluşturulurken hata: $e')),
        );
      }
      return null;
    }
  }

  Future<bool> _isIOSSimulator() async {
    if (Platform.isIOS) {
      final deviceInfo = await DeviceInfoPlugin().iosInfo;
      return !deviceInfo.isPhysicalDevice;
    }
    return false;
  }

  Widget _buildContent() {
    return _isLoading
        ? const AILoadingAnimation()
        : _error != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Mektup oluşturulurken bir hata oluştu:',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _error!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _error = null;
                            _isLoading = true;
                          });
                          _generateLetter();
                        },
                        child: const Text('Tekrar Dene'),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: _isEditing
                          ? TextField(
                              controller: _letterController,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Mektup içeriğini düzenleyin...',
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                              ),
                            )
                          : Text(
                              _letterController.text,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                    ),
                  ),
                ),
              );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).padding.bottom + 16,
        top: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _letterController.text));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Mektup panoya kopyalandı'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
              icon: const Icon(Icons.copy),
              label: const Text('Kopyala'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {
                try {
                  print('Generating PDF...');
                  final pdf = await _generatePDF();
                  if (pdf != null) {
                    print('PDF generated successfully');
                    // Save PDF and share
                    final directory = await getApplicationDocumentsDirectory();
                    final file =
                        File('${directory.path}/motivasyon_mektubu.pdf');
                    print('Saving PDF to: ${file.path}');
                    await file.writeAsBytes(await pdf.save());
                    print('PDF saved successfully');

                    if (mounted) {
                      print('Sharing PDF...');
                      final box = context.findRenderObject() as RenderBox?;
                      final Rect? sharePositionOrigin = box != null
                          ? Rect.fromPoints(
                              box.localToGlobal(Offset.zero),
                              box.localToGlobal(Offset.zero) + Offset(box.size.width, box.size.height),
                            )
                          : null;

                      if (Platform.isIOS) {
                        // Check if running on simulator
                        if (await _isIOSSimulator()) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('PDF dosyası kaydedildi. Paylaşma özelliği iOS simulatöründe çalışmayabilir.'),
                                duration: Duration(seconds: 5),
                              ),
                            );
                          }
                          return;
                        }
                      }

                      final result = await Share.shareXFiles(
                        [XFile(file.path)],
                        subject: 'Motivasyon Mektubu',
                        sharePositionOrigin: Platform.isIOS ? sharePositionOrigin : null,
                      );
                      
                      print('Share result: ${result.status}');
                    }
                  } else {
                    print('PDF generation returned null');
                  }
                } catch (e, stackTrace) {
                  print('Error in send button: $e');
                  print('Stack trace: $stackTrace');
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gönderme işlemi başarısız: $e')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.send),
              label: const Text('Gönder'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.letterType.displayName),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildContent(),
          ),
          const AdBanner(),
          _buildBottomBar(),
        ],
      ),
    );
  }
}
