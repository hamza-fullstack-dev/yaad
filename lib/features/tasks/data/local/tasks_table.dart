import 'package:drift/drift.dart';

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get notes => text().nullable()();
  IntColumn get category => integer()();
  DateTimeColumn get dueDate => dateTime()();
  IntColumn get dueTimeMinutes => integer().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(1))();
  IntColumn get recurrence => integer().withDefault(const Constant(0))();
  BoolColumn get isAlarm => boolean().withDefault(const Constant(false))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
