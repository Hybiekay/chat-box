import 'package:flint_client/flint_client.dart';

class UserRepositry {
  UserRepositry({required this.client});

  final FlintClient client;

  Future<List<dynamic>> getAllUsers() async {
    final res = await client.get('/users');
    res.throwIfError();
    return res.data['users'] as List<dynamic>;
  }
}
