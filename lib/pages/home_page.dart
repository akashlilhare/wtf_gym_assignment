import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf_gym_assignment/pages/widget/home_appbar.dart';
import 'package:wtf_gym_assignment/pages/widget/home_body.dart';

import '../provider/data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    var provider = Provider.of<DataProvider>(context, listen: false);
    provider.getNearestGym();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            HomeAppBar(),
            HomeBody(),
          ],
        ),
      ),
    );
  }
}
