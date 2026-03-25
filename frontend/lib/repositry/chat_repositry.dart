import 'package:flint_client/flint_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/chat_message_model.dart';
import 'package:frontend/provider/core_provider.dart';
import 'package:frontend/repositry/auth_repositry.dart';

class ChatRepositry {
  ChatRepositry({required this.client, required this.authRepository});

  final FlintClient client;
  final AuthRepositry authRepository;

  String buildConversationId({
    required String currentUserId,
    String? peerId,
    required String fallbackKey,
  }) {
    final cleanedCurrentUserId = currentUserId.trim();
    final cleanedPeerId = peerId?.trim();

    if (cleanedCurrentUserId.isNotEmpty &&
        cleanedPeerId != null &&
        cleanedPeerId.isNotEmpty) {
      final ids = [cleanedCurrentUserId, cleanedPeerId]..sort();
      return 'room_${ids.join('__')}';
    }

    final slug = fallbackKey
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');

    return 'demo_${slug.isEmpty ? 'chat' : slug}';
  }

  Future<List<ChatMessageModel>> getHistory({
    required String roomId,
    required String currentUserId,
  }) async {
    final headers = await authRepository.authHeaders();
    final res = await client.get('/chat/rooms/$roomId/messages', headers: headers);
    res.throwIfError();

    final responseData = res.data;
    final rawMessages = responseData is Map
        ? responseData['data'] as List<dynamic>? ?? const []
        : const [];

    return rawMessages
        .map((item) => ChatMessageModel.fromMap(
              Map<String, dynamic>.from(item as Map),
              currentUserId: currentUserId,
            ))
        .toList();
  }

  Future<FlintWebSocketClient> createSocket(String roomId) async {
    final headers = await authRepository.authHeaders();
    return client.ws('/chat/rooms/$roomId', headers: headers);
  }
}

final chatRepositryProvider = Provider<ChatRepositry>((ref) {
  final client = ref.read(flintCLient);
  final authRepository = ref.read(authRepositryProvider);
  return ChatRepositry(client: client, authRepository: authRepository);
});
