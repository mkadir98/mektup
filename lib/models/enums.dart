enum LetterType {
  job('İş Başvurusu'),
  masters('Yüksek Lisans Motivasyon'),
  visa('Turistik Vize Niyet Mektubu');

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