import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:amazing_tools/tools/flip_widget.dart';

// Diese Enum beinhaltet Die Sitching States, dadurch kann man eintscheden, welche Factory benutzt werden soll
enum SwitchingTyp { dualState, starSingleState, flipSingleState, dualScaleState }

class AmazingSwitcher extends StatefulWidget {
// Dise Inernal Konstraktor wird benutzt um die Factories Bedarfsgerecht bauen zu können
// es benutzt meistens wenn man nur spezifische Angaben will, den Benutzer steuern und sehen lassen
  const AmazingSwitcher._internal({
    super.key,
    this.switcherHeight = 40,
    this.switcherWidth = 80,
    this.indicatorRotationAngel = 360,
    this.indicatorChild,
    this.animationDuration,
    this.onFirstPress,
    this.onSecondPress,
    this.onFirstAnimationComplete,
    this.onSecondAnimationComplete,
    this.startText,
    this.secondText,
    this.switcherState2,
    required this.switcherState1,
    required this.switchingTyp,
    this.endStarInnerSize,
    this.startStarInnerSize,
    this.flipDirection,
    this.switcherBoxBorder,
    this.switcherBoxShadowList,
    this.switcherGradientColor,
    this.firstFlipCondition = true,
    this.secondFlipCondition = true,
    this.onFirstUnactive,
    this.onSecondUnactive,
    this.beginnWithFirstState = true,
  });

  ///- [AmazingSwitcher] ist ein Konstraktor, der ein normale dualstates Switcher baut.
  const AmazingSwitcher({
    super.key,
    this.switcherHeight = 40,
    this.switcherWidth = 80,
    this.indicatorRotationAngel = 360,
    this.indicatorChild,
    this.animationDuration,
    this.onFirstPress,
    this.onSecondPress,
    this.onFirstAnimationComplete,
    this.onSecondAnimationComplete,
    this.startText,
    this.secondText,
    required this.switcherState1,
    this.switcherState2,
    this.endStarInnerSize = 0.7,
    this.startStarInnerSize = 0.7,
    this.switcherBoxBorder,
    this.switcherBoxShadowList,
    this.switcherGradientColor,
    this.onFirstUnactive,
    this.onSecondUnactive,
    this.beginnWithFirstState = true,
  })  : switchingTyp = SwitchingTyp.dualState,
        flipDirection = null,
        firstFlipCondition = true,
        secondFlipCondition = true;

  ///- [switcherHeight] : es soll midestens die hälfte von [switcherWidth] sein, um die Switcher Animation richtig funktionieren.
  final double switcherHeight;
  final double switcherWidth;

  ///- [indicatorRotationAngel] : es feststellt die Rotation Angel, die der Indikator zwischen die Zwei Situationen macht.
  final double indicatorRotationAngel;

  ///- [startStarInnerSize] : es feststellt die anfangs Indikator-Star inner Size, vor der Switchingsanimations.
  final double? startStarInnerSize;

  ///- [endStarInnerSize] : es feststellt die ende Indikator-Star inner Size, nachdem Switchingsanimations.

  final double? endStarInnerSize;

  ///- [indicatorChild] : es ermöglicht ein Child dem Indikator zu erstellen.
  final Widget? indicatorChild;
  final Duration? animationDuration;

  ///- [onFirstPress] : Diese Funktion wird beim Anfang der Taste auf den Siwtcher in der erste Switching situation aufgerufen.
  final Function? onFirstPress;

  ///- [onSecondPress] : Diese Funktion wird beim Anfang der Taste auf den Switcher in der zweite Switching situation aufgerufen.

  final Function? onSecondPress;

  ///- [onFirstAnimationComplete] : Diese Funktion wird beim der Ende der Animation in der erste Switching situation aufgerufen, das benutzt man wen die Funktion nur nach der Animationsende aufgerufen soll.

  final Function? onFirstAnimationComplete;

  ///- [onSecondAnimationComplete] : Diese Funktion wird beim der Ende der Animation in der zweite Switching situation aufgerufen, das benutzt man wen die Funktion nur nach der Animationsende aufgerufen soll.

  final Function? onSecondAnimationComplete;

  ///- [onFirstUnactive] : Diese Funktion wird aufgerufen, wenn die Condition der erste Switching Situation nicht verfüllt ist, ZB: einen Scafold massenger, dass die Condition nicht verfüllt ist.
  final Function? onFirstUnactive;

  ///- [onSecondUnactive] : Diese Funktion wird aufgerufen, wenn die Condition der zweite Switching Situation nicht verfüllt ist, ZB: einen Scafold massenger, dass die Condition nicht verfüllt ist.

  final Function? onSecondUnactive;
  final SwitchingTyp switchingTyp;

  ///- [startText] : ein Widget, das man sieht inm Switcher wen die Switcher bei der anfangssituation ist.
  final Widget? startText;

