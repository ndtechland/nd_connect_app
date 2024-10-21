import 'package:flutter/material.dart';

import '../../../components/styles.dart';
class Testtt extends StatefulWidget {
  const Testtt({super.key});

  @override
  State<Testtt> createState() => _TestttState();
}

class _TestttState extends State<Testtt> {
  @override
  void initState() {
    super.initState();
    // Show the modal bottom sheet when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet();
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 400,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 8,
                    width: 50,
                    color: Colors.black87,
                  ),
                ),
                const Text('Name: Kumar Prince',style: TextStyle(
                    fontWeight: FontWeight.w500,fontSize: 17
                ),),
                const Text('Email: kumarprince@gmail.com',style: TextStyle(
                    fontWeight: FontWeight.w500,fontSize: 17
                ),),
                const Text('Phone Num: +91 8465128454',style: TextStyle(
                    fontWeight: FontWeight.w500,fontSize: 17
                ),),
                ElevatedButton
                  (
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        title: const Text(
          'Testt',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Show Modal Again'),
          onPressed: () {
            _showBottomSheet(); // Manually show the bottom sheet on button press
          },
        ),
      ),
    );
  }
}
