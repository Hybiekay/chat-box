import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/user_model.dart';
import 'package:frontend/provider/core_provider.dart';
import 'package:frontend/repositry/user_repositry.dart';

class ContactsNotifier extends AsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    final repository = ref.read(userRepositoryProvider);
    final users = await repository.getAllUsers();
    return users
        .map((user) => UserModel.fromMap(Map<String, dynamic>.from(user)))
        .toList();
  }
}

final userRepositoryProvider = Provider<UserRepositry>((ref) {
  final client = ref.read(flintCLient);
  return UserRepositry(client: client);
});

final contactsProvider =
    AsyncNotifierProvider<ContactsNotifier, List<UserModel>>(
      ContactsNotifier.new,
    );
