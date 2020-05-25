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
  final bool isLightCardTop;

  const BoardingItem({
    @required this.header,
    @required this.description,
    @required this.lightCardIcons,
    @required this.darkCardWidget,
    @required this.isLightCardTop,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardingItem &&
          runtimeType == other.runtimeType &&
          header == other.header &&
          description == other.description &&
          lightCardIcons == other.lightCardIcons &&
          darkCardWidget == other.darkCardWidget &&
          isLightCardTop == other.isLightCardTop;

  @override
  int get hashCode =>
      header.hashCode ^
      description.hashCode ^
      lightCardIcons.hashCode ^
      darkCardWidget.hashCode ^
      isLightCardTop.hashCode;
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  static final items = [
    BoardingItem(
      header: "Community",
      description:
          "Lorem ipsum dolor sit consetetur sadipscing eliter, sed diarm",
      lightCardIcons: [
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
      ],
      darkCardWidget: CommunityCard(),
      isLightCardTop: false,
    ),
    BoardingItem(
      header: "Keep learning",
      description:
          "Lorem ipsum dolor sit consetetur sadipscing eliter, sed diarm",
      lightCardIcons: [
        IconContainer(
          icon: Icons.open_with,
        ),
        IconContainer(
          padding: kPaddingM,
          icon: Icons.card_membership,
        ),
        IconContainer(
          icon: Icons.mode_comment,
        )
      ],
      darkCardWidget: Container(),
      isLightCardTop: true,
    ),
    BoardingItem(
      header: "Work together",
      description:
          "Lorem ipsum dolor sit consetetur sadipscing eliter, sed diarm",
      lightCardIcons: [
        IconContainer(
          icon: Icons.event_seat,
        ),
        IconContainer(
          padding: kPaddingM,
          icon: Icons.confirmation_number,
        ),
        IconContainer(
          icon: Icons.border_color,
        )
      ],
      darkCardWidget: CommunityCard(),
      isLightCardTop: false,
    )
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    var item = items[index];
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
              CardStack(
                item: item,
              ),
              Container(
                height: kPaddingL,
              ),
              TextColumn(
                header: item.header,
                description: item.description,
              ),
              Spacer(),
              CurrentPageIndicator(
                page: index + 1,
                total: items.length,
                child: NextButton(onTap: () {
                  if (index < items.length - 1) {
                    setState(() {
                      index += 1;
                    });
                  }
                }),
              ),
            ],
          )),
    );
  }
}

class CommunityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPaddingM * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildColumn(Icons.people, false),
          _buildColumn(Icons.camera_alt, true),
          _buildColumn(Icons.access_alarm, false),
        ],
      ),
    );
  }

  _buildColumn(IconData iconData, bool highlight) {
    return Column(
      children: [
        if (!highlight)
          Container(
            height: 48,
          ),
        Icon(iconData, color: Colors.white.withOpacity(0.8), size: 38),
        Container(
          height: 16,
        ),
        Expanded(
          child: CustomPaint(
            painter: VerticalDashedContainer(),
            child: Container(
              width: 20,
            ),
          ),
        )
      ],
    );
  }
}

class VerticalDashedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(size.width / 2, 0);
    final pathMetric = path.computeMetrics().first;
    final dashedPath = List<Path>();
    final dashedLength = 8;
    final dashedSpace = 4;
    for (double i = 0;
        i < pathMetric.length;
        i = i + dashedLength + dashedSpace) {
      dashedPath.add(pathMetric.extractPath(i, i + dashedLength));
    }

    dashedPath.forEach((element) {
      canvas.drawPath(
          element,
          Paint()
            ..color = kGrey.withOpacity(0.1)
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
      painter: IndicatorPainter(total, page),
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
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final otherPagePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 4
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

class CardStack extends StatefulWidget {
  final BoardingItem item;

  const CardStack({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  BoardingItem oldItem;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    oldItem = widget.item;
    super.initState();
  }

  @override
  void didUpdateWidget(CardStack oldWidget) {
    if (oldWidget.item != widget.item) {
      this.oldItem = oldWidget.item;
      _controller.forward(from: 0.0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          SlideTransition(
            position: Tween<Offset>(begin: Offset.zero, end: Offset(-2, 0))
                .animate(CurvedAnimation(
                    parent: _controller,
                    curve: Interval(0.2, 1.0, curve: Curves.decelerate))),
            child: DarkCard(
              darkCardWidget: oldItem.darkCardWidget,
              isTop: oldItem.isLightCardTop,
            ),
          ),

          SlideTransition(
            position: Tween<Offset>(begin: Offset(2, 0), end: Offset.zero)
                .animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(0.2, 1.0, curve: Curves.decelerate),
            )),
            child: DarkCard(
                darkCardWidget: widget.item.darkCardWidget,
                isTop: widget.item.isLightCardTop),
          ),

          Positioned(
            top: oldItem.isLightCardTop ? 0 : null,
            bottom: oldItem.isLightCardTop ? null : 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: Tween<Offset>(begin: Offset.zero, end: Offset(-2, 0))
                  .animate(CurvedAnimation(
                      parent: _controller, curve: Curves.decelerate)),
              child: LightCard(lightCardIcons: oldItem.lightCardIcons),
            ),
          ),

          Positioned(
            top: widget.item.isLightCardTop ? 0 : null,
            bottom: widget.item.isLightCardTop ? null : 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: Tween<Offset>(begin: Offset(2, 0), end: Offset.zero)
                  .animate(CurvedAnimation(
                      parent: _controller, curve: Curves.decelerate)),
              child: LightCard(lightCardIcons: widget.item.lightCardIcons),
            ),
          )
        ],
      ),
    );
  }
}

class LightCard extends StatelessWidget {
  const LightCard({
    Key key,
    @required this.lightCardIcons,
  }) : super(key: key);

  final List<Widget> lightCardIcons;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kPaddingL),
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
    );
  }
}

class DarkCard extends StatelessWidget {
  const DarkCard({
    Key key,
    @required this.darkCardWidget,
    this.isTop,
  }) : super(key: key);

  final Widget darkCardWidget;
  final bool isTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isTop
          ? EdgeInsets.only(top: kPaddingL)
          : EdgeInsets.only(bottom: kPaddingL),
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
    );
  }
}

class NextButton extends StatelessWidget {
  final VoidCallback onTap;

  const NextButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 68,
        width: 68,
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
                height: 1.5,
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
