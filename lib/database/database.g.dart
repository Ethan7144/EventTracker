// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EventDao? _eventDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Event` (`title` TEXT NOT NULL, `description` TEXT NOT NULL, `startDate` INTEGER NOT NULL, `endDate` INTEGER NOT NULL, PRIMARY KEY (`title`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EventDao get eventDao {
    return _eventDaoInstance ??= _$EventDao(database, changeListener);
  }
}

class _$EventDao extends EventDao {
  _$EventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'Event',
            (Event item) => <String, Object?>{
                  'title': item.title,
                  'description': item.description,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                },
            changeListener),
        _eventUpdateAdapter = UpdateAdapter(
            database,
            'Event',
            ['title'],
            (Event item) => <String, Object?>{
                  'title': item.title,
                  'description': item.description,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                },
            changeListener),
        _eventDeletionAdapter = DeletionAdapter(
            database,
            'Event',
            ['title'],
            (Event item) => <String, Object?>{
                  'title': item.title,
                  'description': item.description,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final UpdateAdapter<Event> _eventUpdateAdapter;

  final DeletionAdapter<Event> _eventDeletionAdapter;

  @override
  Future<List<Event>> findAllEvents() async {
    return _queryAdapter.queryList('SELECT * FROM Event',
        mapper: (Map<String, Object?> row) => Event(
            title: row['title'] as String,
            description: row['description'] as String,
            startDate: _dateTimeConverter.decode(row['startDate'] as int),
            endDate: _dateTimeConverter.decode(row['endDate'] as int)));
  }

  @override
  Stream<List<String>> findAllTitles() {
    return _queryAdapter.queryListStream('SELECT title FROM Event',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Event',
        isView: false);
  }

  @override
  Stream<Event?> findEventbyTitle(String title) {
    return _queryAdapter.queryStream('SELECT * FROM Person WHERE title = ?1',
        mapper: (Map<String, Object?> row) => Event(
            title: row['title'] as String,
            description: row['description'] as String,
            startDate: _dateTimeConverter.decode(row['startDate'] as int),
            endDate: _dateTimeConverter.decode(row['endDate'] as int)),
        arguments: [title],
        queryableName: 'Person',
        isView: false);
  }

  @override
  Future<void> insertEvent(Event event) async {
    await _eventInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEvent(Event event) async {
    await _eventUpdateAdapter.update(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEvent(Event event) async {
    await _eventDeletionAdapter.delete(event);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
