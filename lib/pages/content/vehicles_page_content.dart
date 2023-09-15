import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/data/vehicles.dart';
import 'package:flutter_test_work/features/vehicles/vehicles_bloc.dart';
import 'package:flutter_test_work/features/vehicles/vehicles_event.dart';
import 'package:flutter_test_work/features/vehicles/vehicles_state.dart';
import 'package:flutter_test_work/methods/Debouncer.dart';
import 'package:flutter_test_work/models/vehicle_model.dart';

class VehiclesPageContent extends StatelessWidget {
  const VehiclesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VehiclesBloc(list: vehiclesMap),
      child: BlocListener<VehiclesBloc, VehiclesState>(
        listener: (context, state) {},
        child: BlocBuilder<VehiclesBloc, VehiclesState>(builder: (
          context,
          state,
        ) {
          final debouncer = Debouncer(milliseconds: 500);

          List<Widget> titleRowChildren = [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Vehicles",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${state.vehiclesModel.length} in total',
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  context
                      .read<VehiclesBloc>()
                      .add(VehiclesShowSearch(show: state.showSearch != true));
                  context
                      .read<VehiclesBloc>()
                      .add(const VehiclesStartSearching(keyword: ''));
                },
                icon: const Icon(Icons.search)),
          ];

          if (state.showSearch == true) {
            titleRowChildren.insert(
                1,
                SizedBox(
                  width: 130,
                  child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Type car name',
                      ),
                      onChanged: (value) => debouncer.run(
                            () => context.read<VehiclesBloc>().add(
                                  VehiclesStartSearching(keyword: value),
                                ),
                          )),
                ));
          }

          return ListView(children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: titleRowChildren,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.vehiclesModel.length,
                      itemBuilder: (context, index) {
                        return _vehicle(context, index, state.vehiclesModel);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]);
        }),
      ),
    );
  }

  Widget _vehicle(
      BuildContext context, int index, List<VehicleModel> vehiclesMap) {
    var imagesUrl = vehiclesMap[index].imagesUrl;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 190,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 1.0,
                  initialPage: 0,
                ),
                itemCount: imagesUrl.length,
                itemBuilder: (context, idx, realIndex) {
                  return Stack(
                    children: [
                      SizedBox(
                        child: Image.network(
                          imagesUrl[idx],
                        ),
                      ),
                      Positioned(
                        right: 25.0,
                        bottom: 25.0,
                        child: Container(
                          width: 65.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                spreadRadius: 3,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.photo_camera_outlined,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                              ),
                              Text(
                                "${idx + 1}/${imagesUrl.length}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                left: 10.0,
                top: 10.0,
                child: Container(
                  width: 85.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: Center(
                      child: Text(
                    vehiclesMap[index].available,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  )),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                vehiclesMap[index].name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  children: List<Widget>.generate(
                    vehiclesMap[index].tags.length,
                    (int idx) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(226, 225, 231, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              vehiclesMap[index].tags[idx],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(vehiclesMap[index].description),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey, width: 2.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List<Widget>.generate(
                                5,
                                (int idx) {
                                  var greenBg = Colors.green;
                                  if (idx > vehiclesMap[index].priceRank - 1) {
                                    greenBg = Colors.grey;
                                  }
                                  return SizedBox(
                                    width: 22,
                                    height: 8,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: DecoratedBox(
                                        decoration:
                                            BoxDecoration(color: greenBg),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                vehiclesMap[index].getPriceText,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Tooltip(
                            message: "Lorem Lorem text",
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 2, color: Colors.grey)),
                              child: const Icon(
                                Icons.priority_high_rounded,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(vehiclesMap[index].price,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24))
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
