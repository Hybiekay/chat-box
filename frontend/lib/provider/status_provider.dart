import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/status_item_model.dart';
import 'package:frontend/repositry/auth_repositry.dart';
import 'package:frontend/provider/core_provider.dart';
import 'package:frontend/repositry/status_repositry.dart';

class StatusNotifier extends AsyncNotifier<List<StatusItemModel>> {
  @override
  Future<List<StatusItemModel>> build() async {
    return fetchStatuses();
  }

  Future<List<StatusItemModel>> fetchStatuses() async {
    final repository = ref.read(statusRepositoryProvider);
    final statuses = await repository.getAll();
    state = AsyncValue.data(statuses);
    return statuses;
  }

  Future<StatusItemModel> uploadStatus({
    required String content,
    required String type,
    File? file,
  }) async {
    final previous = state.asData?.value ?? <StatusItemModel>[];
    state = const AsyncValue.loading();
    final repository = ref.read(statusRepositoryProvider);
    final created = await repository.create(
      content: content,
      type: type,
      file: file,
    );

    final next = <StatusItemModel>[created, ...previous];
    state = AsyncValue.data(next);
    return created;
  }

  Future<List<StatusItemModel>> fetchStatusesByUser(String userId) async {
    final repository = ref.read(statusRepositoryProvider);
    return repository.getByUser(userId);
  }
}

final statusRepositoryProvider = Provider<StatusRepositry>((ref) {
  final client = ref.read(flintCLient);
  final authRepository = ref.read(authRepositryProvider);
  return StatusRepositry(client: client, authRepository: authRepository);
});

final statusProvider =
    AsyncNotifierProvider<StatusNotifier, List<StatusItemModel>>(
      StatusNotifier.new,
    );
