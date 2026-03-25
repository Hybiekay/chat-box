import 'package:flint_dart/auth.dart';
import 'package:flint_dart/exception.dart';
import 'package:flint_dart/flint_dart.dart';
import 'package:backend/models/user_model.dart';

class AuthController extends Controller {
  Future<Response?> me(Context ctx) async {
    final res = ctx.res;
    final req = ctx.req;
    if (res == null) return null;
    print(req.headers);
    var token = req.bearerToken;

    if (token == null) return res.json({"message": "Unauthorized"});

    var payload = Auth.verifyToken(token);

    User? user = await User().find(payload?['id']);

    if (user == null) {
      return res.json({'message': 'user does not exist'}, status: 401);
    }

    return res.json({'status': true, 'data': user.toMap()});
  }

  Future<Response?> register(ctx) async {
    final req = ctx.req;
    final res = ctx.res;
    if (res == null) return null;

    try {
      final body = await req.json();
      await Validator.validate(body, {
        "email": "required|email",
        "name": "required|string",
        "password": "required|string"
      });
      String hashPassword = Hashing().hash(body["password"]);
      body["password"] = hashPassword;

      // var user = Auth.register(
      //     email: body['email'], password: body['password'], name: body['name']);

      var user = await User().where('email', body['email']).first();
      if (user != null) {
        return res.json(
            {'status': false, 'message': 'User already exist with this email'},
            status: 400);
      }

      user = await User().create(body);
      return res.json({"status": "success", "data": user});
    } on ValidationException catch (e) {
      return res.status(422).json({"status": "errors", "errors": e.errors});
    } on AuthException catch (e) {
      print(e.message);
      return res.status(422).json(
        {"status": "error", "message": 'Hekko'},
      );
    } catch (e) {
      return res.status(422).json(
        {"status": "error", "message": e.toString()},
      );
    }
  }

  Future<Response?> login(Context ctx) async {
    final req = ctx.req;
    final res = ctx.res;
    if (res == null) return null;

    try {
      var body = await req.json();

      // Validator.validate(
      //     body, {"email": "required|string", "password": "required|string"});
      print(body);
      final token = await Auth.login(body['email'], body["password"]);

      return res.json({"status": "successfull", "data": token});
    } on ValidationException catch (e) {
      return res.status(422).json({"status": "errors", "errors": e.errors});
    } catch (e) {
      return res.status(422).json({"status": "errors", "errors": e.toString()});
    }
  }

  Future<Response?> loginWithGoogle(Context ctx) async {
    final req = ctx.req;
    final res = ctx.res;
    if (res == null) return null;

    try {
      final body = await req.json();

      // Check if idToken or code is present and validate
      await Validator.validate(body,
          {"idToken": "string", "code": "string", "callbackPath": "string"});

      // Pass either idToken or code to the Auth class
      final Map<String, dynamic> authResult = await Auth.loginWithGoogle(
        idToken: body['idToken'],
        code: body['code'],
        callbackPath: body['callbackPath'],
      );

      return res.json({
        "status": "success",
        "data": authResult,
      });
    } on ArgumentError catch (e) {
      return res.status(400).json({"status": "error", "message": e.message});
    } on ValidationException catch (e) {
      return res.status(400).json({"status": "error", "message": e.errors});
    } catch (e) {
      return res.status(401).json({"status": "error", "message": e.toString()});
    }
  }

  Future<Response?> update(Context ctx) async {
    final req = ctx.req;
    final res = ctx.res;
    if (res == null) return null;

    return res.send('Updating item ${req.params['id']}');
  }

  Future<Response?> delete(Context ctx) async {
    final req = ctx.req;
    final res = ctx.res;
    if (res == null) return null;

    return res.send('Deleting item ${req.params['id']}');
  }
}
