import 'package:flint_dart/model.dart';
import 'package:flint_dart/schema.dart';
import 'package:backend/models/status.dart';

class User extends Model<User> {
  User() : super(() => User());

  String get name => getAttribute("name");
  String get email => getAttribute("email");
  String get password => getAttribute("password");
  String get profilePicUrl => getAttribute("profilePicUrl");
  String get bio => getAttribute("bio");
  String get address => getAttribute("address");
  String get phoneNumber => getAttribute("phoneNumber");
  List<Status>? get statuses => getRelation<List<Status>>('statuses');

  @override
  Map<String, RelationDefinition> get relations => {
        'statuses': Relations.hasMany(
          'statuses',
          () => Status(),
          foreignKey: 'userId',
          ownerKey: 'id',
        ),
      };

  @override
  // TODO: implement conceal
  List<String> get conceal =>
      ['provider', "provider_id", "phoneNumber", "password"];

  @override
  Table get table => Table(
        name: 'users',
        columns: [
          Column(name: 'name', type: ColumnType.string, length: 255),
          Column(name: 'email', type: ColumnType.string, length: 255),
          Column(
              name: 'bio',
              type: ColumnType.string,
              length: 755,
              defaultValue: 'Hey Am using chatbox'),
          Column(
            name: 'password',
            type: ColumnType.string,
          ),
          Column(
            name: 'profilePicUrl',
            type: ColumnType.string,
            isNullable: true,
            defaultValue:
                'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGhvdG98ZW58MHx8MHx8fDA%3D',
          ),
          Column(name: 'address', type: ColumnType.string, isNullable: true),
          Column(name: 'phoneNumber', type: ColumnType.string, isNullable: true)
        ],
      );
}
