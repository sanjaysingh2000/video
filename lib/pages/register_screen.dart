import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'otp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  final TextEditingController phoneController = TextEditingController();

  sendOtp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phoneController.text}',
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          Get.snackbar("Error Occured", error.code);
          print('+91${phoneController.text}');
        },
        codeSent: (verificationId, forceResendingToken) {
          Get.to(OtpPage(
            vid: verificationId,
            phoneNumber: phoneController.text,
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occured', e.code);
    } catch (e) {
      Get.snackbar('Error Occured', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05,
                vertical: MediaQuery.sizeOf(context).height * 0.03),
            child: Column(
              children: [
                _circularAvatar(context),
                Text(
                  'Registration',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.sizeOf(context).height * 0.025),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Add your phone number, We will send you verification code',
                  style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).height * 0.016),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.018,
                ),
                Tff(context),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01 / 10,
                ),
                MaterialButton(
                  height: MediaQuery.sizeOf(context).height * 0.06,
                  onPressed: () {
                    sendOtp();
                  },
                  minWidth: MediaQuery.sizeOf(context).width,
                  color: Colors.purple,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.purple)),
                  child: const Text(
                    'Recieve OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )));
  }

  Widget _circularAvatar(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.pinkAccent.withOpacity(0.5),
        radius: MediaQuery.sizeOf(context).height * 0.15,
        child: Image.network(
          'https://img.freepik.com/free-vector/privacy-policy-concept-illustration_114360-7853.jpg?w=740&t=st=1716869900~exp=1716870500~hmac=a96a2097462901be70a9af0825ca8ce0be8cb093ae932b3bb03807090ba3a0bc',
        ),
      ),
    );
  }

  Widget Tff(BuildContext context) {
    return TextFormField(
      maxLength: 10,
      style: const TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
      onChanged: (value) {
        setState(() {
          phoneController.text = value;
        });
      },
      cursorColor: Colors.purple,
      keyboardType: TextInputType.number,
      controller: phoneController,
      decoration: InputDecoration(
          hintText: 'Enter your number',
          hintStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black12)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black12)),
          prefixIcon: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05,
                vertical: MediaQuery.sizeOf(context).height * 0.03),
            child: InkWell(
              onTap: () {
                showCountryPicker(
                  context: context,
                  countryListTheme: CountryListThemeData(
                      bottomSheetHeight:
                          MediaQuery.sizeOf(context).height * 0.6),
                  onSelect: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                  },
                );
              },
              child: Text(
                "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.026),
              ),
            ),
          ),
          suffixIcon: phoneController.text.length > 9
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                  child: const Icon(Icons.done),
                )
              : null),
    );
  }
}
