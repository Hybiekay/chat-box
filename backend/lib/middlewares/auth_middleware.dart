import 'package:backend/models/user_model.dart';
import 'package:flint_dart/auth.dart';
import 'package:flint_dart/flint_dart.dart';

class AuthMiddleware extends Middleware {
  @override
  Handler handle(Handler next) {
    return (Context ctx) async {
      final req = ctx.req;
      final res = ctx.res;
      if (res == null) return null;

      final token = req.bearerToken;
      if (token == null) {
        return res.status(401).send("Unauthorized");
      }

      final payload = await Auth.verifyToken(token);
      if (payload == null) {
        return res.status(401).send("Unauthorized");
      }

      final user = await User().find(payload['id']);
      if (user == null) {
        return res.status(401).send("Unauthorized");
      }
      print(token);
      return await next(ctx);
    };
  }
}
