import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile1'),
      ),
      body: Center(
        child: Text('profile1'),
      ),
    );
  }
}

class Profile2 extends StatelessWidget {
  const Profile2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile2'),
      ),
      body: Center(
        child: Text(Get.arguments['1'].toString()),
      ),
    );
  }
}
