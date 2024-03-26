import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensifly/utils/firebase_const.dart';
import 'package:sync_ease/sync_ease.dart';

class ExpenseDataFetcher extends SyncEaseLogic {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];

  Future<void> getExpenseData({required String? fromDate, required String? toDate}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> value = await _db
          .collection(FirebaseConst.expensesCollection)
          .where('date', isGreaterThanOrEqualTo: fromDate)
          .where('date', isLessThanOrEqualTo: toDate)
          .get();

      if (value.docs.isNotEmpty) {
        dataList = value.docs.map((doc) => doc.data()).toList();
        // Here, you can do something with dataList, such as updating UI
        // For example, if you have a method to update the UI:
        // updateUI(dataList);
      } else {
        // Handle case where no documents were found
        // For example, show a message indicating no data found
        // showNoDataFoundMessage();
      }
    } catch (error) {
      // Handle error, such as displaying an error message
      // showErrorDialog(error.toString());
    }
  }
}
