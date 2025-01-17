import 'package:flutter/material.dart';
import '../../models/letter_data.dart';
import '../../models/enums.dart';
import '../letter_preview_screen.dart';
import '../../widgets/ai_info_box.dart';

class MastersFormScreen extends StatefulWidget {
  final Language language;

  const MastersFormScreen({Key? key, required this.language}) : super(key: key);

  @override
  _MastersFormScreenState createState() => _MastersFormScreenState();
}

class _MastersFormScreenState extends State<MastersFormScreen> {
  final _scrollController = ScrollController();

  // Controllers
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateController = TextEditingController();
  final _universityController = TextEditingController();
  final _departmentController = TextEditingController();
  final _educationInfoController = TextEditingController();
  final _academicAchievementsController = TextEditingController();
  final _skillsController = TextEditingController();
  final _additionalInfoController = TextEditingController();

  int _currentStep = 0;

  InputDecoration _getInputDecoration(String label,
      {String? helperText, IconData? icon}) {
    return InputDecoration(
      labelText: label,
      helperText: helperText,
      helperMaxLines: 2,
      prefixIcon: icon != null
          ? Icon(icon, size: 22, color: Colors.grey.shade600)
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kişisel Bilgileriniz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            const AiInfoBox(),
            const SizedBox(height: 32),
            TextFormField(
              controller: _fullNameController,
              decoration:
                  _getInputDecoration('Ad Soyad', icon: Icons.person_outline),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _addressController,
              decoration: _getInputDecoration('Adres',
                  icon: Icons.location_on_outlined),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _dateController,
              decoration: _getInputDecoration(
                'Tarih',
                helperText: 'GG.AA.YYYY formatında',
                icon: Icons.calendar_today,
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Başvuru Detayları',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            const AiInfoBox(),
            const SizedBox(height: 32),
            TextFormField(
              controller: _universityController,
              decoration: _getInputDecoration('Başvurulan Üniversite',
                  icon: Icons.school_outlined),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _departmentController,
              decoration: _getInputDecoration('Başvurulan Bölüm',
                  icon: Icons.business_outlined),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eğitim ve Başarılar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            const AiInfoBox(),
            const SizedBox(height: 32),
            TextFormField(
              controller: _educationInfoController,
              decoration: _getInputDecoration(
                'Eğitim Geçmişi',
                helperText: 'Lisans eğitimi ve diğer eğitim bilgileriniz',
                icon: Icons.school_outlined,
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _academicAchievementsController,
              decoration: _getInputDecoration(
                'Akademik Başarılar',
                helperText: 'Projeler, yayınlar, ödüller vb.',
                icon: Icons.emoji_events_outlined,
              ),
              maxLines: 4,
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yetenekler ve Ek Bilgiler',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            const AiInfoBox(),
            const SizedBox(height: 32),
            TextFormField(
              controller: _skillsController,
              decoration: _getInputDecoration(
                'Yetenekler ve Yetkinlikler',
                helperText:
                    'Teknik beceriler, dil becerileri, sertifikalar vb.',
                icon: Icons.psychology_outlined,
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _additionalInfoController,
              decoration: _getInputDecoration(
                'Ek Bilgiler',
                helperText: 'Eklemek istediğiniz diğer bilgiler',
                icon: Icons.note_add_outlined,
              ),
              maxLines: 4,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Klavyeyi kapat
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Yüksek Lisans Başvuru Formu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey.shade50,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                            4,
                            (index) => Expanded(
                              child: Container(
                                height: 4,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: index <= _currentStep
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _buildStepContent(_currentStep),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            if (_currentStep > 0)
                              Expanded(
                                child: TextButton(
                                  onPressed: () =>
                                      setState(() => _currentStep--),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.arrow_back_rounded),
                                      SizedBox(width: 8),
                                      Text(
                                        'Geri',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (_currentStep > 0) const SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_validateStep()) {
                                    if (_currentStep < 3) {
                                      setState(() => _currentStep++);
                                      _scrollController.animateTo(
                                        0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut,
                                      );
                                    } else {
                                      _submitForm();
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            'Lütfen tüm alanları doldurun'),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        backgroundColor: Colors.red.shade600,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _currentStep == 3
                                          ? 'Mektup Oluştur'
                                          : 'Devam Et',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.arrow_forward_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateStep() {
    // Her zaman true döndür - tüm alanlar boş bırakılabilir
    return true;
  }

  void _submitForm() {
    // Boş alanları "öneri yap" ile doldur
    _fullNameController.text = _fullNameController.text.isEmpty
        ? "öneri yap"
        : _fullNameController.text;
    _addressController.text = _addressController.text.isEmpty
        ? "öneri yap"
        : _addressController.text;
    _dateController.text = _dateController.text.isEmpty
        ? "öneri yap"
        : _dateController.text;
    _universityController.text = _universityController.text.isEmpty
        ? "öneri yap"
        : _universityController.text;
    _departmentController.text = _departmentController.text.isEmpty
        ? "öneri yap"
        : _departmentController.text;
    _educationInfoController.text = _educationInfoController.text.isEmpty
        ? "öneri yap"
        : _educationInfoController.text;
    _academicAchievementsController.text =
        _academicAchievementsController.text.isEmpty
            ? "öneri yap"
            : _academicAchievementsController.text;
    _skillsController.text = _skillsController.text.isEmpty
        ? "öneri yap"
        : _skillsController.text;
    _additionalInfoController.text = _additionalInfoController.text.isEmpty
        ? "öneri yap"
        : _additionalInfoController.text;

    final letterData = MastersLetterData(
      date: _dateController.text,
      fullName: _fullNameController.text,
      address: _addressController.text,
      university: _universityController.text,
      department: _departmentController.text,
      educationInfo: _educationInfoController.text,
      academicAchievements: _academicAchievementsController.text,
      skills: _skillsController.text,
      additionalInfo: _additionalInfoController.text,
      recipientAddress:
          '${_universityController.text}\n${_departmentController.text}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LetterPreviewScreen(
          letterData: letterData,
          letterType: LetterType.masters,
          language: widget.language,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // Controllers
    _fullNameController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    _universityController.dispose();
    _departmentController.dispose();
    _educationInfoController.dispose();
    _academicAchievementsController.dispose();
    _skillsController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }
}
