// import 'package:cloud_firestore/cloud_firestore.dart';
// class Curd {
//   Future<void> create({required String collName,required String docName,
//     required String note}) async{
//     await FirebaseFirestore.instance
//         .collection(collName)
//         .doc(docName)
//         .set({'Note':note,'Check':false});
//     print("Insert");
//   }
//
//   Future<List<int>> findDocId({required String collName}) async{
//
//     List<int> docId = [];
//
//     CollectionReference collection = FirebaseFirestore.instance
//         .collection(collName);
//
//     QuerySnapshot snapshot = await collection.get();
//     for(var doc in snapshot.docs) {
//       final parseId = int.tryParse(doc.id);
//       if(parseId !=null) {
//         docId.add(parseId);
//       }
//     }
//     docId.sort();
//     return docId;
//   }
//
//   Future<List<String>> showData({required String collName}) async{
//
//     List<String> docData = [];
//     CollectionReference collection = FirebaseFirestore.instance
//         .collection(collName);
//
//     QuerySnapshot snapshot = await collection.get();
//
//     for (var doc in snapshot.docs) {
//       final rawData = doc.data() as Map<String, dynamic>;
//       docData.add(rawData['Note']);
//     }
//     return docData;
//   }
//
//
//
//   Future<List<bool>> showCheck({required String collName}) async{
//     List<bool> docCheck = [];
//
//     CollectionReference collection = FirebaseFirestore.instance.collection(collName);
//
//     QuerySnapshot snapshot = await collection.get();
//
//     for(var doc in snapshot.docs) {
//       final rawData = doc.data() as Map<String,dynamic>;
//       docCheck.add(rawData['Check']);
//     }
//     return docCheck;
//   }
//
//   Future<void> updateCheck({required String collName,required docName,
//   required bool status})
//   async {
//     await FirebaseFirestore.instance
//         .collection(collName)
//         .doc(docName)
//         .update({'Check':status});
//     print("Check Update");
//   }
//
//   Future<void> deleteRecord({required String collName,required
//   List<String> docName})
//   async{
//     for(String doc in docName) {
//       await FirebaseFirestore.instance
//           .collection(collName)
//           .doc(doc)
//           .delete();
//     }
//     print("Delete Doc");
//   }
//
//   Future<List<String>> usingCheckGiveId({required String collName}) async{
//     List<String> docId = [];
//
//     CollectionReference collection = FirebaseFirestore.instance.collection(collName);
//
//     QuerySnapshot snapshot = await collection.get();
//
//     for(var doc in snapshot.docs) {
//       final rawData = doc.data() as Map<String,dynamic>;
//       if(rawData['Check'] == true) {
//         docId.add(doc.id);
//       }
//     }
//     return docId;
//   }
//
//   Future<void> updateData({required String collName,required docName,
//     required modifiedData})
//   async {
//     await FirebaseFirestore.instance
//         .collection(collName)
//         .doc(docName)
//         .update({'Note':modifiedData});
//     print("Data Update");
//   }
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';
class Curd {
  Future<void> create({required String collName,required String docName,
    required String note}) async{
    await FirebaseFirestore.instance
        .collection(collName)
        .doc(docName)
        .set({
      'Note': note,
      'Check': false,
      'createdAt': FieldValue.serverTimestamp()
    });
    print("Insert");
  }

  Future<List<int>> findDocId({required String collName}) async{

    List<int> docId = [];

    CollectionReference collection = FirebaseFirestore.instance
        .collection(collName);

    QuerySnapshot snapshot = await collection.get();
    for(var doc in snapshot.docs) {
      final parseId = int.tryParse(doc.id);
      if(parseId !=null) {
        docId.add(parseId);
      }
    }
    docId.sort();
    return docId;
  }

  Future<void> updateCheck({required String collName,required docName,
    required bool status})
  async {
    await FirebaseFirestore.instance
        .collection(collName)
        .doc(docName)
        .update({'Check':status});
    print("Check Update");
  }

  Future<void> deleteRecord({required String collName,required
  List<String> docName})
  async{
    for(String doc in docName) {
      await FirebaseFirestore.instance
          .collection(collName)
          .doc(doc)
          .delete();
    }
    print("Delete Doc");
  }

  Future<void> updateData({required String collName,required docName,
    required modifiedData})
  async {
    await FirebaseFirestore.instance
        .collection(collName)
        .doc(docName)
        .update({'Note':modifiedData});
    print("Data Update");
  }

  Future<List<Map<String,dynamic>>> showDataWithId({required String collName})
  async{

    List<Map<String,dynamic>> docList = [];
    CollectionReference collection = FirebaseFirestore.instance
        .collection(collName);

    QuerySnapshot snapshot = await collection.orderBy('createdAt').get();

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      docList.add({
        'id':doc.id,
        'note':data['Note'],
        'check':data['Check']
      });
    }

    return docList;
  }

}


