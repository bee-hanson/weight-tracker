import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/models/firestore_base_model.dart';

class WeightModel extends FirestoreBaseModel {
  WeightModel(this.userId, this.weight, this.createDate, this.id);

  final String? id;
  final String userId;
  final double weight;
  final DateTime createDate;

  @override
  String get collectionName => 'weight';

  @override
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'weight': weight, 'createDate': createDate};
  }

  WeightModel.fromJson(Map<String, dynamic> parsedJSON, String docId)
      : userId = parsedJSON['userId'],
        weight = parsedJSON['weight'],
        createDate = (parsedJSON['createDate'] as Timestamp).toDate(),
        id = docId;
}
