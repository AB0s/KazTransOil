import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaz_trans_oil/generated/locale_keys.g.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Emergency_Call_Center extends StatefulWidget {
  const Emergency_Call_Center({Key? key}) : super(key: key);

  @override
  _Emergency_Call_CenterState createState() => _Emergency_Call_CenterState();
}

class _Emergency_Call_CenterState extends State<Emergency_Call_Center> {
  String externalNo = "";
  String mobileNo = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('https://www.mbportal.kz/api/emergency'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        externalNo = data['externalNo'];
        mobileNo = data['mobileNo'];
        email = data['email'];
      });
    } else {
      // Handle error case here
      print('Failed to fetch data: ${response.statusCode}');
    }
  }
  Future<void> startWhatsAppChat(String phoneNumber) async {
    String url = "whatsapp://send?phone=$phoneNumber";
    print(canLaunch(url));
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print ('un');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A386A),
        title: Text(LocaleKeys.emergency_call_center.tr(),
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                LocaleKeys.emergency_call_center.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                LocaleKeys.call_center_info.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  launch('tel:${Uri.encodeFull(externalNo)}');
                },
                child: Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).textScaleFactor>=1.3)?100:65,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black, // Black box shadow
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        externalNo,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(LocaleKeys.stationary_phone.tr()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // Paste the mobile number in the phone app here
                  // You can use the platform-specific code to interact with the phone app
                  // Below is an example of how you can use the url_launcher package to open the phone app with the number
                  launch('tel:${Uri.encodeFull(mobileNo)}');
                },
                child: Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).textScaleFactor>=1.3)?100:65,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black, // Black box shadow
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mobileNo,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(LocaleKeys.mobile_phone.tr()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                LocaleKeys.call_center_additional.tr(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                LocaleKeys.via_email.tr(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  launch('mailto:$email');
                },
                child: Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).textScaleFactor>=1.3)?100:70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black, // Black box shadow
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/hse/icn_email.png"),
                      const SizedBox(height: 5,),
                      Text(email,style: const TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                LocaleKeys.via_whatsapp.tr(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  startWhatsAppChat(mobileNo.replaceAll(' ', ''));
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black, // Black box shadow
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Image.asset("assets/hse/icn_whatsapp.png")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
