import 'package:flint_client/flint_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final flintCLient = Provider(
  (ref) => FlintClient(
    baseUrl: 'http://10.0.2.2:3001',
    onError: (error) {
      print(error.toMap());
    },
  ),
);

final storageProvider = Provider((ref) => FlutterSecureStorage());
