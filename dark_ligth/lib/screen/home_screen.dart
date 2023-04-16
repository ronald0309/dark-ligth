import 'package:dark_ligth/app_theme.dart';
import 'package:dark_ligth/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'component/wire_draw.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Offset initialPosition = const Offset(250, 0);
  Offset switchPosition = const Offset(350, 350);
  Offset containerPosition = const Offset(350, 350);
  Offset finalPosition = const Offset(350, 350);

  void didChangeDependencies() {
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    initialPosition = Offset(size.width * .9, 0);
    containerPosition = Offset(size.width * .9, size.height * .4);
    finalPosition = Offset(size.width * .9, size.height * .5 - size.width * .1);

    if (themeProvider.isLightTheme) {
      switchPosition = containerPosition;
    } else {
      switchPosition = finalPosition;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.8, -0.3),
            radius: 1,
            colors: themeProvider.themeMode().gradientColors!,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            FloatingBubbles(
              noOfBubbles: 25,
              colorsOfBubbles: [
                Colors.green.withAlpha(30),
                Colors.red,
              ],
              sizeFactor: 0.16,
              duration: 1200, // 120 seconds.
              opacity: 70,
              paintingStyle: PaintingStyle.stroke,
              strokeWidth: 8,
              shape: BubbleShape
                  .circle, // circle is the default. No need to explicitly mention if its a circle.
              speed: BubbleSpeed.normal, // normal is the default
            ),
            leftPart(context, size, themeProvider),
            Positioned(
              top: containerPosition.dy - size.width * .1 / 2 - 5,
              left: containerPosition.dx - size.width * .1 / 2 - 5,
              child: Container(
                width: size.width * .1 + 10,
                height: size.height * .1 + 10,
                decoration: BoxDecoration(
                  color: themeProvider.themeMode().switchBgColor!,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Wire(
              initialPosition: initialPosition,
              toOffset: switchPosition,
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1),
              top: switchPosition.dy - size.width * 0.1 / 2,
              left: switchPosition.dx - size.width * 0.1 / 2,
              child: Draggable(
                feedback: Container(
                  width: size.width * .1,
                  height: size.width * .1,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
                onDragEnd: (details) {
                  if (themeProvider.isLightTheme) {
                    setState(() {
                      switchPosition = containerPosition;
                    });
                  } else {
                    setState(() {
                      switchPosition = finalPosition;
                    });
                  }
                  themeProvider.toggleThemeData();
                },
                onDragUpdate: (details) {
                  setState(() {
                    switchPosition = details.localPosition;
                  });
                },
                child: Container(
                  width: size.width * .1,
                  height: size.width * .1,
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode().thumbColor,
                    border: Border.all(
                      width: 5,
                      color: themeProvider.themeMode().switchColor!,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SafeArea leftPart(
      BuildContext context, Size size, ThemeProvider themeProvider) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('jm').format(DateTime.now()),
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              width: size.width * .7,
              child: const Divider(
                //height: 0,
                thickness: 1,
                color: AppColors.white,
              ),
            ),
            const Text(
              "Ronny Bonilla Arias",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Spacer(),
            Container(
              width: size.width * .2,
              height: size.width * .2,
              decoration: BoxDecoration(
                color: themeProvider.themeMode().switchColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.nights_stay_outlined,
                size: 50,
                color: AppColors.white,
              ),
            ),
            SizedBox(
              width: size.width * .2,
              child: const Divider(
                //height: 0,
                thickness: 1,
                color: AppColors.white,
              ),
            ),
            Text("30\u00B0C",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: AppColors.white,
                    )),
            const Text(
              "Universidad Nacional",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('EEEE').format(DateTime.now()),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              DateFormat('MMM ').format(DateTime.now()),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              DateFormat('d ').format(DateTime.now()),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
