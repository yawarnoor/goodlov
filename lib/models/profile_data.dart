class ProfileData {
  String? firstName;
  DateTime? dateOfBirth;
  String? gender;
  String? location;
  List<String>? interests;
  String? language;

  ProfileData({
    this.firstName,
    this.dateOfBirth,
    this.gender,
    this.location,
    this.interests,
    this.language,
  });

  // Helper method to get formatted interests as a string
  String getFormattedInterests() {
    if (interests == null || interests!.isEmpty) {
      return 'Add interests';
    }

    // Convert interest IDs to readable format and join with bullets
    final readableInterests = interests!.map((interest) {
      // Convert snake_case to Title Case
      return interest.split('_').map((word) {
        return word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '';
      }).join(' ');
    }).toList();

    return readableInterests.join(' • ');
  }

  // Helper method to get formatted date of birth
  String getFormattedDateOfBirth() {
    if (dateOfBirth == null) {
      return 'Add date of birth';
    }

    return '${dateOfBirth!.day.toString().padLeft(2, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.year}';
  }

  // Helper method to get language name from code
  String getLanguageName() {
    if (language == null) {
      return 'English';
    }

    final languageMap = {
      'en': 'English',
      'fr': 'French',
      'id': 'Indonesian',
      'en-GB': 'English (UK)',
      'it': 'Italian',
      'ms': 'Malay',
      'tr': 'Turkish',
      'nl': 'Dutch',
      'de': 'German',
    };

    return languageMap[language] ?? 'English';
  }
}
