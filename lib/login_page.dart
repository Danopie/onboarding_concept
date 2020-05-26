import 'package:flutter/material.dart';
import 'package:onboardingconcept/constants.dart';
import 'package:onboardingconcept/onboarding_page.dart';

class LoginPage extends StatefulWidget {
  static Future<dynamic> show({BuildContext context}) {
    return Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: Duration(seconds: 2),
      pageBuilder: (context, animation, secondaryAnimation) {
        return LoginPage();
      },
    ));
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildSecondBackgroundCurve(context),
          buildFirstBackgroundCurve(context),
          buildHeader(context),
        ],
      ),
    );
  }

  ClipPath buildHeader(BuildContext context) {
    final animation = ModalRoute.of(context).animation;
    return ClipPath(
      clipper: CurveClipper(
        lowerHeightRatio: 1.0,
        upperHeightRatio: 0.38,
        rightOffset: 50,
        animation: CurvedAnimation(
            parent: animation, curve: Interval(0.3, 0.8, curve: Curves.easeIn)),
      ),
      child: Container(
        color: kGrey,
        padding: EdgeInsets.symmetric(
          vertical: kPaddingL + kPaddingM,
          horizontal: kPaddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
                opacity:
                    CurvedAnimation(parent: animation, curve: Interval(0, 0.2)),
                child: Logo(
                  size: 62,
                )),
            Container(
              height: 28,
            ),
            FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animation, curve: Interval(0.1, 0.4))),
              child: SlideTransition(
                position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                    .animate(CurvedAnimation(
                        parent: animation, curve: Interval(0.1, 0.4))),
                child: Text(
                  "Welcome to Busble",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animation, curve: Interval(0.1, 0.4))),
              child: SlideTransition(
                position: Tween<Offset>(begin: Offset(0, 1.5), end: Offset.zero)
                    .animate(CurvedAnimation(
                        parent: animation, curve: Interval(0.1, 0.4))),
                child: Text(
                  "Lorem ipsum dolor sit conseteur\nsadipscing elitr, sed diam",
                  style: TextStyle(
                      fontSize: 18, color: Colors.grey[600], height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFirstBackgroundCurve(BuildContext context) {
    final animation = ModalRoute.of(context).animation;
    return ClipPath(
      clipper: CurveClipper(
          lowerHeightRatio: 1.0,
          upperHeightRatio: 0.44,
          rightOffset: 80,
          animation: CurvedAnimation(
              parent: animation,
              curve: Interval(0.5, 0.85, curve: Curves.easeIn))),
      child: Container(
        color: kBlue,
      ),
    );
  }

  Widget buildSecondBackgroundCurve(BuildContext context) {
    final animation = ModalRoute.of(context).animation;
    return ClipPath(
      clipper: CurveClipper(
          lowerHeightRatio: 2.0,
          upperHeightRatio: 0.51,
          rightOffset: 100,
          animation: CurvedAnimation(
              parent: animation,
              curve: Interval(0.6, 0.9, curve: Curves.easeIn))),
      child: Container(
        color: kGrey,
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  final double lowerHeightRatio;
  final double upperHeightRatio;
  final double rightOffset;
  final Animation<double> animation;

  CurveClipper({
    this.rightOffset,
    this.lowerHeightRatio,
    this.upperHeightRatio,
    this.animation,
  }) : super(reclip: animation);

  @override
  Path getClip(Size size) {
    final path = Path();
    final screenHeight = size.height;
    final height = screenHeight *
        Tween<double>(begin: lowerHeightRatio, end: upperHeightRatio)
            .evaluate(animation);
    path.lineTo(0, height);
    path.quadraticBezierTo(
        size.width * 1 / 3, height + 50, size.width, height - rightOffset);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CurveClipper oldClipper) {
    return true;
  }
}
