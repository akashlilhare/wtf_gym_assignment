import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constant.dart';
import '../../core/enum/gym_type.dart';
import '../../provider/data_provider.dart';
import '../pick_screen/pick_city_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildAppBar({required DataProvider gymData}) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Text("Nodia"),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  Text(gymData.selectedArea)
                ],
              ),
              Spacer(),
            ],
          ));
    }

    buildFilter({required DataProvider gymData}) {
      List<GymType> filterList = [
        GymType.all,
        GymType.exclusive,
        GymType.powered,
        GymType.coBranded,
      ];

      return Container(
        height: 35,
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 8,
              ),
              ...filterList.map((filter) {
                bool isSelected = filter == gymData.selectedGymType;
                return InkWell(
                  onTap: () {
                    gymData.switchGymType(gymType: filter);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.transparent,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: Center(
                        child: Text(
                      Constant().getGymTitle(gymType: filter),
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black),
                    )),
                  ),
                );
              }).toList()
            ]),
      );
    }

    buildSearchBar() {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
            return PickCityPage();
          }));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                "search by gym name",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Spacer(),
              Container(
                height: 36,
                width: 45,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(Radius.circular(18))),
        ),
      );
    }

    return Consumer<DataProvider>(builder: (context, gymData, _) {
      return Column(
        children: [
          SizedBox(
            height: 8,
          ),
          buildAppBar(gymData: gymData),
          SizedBox(
            height: 12,
          ),
          buildFilter(gymData: gymData),
          SizedBox(
            height: 8,
          ),
          buildSearchBar(),
          SizedBox(
            height: 12,
          ),
        ],
      );
    });
  }
}
