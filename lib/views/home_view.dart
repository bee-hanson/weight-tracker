import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/constants/routes.dart';
import 'package:weight_tracker/models/weight_model.dart';
import 'package:weight_tracker/viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView(this._homeViewmodel, {super.key});

  final HomeViewmodel _homeViewmodel;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<WeightModel>>(
        create: (context) => _homeViewmodel.createStream(),
        initialData: const [],
        builder: (context, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Weight Tracker'),
                actions: [
                  TextButton(
                    onPressed: () => _homeViewmodel.logOut(
                        onSucces: () => Navigator.pushNamedAndRemoveUntil(
                            context, loginRoute, (route) => false)),
                    child: const Text('Log Out'),
                  )
                ],
              ),
              body: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .25,
                        child: TextField(
                          controller: _textEditingController,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _homeViewmodel.addWeight(
                                _textEditingController.text,
                                onError: (errorMsg) =>
                                    showErrorDialog(errorMsg, context));
                            _textEditingController.clear();
                          },
                          child: const Text('Add Weight')),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: ListView.builder(
                        itemCount:
                            Provider.of<List<WeightModel>>(context).length,
                        itemBuilder: (context, index) {
                          final weight =
                              Provider.of<List<WeightModel>>(context)[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                                '${weight.createDate.toString()} - ${weight.weight.toString()}'),
                          );
                        }),
                  ),
                ]),
              ),
            ));
  }

  void showErrorDialog(String errorMessage, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
                child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(errorMessage),
            )));
  }
}