  ///- [secondText] : ein Widget, das man sieht inm Switcher wen die Switcher bei der zweite Situation ist.

  final Widget? secondText;

  ///- [switcherState1] : Diese Klasse feststellt, wie der Indikator vor dem Switching aussehen soll.
  final AmazingSwitcherState switcherState1;

  ///- [switcherState2] : Diese Klasse feststellt, wie der Indikator nachdem Switching aussehen soll.

  final AmazingSwitcherState? switcherState2;
  final FlipDirection? flipDirection;
  final BoxBorder? switcherBoxBorder;
  final List<BoxShadow>? switcherBoxShadowList;

  ///- [switcherGradientColor] : Diese Liste empfängt Farben und baut ein Gradient, wenn die mehr als eine Farbe sind, und wenn nur eine gegeben ist, dann baut ein normale Farbe.
  final List<Color>? switcherGradientColor;

  ///- [firstFlipCondition] : es ist die Vorraussetzung, die verfüllt werden soll, um die erste switching Animation und Funktion activieren kann. Standardweise ist es True.
  final bool firstFlipCondition;

  ///- [secondFlipCondition] : es ist die Vorraussetzung, die verfüllt werden soll, um die zweite switching Animation und Funktion activieren kann. Standardweise ist es True.

  final bool secondFlipCondition;

  ///- [beginnWithFirstState] : es feststellt mit welche Situation, der Switcher anfangen soll. ZB standardweise ist der Indikator links und besitzt die Situation eins Eigenschaften, aber wenn diese Variable false ist der Indikator rechts und besitzt die zweite Situation Eigenschaften.
  final bool beginnWithFirstState;

  ///- [AmazingSwitcher.starSingleState] : Diese Factory baut einen Switcher mit einziger Indikator Platz, was sich ändert, ist nur die Indikator Form gemäß die gegebene Switcher Situationen.
  factory AmazingSwitcher.starSingleState({
    Key? key,
    Function? onFirstPress,
    Function? onSecondPress,
    Function? onFirstAnimationComplete,
    Function? onSecondAnimationComplete,
    double indicatorRotationAngel = 360,
    double starFirsInnerRadius = 0,
    double secondStarInnerRadius = 0.1,
    Color indicatorColor = Colors.blue,
    double starHeads = 7,
    double starHeadsRounding = 0,
    double starValleyRounding = 0,
    Widget? child,
    double? startStarInnerSize = 0.7,
    double? endStarInnerSize = 0.7,
    required AmazingSwitcherState switcherState1,
    AmazingSwitcherState? switcherState2,
    final Function? onFirstUnactive,
    final Function? onSecondUnactive,
    bool beginnWithFirstState = true,
  }) {
    return AmazingSwitcher._internal(
      switcherState2: switcherState2,
      switcherState1: switcherState1,
      startStarInnerSize: startStarInnerSize,
      endStarInnerSize: endStarInnerSize,
      switchingTyp: SwitchingTyp.starSingleState,
      key: key,
      indicatorChild: child,
      indicatorRotationAngel: indicatorRotationAngel,
      onFirstPress: onFirstPress,
      onSecondPress: onSecondPress,
      onFirstAnimationComplete: onFirstAnimationComplete,
      onSecondAnimationComplete: onSecondAnimationComplete,
      switcherHeight: 40,
      switcherWidth: 40,
      onFirstUnactive: onFirstUnactive,
      onSecondUnactive: onSecondUnactive,
      beginnWithFirstState: beginnWithFirstState,
    );
  }

  ///- [AmazingSwitcher.flipSingleState] : Diese Factory baut einen Switcher, der sich Beim Klicken zur nächste Seite dreht, und schaut durch die Sides Widgets das gewählte Widget.
  factory AmazingSwitcher.flipSingleState({
    Key? key,
    final Widget? startSide,
    final Widget? secondSide,
    double height = 40,
    double width = 40,
    Function? onFirstPress,
    Function? onSecondPress,
    Function? onFirstAnimationComplete,
    Function? onSecondAnimationComplete,
    Duration? animationDuration,
    FlipDirection? flipDirection,
    bool firstFlipCondition = true,
    bool secondFlipCondition = true,
    final Function? onFirstUnactive,
    final Function? onSecondUnactive,
    bool beginnWithFirstState = true,
  }) {
    return AmazingSwitcher._internal(
      firstFlipCondition: firstFlipCondition,
      secondFlipCondition: secondFlipCondition,
      flipDirection: flipDirection,
      animationDuration: animationDuration,
      switcherHeight: height,
      switcherWidth: width,
      onFirstPress: onFirstPress,
      onSecondPress: onSecondPress,
      onFirstAnimationComplete: onFirstAnimationComplete,
      onSecondAnimationComplete: onSecondAnimationComplete,
      onFirstUnactive: onFirstUnactive,
      onSecondUnactive: onSecondUnactive,
      startText: startSide,
      secondText: secondSide,
      switcherState1: AmazingSwitcherState(),
      switchingTyp: SwitchingTyp.flipSingleState,
      beginnWithFirstState: beginnWithFirstState,
    );
  }

