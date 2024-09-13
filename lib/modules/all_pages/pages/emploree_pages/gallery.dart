import 'package:flutter/material.dart';
import 'package:nd_connect_techland/components/styles.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
            },
        ),
        title: Text("Gallery",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),),
      ),
      body: Container(
        child: Text("Gallery Screen",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),),
      ),
    );
  }
}
