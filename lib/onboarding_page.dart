import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onboardingconcept/constants.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
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
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: DotGrid(
              verticalCount: 5,
              horizontalCount: 5,
            ),
          ),
          Positioned(
            left: 0,
            top: MediaQuery.of(context).size.height * 1 / 4,
            child: DotGrid(
              verticalCount: 10,
              horizontalCount: 5,
            ),
          ),
          Positioned(
            left: 0,
            bottom: kPaddingM,
            child: DotGrid(
              verticalCount: 10,
              horizontalCount: 5,
            ),
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).size.height * 2 / 3,
            child: DotGrid(
              verticalCount: 10,
              horizontalCount: 5,
            ),
          ),
          Container(
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
                    item: item,
                  ),
                ],
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(bottom: kPaddingL + kPaddingM),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CurrentPageIndicator(
                    page: index + 1,
                    total: items.length,
                    child: Container(
                      height: 68,
                      width: 68,
                    ),
                  ),
                  NextButton(
                    onNext: () {
                      if (index < items.length - 1) {
                        setState(() {
                          index += 1;
                        });
                      }
                    },
                    onFinish: () {
                      //TODO Push login
                    },
                    isFinished: () {
                      return item == items.last;
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
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
          height: 12,
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

class CurrentPageIndicator extends StatefulWidget {
  final int page;
  final int total;
  final Widget child;

  const CurrentPageIndicator({Key key, this.page, this.total, this.child})
      : super(key: key);

  @override
  _CurrentPageIndicatorState createState() => _CurrentPageIndicatorState();
}

class _CurrentPageIndicatorState extends State<CurrentPageIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1.0);

    super.initState();
  }

  @override
  void didUpdateWidget(CurrentPageIndicator oldWidget) {
    if (oldWidget.page != widget.page) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndicatorPainter(widget.total, widget.page,
          CurvedAnimation(parent: _controller, curve: Curves.decelerate)),
      child: Container(
        margin: EdgeInsets.all(12),
        child: widget.child,
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final int pageCount;
  final int currentPage;
  final Animation<double> loopAnimation;

  final currentPageColorTween =
      ColorTween(begin: Colors.white.withOpacity(0.4), end: Colors.white);

  IndicatorPainter(this.pageCount, this.currentPage, this.loopAnimation)
      : super(repaint: loopAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final rect = Rect.fromCenter(
        center: center, width: size.width - 12, height: size.height - 12);

    final currentPagePaint = Paint()
      ..color = currentPageColorTween.evaluate(loopAnimation)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final otherPagePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final offsetAngle =
        Tween<double>(begin: 0, end: pi * 2).evaluate(loopAnimation) *
            (currentPage % 2 == 0 ? -1 : 1);
    final spaceAngle = pi / 12;
    final sweepAngle = ((pi - ((pageCount - 1) * spaceAngle)) / pageCount);

    for (int i = 0; i < pageCount; i++) {
      canvas.drawArc(
          rect,
          pi + sweepAngle * i + spaceAngle * i + offsetAngle,
          sweepAngle,
          false,
          i <= currentPage - 1 ? currentPagePaint : otherPagePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class DotGrid extends StatelessWidget {
  final int horizontalCount;
  final int verticalCount;

  const DotGrid({
    Key key,
    this.horizontalCount,
    this.verticalCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dotSize = 2.5;
    final spaceSize = 8.0;
    final width =
        (horizontalCount * dotSize) + ((horizontalCount - 1) * spaceSize);
    final height =
        (verticalCount * dotSize) + ((verticalCount - 1) * spaceSize);
    return CustomPaint(
      painter: DotGridPainter(
        horizontalCount,
        verticalCount,
        kWhite.withOpacity(0.1),
        dotSize,
        spaceSize,
      ),
      child: Container(
        width: width,
        height: height,
      ),
    );
  }
}

class DotGridPainter extends CustomPainter {
  final int horizontalCount;
  final int verticalCount;
  final Color color;
  final double dotSize;
  final double spaceSize;

  DotGridPainter(this.horizontalCount, this.verticalCount, this.color,
      this.dotSize, this.spaceSize);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < horizontalCount; i++) {
      for (int j = 0; j < verticalCount; j++) {
        canvas.drawCircle(
            Offset(
              (spaceSize + dotSize) * i,
              (dotSize + spaceSize) * j,
            ),
            dotSize.toDouble(),
            Paint()..color = color);
      }
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
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
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
                    curve: Interval(0.1, 1.0, curve: Curves.decelerate))),
            child: DarkCard(
              darkCardWidget: oldItem.darkCardWidget,
              isTop: oldItem.isLightCardTop,
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(begin: Offset(2, 0), end: Offset.zero)
                .animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.decelerate,
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
                      parent: _controller,
                      curve: Interval(0.2, 1.0, curve: Curves.decelerate))),
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

class NextButton extends StatefulWidget {
  final VoidCallback onFinish;
  final VoidCallback onNext;
  final bool Function() isFinished;

  const NextButton({Key key, this.onNext, this.onFinish, this.isFinished})
      : super(key: key);

  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onFinish();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final circleSizeTween =
        Tween<double>(begin: 68, end: MediaQuery.of(context).size.height * 2);

    final iconSizeTween = Tween<double>(begin: 24, end: 32);
    final iconOpacityTween = Tween<double>(begin: 1.0, end: 0.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: handleOnTap,
          child: CustomPaint(
            painter:
                RippleCirclePainter(circleSizeTween.evaluate(CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInCubic,
            ))),
            child: Opacity(
              opacity: iconOpacityTween.evaluate(CurvedAnimation(
                  parent: _controller, curve: Interval(0.6, 1.0))),
              child: Icon(
                Icons.arrow_forward,
                color: kBlue,
                size: iconSizeTween.evaluate(CurvedAnimation(
                    parent: _controller, curve: Interval(0.6, 1.0))),
              ),
            ),
          ),
        );
      },
    );
  }

  void handleOnTap() {
    if (widget.isFinished()) {
      _controller.forward(from: 0.0);
    } else {
      widget.onNext();
    }
  }
}

class RippleCirclePainter extends CustomPainter {
  final double circleSize;

  RippleCirclePainter(this.circleSize);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(size.center(Offset.zero), circleSize / 2,
        Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TextColumn extends StatefulWidget {
  final BoardingItem item;

  const TextColumn({Key key, this.item}) : super(key: key);

  @override
  _TextColumnState createState() => _TextColumnState();
}

class _TextColumnState extends State<TextColumn>
    with SingleTickerProviderStateMixin {
  BoardingItem oldItem;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 180));
    oldItem = widget.item;
    super.initState();
  }

  @override
  void didUpdateWidget(TextColumn oldWidget) {
    if (oldWidget.item != widget.item) {
      oldItem = oldWidget.item;
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          if (oldItem != widget.item)
            FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: _controller, curve: Curves.decelerate)),
                child: buildItems(widget.item)),
          FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                      parent: _controller, curve: Curves.decelerate)),
              child: buildItems(oldItem))
        ],
      ),
    );
  }

  Column buildItems(BoardingItem item) {
    return Column(
      key: ObjectKey(item),
      children: <Widget>[
        Text(
          item.header,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
        ),
        Container(
          height: kPaddingS,
        ),
        Text(
          item.description,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              height: 1.5,
              fontSize: 16,
              color: kGrey.withOpacity(0.6)),
        ),
      ],
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
