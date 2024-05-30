import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:videoapplication/pages/home_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if(snapshot.hasData){
          return HomeScreen();
        }else{
          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? _buildUI(context)
                  : _buildLandScapeUI(context);
            },
          );
        }
      },
    ));
  }

  Widget _buildUI(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    print('potrait');
    return SafeArea(
        child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.09),
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
              "https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-135.jpg?w=740&t=st=1716866746~exp=1716867346~hmac=490e0dfaddf9aacb852d5b0a85956e97044d8c19be067e5fefb2c78cbb22d87b"),
          Text(
            'Lets get started',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: height * 0.03),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text('Never a better time than now to start',
              style: TextStyle(fontSize: height * 0.02, color: Colors.black38)),
          SizedBox(
            height: height * 0.03,
          ),
          MaterialButton(
            color: Colors.purple,
            minWidth: width,
            onPressed: () {
              Navigator.pushNamed(context, "/register");
            },
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.purple)),
            child: const Text(
              'Get Started',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
              ),
            ));
  }

  Widget _buildLandScapeUI(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    print('landscape');
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.09),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
                "https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-135.jpg?w=740&t=st=1716866746~exp=1716867346~hmac=490e0dfaddf9aacb852d5b0a85956e97044d8c19be067e5fefb2c78cbb22d87b"),
            Text(
              'Lets get started',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: height * 0.03),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text('Never a better time than now to start',
                style:
                    TextStyle(fontSize: height * 0.02, color: Colors.black38)),
            SizedBox(
              height: height * 0.03,
            ),
            MaterialButton(
              color: Colors.purple,
              minWidth: width,
              onPressed: () {


              },
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.purple)),
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
