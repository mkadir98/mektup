import 'package:flutter/material.dart';
import '../../models/letter_data.dart';
import '../../models/enums.dart';
import 'visa_form_screen.dart';
import 'masters_form_screen.dart';
import 'job_form_screen.dart';
import '../../widgets/ad_banner.dart';

class TypeSelectionScreen extends StatefulWidget {
  const TypeSelectionScreen({Key? key}) : super(key: key);

  @override
  _TypeSelectionScreenState createState() => _TypeSelectionScreenState();
}

class _TypeSelectionScreenState extends State<TypeSelectionScreen> {
  LetterType? _selectedType;
  Language _selectedLanguage = Language.turkish;

  void _navigateToNextScreen() {
    if (_selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen bir mektup türü seçin'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    String disclaimerTitle = '';
    String disclaimerMessage = '';

    switch (_selectedType!) {
      case LetterType.visa:
        disclaimerTitle = 'Vize Başvurusu Bilgilendirme';
        disclaimerMessage = '''Bu mektup, vize başvurunuz için bir destek belgesi niteliğindedir. Ancak:

• Bu mektup, vizenizin onaylanacağının garantisi değildir
• Her ülkenin vize politikaları ve gereksinimleri farklılık gösterebilir
• Mektubun içeriği genel bir şablon üzerine oluşturulmuştur
• Vize başvurunuzun sonucu, konsolosluğun değerlendirmesine bağlıdır

Mektubu kullanmadan önce, başvuru yapacağınız ülkenin vize gereksinimlerini detaylı olarak incelemenizi öneririz.

ÖNEMLİ: Uygulamamız, vize başvurunuzun reddi veya herhangi bir olumsuz sonuç durumunda hiçbir sorumluluk kabul etmemektedir. Mektubu kullanmaya karar verdiğinizde, tüm sorumluluğu kabul etmiş sayılırsınız.''';
        break;
      case LetterType.masters:
        disclaimerTitle = 'Yüksek Lisans Başvurusu Bilgilendirme';
        disclaimerMessage = '''Bu motivasyon mektubu, yüksek lisans başvurunuz için hazırlanacaktır. Lütfen şu noktaları göz önünde bulundurun:

• Bu mektup, başvurunuzun kabul edileceğinin garantisi değildir
• Her üniversitenin kabul kriterleri farklılık gösterebilir
• Mektup içeriği verdiğiniz bilgiler doğrultusunda oluşturulacaktır
• Başvuru sonucu, ilgili üniversitenin değerlendirme sürecine bağlıdır

Mektubu göndermeden önce, başvuracağınız üniversitenin gereksinimlerini ve formatını kontrol etmenizi öneririz.

ÖNEMLİ: Uygulamamız, başvurunuzun reddi veya herhangi bir olumsuz sonuç durumunda hiçbir sorumluluk kabul etmemektedir. Mektubu kullanmaya karar verdiğinizde, tüm sorumluluğu kabul etmiş sayılırsınız.''';
        break;
      case LetterType.job:
        disclaimerTitle = 'İş Başvurusu Bilgilendirme';
        disclaimerMessage = '''Bu motivasyon mektubu, iş başvurunuz için hazırlanacaktır. Önemli noktalar:

• Bu mektup, işe alınacağınızın garantisi değildir
• Her şirketin farklı değerlendirme kriterleri olabilir
• Mektup içeriği genel bir format üzerine oluşturulacaktır
• İş başvurunuzun sonucu, işverenin değerlendirmesine bağlıdır

Mektubu göndermeden önce, başvuracağınız pozisyonun gereksinimlerini ve şirketin beklentilerini göz önünde bulundurmanızı öneririz.

ÖNEMLİ: Uygulamamız, başvurunuzun reddi veya herhangi bir olumsuz sonuç durumunda hiçbir sorumluluk kabul etmemektedir. Mektubu kullanmaya karar verdiğinizde, tüm sorumluluğu kabul etmiş sayılırsınız.''';
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Column(
            children: [
              const Icon(
                Icons.info_outline,
                size: 36,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              Text(
                disclaimerTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              disclaimerMessage,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İPTAL'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                switch (_selectedType!) {
                  case LetterType.visa:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisaFormScreen(
                          language: _selectedLanguage,
                        ),
                      ),
                    );
                    break;
                  case LetterType.masters:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MastersFormScreen(
                          language: _selectedLanguage,
                        ),
                      ),
                    );
                    break;
                  case LetterType.job:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobFormScreen(
                          language: _selectedLanguage,
                        ),
                      ),
                    );
                    break;
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('ANLADIM, DEVAM ET'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeCard(LetterType type, IconData icon) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              ),
              const SizedBox(height: 12),
              Text(
                type.displayName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Hoş Geldiniz! 👋',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Profesyonel mektubunuzu oluşturmaya başlayalım.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'Mektup Türü',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1.2,
                            children: [
                              _buildTypeCard(LetterType.visa, Icons.flight),
                              _buildTypeCard(LetterType.masters, Icons.school),
                              _buildTypeCard(LetterType.job, Icons.work),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Mektup Dili',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonFormField<Language>(
                              value: _selectedLanguage,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                hintText: 'Dil seçin',
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                              items: Language.values.map((language) {
                                return DropdownMenuItem(
                                  value: language,
                                  child: Text(language.displayName),
                                );
                              }).toList(),
                              onChanged: (Language? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedLanguage = value;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _navigateToNextScreen,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Devam Et',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const AdBanner(),
              ],
            );
          },
        ),
      ),
    );
  }
}