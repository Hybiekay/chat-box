import 'package:flint_dart/model.dart';
import 'package:flint_dart/schema.dart';

class StatusRead extends Model<StatusRead> {
  StatusRead() : super(() => StatusRead());

  // Define your fields here
  String? get statusId => getAttribute("statusId");
  String? get userId => getAttribute("userId");

  @override
  Table get table => Table(
        name: 'status_reads',
        columns: [
          Column(name: 'statusId', type: ColumnType.string),
          Column(name: 'userId', type: ColumnType.string),
        ],
      );
}
