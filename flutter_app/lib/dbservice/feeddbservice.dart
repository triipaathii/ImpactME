  import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/feeds.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

// addEmployee(Employee employeeData) async {
//     await _db.collection("Employees").add(employeeData.toMap());
//   }

 class DatabaseService{  
  Future<List<Feed>?> retrieveFeeds() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Feeds").get();
    return snapshot.docs
        .map((docSnapshot) => Feed.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
 }