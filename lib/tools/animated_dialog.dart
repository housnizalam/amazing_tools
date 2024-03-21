import 'dart:async';

import 'package:amazing_tools/tools/live_widget.dart';
import 'package:flutter/material.dart';

enum TitelDekoration { normal, warnung, spezial }

///It is a class that allows the user to easily retrieve and control an animation dialog.
class AnimatedDialog {
  /// With this function, the dialog appears from the center of the screen.
  /// Parameters:
  /// - [context]:[context] is the build context. It is required.
  /// - [child]:[child] is the widget that appears in the dialog.
  /// - [dismissable]:[dismissable] It is a boolean attribute that determines whether the dialog should close when clicked outside of it or not.Default to true.
  /// - [showCloseIcon]:[showCloseIcon] It is a boolean attribute that determines whether the dialog has a close icon or not.Default to false.
  /// - [titelWidget]:[titelWidget] It is the widget titel that comes from the user. It is optional.
  /// - [title]:[title] It is the String titel that comes from the user. It is optional.
  /// - [title]:[titelSize] It is the size of titel that comes from the user. Default to 20.
  ///  -[title]:[titleColor] the color of the titel. Default to black.
  /// - [title]:[titelDekoration] It controls the title type (normal, warning, special). Default to normal.
  /// - [duration]:[duration] The duration of the scale animation. Defaults to 700 milliseconds.
  /// - [backgroundColor]:[backgroundColor] The background color of the dialog. Defaults to grey.
  /// - [height]:[height] The widget height. Defaults to 70% current Widget height.
  /// - [width]:[width] The widget width. Defaults to 40% current Widget width.
  /// - [begin]: [begin] can determine the start size of the scale animation. Dafault to 0
  /// - [end]: [end] can determine the end size of the scale animation. Dafault to 1
  static void scale({
    required Widget child,
    required BuildContext context,
    Widget? titelWidget,
    bool dismissable = true,
    bool showCloseIcon = false,
    double? height,
    double? width,
    Color? backgroundColor,
    Color? titleColor,
    String title = '',
    double titelSize = 20,
    TitelDekoration titelDekoration = TitelDekoration.normal,
    Duration? duration,
    double begin = 0,
    double end = 1,
  }) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    showGeneralDialog(
      barrierDismissible: dismissable,
      barrierLabel: "Dismiss",
      transitionDuration: duration ?? const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: begin,
            end: end,
          ).animate(a1),
          child: AlertDialog(
            title: titelWidget ?? Center(
                    child: Column(
                      children: [
                        if (showCloseIcon)
                          Container(
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(Icons.close),
                            ),
                          ),
                        if (titelDekoration == TitelDekoration.normal)
                          Text(
                            title,
                            style: TextStyle(
                              color: titleColor ?? Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: titelSize,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (titelDekoration == TitelDekoration.warnung)
                          LiveWidget(
                            duration: const Duration(milliseconds: 1500),
                            animateBegin: 0.8,
                            animateEnd: 1.1,
                            child: Text(
                              title,
                              style: TextStyle(
                                color: titleColor ?? Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: titelSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (titelDekoration == TitelDekoration.spezial)
                          LiveWidget(
                            duration: const Duration(milliseconds: 1500),
                            animateBegin: 1,
                            animateEnd: 1.1,
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: titleColor ?? Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: titelSize,
                                  shadows: const [
                                    BoxShadow(
                                      color: Color.fromARGB(160, 255, 193, 7),
                                      offset: Offset(-1, 1),
                                      blurRadius: BorderSide.strokeAlignOutside,
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(100, 255, 193, 7),
                                      offset: Offset(-2, 2),
                                      blurRadius: BorderSide.strokeAlignOutside,
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(40, 255, 193, 7),
                                      offset: Offset(-3, 3),
                                      blurRadius: BorderSide.strokeAlignOutside,
                                    ),
                                  ],
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
            backgroundColor: backgroundColor ?? Colors.grey[250],
            content: SizedBox(
              height: height ?? widgetHeight * 0.4,
              width: width ?? widgetWidth * 0.7,
              child: child,
            ),
          ),
        );
      },
    );
  }

  /// With this function, the dialog slides from the screen side that user choose.
  /// Parameters:
  /// - [context]:[context] is the build context. It is required.
  /// - [child]:[child] is the widget that appears in the dialog. It is required.
  /// - [startOffset]:[startOffset] is a Offset attribut that determines the direction from which the slide transition starts. It is required.
  /// - [endOffset]:[endOffset] is a Offset attribut that determines the position that the slide transition ends in. Default to (0,0).
  /// - [dismissable]:[dismissable] It is a boolean attribute that determines whether the dialog should close when clicked outside of it or not.Default to true.
  /// - [showCloseIcon]:[showCloseIcon] It is a boolean attribute that determines whether the dialog has a close icon or not.Default to false.
  /// - [titelWidget]:[titelWidget] It is the widget titel that comes from the user. It is optional.
  /// - [title]:[title] It is the String titel that comes from the user. It is optional.
  /// - [title]:[titelSize] It is the size of titel that comes from the user. Default to 20.
  /// - [title]:[titleColor] the color of the titel. Default to black.
  /// - [title]:[titelDekoration] It controls the title type (normal, warning, special). Default to normal.
  /// - [duration]:[duration] The duration of the scale animation. Defaults to 700 milliseconds.
  /// - [backgroundColor]:[backgroundColor] The background color of the dialog. Defaults to grey.
  /// - [height]:[height] The widget height. Defaults to 70% current Widget height.
  /// - [width]:[width] The widget width. Defaults to 40% current Widget width.

  static void slide({
    required Widget child,
    required BuildContext context,
    required Offset startOffset,
    Widget? titelWidget,
    Color? backgroundColor,
    String title = '',
    double titelSize = 20,
    Color? titleColor,
    bool dismissable = true,
    bool showCloseIcon = false,
    Offset endOffset = const Offset(0, 0),
    TitelDekoration titelDekoration = TitelDekoration.normal,
    double? height,
    double? width,
    Duration? duration,
  }) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;

    showGeneralDialog(
      barrierDismissible: dismissable,
      barrierLabel: "Dismiss",
      transitionDuration: duration ?? const Duration(milliseconds: 700),
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
            title: titelWidget == null
                ? Center(
                    child: Column(
                      children: [
                        if (showCloseIcon)
                          Container(
                            margin: EdgeInsets.only(left: widgetWidth * 0.54),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(Icons.close),
                            ),
                          ),
                        if (titelDekoration == TitelDekoration.normal)
                          Text(
                            title,
                            style: TextStyle(
                              color: titleColor ?? Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: titelSize,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (titelDekoration == TitelDekoration.warnung)
                          LiveWidget(
                            duration: const Duration(milliseconds: 1000),
                            animateBegin: 0.8,
                            animateEnd: 1.1,
                            child: Text(
                              title,
                              style: TextStyle(
                                color: titleColor ?? Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: titelSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (titelDekoration == TitelDekoration.spezial)
                          LiveWidget(
                            duration: const Duration(milliseconds: 1000),
                            animateBegin: 1,
                            animateEnd: 1.1,
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: titleColor ?? Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: titelSize,
                                  shadows: const [
                                    BoxShadow(
                                      color: Color.fromARGB(160, 255, 193, 7),
                                      offset: Offset(-1, 1),
                                      blurRadius: BorderSide.strokeAlignOutside,
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(100, 255, 193, 7),
                                      offset: Offset(-2, 2),
                                      blurRadius: BorderSide.strokeAlignOutside,
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(40, 255, 193, 7),
                                      offset: Offset(-3, 3),
                                      blurRadius: BorderSide.strokeAlignOutside,
                                    ),
                                  ],
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  )
                : const SizedBox(),
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

  /// With this function, the dialog appears from the center of the screen for from user choosed Time and disapear.
  /// Parameters:
  /// - [context]:[context] is the build context. It is required.
  /// - [child]:[child] is the widget that appears in the dialog. It is optional.
  /// - [text]:[text] is the text that appears in dialog.
  /// - [textStyle]:[textStyle] is the style of the users text.
  /// - [title]:[title] It is the String titel that comes from the user. It is optional.
  /// - [titelStyle]:[titelStyle] is the style of the users titel.
  /// - [scalePeriod]:[scalePeriod] The duration of the scale animation. Defaults to 400 milliseconds.
  /// - [dialogPeriod]:[dialogPeriod] The time of the apearing of the dialog. Defaults to 1300 milliseconds.
  /// - [backgroundColor]:[backgroundColor] The background color of the dialog. Defaults to grey.
  /// - [height]:[height] The widget height. Defaults to 70% current Widget height.
  /// - [width]:[width] The widget width. Defaults to 40% current Widget width.
  /// - [scalebegin]: [scalebegin] can determine the start size of the scale animation. Dafault to 0.

  static void warnung({
    String text = '',
    required BuildContext context,
    Widget? child,
    String title = '',
    Color? backgroundColor,
    Duration? scalePeriod,
    Duration? dialogPeriod,
    double? height,
    double? width,
    int scalebegin = 0,
    TextStyle? textStyle,
    TextStyle? titelStyle,
  }) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;

    showGeneralDialog(
      barrierDismissible: false,
      barrierLabel: "Dismiss",
      transitionDuration: scalePeriod ?? const Duration(milliseconds: 400),
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
              child: child ??
                  Text(
                    title,
                    style: titelStyle ??
                        const TextStyle(
                          color: Colors.black,
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
                  style: textStyle ??
                      const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          ),
        );
      },
    );
    Timer(dialogPeriod ?? const Duration(milliseconds: 1300), () {
      Navigator.of(context).pop();
    });
  }
}
