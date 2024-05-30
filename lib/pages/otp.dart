import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:videoapplication/pages/welcome_screen.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.vid, required this.phoneNumber});

  final String phoneNumber;
  final String vid;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var code = "";

  signIn() async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: widget.vid, smsCode: code);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Get.offAll(const WelcomeScreen());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Invalid code', e.code);
    } catch (e) {
      Get.snackbar("Error occured", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 250,),
            const Center(
              child: Text('OTP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            ),
            const SizedBox(
              height: 20,
            ),
            textCode(),
            const SizedBox(
              height: 20,
            ),
            button()
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Center(
      child: MaterialButton(
        color: Colors.blue,
        onPressed: () {
          signIn();
        },
        child: const Text(
          'Verify & proceed',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget textCode() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Pinput(
          length: 6,
          onChanged: (value) {
            setState(() {
              code = value;
            });
          },
        ),
      ),
    );
  }
}
