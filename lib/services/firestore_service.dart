import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/models/firestore_base_model.dart';
import 'package:weight_tracker/models/weight_model.dart';
import 'package:weight_tracker/services/auth_service.dart';

class FirestoreService {
  FirestoreService(this._db, this._auth);

  final FirebaseFirestore _db;
  final AuthService _auth;

  Stream<List<WeightModel>> getWeightsList() {
    if (_auth.currentUser == null) {
      return const Stream.empty();
    }
    return _db
        .collection('weight')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .orderBy('createDate', descending: true)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => WeightModel.fromJson(document.data()))
            .toList());
  }

  Future add(FirestoreBaseModel item) async {
    await _db.collection(item.collectionName).add(item.toJson());
  }

  Future edit(FirestoreBaseModel item) async {
    _db.collection(item.collectionName);
  }

  Future delete(FirestoreBaseModel item) async {}
}
