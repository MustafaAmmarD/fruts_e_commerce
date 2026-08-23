import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruts_e_commerce/core/services/database_service.dart';


class FirestoreService implements DatabaseService {

FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId
  }) async {
    if ( documentId != null) {
  firestore.collection(path).doc(documentId).set(data);
}else{
await FirebaseFirestore.instance.collection(path).add(data);
}
  }

  @override
  Future<dynamic> getData({required String path,  String? documentId, Map<String, dynamic>? query}) async {
    
   if (documentId != null) {
  var data = await firestore.collection(path).doc(documentId).get();
  
  return data.data() as Map<String,dynamic>;
}else{
  Query<Map<String, dynamic>> data = firestore.collection(path);
  if (query != null){
    if (query['whereField'] != null && query['whereIsEqualTo'] != null) {
      data = data.where(query['whereField'], isEqualTo: query['whereIsEqualTo']);
    }
    
    if (query['orderBy'] != null){
      var orderByField = query['orderBy'];
      var descending = query['descending'];
      data = data.orderBy(orderByField, descending: descending);
    }

    if (query['limit'] != null){
      var limit = query['limit'];
      data = data.limit(limit);
    }
  }
  // Always fetch and return data, whether query exists or not
  var result = await data.get();
  return result.docs.map((e) => e.data()).toList();
  }
  }
  
  @override
  Future<bool> checkIfDataExists({required String path, required String documentId}) async {
    
    var doc = await firestore.collection(path).doc(documentId).get();
    return doc.exists; 
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    await firestore.collection(path).doc(documentId).update(data);
  }

}

