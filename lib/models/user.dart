class User {
  final String id;
  final String name;
  final String? profileImage;
  final Map<String, double> personalityTraits;
  final bool isNewUser;

  User({
    required this.id,
    required this.name,
    this.profileImage,
    required this.personalityTraits,
    this.isNewUser = true,
  });

  // Sample users for testing
  static User getSampleUser({bool isNew = true}) {
    if (isNew) {
      return User(
        id: '1',
        name: '',
        isNewUser: true,
        personalityTraits: {},
      );
    } else {
      return User(
        id: '2',
        name: 'Anaya Ali',
        profileImage: 'assets/images/anaya_res.png',
        isNewUser: false,
        personalityTraits: {
          'Innovative': 0.8,
          'Explorer': 0.6,
          'Strategist': 0.9,
          'Visionary': 0.7,
          'Socializer': 0.5,
          'Negotiator': 0.75,
          'Builder': 0.85,
          'Engineer': 0.95,
        },
      );
    }
  }
}
