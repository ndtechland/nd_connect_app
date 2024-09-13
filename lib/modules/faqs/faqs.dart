import 'package:flutter/material.dart';
import 'package:nd_connect_techland/components/styles.dart';

import '../bottom_bar/bottom_bar.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key});

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        title: const Text(
          "FAQs",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomBar()));

          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: const ExpansionTile(
                backgroundColor: Colors.white,
                title: Text(
                  'What services does N D Techland Private Limited provide?',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                leading: Icon(Icons.info, color: appColor2),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'We offer a range of services including software development, web and mobile app development, website designing, and internet marketing solutions. We cater to businesses of all sizes, providing custom solutions to meet your unique needs.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: const ExpansionTile(
                backgroundColor: Colors.white,
                title: Text(
                  'How do I contact N D Techland Private Limited?',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                leading: Icon(Icons.info, color: appColor2),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'You can contact us via email at info@ndtechland.com or call us at +91 1234567890. We are also available on our social media channels.',
                      //'We offer a range of services including software development, web and mobile app development, website designing, and internet marketing solutions. We cater to businesses of all sizes, providing custom solutions to meet your unique needs.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10),
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   elevation: 2,
            //   child: ExpansionTile(
            //     backgroundColor: Colors.white,
            //     title: const Text(
            //       'How do I contact N D Techland Private Limited?',
            //       style: TextStyle(
            //         fontWeight: FontWeight.w500,
            //         fontSize: 16,
            //       ),
            //     ),
            //     leading: const Icon(Icons.contact_mail, color: appColor2),
            //     trailing: Icon(
            //       _customTileExpanded
            //           ? Icons.arrow_drop_down_circle
            //           : Icons.arrow_drop_down,
            //       color: appColor2,
            //     ),
            //     children: const <Widget>[
            //       Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: Text(
            //           'You can contact us via email at info@ndtechland.com or call us at +91 1234567890. We are also available on our social media channels.',
            //           style: TextStyle(fontSize: 14),
            //         ),
            //       ),
            //     ],
            //     onExpansionChanged: (bool expanded) {
            //       setState(() {
            //         _customTileExpanded = expanded;
            //       });
            //     },
            //   ),
            // ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: const ExpansionTile(
                backgroundColor: Colors.white,
                title: Text(
                  'Where is N D Techland Private Limited located?',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                leading: Icon(Icons.location_on, color: appColor2),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Our head office is located at ABC Building, XYZ Road, City Name, State, Pin Code.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// stateless

///todo: stateless
// import 'package:flutter/material.dart';
//
// class Faqs extends StatelessWidget {
//   const Faqs({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "FAQs",
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back),
//         ),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             const ExpansionTile(
//               title: Text('ExpansionTile 1'),
//               subtitle: Text('Trailing expansion arrow icon'),
//               children: <Widget>[
//                 ListTile(title: Text('This is tile number 1')),
//               ],
//             ),
//             StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//                 bool _customTileExpanded = false;
//                 return ExpansionTile(
//                   title: const Text('ExpansionTile 2'),
//                   subtitle: const Text('Custom expansion arrow icon'),
//                   trailing: Icon(
//                     _customTileExpanded
//                         ? Icons.arrow_drop_down_circle
//                         : Icons.arrow_drop_down,
//                   ),
//                   children: const <Widget>[
//                     ListTile(title: Text('This is tile number 2')),
//                   ],
//                   onExpansionChanged: (bool expanded) {
//                     setState(() {
//                       _customTileExpanded = expanded;
//                     });
//                   },
//                 );
//               },
//             ),
//             const ExpansionTile(
//               title: Text('ExpansionTile 3'),
//               subtitle: Text('Leading expansion arrow icon'),
//               controlAffinity: ListTileControlAffinity.leading,
//               children: <Widget>[
//                 ListTile(title: Text('This is tile number 3')),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
