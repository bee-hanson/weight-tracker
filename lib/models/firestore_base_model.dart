abstract class FirestoreBaseModel {
  String get collectionName;

  Map<String, dynamic> toJson();
}
