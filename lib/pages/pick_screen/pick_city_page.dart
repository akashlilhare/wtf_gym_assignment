import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf_gym_assignment/core/enum/app_connection_status.dart';
import 'package:wtf_gym_assignment/core/enum/filter_type.dart';

import '../../provider/data_provider.dart';

class PickCityPage extends StatefulWidget {
  const PickCityPage({Key? key}) : super(key: key);

  @override
  State<PickCityPage> createState() => _PickCityPageState();
}

class _PickCityPageState extends State<PickCityPage> {
  @override
  void initState() {
    var provider = Provider.of<DataProvider>(context, listen: false);
    provider.getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Consumer<DataProvider>(builder: (context, cityData, _) {
      if (cityData.appConnectionStatus == AppConnectionStatus.active) {
        return Material(child: Center(child: CircularProgressIndicator()));
      } else {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "Pick Location",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Spacer(),
                      Text("Nodia"),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: const [
                                  Spacer(),
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Text("Loading..."),
                                  Spacer(),
                                ],
                              ),
                            );
                          });

                      await cityData.selectFromLocation(context: context);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          children: [
                            Icon(Icons.my_location),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Around Your Location"),
                            Spacer(),
                            Icon(Icons.arrow_forward)
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "AREA",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(" (No. of gyms)")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...cityData.cityModel.cityList[0].popularLocations.map((e) {
                    return InkWell(
                      onTap: (){
                        cityData.resetFilter();
                        cityData.switchSelectedArea(area: e.location);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(e.location),
                              ],
                            )),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
