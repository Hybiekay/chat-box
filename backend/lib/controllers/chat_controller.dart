import 'package:backend/helper/auth_helper.dart';
import 'package:backend/models/chat_message.dart';
import 'package:flint_dart/flint_dart.dart';

class ChatController {
  Future<Response?> history(Context ctx) async {
    final res = ctx.res;
    if (res == null) return null;

    final user = await ctx.req.authUser;
    if (user == null) {
      return res.status(401).json({
        'status': false,
        'message': 'Unauthorized',
      });
    }

    final roomId = ctx.req.param('roomId');
    if (roomId == null || roomId.trim().isEmpty) {
      return res.status(400).json({
        'status': false,
        'message': 'Room id is required',
      });
    }

    final messages = await ChatMessage()
        .where('conversationId', roomId)
        .withRelation('sender')
        .orderBy('sentAt', asc: true)
        .limit(100)
        .get();

    return res.json({
      'status': true,
      'data': messages.map((message) => message.toMap()).toList(),
    });
  }

  Future<Object?> connect(Context ctx) async {
    final socket = ctx.socket;
    if (socket == null) return null;

    final roomId = ctx.req.param('roomId');
    final user = await ctx.req.authUser;

    if (roomId == null || roomId.trim().isEmpty || user == null) {
      socket.emit('chat:error', {
        'message': 'Unauthorized',
      });
      return null;
    }

    final conversationId = roomId.trim();
    socket.join(conversationId);
    socket.emit('chat:ready', {
      'roomId': conversationId,
      'userId': user.id.toString(),
    });

    socket.on('ping', (_) {
      socket.emit('pong', {
        'roomId': conversationId,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });

    socket.on('chat:send', (dynamic payload) async {
      final data = _asMap(payload);
      final content = (data['content'] ?? data['text'] ?? '').toString().trim();
      if (content.isEmpty) {
        socket.emit('chat:error', {
          'message': 'Message cannot be empty',
        });
        return;
      }

      final messageType = (data['messageType'] ?? data['type'] ?? 'text')
          .toString()
          .trim();
      final recipientId = data['recipientId']?.toString();
      final sentAt = DateTime.now().toIso8601String();

      final created = await ChatMessage().create({
        'conversationId': conversationId,
        'senderId': user.id.toString(),
        'recipientId': recipientId,
        'content': content,
        'messageType': messageType.isEmpty ? 'text' : messageType,
        'sentAt': sentAt,
      });

      if (created == null) {
        socket.emit('chat:error', {
          'message': 'Message could not be saved',
        });
        return;
      }

      final stored = await ChatMessage()
          .withRelation('sender')
          .find(created.id);

      if (stored == null) {
        return;
      }

      socket.emitToRoom(
        conversationId,
        'chat:message',
        stored.toMap(),
        includeSelf: true,
      );
    });

    socket.onClose(() {
      socket.leave(conversationId);
    });

    return null;
  }

  Map<String, dynamic> _asMap(dynamic payload) {
    if (payload is Map<String, dynamic>) {
      return payload;
    }

    if (payload is Map) {
      return Map<String, dynamic>.from(payload);
    }

    return <String, dynamic>{};
  }
}
