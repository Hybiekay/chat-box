import 'package:flint_dart/flint_dart.dart';

class ValidationMiddleware extends Middleware {
  final Map<String, String> rules;

  ValidationMiddleware(this.rules);

  @override
  Handler handle(Handler next) {
    return (Context ctx) async {
      final req = ctx.req;
      final res = ctx.res;
      if (res == null) return null;

      try {
        final data = await req.json();
        await Validator.validate(data, rules);
        return await next(ctx);
      } catch (e) {
        return res.status(400).json({'error': e.toString()});
      }
    };
  }
}
