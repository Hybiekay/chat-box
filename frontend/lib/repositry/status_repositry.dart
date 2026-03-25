import 'dart:io';
import 'package:flint_client/flint_client.dart';
import 'package:frontend/model/status_item_model.dart';
import 'package:frontend/repositry/auth_repositry.dart';

class StatusRepositry {
  final FlintClient client;
  final AuthRepositry authRepository;

  StatusRepositry({required this.client, required this.authRepository});

  Future create({
    required String content,
    required String type,
    File? file,
  }) async {
    final headers = await authRepository.authHeaders();
    var res = await client.post(
      "/status",
      headers: headers,
      files: file == null ? null : {"file": file},
      body: {'type': type, "content": content},
    );

    if (res.isError) {
      res.throwIfError();
    }

    return StatusItemModel.fromMap(Map<String, dynamic>.from(res.data['data']));
  }

  Future<List<StatusItemModel>> getAll() async {
    final headers = await authRepository.authHeaders();
    final res = await client.get("/status", headers: headers);
    res.throwIfError();
    return (res.data['data'] as List<dynamic>)
        .map((item) => StatusItemModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<List<StatusItemModel>> getByUser(String userId) async {
    final headers = await authRepository.authHeaders();
    final res = await client.get("/status/user/$userId", headers: headers);
    res.throwIfError();
    return (res.data['data'] as List<dynamic>)
        .map((item) => StatusItemModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }
}
