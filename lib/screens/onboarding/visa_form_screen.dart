import 'package:flutter/material.dart';
import '../../models/letter_data.dart';
import '../../models/enums.dart';
import '../letter_preview_screen.dart';

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

  InputDecoration _getInputDecoration(String label, {String? helperText, IconData? icon}) {
    return InputDecoration(
      labelText: label,
      helperText: helperText,
      helperMaxLines: 2,
      prefixIcon: icon != null ? Icon(icon, size: 22, color: Colors.grey.shade600) : null,
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
            const SizedBox(height: 8),
            Text(
              'Lütfen pasaportunuzda yazan bilgileri giriniz',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _fullNameController,
              decoration: _getInputDecoration('Ad Soyad', icon: Icons.person_outline),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _birthDateController,
              decoration: _getInputDecoration(
                'Doğum Tarihi',
                helperText: 'GG.AA.YYYY formatında',
                icon: Icons.calendar_today,
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _professionController,
              decoration: _getInputDecoration('Meslek', icon: Icons.work_outline),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _passportNumberController,
              decoration: _getInputDecoration(
                'Pasaport Numarası',
                icon: Icons.badge_outlined,
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seyahat Bilgileriniz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lütfen seyahat planınızı giriniz',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _consulateController,
              decoration: _getInputDecoration('Başvurulan Konsolosluk', icon: Icons.flag_outlined),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _travelDatesController,
              decoration: _getInputDecoration(
                'Seyahat Tarihleri',
                helperText: 'Gidiş-dönüş tarihleri',
                icon: Icons.calendar_today,
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _travelDurationController,
              decoration: _getInputDecoration(
                'Kalış Süresi',
                helperText: 'Toplam kalış süresi (gün)',
                icon: Icons.timer_outlined,
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
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
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Konaklama Bilgileriniz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lütfen konaklama bilgilerini giriniz',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _hotelNameController,
              decoration: _getInputDecoration('Konaklama Yeri Adı', icon: Icons.hotel_outlined),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _hotelAddressController,
              decoration: _getInputDecoration(
                'Konaklama Adresi',
                icon: Icons.location_on_outlined,
              ),
              maxLines: 2,
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _hotelContactController,
              decoration: _getInputDecoration(
                'Konaklama Yeri İletişim',
                helperText: 'Telefon/e-posta',
                icon: Icons.phone_outlined,
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ulaşım Bilgileriniz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lütfen ulaşım bilgilerini giriniz',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _flightDetailsController,
              decoration: _getInputDecoration(
                'Uçuş Bilgileri',
                helperText: 'Uçuş numaraları ve saatleri',
                icon: Icons.flight_outlined,
              ),
              maxLines: 2,
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
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
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
            ),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bağlayıcı Unsurlar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lütfen bağlayıcı unsurları giriniz',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _jobTiesController,
              decoration: _getInputDecoration(
                'İş Bağlantısı',
                helperText: 'Mevcut iş durumu ve pozisyonunuz',
                icon: Icons.work_outline,
              ),
              maxLines: 2,
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
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
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
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
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
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
            const SizedBox(height: 8),
            Text(
              'Lütfen maddi durumunuzu giriniz',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _financialStatusController,
              decoration: _getInputDecoration(
                'Maddi Durum Bilgisi',
                helperText: 'Aylık geliriniz, birikimleriniz ve maddi durumunuzu detaylı açıklayın',
                icon: Icons.attach_money_outlined,
              ),
              maxLines: 3,
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
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
              'İletişim Bilgileriniz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lütfen iletişim bilgilerinizi giriniz',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _senderAddressController,
              decoration: _getInputDecoration(
                'Ev Adresi',
                icon: Icons.location_on_outlined,
              ),
              maxLines: 3,
              validator: (value) => value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(
                          7,
                          (index) => Expanded(
                            child: Container(
                              height: 4,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
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
                                onPressed: () => setState(() => _currentStep--),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                          if (_currentStep > 0)
                            const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_validateCurrentStep()) {
                                  if (_currentStep < 6) {
                                    setState(() => _currentStep++);
                                    _scrollController.animateTo(
                                      0,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  } else {
                                    _submitForm();
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Lütfen tüm alanları doldurun'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: Colors.red.shade600,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentStep == 6 ? 'Mektup Oluştur' : 'Devam Et',
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
    );
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _fullNameController.text.isNotEmpty &&
               _birthDateController.text.isNotEmpty &&
               _professionController.text.isNotEmpty &&
               _passportNumberController.text.isNotEmpty;
      case 1:
        return _consulateController.text.isNotEmpty &&
               _travelDatesController.text.isNotEmpty &&
               _travelDurationController.text.isNotEmpty &&
               _travelPurposeController.text.isNotEmpty;
      case 2:
        return _hotelNameController.text.isNotEmpty &&
               _hotelAddressController.text.isNotEmpty &&
               _hotelContactController.text.isNotEmpty;
      case 3:
        return _flightDetailsController.text.isNotEmpty &&
               _localTransportController.text.isNotEmpty;
      case 4:
        return _jobTiesController.text.isNotEmpty &&
               _familyTiesController.text.isNotEmpty &&
               _propertyTiesController.text.isNotEmpty;
      case 5:
        return _financialStatusController.text.isNotEmpty;
      case 6:
        return _senderAddressController.text.isNotEmpty;
      default:
        return false;
    }
  }

  void _submitForm() {
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