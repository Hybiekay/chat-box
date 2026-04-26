import 'package:backend/seeders/user_seeder.dart';
import 'package:flint_dart/flint_dart.dart';

Future<void> main() async {
  await runSeeders([
    UserSeeder(),
  ]);
}
