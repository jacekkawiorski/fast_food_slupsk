import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionContend extends StatefulWidget {
  const AddOpinionContend({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final Function onSave;

  @override
  State<AddOpinionContend> createState() => _AddOpinionContendState();
}

class _AddOpinionContendState extends State<AddOpinionContend> {
  var resturantsName = '';
  var pizzaName = '';
  var rating = 1.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Wpisz nazwę restauracji',
              ),
              onChanged: (newValue) {
                setState(() {
                  resturantsName = newValue;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Podaj nazwe fast fooda.',
              ),
              onChanged: (newValue) {
                setState(() {
                  pizzaName = newValue;
                });
              },
            ),
            Slider(
              onChanged: (newValue) {
                setState(() {
                  rating = newValue;
                });
              },
              value: rating,
              min: 1.0,
              max: 6.0,
              divisions: 10,
              label: rating.toString(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: resturantsName.isEmpty || pizzaName.isEmpty
                    ? null
                    : () {
                        FirebaseFirestore.instance
                            .collection('restaurants')
                            .add({
                          'name': resturantsName,
                          'pizza': pizzaName,
                          'rating': rating,
                        });
                        widget.onSave();
                      },
                child: const Text('Dodaj'))
          ],
        ),
      ),
    );
  }
}
