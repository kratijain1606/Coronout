import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'main.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MyStatefulWidget()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.blue);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.deepOrange),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "ॐ",
          body:
              "ॐ सर्वे भवन्तु सुखिनः \nसर्वे सन्तु निरामयाः । \nसर्वे भद्राणि पश्यन्तु \nमा कश्चिद्दुःखभाग्भवेत् । \nॐ शान्तिः शान्तिः शान्तिः ॥",
          image: _buildImage('prayinghand'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Coronout = Corona + burnout",
          body:
              "The mental anguish one feels \nfrom hearing about the \nCoronavirus every minute \nof the day.",
          image: _buildImage('doctor'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Features",
          body:
              "It got Symptoms Checker, \nAnd Mrs. Doc Bot \nTo help you \nStay Safe and Healthy",
          image: _buildImage('doctors'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Updates",
          body: "Also keep you Update \nwith regular news \nand stats from the world",
          image: _buildImage("stats"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Donate",
          body: "You can also donate \nCheck nearbys \nContact in crisis",
          image: _buildImage("donate"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Welcome",
          body: "Get Ready to boost-up",
          image: _buildImage("welcome"),
          footer: RaisedButton(
            onPressed: () {
              _onIntroEnd(context);
            },
            child: const Text(
              'Enter!',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          decoration: pageDecoration,
        )
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}