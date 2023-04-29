import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:wtf_gym_assignment/core/constant.dart';
import 'package:wtf_gym_assignment/core/enum/app_connection_status.dart';
import 'package:wtf_gym_assignment/provider/data_provider.dart';

import '../../core/enum/gym_type.dart';
import '../../model/gym_model.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    buildButton(
        {required Color color,
        required Function onTap,
        required String title}) {
      return Expanded(
        child: InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
                child: Text(
              title.toUpperCase(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(18))),
          ),
        ),
      );
    }

    buildGymCard({required Gym gym, required DataProvider dataProvider}) {
      return dataProvider.selectedGymType == GymType.all ||
              Constant().stringToGymType(gymType: gym.categoryName) ==
                  dataProvider.selectedGymType
          ? Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8,
              ).copyWith(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      gym.categoryName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Image.network(
                    "https://plus.unsplash.com/premium_photo-1679635697694-4ab045eb0af6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3ltfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=250&q=60",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(gym.gymName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        gym.distanceText,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        gym.address1,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text("STARTING AT 1833/month",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            buildButton(
                                color: Colors.red,
                                onTap: () {},
                                title: "Free First Day"),
                            SizedBox(
                              width: 18,
                            ),
                            buildButton(
                                color: Colors.grey,
                                onTap: () {},
                                title: "Buy Now"),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/bg_cover.jpg",
                      ),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            )
          : Container();
    }

    List<Widget> getGymList(DataProvider gymData) {
      return gymData.gymModel!.gymList.map((gym) {
        return buildGymCard(
          gym: gym,
          dataProvider: gymData,
        );
      }).toList();
    }

    return Expanded(
      child: Consumer<DataProvider>(builder: (context, gymData, _) {
        if (gymData.appConnectionStatus == AppConnectionStatus.active) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (gymData.gymModel == null) {
          return const Center(
            child: Text("Something went wrong"),
          );
        } else {
          return Container(
            color: Color(0xffF0F0F0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...getGymList(gymData),
                  SizedBox(
                    height: 12,
                  ),

                  NumberPaginator(
                    numberPages: gymData.totalPageCount,
                    onPageChange: (int index) {
                      print(index);
                      gymData.getNearestGym(pageIndex: index + 1);
                    },
                    initialPage: gymData.initialPage - 1,
                    config: NumberPaginatorUIConfig(
                        buttonSelectedBackgroundColor:
                            Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
