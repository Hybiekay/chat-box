import 'package:flint_client/flint_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/provider/core_provider.dart';

class AuthRepositry {
  final FlintClient client;
  final FlutterSecureStorage storage;

  AuthRepositry({required this.client, required this.storage});
  Future<Map<String, String>> authHeaders({String? token}) async {
    final authToken = token ?? await getToken();
    if (authToken == null || authToken.isEmpty) {
      throw Exception('User is not authenticated');
    }

    return {'Authorization': 'Bearer $authToken'};
  }

  Future saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future register({
    required String name,
    required String email,
    required String password,
  }) async {
    var res = await client.post(
      '/auth/register',
      body: {'name': name, 'email': email, 'password': password},
    );
    if (res.isError) {
      return res.throwIfError();
    }
    return res.data;
  }

  Future login({required String email, required String password}) async {
    var res = await client.post(
      '/auth/login',
      body: {'email': email, 'password': password},
    );
    if (res.isError) {
      return res.throwIfError();
    }
    await saveToken(res.data['data']['token']);
    return res.data;
  }

  Future me({required String token}) async {
    var headers = await authHeaders(token: token);
    print(headers);
    var res = await client.post('/auth/me', headers: headers);
    print(res.data);
    if (res.isError) {
      return null;
    }
    return res.data;
  }
}

final authRepositryProvider = Provider((ref) {
  final client = ref.read(flintCLient);
  final storage = ref.watch(storageProvider);
  return AuthRepositry(client: client, storage: storage);
});
