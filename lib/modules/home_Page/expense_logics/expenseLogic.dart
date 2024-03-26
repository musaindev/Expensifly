import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensifly/data/models/user.dart';
import 'package:expensifly/utils/firebase_const.dart';
import 'package:intl/intl.dart';
import 'package:sync_ease/sync_ease/src/sync_ease_logic.dart';

import '../../../data/models/expense_model.dart';

class ExpenseLogic extends SyncEaseLogic {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<User> users = [];
  List<Expense> expenses = [];
  String? selectedUserName;
  double todayExpense = 0.0;
  double monthlyExpense = 0.0;

  List<QueryDocumentSnapshot> dataList = [];

  ExpenseLogic() {
    get();
  }

  void todayCalculation() {
    todayExpense = 0;
    List<Expense> today = [];
    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    for (Expense data in expenses) {
      String expenseDate = data.date;

      if (expenseDate == todayDate && data.status == 'd') {
        today.add(data);
        todayExpense += data.amount;
      }
    }
  }

  void monthCalculation() {
    monthlyExpense = 0;
    List<Expense> monthExpense = [];
    String monthlyCurrentDate =
    DateFormat('MM-yyyy').format(DateTime.now());
    for (Expense expense in expenses) {
      String monthDate ="${expense.date.split("-")[1]}-${expense.date.split("-")[2]}";

      if (monthlyCurrentDate == monthDate && expense.status == 'd') {
        monthExpense.add(expense);
      }
    }
    for (Expense docs in monthExpense) {
      monthlyExpense = docs.amount + monthlyExpense;
    }
  }

  Future<void> get() async {
    // Get the stream of snapshots from Firestore
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = _db
        .collection(FirebaseConst.expensesCollection)
        .orderBy('date', descending: true)
        .snapshots();

    // Listen to the stream for changes
    snapshots.listen((QuerySnapshot<Map<String, dynamic>> value) {
      // Clear existing expenses list
      expenses.clear();

      // Iterate through each document in the snapshot
      for (QueryDocumentSnapshot expenseData in value.docs) {
        // Convert each document data into an Expense object and add it to the list
        expenses
            .add(Expense.fromMap(expenseData.data() as Map<String, dynamic>));
      }
      todayCalculation();
      monthCalculation();

      // Call put method after updating expenses list (assuming it updates some UI or state)
      put();
      getUserData();
    });
  }

  update(
      {required String date,
      required String item,
      required String amount,
      required String status,
      String? userId}) async {
    // add validation
    await _db.collection(FirebaseConst.expensesCollection).doc().update({
      'date': date,
      'item': item,
      'amount': amount,
      'status': status,
      'userId': userId
    });
  }

  Future<void> addExpenses(
      {required String date,
      required String item,
      required String amount,
      required String status,
      String? userId}) async {
    //add condition for validate
    final addedData =
        await _db.collection(FirebaseConst.expensesCollection).add({
      'date': date,
      'item': item,
      'amount': amount,
      'status': status,
      'userId': userId,
    });

    addedData.update({"id": addedData.id});
  }

  Future<void> getUserData() async {
    users.clear();
    QuerySnapshot<Map<String, dynamic>> value =
        await _db.collection(FirebaseConst.usersCollection).get();
    if (value.docs.isNotEmpty) {
      for (QueryDocumentSnapshot userData in value.docs) {
        users.add(User.fromMap(userData.data() as Map<String, dynamic>));
        put();
      }
    }
    userDeposit();
  }

  Future<void> getExpenseData(
      {required String? fromDate, required String? toDate}) async {
    QuerySnapshot<Map<String, dynamic>> value = await _db
        .collection(FirebaseConst.expensesCollection)
        .where('date', isGreaterThanOrEqualTo: fromDate)
        .where('date', isLessThanOrEqualTo: toDate)
        .get();

    if (value.docs.isNotEmpty) {
      dataList = value.docs;
      put();
    }
  }

  void deleteExpense(int index) {
    _db
        .collection(FirebaseConst.expensesCollection)
        .doc(expenses[index].id)
        .delete()
        .then((_) {
      // Remove the expense from the expenses list
      expenses.removeAt(index);
      // Call put method after deleting the expense (assuming it updates some UI or state)
      put();
    }).catchError((error) {});
  }

  userDeposit() {
    for (User element in users) {
      String userId = element.userId;
      element.deposit = 0.0;
      String currentMonth = DateFormat('MM-yyyy').format(DateTime.now());

      for (Expense expense in expenses) {
        String expenseMonth ="${expense.date.split("-")[1]}-${expense.date.split("-")[2]}";


        if (currentMonth == expenseMonth &&
            expense.status == "c" &&
            expense.userId == userId) {
          element.deposit = element.deposit + expense.amount;

        }
      }
    }
    put();
  }
}
