import 'package:flutter/material.dart';
import 'package:weight_tracker/models/weight_model.dart';
import 'package:weight_tracker/services/auth_service.dart';
import 'package:weight_tracker/services/firestore_service.dart';

class HomeViewmodel {
  HomeViewmodel(this._authService, this._firestoreService);

  final AuthService _authService;
  final FirestoreService _firestoreService;

  Future<void> logOut({required VoidCallback onSucces}) async {
    await _authService.logOut();
    debugPrint('log out successful');
    onSucces();
  }

  Stream<List<WeightModel>> createStream() {
    return _firestoreService.getWeightsList();
  }

  void addWeight(String weightStr, {required Function(String) onError}) {
    try {
      final weight = double.parse(weightStr);
      if (weight < 0 || weight > 600) {
        onError('Please enter a weight between 0 and 600 pounds');
        return;
      }
      final weightModel =
          WeightModel(_authService.currentUser!.uid, weight, DateTime.now());
      _firestoreService.add(weightModel);
    } catch (e) {
      onError('Please enter a valid weight');
    }
  }
}