  ///_ [AmazingSwitcher.dualScaleState] : Diese Factory baut einen Switcher, der zwei indikatoren hat, eine ist scheinbar und der andere verborgen. wenn einer gecklikt ist, verbirgt sich und erscheind der andere mit Animation Effekt.
  factory AmazingSwitcher.dualScaleState({
    Key? key,
    required AmazingSwitcherState switcherState1,
    final double switcherHeight = 40,
    final double switcherWidth = 80,
    final double indicatorRotationAngel = 360,
    final double? startStarInnerSize = 0.7,
    final double? endStarInnerSize = 0.7,
    final Widget? indicatorChild,
    final Duration? animationDuration,
    final Function? onFirstPress,
    final Function? onSecondPress,
    final Function? onFirstAnimationComplete,
    final Function? onSecondAnimationComplete,
    final Function? onFirstUnactive,
    final Function? onSecondUnactive,
    final Widget? startText,
    final Widget? secondText,
    final AmazingSwitcherState? switcherState2,
    final List<Color>? switcherGradientColor,
    bool beginnWithFirstState = true,
  }) {
    return AmazingSwitcher._internal(
      switchingTyp: SwitchingTyp.dualScaleState,
      switcherState1: switcherState1,
      switcherState2: switcherState2,
      switcherHeight: switcherHeight,
      switcherWidth: switcherWidth,
      indicatorRotationAngel: indicatorRotationAngel,
      startStarInnerSize: startStarInnerSize,
      endStarInnerSize: endStarInnerSize,
      indicatorChild: indicatorChild,
      animationDuration: animationDuration,
      onFirstPress: onFirstPress,
      onSecondPress: onSecondPress,
      onFirstAnimationComplete: onFirstAnimationComplete,
      onSecondAnimationComplete: onSecondAnimationComplete,
      onFirstUnactive: onFirstUnactive,
      onSecondUnactive: onSecondUnactive,
      startText: startText,
      secondText: secondText,
      switcherGradientColor: switcherGradientColor,
      beginnWithFirstState: beginnWithFirstState,
    );
  }

  @override
  State<AmazingSwitcher> createState() => _AmazingSwitcherState();
}

class _AmazingSwitcherState extends State<AmazingSwitcher> with TickerProviderStateMixin {
  // Die Animaion Controller muss mit Late definiert werden, weil es muss sein wert in InitState erhalten.
  // Die Animaion kann aber nicht in InitState definiert werden, sonst ist sie in die Widgets nicht erkannt, deshalb soll es unbedingt mit late gebaut werden.
  // _animationController kontrolliert die normale Animations Effekte im Switcher
  late AnimationController _animationController;
  // _unActiveAnimationController er kontrolliert die sundere Animation, die nur scheint wenn die Switching Vorraussetzungen nicht erfülen sind.
  late AnimationController _unActiveAnimationController;
  // es repräsentier das Child Widget vom Indikator.
  late Widget child;
  // switcherState feststellt, welche Factory gebaut werden soll.
  late AmazingSwitcherState switcherState;
  // presed feststellt die Switching Situation
  bool presed = false;
  // beginnWithFirstState es kontrolliert die beginn Situation des Switchers
  late bool beginnWithFirstState;
  @override
  void initState() {
    beginnWithFirstState = widget.beginnWithFirstState;
    // diese wird nur aufgerufen, wenn die Switching Vorraussetzungen nicht erfülen sind.
    _unActiveAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      // dies Animation soll nur die hälfe weg machen, daher ist das upperBound mit 0.5 bewertet
      upperBound: 0.5,
    )
      // addListener diese Funktion hört die änderungen mit dem Controller
      ..addListener(
        () {
          // mit je änderung soll die Seite sich erneut bauen
          setState(() {});
        },
      )
      // addStatusListener diese Funktion hört die Situationen von Controller
      ..addStatusListener(
        (status) {
          // weil ich den Indikator wiederkehren will.
          if (status == AnimationStatus.completed) _unActiveAnimationController.reverse();
          if (status == AnimationStatus.dismissed) {
            // weil die Funftionen onSecondUnactive und onFirstUnactive sollen nur nach die Animationsende aufgerufen sein.
            // sooen sie nur wenn die Animation Situation dismissed ist.
            if (presed && widget.onSecondUnactive != null) widget.onSecondUnactive!.call();
            if (!presed && widget.onFirstUnactive != null) widget.onFirstUnactive!.call();
          }
        },
      );

