import 'package:flint_dart/flint_dart.dart';
import 'package:backend/controllers/auth_controller.dart';

/// Auth API routes
class AuthRoutes extends RouteGroup {
  @override
  String get prefix => '/auth';

  @override
  List<Middleware> get middlewares =>
      []; // optional global middleware for this group

  @override
  void register(Flint app) {
    final authController = AuthController();

    /// @summary Register a new user
    /// @auth bearer
    /// @response 200 Success response description
    /// @response 400 Bad request
    /// @response 401 Unauthorized
    /// @response 500 Internal server error
    /// @body {"field1": "string", "field2": "string"}
    app.post('/register', authController.register);

    /// @summary Login user
    /// @auth bearer
    /// @response 200 Success response description
    /// @response 400 Bad request
    /// @response 401 Unauthorized
    /// @response 500 Internal server error
    /// @body {"field1": "string", "field2": "string"}
    app.post('/login', authController.login);

    /// @summary Login with Google
    /// @auth bearer
    /// @response 200 Resource created successfully
    /// @response 400 Bad request
    /// @response 401 Unauthorized
    /// @response 500 Internal server error
    /// @body {"example": "string"}
    app.post('/login-with-google', authController.loginWithGoogle);

    /// @summary Get Auth Current User
    /// @auth bearer
    /// @response 200 Resource created successfully
    /// @response 400 Bad request
    /// @response 401 Unauthorized
    /// @response 500 Internal server error
    app.post('/me', authController.me);
  }
}
