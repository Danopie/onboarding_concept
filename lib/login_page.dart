import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        children: <Widget>[
          buildForms(context),
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
        upperHeightRatio: 0.3,
        rightOffset: 35,
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
                    CurvedAnimation(parent: animation, curve: Interval(0, 0.3)),
                child: Logo(
                  size: 56,
                )),
            Container(
              height: 28,
            ),
            FadeAndSlideInWidget(
              animation:
                  CurvedAnimation(parent: animation, curve: Interval(0.1, 0.4)),
              slideOffset: Offset(0, 1),
              child: Text(
                "Welcome to Facebook",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 8,
            ),
            FadeAndSlideInWidget(
              animation:
                  CurvedAnimation(parent: animation, curve: Interval(0.1, 0.4)),
              slideOffset: Offset(0, 1.5),
              child: Text(
                "Lorem ipsum dolor sit conseteur\nsadipscing elitr, sed diam",
                style: TextStyle(
                    fontSize: 16, color: Colors.grey[600], height: 1.5),
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
          upperHeightRatio: 0.355,
          rightOffset: 66,
          animation: CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.5,
                0.8,
                curve: Curves.easeIn,
              ))),
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
          upperHeightRatio: 0.41,
          rightOffset: 100,
          animation: CurvedAnimation(
              parent: animation,
              curve: Interval(0.6, 0.8, curve: Curves.easeIn))),
      child: Container(
        color: kGrey,
      ),
    );
  }

  Widget buildForms(BuildContext context) {
    final animation = ModalRoute.of(context).animation;
    final curvedAnimation = CurvedAnimation(
        parent: animation, curve: Interval(0.82, 1.0, curve: Curves.easeInOut));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        children: [
          Spacer(
            flex: 3,
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeAndSlideInWidget(
                  slideOffset: Offset(0, 0.5),
                  animation: curvedAnimation,
                  child: InputTextField(
                    icon: Icons.person,
                    text: "Username or Email",
                  ),
                ),
                Container(
                  height: 16,
                ),
                FadeAndSlideInWidget(
                  slideOffset: Offset(0, 0.75),
                  animation: curvedAnimation,
                  child: InputTextField(
                    icon: Icons.lock,
                    text: "Password",
                  ),
                ),
                Container(
                  height: 16,
                ),
                FadeAndSlideInWidget(
                    slideOffset: Offset(0, 1),
                    animation: curvedAnimation,
                    child: LoginButton()),
                Container(
                  height: 48,
                ),
                FadeAndSlideInWidget(
                    slideOffset: Offset(0, 1.25),
                    animation: curvedAnimation,
                    child: GoogleButton()),
                Container(
                  height: 24,
                ),
                FadeAndSlideInWidget(
                    slideOffset: Offset(0, 1.5),
                    animation: curvedAnimation,
                    child: CreateAccountButton()),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}

class FadeAndSlideInWidget extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final Offset slideOffset;

  const FadeAndSlideInWidget(
      {Key key, this.animation, this.child, this.slideOffset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(begin: slideOffset, end: Offset.zero)
            .animate(animation),
        child: child,
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            left: kPaddingM,
            child: SvgPicture.network(
              "https://image.flaticon.com/icons/svg/2702/2702602.svg",
              height: 26,
            )),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: Colors.grey[300].withOpacity(0.8), width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            "Continue with Google",
            style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        "Create an account",
        style:
            TextStyle(color: kWhite, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kBlue,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        "Login to continue",
        style:
            TextStyle(color: kWhite, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final IconData icon;
  final String text;

  const InputTextField({
    Key key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide:
          BorderSide(width: 1.5, color: Colors.grey[300].withOpacity(0.8)),
      borderRadius: BorderRadius.circular(4),
    );
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: kLightBlue, textSelectionColor: Colors.grey[300]),
      child: TextField(
        cursorColor: kLightBlue,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(
            icon,
            size: 22,
          ),
          border: border,
          enabledBorder: border,
        ),
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
        size.width * 0.4, height + 40, size.width, height - rightOffset);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CurveClipper oldClipper) {
    return true;
  }
}
