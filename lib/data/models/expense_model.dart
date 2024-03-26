/// Represents an expense entity with date, item, amount, status, and optional deposit information.
class Expense {
  /// The date of the expense.
  final String date;

  /// The item description of the expense.
  final String item;

  /// The amount of the expense.
  final double amount;

  /// The status of the expense.
  final String status;

  /// The optional deposit information of the expense.
  final String? deposit;

  /// The unique identifier of the expense.
  final String id;

  /// The user ID associated with the expense.
  final String userId;

  /// Constructs a new Expense instance.
  ///
  /// [date] represents the date of the expense.
  /// [item] represents the item description of the expense.
  /// [amount] represents the amount of the expense.
  /// [status] represents the status of the expense.
  /// [id] represents the unique identifier of the expense.
  /// [userId] represents the user ID associated with the expense.
  Expense({
    required this.date,
    required this.item,
    required this.amount,
    required this.status,
    this.deposit,
    required this.id,
    required this.userId,
  });

  /// Converts the Expense object to a map representation.
  ///
  /// Returns a map containing the date, item, amount, status, id, and userId.
  Map<String, dynamic> toExpense() {
    return {
      "date": date,
      "item": item,
      "amount": amount,
      "status": status,
      "id": id,
      "userId": userId,
    };
  }

  /// Constructs a new Expense instance from a map.
  ///
  /// [map] is the map containing the expense data.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      date: map['date'],
      item: map['item'],
      amount: double.parse(map['amount'].toString()),
      status: map['status'],
      id: map['id'] ?? "",
      userId: map['userId'],
    );
  }
}
