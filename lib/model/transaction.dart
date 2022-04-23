final String tableTransactions = "transactions";

class TransactionFields {
  static final String id = "_id";
  static final String title = "title";
  static final String price = "price";
  static final String category = "category";
  static final String date = "date";
}


class Transaction{
  final int? id;
  final String title;
  final double price;
  final String category;
  final DateTime date;

  const Transaction({this.id,required this.title,required this.price, required this.category,required this.date});

  Map<String,Object?> toJson() => {
    TransactionFields.id : id,
    TransactionFields.title : title,
    TransactionFields.price : price,
    TransactionFields.category : category,
    TransactionFields.date : date.toIso8601String(),
  };

  Transaction copy({
    int? id,
    String? title,
    double? price,
    String? category,
    DateTime? date,
  }) => Transaction(id:id ?? this.id,title:title ?? this.title,price: price ?? this.price,
      category: category ?? this.category,date:date ?? this.date);

  static Transaction fromJson(Map<String,Object?> json) => Transaction(
    id: json[TransactionFields.id] as int?,
    title: json[TransactionFields.title] as String,
    price: json[TransactionFields.price] as double,
    category: json[TransactionFields.category] as String,
    date: DateTime.parse(json[TransactionFields.date] as String)
  );


}

