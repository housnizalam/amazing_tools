import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedDialog {
  static void scale({
    required Widget child,
    required BuildContext context,
    bool dismissable = true,
    double? height,
    double? width,
    Color? backgroundColor,
    Color? titleColor,
    String title = '',
    int duration = 1000,
    double beginn = 0,
    double end = 1,
  }) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    showGeneralDialog(
      barrierDismissible: dismissable,
      barrierLabel: "Dismiss",
      transitionDuration: Duration(milliseconds: duration),
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(a1),
          child: AlertDialog(
            title: Center(
              child: FittedBox(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: widgetWidth * 0.6),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.close),
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: titleColor ?? Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: backgroundColor ?? Colors.grey[250],
            content: SizedBox(
              height: height ?? widgetHeight * 0.7,
              width: width ?? widgetWidth * 0.7,
              child: child,
              // Hier können Sie den Inhalt Ihres Dialogs platzieren
            ),
          ),
        );
      },
    );
  }

  static void slide({
    required Widget child,
    required BuildContext context,
    required Offset startOffset,
    Color? backgroundColor,
    String title = '',
    Color? titleColor,
    Offset endOffset = const Offset(0, 0),
    double? height,
    double? width,
    int duration = 400,
  }) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;

    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: Duration(milliseconds: duration),
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: startOffset,
            end: endOffset,
          ).animate(a1),
          child: AlertDialog(
            backgroundColor: backgroundColor ?? Colors.grey[250],
            title: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: widgetWidth * 0.6),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            content: SizedBox(
              height: height ?? widgetHeight * 0.7,
              width: width ?? widgetWidth * 0.7,
              child: child,
            ),
          ),
        );
      },
    );
  }

  static void warnung({
    required String text,
    required BuildContext context,
    String title = '',
    Color? backgroundColor,
    Color? titleColor,
    Color textColor = Colors.red,
    int scaleDauer = 400,
    int dialogDauer = 1300,
    double? height,
    double? width,
    int scalebeginn = 0,
    int scaleEnd = 0,
    double textSize = 30,
  }) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;

    showGeneralDialog(
      // routeSettings:Dismissible(key: key, child: child),
      barrierDismissible: false,
      barrierLabel: "Dismiss",
      transitionDuration: Duration(milliseconds: scaleDauer),
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(a1),
          child: AlertDialog(
            backgroundColor: backgroundColor ?? Colors.grey[250],
            title: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor ?? Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SizedBox(
              height: height ?? widgetHeight * 0.25,
              width: width ?? widgetWidth * 0.5,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                  ),
                  textAlign: TextAlign.center,
                )),
              ),
              // Hier können Sie den Inhalt Ihres Dialogs platzieren
            ),
          ),
        );
      },
    );
    Timer(Duration(milliseconds: dialogDauer), () {
      Navigator.of(context).pop();
    });
  }
}
