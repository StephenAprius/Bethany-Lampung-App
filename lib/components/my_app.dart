import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final Function()? onTap;

  final bool isVisible;
  final String name;
  final String imagePath;

  const MyApp(
      {super.key,
      required this.isVisible,
      required this.onTap,
      required this.name,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                width: 230,
                height: 40,
                fit: BoxFit.fitHeight,
                imagePath,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(10),
    //         boxShadow: [
    //           BoxShadow(
    //               offset: const Offset(0, 5),
    //               color: Theme.of(context).primaryColor.withOpacity(.2),
    //               spreadRadius: 2,
    //               blurRadius: 5)
    //         ]),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Container(
    //             padding: const EdgeInsets.all(10),
    //             decoration: const BoxDecoration(
    //               shape: BoxShape.circle,
    //             ),
    //             child: Column(
    //               children: [
    //                 const SizedBox(height: 8),
    //                 Image.asset(
    //                   imagePath,
    //                 ),
    //                 Text(name, style: Theme.of(context).textTheme.titleMedium),
    //               ],
    //             )),
    //       ],
    //     ),
    //   ),
    // );
  }
}
