import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:masroufi/model/transaction.dart' as T;
class TransactionsDatabase{
  static final TransactionsDatabase instance = TransactionsDatabase._init();

  static Database? _database;

  TransactionsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB('data.db');

    return _database!;
  }

  Future<Database> initDB(String dbFilePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,dbFilePath);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }
  Future _createDB(Database db,int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final floatType = 'FLOAT NOT NULL';
      db.execute('''
      CREATE TABLE ${T.tableTransactions} (
      ${T.TransactionFields.id} $idType,
      ${T.TransactionFields.title} $textType,
      ${T.TransactionFields.price} $floatType,
      ${T.TransactionFields.category} $textType,
      ${T.TransactionFields.date} $textType
      )
      ''');
  }
  Future<T.Transaction> create(T.Transaction transaction) async{
    final db = await instance.database;
    final id = await db.insert(T.tableTransactions, transaction.toJson());
    return transaction.copy(id:id);
  }
  Future<List<T.Transaction>> redAllTransactions() async {
    final db = await instance.database;
    final result = await db.query(T.tableTransactions);
    return result.map((json) => T.Transaction.fromJson(json)).toList();
  }
  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(T.tableTransactions,
        where:"${T.TransactionFields.id} = ?",
    whereArgs: [id]);
  }
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}