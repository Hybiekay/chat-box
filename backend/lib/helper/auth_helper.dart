import 'package:backend/models/user_model.dart';
import 'package:flint_dart/auth.dart';
import 'package:flint_dart/flint_dart.dart';

extension AuthHelper on Request {
  Future<User?> get authUser async {
    var token = this.bearerToken;

    var payload = await Auth.verifyToken("$token");

    var user = await User().find(payload?['id']);

    return user;
  }
}
