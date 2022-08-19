import 'package:bikeapp_v0/model/station_model.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStationScreen extends StatefulWidget {
  const AddStationScreen({Key? key}) : super(key: key);

  @override
  State<AddStationScreen> createState() => _AddStationScreenState();
}

class _AddStationScreenState extends State<AddStationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nbBikesController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, "New Station"),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                const Text("Create new station"),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: " Station Name ",
                      labelStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.all(10)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: " Address ",
                      labelStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.all(10)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nbBikesController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: " Number of bikes ",
                      labelStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.all(10)),
                ),
                const SizedBox(
                  height: 20,
                ),
                _loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (!_formkey.currentState!.validate() == true) {
                                return;
                              }
                              setState(() {
                                _loading = true;
                              });

                              final stationsRef = FirebaseFirestore.instance
                                  .collection('stations')
                                  .doc();
                              Station station = Station(
                                  id: stationsRef.id,
                                  name: nameController.text,
                                  address: addressController.text,
                                  nbBikes: nbBikesController.text);

                              await stationsRef.set(station.toJson());

                              setState(() {
                                _loading = false;
                              });
                            },
                            child: const Text(
                              "Add Station",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),
              ],
            )),
      ),
    );
  }
}
