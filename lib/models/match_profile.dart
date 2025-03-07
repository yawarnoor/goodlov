class MatchProfile {
  final String id;
  final String name;
  final String imageUrl;
  final bool isActiveToday;
  final int compatibilityScore;
  final String location;
  final String occupation;
  final String bio;
  final List<String> hobbies;
  final List<String> traits;

  MatchProfile({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isActiveToday = true,
    required this.compatibilityScore,
    required this.location,
    required this.occupation,
    required this.bio,
    required this.hobbies,
    required this.traits,
  });

  static List<MatchProfile> getSampleProfiles() {
    return [
      MatchProfile(
        id: '1',
        name: 'Anaya Ali',
        imageUrl: 'assets/images/anaya.png',
        compatibilityScore: 85,
        location: 'United Kingdom',
        occupation: 'Graphic Designer',
        bio:
            "I'm an adventurous soul who loves hiking, photography and exploring. Professionally, I'm a graphic designer passionate about connecting with new people.",
        hobbies: ['Travelling', 'Cycling', 'Baking', 'TV Shows', 'Spice Lover'],
        traits: ['Adventurous', 'Outgoing', 'Creative Thinker'],
      ),
      MatchProfile(
        id: '2',
        name: 'Sophia',
        imageUrl: 'assets/images/sophia.png',
        compatibilityScore: 80,
        location: 'United States',
        occupation: 'Software Engineer',
        bio:
            "Tech enthusiast with a love for coding and outdoor adventures. Always up for trying new cuisines and exploring hidden gems in the city.",
        hobbies: ['Coding', 'Hiking', 'Cooking', 'Photography', 'Travel'],
        traits: ['Analytical', 'Curious', 'Adventurous'],
      ),
      MatchProfile(
        id: '3',
        name: 'Lina',
        imageUrl: 'assets/images/lina.png',
        compatibilityScore: 75,
        location: 'Canada',
        occupation: 'Yoga Instructor',
        bio:
            "Passionate about wellness and mindfulness. I love helping others find balance in their lives through yoga and meditation.",
        hobbies: ['Yoga', 'Meditation', 'Reading', 'Gardening', 'Painting'],
        traits: ['Calm', 'Empathetic', 'Spiritual'],
      ),
    ];
  }
}
