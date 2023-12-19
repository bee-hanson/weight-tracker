import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/models/weight_model.dart';
import 'package:weight_tracker/services/auth_service.dart';

class FirestoreWeightService {
  FirestoreWeightService(this._db, this._auth);

  final FirebaseFirestore _db;
  final AuthService _auth;

  Stream<List<WeightModel>> getList() {
    if (_auth.currentUser == null) {
      return const Stream.empty();
    }
    return _db
        .collection('weight')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .orderBy('createDate', descending: true)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) =>
                WeightModel.fromJson(document.data(), document.id))
            .toList());
  }

  Future add(WeightModel item) async {
    await _db.collection(item.collectionName).add(item.toJson());
  }

  // TODO: create UI to call this
  Future edit(WeightModel item) async {
    _db
        .collection(item.collectionName)
        .doc(item.id)
        .update({'weight': item.weight});
  }

  // TODO: create UI to call this
  Future delete(WeightModel item) async {
    _db.collection(item.collectionName).doc(item.id).delete();
  }
}
