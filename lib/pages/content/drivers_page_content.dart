import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/features/drivers/drivers_bloc.dart';
import 'package:flutter_test_work/features/drivers/drivers_event.dart';
import 'package:flutter_test_work/features/drivers/drivers_state.dart';
import 'package:flutter_test_work/models/driver_model.dart';

class DriversPageContent extends StatefulWidget {
  const DriversPageContent({super.key});

  @override
  State<DriversPageContent> createState() => _DriversPageContentState();
}

class _DriversPageContentState extends State<DriversPageContent> {
  final DriversBloc _driversBloc = DriversBloc();

  @override
  void initState() {
    _driversBloc.add(GetDriversList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _driversBloc,
      child: BlocListener<DriversBloc, DriversState>(
        listener: (context, state) {
          if (state is DriversError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<DriversBloc, DriversState>(
          builder: (context, state) {
            if (state is DriversInitial) {
              return _buildLoading();
            } else if (state is DriversLoading) {
              return _buildLoading();
            } else if (state is DriversLoaded) {
              return _buildCard(context, state.driversModel);
            } else {
              return const Text("Error");
            }
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<DriverModel> drivers) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            const Center(
              child: Text(
                "Drivers Information",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: List<Widget>.generate(
                  drivers.length,
                  (int index) {
                    return SizedBox(
                      width: 400,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              drivers[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Text("UserName: ${drivers[index].username}"),
                            Text("Email: ${drivers[index].email}"),
                            Text("Driver Name: ${drivers[index].phone}"),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 2.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Address Information",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                            "Street: ${drivers[index].address.street}"),
                                        Text(
                                            "Suite: ${drivers[index].address.suite}"),
                                        Text(
                                            "City: ${drivers[index].address.city}"),
                                        Text(
                                            "Zipcode: ${drivers[index].address.zipcode}"),
                                        Text(
                                            "Geo: ${drivers[index].address.geo}")
                                      ]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 2.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Company Information",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                            "Company name: ${drivers[index].company.name}"),
                                        Text(
                                            "Catch Phrase: ${drivers[index].company.catchPhrase}"),
                                        Text(
                                            "BS: ${drivers[index].company.bs}"),
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                    );
                  },
                ).toList(),
              ),
            )
          ]),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
