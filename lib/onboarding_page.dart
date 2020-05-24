import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onboardingconcept/constants.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class BoardingItem {
  final String header;
  final String description;
  final List<Widget> lightCardIcons;
  final Widget darkCardWidget;

  const BoardingItem({
    @required this.header,
    @required this.description,
    @required this.lightCardIcons,
    @required this.darkCardWidget,
  });
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final items = [
    BoardingItem(
      header: "Community",
      description:
          "Lorem ipsum dolor sit consetetur sadipscing eliter, sed diarm",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: Container(
          margin: EdgeInsets.symmetric(
            vertical: kPaddingL + kPaddingM,
            horizontal: kPaddingL,
          ),
          child: Column(
            children: <Widget>[
              Header(),
              Container(
                height: kPaddingL,
              ),
              CardStack(lightCardIcons: <Widget>[
                IconContainer(
                  icon: Icons.accessibility,
                ),
                IconContainer(
                  padding: kPaddingM,
                  icon: Icons.access_alarm,
                ),
                IconContainer(
                  icon: Icons.watch,
                )
              ], darkCardWidget: Container()),
              Container(
                height: kPaddingL,
              ),
              TextColumn(
                header: "Community",
                description:
                    "Lorem ipsum dolor sit consetetur sadipscing eliter, sed diarm",
              ),
              Spacer(),
              CurrentPageIndicator(
                child: NextButton(),
              ),
            ],
          )),
    );
  }
}

class CurrentPageIndicator extends StatelessWidget {
  final int page;
  final int total;
  final Widget child;

  const CurrentPageIndicator({Key key, this.page, this.total, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndicatorPainter(3, 1),
      child: Container(
        margin: EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final int pageCount;
  final int currentPage;

  IndicatorPainter(this.pageCount, this.currentPage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final rect = Rect.fromCenter(
        center: center, width: size.width - 12, height: size.height - 12);

    final currentPagePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final otherPagePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final spaceAngle = pi / 12;
    final sweepAngle = ((pi - ((pageCount - 1) * spaceAngle)) / pageCount);

    for (int i = 0; i < pageCount; i++) {
      canvas.drawArc(rect, pi + sweepAngle * i + spaceAngle * i, sweepAngle,
          false, i <= currentPage - 1 ? currentPagePaint : otherPagePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class IconContainer extends StatelessWidget {
  final IconData icon;
  final double padding;

  const IconContainer({Key key, this.icon, this.padding = kPaddingS})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kWhite.withOpacity(0.4),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(
                  0,
                  3,
                ),
                blurRadius: 2,
                spreadRadius: 1)
          ]),
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding),
      child: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}

class CardStack extends StatelessWidget {
  final List<Widget> lightCardIcons;
  final Widget darkCardWidget;
  final bool isTop;

  const CardStack(
      {Key key, this.lightCardIcons, this.darkCardWidget, this.isTop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: kPaddingL),
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Container(
                padding: EdgeInsets.all(kPaddingL),
                decoration: BoxDecoration(
                  color: kDarkBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: darkCardWidget,
              ),
            ),
          ),
          Positioned(
            bottom: isTop ? null : 0,
            top: isTop ? 0 : null,
            left: kPaddingL,
            right: kPaddingL,
            child: AspectRatio(
              aspectRatio: 2,
              child: Container(
                padding: EdgeInsets.all(kPaddingL),
                decoration: BoxDecoration(
                    color: kLightBlue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: Offset(0, 5))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: lightCardIcons,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.arrow_forward,
        color: kBlue,
        size: 24,
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  final String header;

  final String description;

  const TextColumn({Key key, this.header, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            header,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
          ),
          Container(
            height: kPaddingS,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: kGrey.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Logo(
          colorMask: Colors.white,
        ),
        SkipButton()
      ],
    );
  }
}

class Logo extends StatelessWidget {
  final Color colorMask;

  const Logo({Key key, this.colorMask}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        "https://image.flaticon.com/icons/png/512/1076/1076990.png",
        height: 36,
        color: colorMask,
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Skip",
        style: TextStyle(color: kGrey, fontSize: 16),
      ),
    );
  }
}
