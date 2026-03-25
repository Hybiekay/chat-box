import 'package:backend/controllers/status_controller.dart';
import 'package:backend/middlewares/auth_middleware.dart';
import 'package:flint_dart/flint_dart.dart';

class StatusRoutes extends RouteGroup {
  @override
  String get prefix => '/status';

  @override
  List<Middleware> get middlewares => [];

  @override
  void register(Flint app) {
    final controller = StatusController();

    app.get('/', controller.index);
    app.get('/user/:userId', controller.getByUser);
    app.post('/', AuthMiddleware().handle(controller.create));
    app.post('/:id/read', AuthMiddleware().handle(controller.readStatus));
    app.get('/:id/read', controller.getReadStatus);
  }
}
