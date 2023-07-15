import 'package:flutter/material.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter Functions'),
          // leading: ,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () {
                setState(() {
                  clickCounter = 0;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$clickCounter',
                  style: const TextStyle(
                      fontSize: 160, fontWeight: FontWeight.w300)),
              Text('Click${clickCounter != 1 ? 's' : ''}',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w800))
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              icon: Icons.refresh_outlined,
              onPressed: () {
                setState(() {
                  clickCounter = 0;
                });
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              icon: Icons.plus_one,
              onPressed: () {
                setState(() {
                  clickCounter++;
                });
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              icon: Icons.exposure_minus_1_outlined,
              onPressed: () {
                if (clickCounter == 0) return;
                setState(() {
                  clickCounter--;
                });
              },
            ),
            // FloatingActionButton(
            //   shape: const StadiumBorder(),
            //   onPressed: () {
            //     setState(() {
            //       clickCounter = 0;
            //     });
            //   },
            //   child: const Icon(Icons.refresh_outlined),
            // ),
            // const SizedBox(height: 10),
            // FloatingActionButton(
            //   shape: const StadiumBorder(),
            //   onPressed: () {
            //     setState(() {
            //       clickCounter++;
            //     });
            //   },
            //   child: const Icon(Icons.plus_one),
            // ),
            // const SizedBox(height: 10),
            // FloatingActionButton(
            //   shape: const StadiumBorder(),
            //   onPressed: () {

            //   },
            //   child: const Icon(Icons.exposure_minus_1_outlined),
            // ),
          ],
        ));
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // shape: const StadiumBorder(),
      enableFeedback: true,
      elevation: 5,
      // backgroundColor: Colors.purple,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
