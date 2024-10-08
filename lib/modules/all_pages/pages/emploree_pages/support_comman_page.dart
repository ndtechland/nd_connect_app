import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/website_page_comman.dart';
import '../../../../../components/styles.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../controllers/employeee_controllersss/support_comman/support_commannn.dart';

SupportEmployeeController _supportEmployeeController =
    Get.put(SupportEmployeeController());

final Uri emailLaunchUri = Uri.parse('info@pswellness.in/');

_launchWhatsapp() async {
  var whatsapp =
      "+91${_supportEmployeeController.supportModel?.response?.callNumber.toString()}";
  var whatsappAndroid =
      Uri.parse("whatsapp://send?phone=$whatsapp&text=Hi HireJob India");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid);
  } else {
    Get.snackbar(
      "Whats App not installed ",
      "Please install the what's app ",
      colorText: Colors.red.shade400,
      backgroundColor: Colors.white10,
      icon: Icon(Icons.person, color: Colors.red),
      snackPosition: SnackPosition.TOP,
    );
  }
}

class SupportViewHirejobComman extends StatelessWidget {
  const SupportViewHirejobComman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -size.height * 0.02,
              //bottom: size.height * 0.64,
              //left: -30,
              right: -size.width * 0.124,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: size.height * 0.22,
                  width: size.width * 0.75,
                  decoration: BoxDecoration(
                      //color: Colors.,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/background_stack_png/contactus.png',
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            Container(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.0,
                            vertical: size.height * 0.01),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: size.height * 0.03,
                                width: size.width * 0.1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_outlined,
                                  size: size.height * 0.022,
                                  color: logoColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              'CONTACT SUPPORT HireJObIndia',
                              style: GoogleFonts.alatsi(
                                fontSize: size.height * 0.025,
                                fontWeight: FontWeight.w600,
                                color: logoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        'Address:',
                        style: GoogleFonts.poppins(
                            color: logoColor,
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Registered Office:-',
                        style: GoogleFonts.poppins(
                            color: logoColor,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        "${_supportEmployeeController.supportModel?.response?.location.toString()}",
                        //'A 151, Gali No 8, Nasirpur Colony, Palam, South West Delhi 110045',
                        // '278B, 1ST FLOOR, LEERA RAM MARKET MASJID MOTH,'
                        // 'SOUTH EX. PAPER-2, Masjid Moth Village, South Extension.'
                        // 'II, New Delhi, Delhi 110049.',
                        style: GoogleFonts.roboto(
                            color: logoColor,
                            fontSize: size.width * 0.037,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Corporate Office',
                        style: GoogleFonts.poppins(
                            color: logoColor,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        "${_supportEmployeeController.supportModel?.response?.location.toString()}",

                        // '278 B 1st Floor, Leela Ram Market,South Extension Part 2, New Delhi 110049',
                        //'No. 224, 1st Floor, Humayunpur, safdasrjang Enclav,Humayupur, Safadrazganj Enclav, Humayupiur, safdarjung Enclav, New Delhi, Delhi 110029.',
                        style: GoogleFonts.roboto(
                            color: logoColor,
                            fontSize: size.width * 0.037,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Text(
                            "Contact: ${_supportEmployeeController.supportModel?.response?.callNumber.toString()}",

                            // 'Contact : 01141101286',
                            style: GoogleFonts.poppins(
                                color: logoColor,
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  barrierDismissible: true,
                                  title: "Welcome to HireJobIndia",
                                  confirm: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: PhysicalModel(
                                      color: logoColor,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                          onTap: () async {
                                            String telephoneNumber =
                                                "${_supportEmployeeController.supportModel?.response?.callNumber.toString()}";
                                            String telephoneUrl =
                                                "tel:$telephoneNumber";
                                            if (await canLaunch(telephoneUrl)) {
                                              await launch(telephoneUrl);
                                            } else {
                                              throw "Error occured trying to call that number.";
                                            }
                                            // launch('tel:+9111126194230');
                                          },
                                          child: Container(
                                              height: size.height * 0.04,
                                              width: size.width * 0.26,
                                              color: logoColor,
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    color: Colors.white,
                                                    size: size.width * 0.05,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.03,
                                                  ),
                                                  Text(
                                                    'Call',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.width * 0.03,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  cancel: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: PhysicalModel(
                                      color: logoColor,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                          onTap: () {
                                            _launchWhatsapp();
                                          },
                                          child: Container(
                                              height: size.height * 0.04,
                                              width: size.width * 0.26,
                                              color: logoColor,
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.message,
                                                    color: Colors.white,
                                                    size: size.height * 0.03,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.03,
                                                  ),
                                                  Text(
                                                    'Whatsapp',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            size.width * 0.03),
                                                  ),
                                                ],
                                              ))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  middleText:
                                      "We are giving two options to our User for contact with us.",
                                  backgroundColor: logoColor,
                                  titleStyle: GoogleFonts.alatsi(
                                      color: Colors.white,
                                      fontSize: size.height * 0.03,
                                      fontWeight: FontWeight.bold),
                                  middleTextStyle:
                                      TextStyle(color: Colors.grey),
                                  radius: 10);
                            },
                            child: Container(
                              height: size.height * 0.04,
                              width: size.width * 0.08,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.call,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Text(
                            'Email: ',
                            style: GoogleFonts.poppins(
                              color: logoColor,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                              //decoration: TextDecoration.underline,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              String email =
                                  "${_supportEmployeeController.supportModel?.response?.email.toString()}";
                              String subject = 'This is a email';
                              String body = 'This is a  email body';

                              String emailUrl =
                                  "mailto:$email?subject=$subject&body=$body";

                              if (await canLaunch(emailUrl)) {
                                await launch(emailUrl);
                              } else {
                                throw "Error occured sending an email";
                              }

                              //_launchUrl2();
                            },
                            child: Row(
                              children: [
                                //_launchUrl2
                                Text(
                                  "${_supportEmployeeController.supportModel?.response?.email.toString()}",
                                  style: GoogleFonts.poppins(
                                    color: logoColor,
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Text(
                            'Website: ',
                            style: GoogleFonts.poppins(
                              color: logoColor,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                              //decoration: TextDecoration.underline,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //_launchUrl();
                              Get.to(WebViewHirejobwebsite());
                              print("clickios");
                            },
                            child: Row(
                              children: [
                                Text(
                                  'www.hirejobindia.com',
                                  style: GoogleFonts.poppins(
                                    color: logoColor,
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_right,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
