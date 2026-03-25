import 'package:backend/models/user_model.dart';
import 'package:flint_dart/flint_dart.dart';

class UserSeeder {
  static Future<void> seedDemoUsers() async {
    final password = Hashing().hash('password123');

    const users = [
      {
        'name': 'Afrin Sabila',
        'email': 'afrin@example.com',
        'bio': 'Life is beautiful',
        'profilePicUrl':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=600&q=80',
      },
      {
        'name': 'Adil Adnan',
        'email': 'adil@example.com',
        'bio': 'Be your own hero',
        'profilePicUrl':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
      },
      {
        'name': 'Bristy Haque',
        'email': 'bristy@example.com',
        'bio': 'Keep working',
        'profilePicUrl':
            'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?auto=format&fit=crop&w=600&q=80',
      },
      {
        'name': 'John Borino',
        'email': 'john.borino@example.com',
        'bio': 'Make yourself proud',
        'profilePicUrl':
            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=600&q=80',
      },
      {
        'name': 'Borsha Akther',
        'email': 'borsha@example.com',
        'bio': 'Flowers are beautiful',
        'profilePicUrl':
            'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=600&q=80',
      },
      {
        'name': 'Sheik Sadi',
        'email': 'sheik@example.com',
        'bio': 'Stay focused and kind',
        'profilePicUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?auto=format&fit=crop&w=600&q=80',
      },
    ];

    for (final user in users) {
      final existingUser = await User().where('email', user['email']).first();
      if (existingUser != null) {
        continue;
      }

      await User().create({
        'name': user['name'],
        'email': user['email'],
        'bio': user['bio'],
        'password': password,
        'profilePicUrl': user['profilePicUrl'],
      });
    }
  }
}
