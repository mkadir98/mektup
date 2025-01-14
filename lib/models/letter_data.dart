class VisaLetterData {
  final String personalInfo;
  final String travelPurpose;
  final String travelPlan;
  final String personalHistory;
  final String senderAddress;
  final String recipientAddress;
  final String recipientName;
  final String senderName;

  VisaLetterData({
    required this.personalInfo,
    required this.travelPurpose,
    required this.travelPlan,
    required this.personalHistory,
    required this.senderAddress,
    required this.recipientAddress,
    required this.recipientName,
    required this.senderName,
  });
}

class MastersLetterData {
  final String date;
  final String fullName;
  final String address;
  final String recipientAddress;
  final String university;
  final String department;
  final String educationInfo;
  final String academicAchievements;
  final String skills;
  final String additionalInfo;

  MastersLetterData({
    required this.date,
    required this.fullName,
    required this.address,
    required this.recipientAddress,
    required this.university,
    required this.department,
    required this.educationInfo,
    required this.academicAchievements,
    required this.skills,
    required this.additionalInfo,
  });
}

class JobLetterData {
  final String senderAddress;
  final String recipientAddress;
  final String recipientName;
  final String senderName;
  final String date;

  JobLetterData({
    required this.senderAddress,
    required this.recipientAddress,
    required this.recipientName,
    required this.senderName,
    required this.date,
  });
} 