    setState(() {
      // festellung von die erste Situation des Switchers.
      // um die Fehler Angaben zu beseitigen habe ich es durch copyFrom gebaut
      switcherState = AmazingSwitcherState.copyFrom(state1: widget.switcherState1, state2: null)
          // starInnerRadius wird das wert von widget.startStarInnerSize weil es ist die erste Situation .
          .copyWith(starInnerRadius: widget.startStarInnerSize);
    });
    // wenn die Indikator in Switcher State nicht definiert wird in Widget gesucht
    child = switcherState.child ?? widget.indicatorChild ?? const SizedBox();
    // _animationController ist der Controller für die normale Animation.
    _animationController = AnimationController(
      vsync: this,
      // wenn beginnWithFirstState ist flase macht das Switcher eine schnelle Bewegung um mit der zweite Situation zu anfangen.
      duration: !beginnWithFirstState ? Duration.zero : widget.animationDuration ?? const Duration(milliseconds: 500),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener((status) {
        setState(() {
          if (status == AnimationStatus.forward) {
            // wenn die Animation anfängt soll das Child verborgen werden
            child = const SizedBox();
            // hier wird die zweite State definiert.
            switcherState = AmazingSwitcherState.copyFrom(state1: widget.switcherState1, state2: widget.switcherState2);
            // wenn die Animation rüchkehrt
          } else if (status == AnimationStatus.reverse) {
            switcherState = AmazingSwitcherState.copyFrom(state1: widget.switcherState1, state2: null);
            child = const SizedBox();
          }
          if (status == AnimationStatus.completed) {
            if (widget.onFirstAnimationComplete != null) widget.onFirstAnimationComplete!.call();
            if (widget.endStarInnerSize != null) switcherState.starInnerRadius = widget.endStarInnerSize!;
          } else if (status == AnimationStatus.dismissed) {
            if (widget.onSecondAnimationComplete != null) widget.onSecondAnimationComplete!.call();
            if (widget.startStarInnerSize != null) switcherState.starInnerRadius = widget.startStarInnerSize!;
          }
        });
      });
    // Diese wird nur aufgerufen wenn beginnWithFirstState false ist, um
    if (!beginnWithFirstState) {
      // _onClickFunction ist eine Symulationsfunktion zu dem Switcher-Drücken
      _onClickFunction();
      setState(() {
        // hier versorgen wir den Sitcher State mit den zweiten State eigenschaften
        switcherState =
            AmazingSwitcherState.copyFrom(state1: widget.switcherState2 ?? widget.switcherState1, state2: null)
                .copyWith(
          starInnerRadius: widget.startStarInnerSize,
        );
        // hir wird die normale Duration wieder verwendet
        _animationController.duration = widget.animationDuration ?? const Duration(milliseconds: 500);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _unActiveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
                                          ***************************
    ****************************************  Dual Scale State  ********************************************
                                          ***************************
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
    */
    if (widget.switchingTyp == SwitchingTyp.dualScaleState) {
      return Center(
        child: Container(
          height: widget.switcherHeight,
          // Switcher Width muss mindestens zwei Mal größer als Switcher Height
          width: widget.switcherWidth < widget.switcherHeight * 2 ? widget.switcherHeight * 2 : widget.switcherWidth,
          decoration: BoxDecoration(
            // um Oval Form zu erhalten soll das Border Radius die Hälfte von Switcher height sein
            borderRadius: BorderRadius.all(Radius.circular(widget.switcherHeight / 2)),
            boxShadow: widget.switcherBoxShadowList ??
                // gradient Elevation geben
                [
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey[200]!,
                      offset: const Offset(-8, 8)),
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey[400]!,
                      offset: const Offset(-6, 6)),
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey[600]!,
                      offset: const Offset(-4, 4)),
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey[800]!,
                      offset: const Offset(-2, 2)),
                ],
            border: widget.switcherBoxBorder ?? Border.all(color: Colors.transparent, width: 0),
            color: null,
            gradient: LinearGradient(
                // Beseitigung der Falsche Angaben
                colors: (widget.switcherGradientColor == null || widget.switcherGradientColor!.isEmpty)
                    ? <Color>[Colors.yellow[100]!, Colors.yellow[800]!]
                    : widget.switcherGradientColor!.length == 1
                        ? <Color>[widget.switcherGradientColor!.first, widget.switcherGradientColor!.first]
                        : widget.switcherGradientColor!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Feststellen wenn das second Text erscheinen soll
              (presed && widget.secondText != null && _animationController.isCompleted)
                  ? Center(
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Center(child: widget.secondText!),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          // _animationController und _unActiveAnimationController eine davon soll aktivieren werden.
                          // deshalb macht es nichts wenn sie zu sicheinander eingefügen sind.
                          // der Indikator Größe ändert sich, daher das Pading soll sich auch ändern, um die Position des Indikators festzuhalten.
                          left: (_animationController.value + _unActiveAnimationController.value) *
                              widget.switcherHeight /
                              4),
                      child: InkWell(
                        onTap: () {
                          _dualScaleStateClickFunktion();
                        },
                        child: Transform.rotate(
                          // Nicht aktive Rotation
                          angle: presed
                              ? widget.indicatorRotationAngel *
                                  (2 * pi / 360) *
                                  (_animationController.value - _unActiveAnimationController.value)
                              : widget.indicatorRotationAngel *
                                  (2 * pi / 360) *
                                  (_animationController.value + _unActiveAnimationController.value),
                          child: Container(
                            height: widget.switcherHeight -
                                widget.switcherHeight *
                                    (_animationController.value + _unActiveAnimationController.value),
                            width: widget.switcherHeight -
                                widget.switcherHeight *
                                    (_animationController.value + _unActiveAnimationController.value),
                            decoration: ShapeDecoration(
                              color: widget.switcherState1.indicatorColor,
                              shadows: widget.switcherState1.indicatorBoxShadow ??
                                  [
                                    BoxShadow(
                                      blurRadius: 2,
                                      blurStyle: BlurStyle.normal,
                                      color: Colors.grey[800]!,
                                    ),
                                  ],
                              // Standardisiert Start Indikator Situation
                              shape: StarBorder(
                                side: widget.switcherState1.indicatorBorder ??
                                    const BorderSide(color: Colors.transparent),
                                points: widget.switcherState1.starHeadsNumber ?? 7,
                                innerRadiusRatio: widget.switcherState1.starInnerRadius ?? 0.7,
                                pointRounding: widget.switcherState1.starHeadsRounding ?? 0,
                                valleyRounding: widget.switcherState1.starValleyRounding ?? 0,
                              ),
                            ),
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: widget.indicatorChild ?? const SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              // Feststellen wenn das start Text erscheinen soll

              (!presed && widget.startText != null && _animationController.isDismissed)
                  ? Center(
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Center(child: widget.startText!),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          right: widget.switcherHeight / 4 -
                              (_animationController.value - _unActiveAnimationController.value) *
                                  widget.switcherHeight /
                                  4),
                      child: InkWell(
                        onTap: () {
                          _dualScaleStateClickFunktion();
                        },
                        child: Transform.rotate(
                          angle: presed
                              ? widget.indicatorRotationAngel *
                                  (2 * pi / 360) *
                                  (_animationController.value - _unActiveAnimationController.value)
                              : widget.indicatorRotationAngel *
                                  (2 * pi / 360) *
                                  (_animationController.value + _unActiveAnimationController.value),
                          child: Container(
                            height: widget.switcherHeight *
                                (_animationController.value - _unActiveAnimationController.value),
                            width: widget.switcherHeight *
                                (_animationController.value - _unActiveAnimationController.value),
                            decoration: ShapeDecoration(
                              color: widget.switcherState2?.indicatorColor ?? widget.switcherState1.indicatorColor,
                              shadows: widget.switcherState2?.indicatorBoxShadow ??
                                  widget.switcherState1.indicatorBoxShadow ??
                                  [
                                    BoxShadow(
                                      blurRadius: 2,
                                      blurStyle: BlurStyle.normal,
                                      color: Colors.grey[800]!,
                                    ),
                                  ],
                              shape: StarBorder(
                                side: widget.switcherState2?.indicatorBorder ??
                                    widget.switcherState1.indicatorBorder ??
                                    const BorderSide(color: Colors.transparent),
                                points: widget.switcherState2?.starHeadsNumber ??
                                    widget.switcherState1.starHeadsNumber ??
                                    7,
                                innerRadiusRatio: widget.switcherState2?.starInnerRadius ??
                                    widget.switcherState1.starInnerRadius ??
                                    0.7,
                                pointRounding: widget.switcherState2?.starHeadsRounding ??
                                    widget.switcherState1.starHeadsRounding ??
                                    0,
                                valleyRounding: widget.switcherState2?.starValleyRounding ??
                                    widget.switcherState1.starValleyRounding ??
                                    0,
                              ),
                            ),
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: widget.indicatorChild ?? const SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
    }
    /*
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
                                          ***************************
    ****************************************        Flip State        ********************************************
                                          ***************************
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
    */
    // Flipp Switcher aufrufen
    if (widget.switchingTyp == SwitchingTyp.flipSingleState) {
      return Center(
        child: FlippWidget(
          // Feststellen welche Condition soll aufgerufen werden
          condition: !presed ? widget.firstFlipCondition : widget.secondFlipCondition,
          flipDirection: widget.flipDirection,
          animationDuration: widget.animationDuration,
          startChild: widget.startText,
          secondChild: widget.secondText,
          height: widget.switcherHeight,
          width: widget.switcherWidth,
          beginnWithFirstState: widget.beginnWithFirstState,
          onFirstPress: () {
            widget.onFirstPress!.call();
          },
          onFirstAnimationComplete: () {
            widget.onFirstAnimationComplete!.call();
          },
          onSecondPress: () {
            widget.onSecondPress!.call();
          },
          onSecondAnimationComplete: () {
            widget.onSecondAnimationComplete!.call();
          },
        ),
      );
    }
    /*
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
                                          ***************************
    ****************************************    Single Star State    ********************************************
                                          ***************************
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
    */
    // Single Star Switcher aufrufen
    if (widget.switchingTyp == SwitchingTyp.starSingleState) {
      return Center(
        child: InkWell(
          onTap: () {
            _singleStarClickFunktion();
          },
          child: Transform.rotate(
            angle: widget.indicatorRotationAngel *
                (2 * pi / 360) *
                (_animationController.value + _unActiveAnimationController.value),
            child: AnimatedContainer(
              // Nichtr aktive Animation bauen
              height: switcherState.indicatorSize == null
                  ? 40 - _unActiveAnimationController.value * 40
                  : switcherState.indicatorSize! - _unActiveAnimationController.value * switcherState.indicatorSize!,
              width: switcherState.indicatorSize == null
                  ? 40 - _unActiveAnimationController.value * 40
                  : switcherState.indicatorSize! - _unActiveAnimationController.value * switcherState.indicatorSize!,
              duration: widget.animationDuration ?? const Duration(milliseconds: 500),
              decoration: ShapeDecoration(
                color: switcherState.indicatorColor,
                shadows: switcherState.indicatorBoxShadow ??
                    [
                      BoxShadow(
                        blurRadius: 2,
                        blurStyle: BlurStyle.normal,
                        color: Colors.grey[800]!,
                      ),
                    ],
                shape: StarBorder(
                  side: switcherState.indicatorBorder ?? const BorderSide(color: Colors.transparent),
                  points: switcherState.starHeadsNumber ?? 7,
                  innerRadiusRatio: switcherState.starInnerRadius ?? 0.2,
                  pointRounding: switcherState.starHeadsRounding ?? 0,
                  valleyRounding: switcherState.starValleyRounding ?? 0,
                ),
              ),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: child,
                ),
              ),
              onEnd: () {
                setState(() {
                  // erstens würde versucht die State Child zu erreichen, zweitens, das Widget Child drittens ergibt das Standard Child.
                  child = switcherState.child ?? widget.indicatorChild ?? const SizedBox();
                });
              },
            ),
          ),
        ),
      );
    }
    /*
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
                                          ***************************
    ****************************************     Dual Star State     ********************************************
                                          ***************************
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
    */
    // Zwei Situations Star Switcher aufgerifen.
    return Center(
      child: Stack(
        children: [
          Container(
            // Falsche Height Angaben Beseitigen: Height kann nicht größer als Width sein
            height: widget.switcherHeight > widget.switcherWidth ? widget.switcherWidth : widget.switcherHeight,
            width: widget.switcherWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(
                  (widget.switcherHeight > widget.switcherWidth ? widget.switcherWidth : widget.switcherHeight) / 2)),
              boxShadow: widget.switcherBoxShadowList ??
                  [
                    BoxShadow(
                        blurRadius: 4,
                        blurStyle: BlurStyle.normal,
                        color: Colors.grey[200]!,
                        offset: const Offset(-8, 8)),
                    BoxShadow(
                        blurRadius: 4,
                        blurStyle: BlurStyle.normal,
                        color: Colors.grey[400]!,
                        offset: const Offset(-6, 6)),
                    BoxShadow(
                        blurRadius: 4,
                        blurStyle: BlurStyle.normal,
                        color: Colors.grey[600]!,
                        offset: const Offset(-4, 4)),
                    BoxShadow(
                        blurRadius: 4,
                        blurStyle: BlurStyle.normal,
                        color: Colors.grey[800]!,
                        offset: const Offset(-2, 2)),
                  ],
              border: widget.switcherBoxBorder ?? Border.all(color: Colors.transparent, width: 0),
              // wenn man Gradient benutzt darf man kein Color geben
              color: null,
              gradient: LinearGradient(
                  colors: (widget.switcherGradientColor == null || widget.switcherGradientColor!.isEmpty)
                      ? <Color>[Colors.yellow[100]!, Colors.yellow[800]!]
                      : widget.switcherGradientColor!.length == 1
                          ? <Color>[widget.switcherGradientColor!.first, widget.switcherGradientColor!.first]
                          : widget.switcherGradientColor!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: presed ? switcherState.child ?? widget.secondText ?? const Text(' ') : const Text(' '),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: !presed ? switcherState.child ?? widget.startText ?? const Text(' ') : const Text(' '),
                  ),
                ))
              ],
            ),
          ),
          Positioned(
            // Hier würde die Bewegung des Indikators feststellt
            left: presed
                ? (widget.switcherWidth -
                        (widget.switcherHeight > widget.switcherWidth ? widget.switcherWidth : widget.switcherHeight)) *
                    (_animationController.value - _unActiveAnimationController.value)
                : (widget.switcherWidth -
                        (widget.switcherHeight > widget.switcherWidth ? widget.switcherWidth : widget.switcherHeight)) *
                    (_animationController.value + _unActiveAnimationController.value),
            height: widget.switcherHeight > widget.switcherWidth ? widget.switcherWidth : widget.switcherHeight,
            width: widget.switcherHeight > widget.switcherWidth ? widget.switcherWidth : widget.switcherHeight,
            child: InkWell(
              onTap: () {
                _dualStateStarClickFunktion();
              },
              child: Transform.rotate(
                angle: presed
                    ? widget.indicatorRotationAngel *
                        (2 * pi / 360) *
                        (_animationController.value - _unActiveAnimationController.value)
                    : widget.indicatorRotationAngel *
                        (2 * pi / 360) *
                        (_animationController.value + _unActiveAnimationController.value),
                child: AnimatedContainer(
                    duration: widget.animationDuration ?? const Duration(milliseconds: 500),
                    decoration: ShapeDecoration(
                      color: switcherState.indicatorColor,
                      shadows: switcherState.indicatorBoxShadow ??
                          [
                            BoxShadow(
                              blurRadius: 2,
                              blurStyle: BlurStyle.normal,
                              color: Colors.grey[800]!,
                            ),
                          ],
                      shape: StarBorder(
                        side: switcherState.indicatorBorder ?? const BorderSide(color: Colors.transparent),
                        points: switcherState.starHeadsNumber ?? 7,
                        innerRadiusRatio: switcherState.starInnerRadius ?? 0.7,
                        pointRounding: switcherState.starHeadsRounding ?? 0,
                        valleyRounding: switcherState.starValleyRounding ?? 0,
                      ),
                    ),
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: widget.indicatorChild ?? const SizedBox(),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
                                          ***************************
    ****************************************        Functions        ********************************************
                                          ***************************
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
    */
  // Clicken Symilations funktion
  void _onClickFunction() {
    if (widget.switchingTyp == SwitchingTyp.starSingleState) return _singleStarClickFunktion();
    if (widget.switchingTyp == SwitchingTyp.dualScaleState) return _dualScaleStateClickFunktion();
    _dualStateStarClickFunktion();
  }

  void _dualScaleStateClickFunktion() {
    // wenn nicht pressed sind wir bei der erste Situation
    if (!presed) {
      setState(() {
        // hor ist die Voraussitzung von erste Switching genommen.
        switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
      });
      // wenn Voraussetzungen nicht erfült.
      if (!switcherState.condition) {
        _unActiveAnimationController.forward();

        return;
      }
      if (widget.onFirstPress != null) widget.onFirstPress!.call();

      _animationController.forward();
      presed = true;
      // else sind wir bei der zweiter Situation.
    } else {
      setState(() {
        // hor ist die Voraussitzung von zweite Switching genommen.
        switcherState = switcherState.copyWith(condition: widget.switcherState2?.condition ?? true);
      });
      // wenn Voraussetzungen nicht erfült.
      if (!switcherState.condition) {
        _unActiveAnimationController.forward();

        return;
      }
      if (widget.onSecondPress != null) widget.onSecondPress!.call();
      _animationController.reverse();
      presed = false;
    }
  }

  void _singleStarClickFunktion() {
    switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
    if (!presed) {
      setState(() {
        switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
      });
      if (!switcherState.condition) {
        _unActiveAnimationController.forward();

        return;
      }
      if (widget.onFirstPress != null) widget.onFirstPress!.call();

      _animationController.forward();
      presed = true;
    } else {
      setState(() {
        switcherState = switcherState.copyWith(condition: widget.switcherState2?.condition ?? true);
      });
      if (!switcherState.condition) {
        _unActiveAnimationController.forward();

        return;
      }
      if (widget.onSecondPress != null) widget.onSecondPress!.call();
      _animationController.reverse();
      presed = false;
    }
  }

  void _dualStateStarClickFunktion() {
    print(beginnWithFirstState);
    if (!presed) {
      setState(() {
        switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
      });

      if (!switcherState.condition) {
        _unActiveAnimationController.forward();

        return;
      }
      if (widget.onFirstPress != null) widget.onFirstPress!.call();

      _animationController.forward();
      presed = true;
    } else {
      setState(() {
        switcherState = switcherState.copyWith(condition: widget.switcherState2?.condition ?? true);
      });
      if (!switcherState.condition) {
        _unActiveAnimationController.forward();

        return;
      }
      if (widget.onSecondPress != null) widget.onSecondPress!.call();
      _animationController.reverse();
      presed = false;
    }
  }
}

/*
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
                                          ***************************
    ****************************************  Switcher State Klasse  ********************************************
                                          ***************************
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
    */

class AmazingSwitcherState {
  ///- [indicatorColor] : bestimmt die Indikator Farbe.
  Color? indicatorColor;

  ///- [starHeadsNumber] : bestimmt wie viel Kopfen die Indikator-Star-Form haben soll. das Star kann nicht weniger als 2 Kopfen haben.
  double? starHeadsNumber;

  ///- [starInnerRadius] : bestimmt wie größ, die innere indikator area sein soll. dieser Wert soll zwischen 1 und 0 sein.
  double? starInnerRadius;

  ///- [starHeadsRounding] : bestimmt wie weit, die Star Kopfen gerundet sein soll.dieser Wert soll zwischen 1 und 0 sein. [starHeadsRounding] + [starValleyRounding] soll <= 1 sein.
  double? starHeadsRounding;

  ///- [starValleyRounding] : bestimmt wie weit, die innere Star Kopfen gerundet sein soll. dieser Wert soll zwischen 1 und 0 sein.
  double? starValleyRounding;
  double? indicatorSize;

  ///- [condition] : beinhaltet die Voraussetzung, um die Switching Action zu aktviert, standardweise true.
  bool condition;

  ///- [child] : ist das Child , das in Indikator erstellt kann. Standardweise Null.
  Widget? child;

  List<BoxShadow>? indicatorBoxShadow;
  BorderSide? indicatorBorder;

  AmazingSwitcherState({
    this.indicatorColor,
    this.starHeadsNumber,
    this.starInnerRadius,
    this.starHeadsRounding,
    this.starValleyRounding,
    this.indicatorSize,
    this.condition = true,
    this.child,
    this.indicatorBoxShadow,
    this.indicatorBorder,
  });
  // warum copyFrom Factory: normalerweise kann man die Die Attributen nur von Indikator-State1 geben, und muss nicht diese auch wieder von State2 geben
  // um das zu schaffen muss einee Factory gebaut werden um das zu schaffen, und die State2 kann nur anders als State1 sien wenn die Attribut davon gegeben wird.
  // das kann die Arbeit für des Benutzers viel erleichtern.
  factory AmazingSwitcherState.copyFrom({required AmazingSwitcherState state1, AmazingSwitcherState? state2}) {
    if (state2 == null) {
      return AmazingSwitcherState(
        indicatorColor: state1.indicatorColor,
        starHeadsNumber: inputHandeler(state1.starHeadsNumber, 2, 10000),
        starInnerRadius: inputHandeler(state1.starInnerRadius),
        starHeadsRounding: inputHandeler(state1.starHeadsRounding),
        starValleyRounding: inputHandeler(state1.starValleyRounding),
        indicatorSize: state1.indicatorSize,
        child: state1.child,
        indicatorBoxShadow: state1.indicatorBoxShadow,
        indicatorBorder: state1.indicatorBorder,
        condition: state1.condition,
      );
    } else {
      return AmazingSwitcherState(
        indicatorColor: state2.indicatorColor ?? state1.indicatorColor,
        starHeadsNumber:
            inputHandeler(state2.starHeadsNumber, 2, 10000) ?? inputHandeler(state1.starHeadsNumber, 2, 10000),
        starInnerRadius: inputHandeler(state2.starInnerRadius) ?? inputHandeler(state1.starInnerRadius),
        starHeadsRounding: inputHandeler(state2.starHeadsRounding) ?? inputHandeler(state1.starHeadsRounding),
        starValleyRounding: inputHandeler(state2.starValleyRounding) ?? inputHandeler(state1.starValleyRounding),
        indicatorSize: state2.indicatorSize ?? state1.indicatorSize,
        child: state2.child,
        indicatorBoxShadow: state2.indicatorBoxShadow ?? state1.indicatorBoxShadow,
        indicatorBorder: state2.indicatorBorder ?? state1.indicatorBorder,
        condition: state2.condition,
      );
    }
  }
  AmazingSwitcherState copyWith({
    Color? indicatorColor,
    double? starHeadsNumber,
    double? starInnerRadius,
    double? starHeadsRounding,
    double? starValleyRounding,
    double? indicatorSize,
    bool? condition,
    Widget? child,
    List<BoxShadow>? indicatorBoxShadow,
    BorderSide? indicatorBorder,
  }) {
    return AmazingSwitcherState(
      indicatorColor: indicatorColor ?? this.indicatorColor,
      starHeadsNumber: starHeadsNumber ?? this.starHeadsNumber,
      starInnerRadius: starInnerRadius ?? this.starInnerRadius,
      starHeadsRounding: starHeadsRounding ?? this.starHeadsRounding,
      starValleyRounding: starValleyRounding ?? this.starValleyRounding,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      condition: condition ?? this.condition,
      child: child ?? this.child,
      indicatorBoxShadow: indicatorBoxShadow ?? this.indicatorBoxShadow,
      indicatorBorder: indicatorBorder ?? this.indicatorBorder,
    );
  }
}

// Viele von Sternindikator Variabeln kann nur zwischen 0 und 1 sein, daher habe ich diese Funktion gebaut.
// um falsche Angaben zu beseitigen.
double? inputHandeler(double? number, [double min = 0, double max = 1]) {
  if (number == null) return null;
  if (number < min) return min;
  if (number > max) return max;
  return number;
}
