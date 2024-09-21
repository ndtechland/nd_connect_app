//
// import 'dart:async';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
//
//
// late BuildContext ctx;
// void _handleMessage(RemoteMessage message) {
//   try {
//     print('/${message.data['routing']}');
//
//    // deepLinking(ctx,message.data['routing']);
//   } catch (e) {
//     print(e);
//   }
// }
// fcmInit(BuildContext context) async {
//   ctx=context;
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   messaging.requestPermission(
//       alert: true, announcement: true, badge: true, sound: true);
//   messaging.getToken().then((token) async {
//     print("FCMToken: " + token!);
//   });
//
//   RemoteMessage? initialMessage =
//   await FirebaseMessaging.instance.getInitialMessage();
//
//   if (initialMessage != null) {
//     _handleMessage(initialMessage);
//   }
//
//   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     Timer(const Duration(seconds: 1), () async {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//       print('Message data: ${message.notification?.title}');
//       print('Message data: ${message.notification?.body}');
//     });
//   });
// }
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FcmService{
//   static void firebaseInit()  {
//     FirebaseMessaging.onMessage.listen((message){
//       print(message.notification?.title);
//       print(message.notification?.body);
//     });
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../components/responsive_text.dart';
// import '../../../components/styles.dart';
// import '../../../constants/static_text.dart';
// import '../../../controllers/bottom_nav_controller.dart';
// import '../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
// import 'package:intl/intl.dart';
//
// class Attendanceee extends StatelessWidget {
//   String id ='13';Attendanceee({super.key,required this.id});
//   @override
//   Widget build(BuildContext context) {
//     final ProfileEmployeeController _getprofileepersonal = Get.put(ProfileEmployeeController());
//    return Scaffold(
//    backgroundColor: Colors.white,
//         body: OrientationBuilder(builder: (context, orientation) {
//           return LayoutBuilder(builder: (context, constraints) {
//            return SingleChildScrollView(
//            child: Container(child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(
//           DateFormat('d MMM y').format(DateTime.now()), style: TextStyle(
//               fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),), SizedBox(height: 10,),],),),Container(
//            child: Column(children: [Text("Search",style: TextStyle(),),IconButton(onPressed: ()async{
//            DateTime? pickedDate = await showDatePicker(context: context,initialDate: DateTime.now(),firstDate: DateTime(1950),lastDate: DateTime(2100),);}, icon: Icon(Icons.calendar_month))],),)],),
//            SizedBox(height: 20,),Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
//            Container(height: categoryHeight * 0.5,width: categoryWidth * 0.85,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8),
//            boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 20.0,),],),
//           child: Padding(padding: const EdgeInsets.all(10.0),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//           children: [Row(children: [Text("Check - In",style: TextStyle(fontSize: 15, color: Colors.grey), ),],),SizedBox(height: sizeHeight2 * 0.1,),
//            Text("09:30 am",style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w600),),
//            SizedBox(height: sizeHeight2 * 0.1,),],),),),
//            Container(child: Padding(padding: const EdgeInsets.all(10.0),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//            children: [Row(children: [Text("Check - Out",style: TextStyle(fontSize: 15, color: Colors.grey),),],),
//            SizedBox(height: 12,),Text("06:30 pm",style: TextStyle(fontSize: 20,color: Colors.black87, fontWeight: FontWeight.w600),),
//            SizedBox(height: 10,),],),),),],), Container(child: Padding(padding: const EdgeInsets.fromLTRB(18.0, 10, 18, 10), child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(Icons.work_history_outlined, color: Colors.deepOrangeAccent,),
//                SizedBox(width: 7,), Text("Total Working Hour", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),), Spacer(),
//                GestureDetector(onTap: () {showDialog(context: context, builder: (context) {return Dialog(shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 16, child: Container(child: ListView(
//                  shrinkWrap: true, children: <Widget>[Padding(padding: const EdgeInsets.fromLTRB(18.0,0,0,0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [Text('Recent Activity', style: TextStyle(fontSize: 17,),), IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.cancel_outlined,color: Colors.red,))],),),
//            _buildRow(Icons.login,Icons.logout_rounded, Colors.green,Colors.red,'Check-In','Check-Out', "09:30am","06:30pm",Colors.green.shade50,Colors.red.shade50,),
//                  Padding(padding: const EdgeInsets.fromLTRB(18.0,10,0,0), child:  Row(children: <Widget>[CircleAvatar(child: Icon(Icons.timer,size: 20,color: Colors.indigoAccent,),backgroundColor:  Color(0xffdcf2fc),radius: 18,), SizedBox(width: 8), Text("Break-In",style: TextStyle(fontWeight: FontWeight.w600),),],),),
//            SizedBox(height: 8,), Padding(padding: const EdgeInsets.only(left: 18.0,), child: Container(child: ListView.builder(
//            scrollDirection: Axis.horizontal, itemCount: 6, itemBuilder: (context,index){return Card(  clipBehavior: Clip.antiAlias, shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(10),),child: Padding(padding: const EdgeInsets.fromLTRB(6,8,12,8),child: Row(
//           children: [CircleAvatar(backgroundColor: Colors.orange.shade100, child: Text('${index+1}', style: TextStyle(
//            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),),), Text('${breakIn[index]}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),),],),),);}),),),
//            ],),),);},);}, child: Container(alignment: Alignment.center, height: imageHeight * 0.15, width: imageWidth * 0.4, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.yellow.shade100, border: Border.all(color: Colors.yellow, width: 1),), child: Text("See Activity", style: TextStyle(fontFamily: 'poppins', fontSize: 12,),),))],),],),), ),],),),);
//           });
//         }));}
//   Widget _buildRow(IconData icon1,IconData icon2,Color iconColor1, Color iconColor2, String name1,String name2, String score1,String score2,Color color1,Color color2,) {
//     return Padding(padding: EdgeInsets.fromLTRB(18.0,10,18,10),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Container(child: Row(
//       children: <Widget>[CircleAvatar(child: Icon(icon1,size: 20,color: iconColor1,),backgroundColor: color1,radius: 18,),
//       SizedBox(width: 8),Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
//       Text(name1,style: TextStyle(fontWeight: FontWeight.w600, ),),Text(score1,style: TextStyle(fontSize: 13),),],),
//       Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(name2,style: TextStyle(fontWeight: FontWeight.w600),),
//       Text(score2,style: TextStyle(fontSize: 13),),],),],),),],),);}}
