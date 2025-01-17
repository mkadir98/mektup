import 'package:flutter/material.dart';
import '../../models/letter_data.dart';
import '../../models/enums.dart';
import '../letter_preview_screen.dart';
import '../../widgets/ai_info_box.dart';

class VisaFormScreen extends StatefulWidget {
  final Language language;

  const VisaFormScreen({Key? key, required this.language}) : super(key: key);

  @override
  _VisaFormScreenState createState() => _VisaFormScreenState();
}

class _VisaFormScreenState extends State<VisaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controllers...
  final _fullNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _professionController = TextEditingController();
  final _passportNumberController = TextEditingController();
  final _consulateController = TextEditingController();
  final _travelDatesController = TextEditingController();
  final _travelDurationController = TextEditingController();
  final _travelPurposeController = TextEditingController();
  final _hotelNameController = TextEditingController();
  final _hotelAddressController = TextEditingController();
  final _hotelContactController = TextEditingController();
  final _flightDetailsController = TextEditingController();
  final _localTransportController = TextEditingController();
  final _jobTiesController = TextEditingController();
  final _familyTiesController = TextEditingController();
  final _propertyTiesController = TextEditingController();
  final _financialStatusController = TextEditingController();
  final _sponsorshipController = TextEditingController();
  final _senderAddressController = TextEditingController();

  int _currentStep = 0;
  final _scrollController = ScrollController();

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
              controller: _birthDateController,
              decoration: _getInputDecoration(
                'Doğum Tarihi',
                helperText: 'GG.AA.YYYY formatında',
                icon: Icons.calendar_today,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _professionController,
              decoration:
                  _getInputDecoration('Meslek', icon: Icons.work_outline),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _passportNumberController,
              decoration: _getInputDecoration(
                'Pasaport Numarası',
                icon: Icons.badge_outlined,
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seyahat Bilgileri',
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
              controller: _consulateController,
              decoration: _getInputDecoration('Başvurulan Konsolosluk',
                  icon: Icons.flag_outlined),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _travelDatesController,
              decoration: _getInputDecoration(
                'Seyahat Tarihleri',
                helperText: 'Gidiş-dönüş tarihleri',
                icon: Icons.calendar_today,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _travelDurationController,
              decoration: _getInputDecoration(
                'Kalış Süresi',
                helperText: 'Toplam kalış süresi (gün)',
                icon: Icons.timer_outlined,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _travelPurposeController,
              decoration: _getInputDecoration(
                'Seyahat Amacı',
                helperText: 'Seyahatinizin detaylı amacı',
                icon: Icons.question_answer_outlined,
              ),
              maxLines: 3,
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Konaklama Bilgileri',
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
              controller: _hotelNameController,
              decoration: _getInputDecoration('Konaklama Yeri Adı',
                  icon: Icons.hotel_outlined),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _hotelAddressController,
              decoration: _getInputDecoration(
                'Konaklama Adresi',
                icon: Icons.location_on_outlined,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _hotelContactController,
              decoration: _getInputDecoration(
                'Konaklama Yeri İletişim',
                helperText: 'Telefon/e-posta',
                icon: Icons.phone_outlined,
              ),
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ulaşım Detayları',
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
              controller: _flightDetailsController,
              decoration: _getInputDecoration(
                'Uçuş Bilgileri',
                helperText: 'Uçuş numaraları ve saatleri',
                icon: Icons.flight_outlined,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _localTransportController,
              decoration: _getInputDecoration(
                'Yerel Ulaşım Planı',
                helperText: 'Ülke içi ulaşım detayları',
                icon: Icons.directions_bus_outlined,
              ),
              maxLines: 2,
            ),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bağlantılar',
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
              controller: _jobTiesController,
              decoration: _getInputDecoration(
                'İş Bağlantısı',
                helperText: 'Mevcut iş durumu ve pozisyonunuz',
                icon: Icons.work_outline,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _familyTiesController,
              decoration: _getInputDecoration(
                'Aile Bağları',
                helperText: 'Türkiye\'deki aile durumunuz',
                icon: Icons.family_restroom_outlined,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _propertyTiesController,
              decoration: _getInputDecoration(
                'Mülkiyet Bağları',
                helperText: 'Sahip olduğunuz mülkler',
                icon: Icons.home_outlined,
              ),
              maxLines: 2,
            ),
          ],
        );
      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Maddi Durum',
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
              controller: _financialStatusController,
              decoration: _getInputDecoration(
                'Maddi Durum Bilgisi',
                helperText:
                    'Aylık geliriniz, birikimleriniz ve maddi durumunuzu detaylı açıklayın',
                icon: Icons.attach_money_outlined,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _sponsorshipController,
              decoration: _getInputDecoration(
                'Sponsor Bilgisi',
                helperText: 'Varsa sponsor bilgileri',
                icon: Icons.person_add_outlined,
              ),
              maxLines: 2,
            ),
          ],
        );
      case 6:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adres Bilgileri',
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
              controller: _senderAddressController,
              decoration: _getInputDecoration(
                'Ev Adresi',
                icon: Icons.location_on_outlined,
              ),
              maxLines: 3,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  bool _validateStep() {
    // Her zaman true döndür - tüm alanlar boş bırakılabilir
    return true;
  }

  void _submitForm() {
    // Boş alanları "öneri yap" ile doldur
    _fullNameController.text = _fullNameController.text.isEmpty ? "öneri yap" : _fullNameController.text;
    _birthDateController.text = _birthDateController.text.isEmpty ? "öneri yap" : _birthDateController.text;
    _professionController.text = _professionController.text.isEmpty ? "öneri yap" : _professionController.text;
    _passportNumberController.text = _passportNumberController.text.isEmpty ? "öneri yap" : _passportNumberController.text;
    _consulateController.text = _consulateController.text.isEmpty ? "öneri yap" : _consulateController.text;
    _travelDatesController.text = _travelDatesController.text.isEmpty ? "öneri yap" : _travelDatesController.text;
    _travelDurationController.text = _travelDurationController.text.isEmpty ? "öneri yap" : _travelDurationController.text;
    _travelPurposeController.text = _travelPurposeController.text.isEmpty ? "öneri yap" : _travelPurposeController.text;
    _hotelNameController.text = _hotelNameController.text.isEmpty ? "öneri yap" : _hotelNameController.text;
    _hotelAddressController.text = _hotelAddressController.text.isEmpty ? "öneri yap" : _hotelAddressController.text;
    _hotelContactController.text = _hotelContactController.text.isEmpty ? "öneri yap" : _hotelContactController.text;
    _flightDetailsController.text = _flightDetailsController.text.isEmpty ? "öneri yap" : _flightDetailsController.text;
    _localTransportController.text = _localTransportController.text.isEmpty ? "öneri yap" : _localTransportController.text;
    _jobTiesController.text = _jobTiesController.text.isEmpty ? "öneri yap" : _jobTiesController.text;
    _familyTiesController.text = _familyTiesController.text.isEmpty ? "öneri yap" : _familyTiesController.text;
    _propertyTiesController.text = _propertyTiesController.text.isEmpty ? "öneri yap" : _propertyTiesController.text;
    _financialStatusController.text = _financialStatusController.text.isEmpty ? "öneri yap" : _financialStatusController.text;
    _sponsorshipController.text = _sponsorshipController.text.isEmpty ? "öneri yap" : _sponsorshipController.text;
    _senderAddressController.text = _senderAddressController.text.isEmpty ? "öneri yap" : _senderAddressController.text;

    final personalInfo = '''
Ad Soyad: ${_fullNameController.text}
Doğum Tarihi: ${_birthDateController.text}
Meslek: ${_professionController.text}
Pasaport No: ${_passportNumberController.text}''';

    final travelPurpose = '''
Seyahat Tarihleri: ${_travelDatesController.text}
Kalış Süresi: ${_travelDurationController.text}
Seyahat Amacı: ${_travelPurposeController.text}

Konaklama Bilgileri:
${_hotelNameController.text}
${_hotelAddressController.text}
İletişim: ${_hotelContactController.text}

Ulaşım Detayları:
Uçuş: ${_flightDetailsController.text}
Yerel Ulaşım: ${_localTransportController.text}''';

    final travelPlan = '''
İş Bağlantısı: ${_jobTiesController.text}
Aile Bağları: ${_familyTiesController.text}
Mülkiyet: ${_propertyTiesController.text}

Maddi Durum: ${_financialStatusController.text}
${_sponsorshipController.text.isNotEmpty ? 'Sponsor: ${_sponsorshipController.text}' : ''}''';

    final letterData = VisaLetterData(
      personalInfo: personalInfo,
      travelPurpose: travelPurpose,
      travelPlan: travelPlan,
      personalHistory: '',
      senderAddress: _senderAddressController.text,
      recipientAddress: '',
      recipientName: _consulateController.text,
      senderName: _fullNameController.text,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LetterPreviewScreen(
          letterData: letterData,
          letterType: LetterType.visa,
          language: widget.language,
        ),
      ),
    );
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
                        'Vize Başvuru Formu',
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
                            7,
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
                                    if (_currentStep < 6) {
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
                                      _currentStep == 6
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

  @override
  void dispose() {
    _scrollController.dispose();
    _fullNameController.dispose();
    _birthDateController.dispose();
    _professionController.dispose();
    _passportNumberController.dispose();
    _consulateController.dispose();
    _travelDatesController.dispose();
    _travelDurationController.dispose();
    _travelPurposeController.dispose();
    _hotelNameController.dispose();
    _hotelAddressController.dispose();
    _hotelContactController.dispose();
    _flightDetailsController.dispose();
    _localTransportController.dispose();
    _jobTiesController.dispose();
    _familyTiesController.dispose();
    _propertyTiesController.dispose();
    _financialStatusController.dispose();
    _sponsorshipController.dispose();
    _senderAddressController.dispose();
    super.dispose();
  }
}
