import 'package:mynote/repository/local_repository.dart';
import 'package:mynote/repository/repository.dart';
import 'package:mynote/ui/views/note/user_model.dart';

//import 'note_model.dart';
import 'user_model.dart';

class UserRepository implements Repository<User> {
  UserRepository._internal(LocalRepository localRepo) {
    this.localRepo = localRepo;
  }

  static final _cache = <String, UserRepository>{};

  factory UserRepository() {
    return _cache.putIfAbsent('NoteRepository',
        () => UserRepository._internal(LocalRepository.instance));
  }

  @override
  LocalRepository localRepo;

  @override
  Future<dynamic> insert(User item) async {
    final db = await localRepo.db();
    return await db.insert(User.tableName, item.toMap());
  }

  @override
  Future<dynamic> update(User item) async {
    final db = await localRepo.db();
    return await db.update(User.tableName, item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
  }

  @override
  Future<dynamic> delete(User item) async {
    return await localRepo.db().then((db) =>
        db.delete(User.tableName, where: 'id' + ' = ?', whereArgs: [item.id]));
  }

  @override
  Future<List<User>> items() async {
    final db = await localRepo.db();
    var maps = await db.query(User.tableName);
    return User.fromList(maps);
  }
}
