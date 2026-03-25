import 'package:flint_dart/model.dart';
import 'package:flint_dart/schema.dart';
import 'package:backend/models/user_model.dart';

class Status extends Model<Status> {
  Status() : super(() => Status());

  // Define your fields here
  String? get content => getAttribute("content");
  String? get type => getAttribute("type");
  String? get url => getAttribute("url");
  String? get userId => getAttribute("userId");
  User? get user => getRelation<User>('user');

  @override
  Map<String, RelationDefinition> get relations => {
        'user': Relations.belongsTo(
          'user',
          () => User(),
          foreignKey: 'userId',
          ownerKey: 'id',
        ),
      };

  @override
  Table get table => Table(
        name: 'statuses',
        columns: [
          Column(name: 'userId', type: ColumnType.string),
          Column(
            name: 'content',
            type: ColumnType.string,
            defaultValue: '',
          ),
          Column(
            name: 'type',
            type: ColumnType.string,
            defaultValue: 'text',
          ),
          Column(
            name: 'url',
            type: ColumnType.string,
            isNullable: true,
            defaultValue: '',
          ),
        ],
      );
}
