import 'dart:math';

import 'package:amazing_tools/tools/swipp_button.dart';
import 'package:flutter/material.dart';

enum AnimationType { scale, slide, fade }

class AmazingList extends StatefulWidget {
  const AmazingList._internal({
    super.key,
    required this.items,
    this.onSwipeRight,
    this.onSwipeLeft,
    this.addedItem,
    this.deleteIcon,
    this.addItemIcon,
    this.showAddIconItem = true,
    this.showRefereshItemsIcon = true,
    this.onAddItem,
    this.onDeleteItem,
    this.startOffset,
    this.listHeight = 400,
    this.delayBetweenItems,
    this.addItemOffset,
    this.removeItemOffset,
    this.moveUpItemOffset,
    this.moveDownItemOffset,
    this.listWidth = 250,
    this.listBackgroundColor,
    this.deleteAndMoveIconSize = 24,
    this.refereshItemsIcon,
    this.backgroundGradientColors,
    this.backgroundBorder,
    this.backGroundBorderRadius = 20,
    this.scaleBeginn = 0.0,
    this.scaleEnd = 1.0,
    this.turns = 0.0,
    this.animationType = AnimationType.slide,
  });
  const AmazingList({
    super.key,
    required this.items,
    this.onSwipeRight,
    this.onSwipeLeft,
    this.addedItem,
    this.deleteIcon,
    this.addItemIcon,
    this.showAddIconItem = true,
    this.showRefereshItemsIcon = true,
    this.onAddItem,
    this.onDeleteItem,
    this.startOffset,
    this.listHeight = 400,
    this.delayBetweenItems,
    this.addItemOffset,
    this.removeItemOffset,
    this.moveUpItemOffset,
    this.moveDownItemOffset,
    this.listWidth = 250,
    this.listBackgroundColor,
    this.deleteAndMoveIconSize = 24,
    this.refereshItemsIcon,
    this.backgroundGradientColors,
    this.backgroundBorder,
    this.backGroundBorderRadius = 20,
  })  : animationType = AnimationType.slide,
        scaleBeginn = 0.0,
        scaleEnd = 1.0,
        turns = 0.0;
  final List<Widget> items;
  final Function? onSwipeRight;
  final Function? onSwipeLeft;
  final Function? onAddItem;
  final Function? onDeleteItem;
  final Widget? addedItem;
  final Widget? deleteIcon;
  final Widget? addItemIcon;
  final Widget? refereshItemsIcon;
  final bool showAddIconItem;
  final bool showRefereshItemsIcon;
  final AnimatedOffset? startOffset;
  final AnimatedOffset? addItemOffset;
  final AnimatedOffset? removeItemOffset;
  final AnimatedOffset? moveUpItemOffset;
  final AnimatedOffset? moveDownItemOffset;
  final double listHeight;
  final double listWidth;
  final double deleteAndMoveIconSize;
  final double backGroundBorderRadius;
  final Duration? delayBetweenItems;
  final Color? listBackgroundColor;
  final Gradient? backgroundGradientColors;
  final Border? backgroundBorder;
  final AnimationType animationType;
  final double scaleBeginn;
  final double scaleEnd;
  final double turns;
  //###############################################################################################
  //#################################### Scale Animation ##########################################
  //###############################################################################################
  factory AmazingList.scaleAnimation({
    Key? key,
    required List<Widget> items,
    final Function? onSwipeRight,
    final Function? onSwipeLeft,
    final Function? onAddItem,
    final Function? onDeleteItem,
    final Widget? addedItem,
    final Widget? deleteIcon,
    final Widget? addItemIcon,
    final Widget? refereshItemsIcon,
    final bool showAddIconItem = true,
    final bool showRefereshItemsIcon = true,
    final double listHeight = 400,
    final double listWidth = 250,
    final double deleteAndMoveIconSize = 24,
    final double backGroundBorderRadius = 20,
    final Duration? delayBetweenItems,
    final Duration? animationDuration,
    final Color? listBackgroundColor,
    final Gradient? backgroundGradientColors,
    final Border? backgroundBorder,
    final double scaleBeginn = 0.0,
    final double scaleEnd = 1.0,
    final double turns = 0.0,
  }) {
    return AmazingList._internal(
      items: items,
      onSwipeRight: onSwipeRight,
      onSwipeLeft: onSwipeLeft,
      onAddItem: onAddItem,
      onDeleteItem: onDeleteItem,
      addedItem: addedItem,
      deleteIcon: deleteIcon,
      addItemIcon: addItemIcon,
      refereshItemsIcon: refereshItemsIcon,
      showAddIconItem: showAddIconItem,
      showRefereshItemsIcon: showRefereshItemsIcon,
      listHeight: listHeight,
      listWidth: listWidth,
      deleteAndMoveIconSize: deleteAndMoveIconSize,
      backGroundBorderRadius: backGroundBorderRadius,
      delayBetweenItems: delayBetweenItems,
      startOffset: AnimatedOffset(
        begin: const Offset(0, -1),
        end: const Offset(0, 0),
        duration: animationDuration ?? const Duration(milliseconds: 150),
      ),
      listBackgroundColor: listBackgroundColor,
      backgroundGradientColors: backgroundGradientColors,
      backgroundBorder: backgroundBorder,
      scaleBeginn: scaleBeginn,
      scaleEnd: scaleEnd,
      turns: turns,
      animationType: AnimationType.scale,
    );
  }
  @override
  State<AmazingList> createState() => _AmazingListState();
}

class _AmazingListState extends State<AmazingList> {
  late Tween<Offset> offset;
  late Tween<double> rotate;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late List<Widget> items;
  int clickedIndex = -1;

  @override
  void initState() {
    super.initState();
    items = [];
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        offset = Tween(
          begin: widget.startOffset?.begin ?? const Offset(0, -1),
          end: widget.startOffset?.end ?? const Offset(0, 0),
        );
        rotate = Tween(begin: 0.0, end: widget.turns);
        _addItems(widget.items);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /*
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
                                          ***************************
    ****************************************     Scale Animation     ********************************************
                                          ***************************
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
    */
    if (widget.animationType == AnimationType.scale) {
      return Container(
        height: widget.listHeight,
        width: widget.listWidth,
        decoration: BoxDecoration(
          border: widget.backgroundBorder ?? Border.all(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(widget.backGroundBorderRadius),
          color: widget.backgroundGradientColors != null ? null : widget.listBackgroundColor ?? Colors.grey[400],
          gradient: widget.backgroundGradientColors,
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  clickedIndex = -1;
                });
              },
              child: AnimatedList(
                key: listKey,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(
                      begin: widget.scaleBeginn,
                      end: widget.scaleEnd,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.linear,
                      ),
                    ),
                    child: RotationTransition(
                      turns: rotate.animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.linear,
                        ),
                      ),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        scale: clickedIndex == index ? 1.2 : 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (clickedIndex == index)
                              SizedBox(
                                width: widget.deleteAndMoveIconSize / 2,
                                child: InkWell(
                                  onTap: () {
                                    removeItem(index);
                                    setState(() {
                                      clickedIndex = -1;
                                    });
                                    if (widget.onDeleteItem == null) return;
                                    widget.onDeleteItem!.call();
                                  },
                                  child: widget.deleteIcon ??
                                      Icon(
                                        size: widget.deleteAndMoveIconSize * 0.8,
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                ),
                              ),
                            SwipeButton(
                                onDoubleClick: () {
                                  setState(() {
                                    clickedIndex = index;
                                  });
                                },
                                onSwipLeft: (details) {
                                  if (widget.onSwipeLeft == null) return;
                                  widget.onSwipeLeft!.call();
                                  // removeItem(index);
                                },
                                onSwipRight: (details) {
                                  if (widget.onSwipeRight == null) return;
                                  widget.onSwipeRight!.call();

                                  // addItem(Center(child: Text('New Item')));
                                },
                                child: items[index]),
                            if (clickedIndex == index)
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        // offset = Tween(
                                        //   begin: Offset(0, 1),
                                        //   end: Offset(0, 0),
                                        // );
                                        moveItemUp(clickedIndex);
                                        clickedIndex = -1;
                                      });
                                    },
                                    child: Container(
                                      height: widget.deleteAndMoveIconSize / 2,
                                      width: widget.deleteAndMoveIconSize / 2,
                                      decoration: const ShapeDecoration(
                                        color: Colors.blue,
                                        shape: StarBorder.polygon(sides: 3),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        //    offset = Tween(
                                        //   begin: Offset(0, -1),
                                        //   end: Offset(0, 0),
                                        // );
                                        moveItemDown(clickedIndex);
                                        clickedIndex = -1;
                                      });
                                    },
                                    child: Transform.rotate(
                                      angle: pi,
                                      child: Container(
                                        height: widget.deleteAndMoveIconSize / 2,
                                        width: widget.deleteAndMoveIconSize / 2,
                                        decoration: const ShapeDecoration(
                                          color: Colors.blue,
                                          shape: StarBorder.polygon(sides: 3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.showAddIconItem)
              Align(
                alignment: Alignment.bottomRight,
                child: widget.showAddIconItem
                    ? IconButton(
                        onPressed: () {
                          if (widget.addedItem != null) {
                            clickedIndex == -1 ? addItem() : addItemAtIndex(clickedIndex, widget.addedItem!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 500),
                                content: Text('No item to add'),
                              ),
                            );
                          }
                          if (widget.onAddItem != null) {
                            widget.onAddItem!.call();
                          }
                        },
                        icon: widget.addItemIcon ?? const CircleAvatar(radius: 20, child: Icon(Icons.add)),
                      )
                    : const SizedBox(),
              ),
            if (widget.showRefereshItemsIcon)
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  onPressed: () {
                    refreshItems();
                  },
                  icon: widget.refereshItemsIcon ?? const CircleAvatar(radius: 20, child: Icon(Icons.refresh)),
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
    ****************************************     Slide Animation     ********************************************
                                          ***************************
    #############################################################################################################
    #############################################################################################################
    #############################################################################################################
    */
    return Container(
      height: widget.listHeight,
      width: widget.listWidth,
      decoration: BoxDecoration(
        border: widget.backgroundBorder ?? Border.all(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(widget.backGroundBorderRadius),
        color: widget.backgroundGradientColors != null ? null : widget.listBackgroundColor ?? Colors.grey[400],
        gradient: widget.backgroundGradientColors,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                clickedIndex = -1;
              });
            },
            child: AnimatedList(
              key: listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) {
                return SlideTransition(
                  position: offset.animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.linear,
                  )),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: clickedIndex == index ? 1.2 : 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (clickedIndex == index)
                          SizedBox(
                            width: widget.deleteAndMoveIconSize / 2,
                            child: InkWell(
                              onTap: () {
                                removeItem(index);
                                setState(() {
                                  clickedIndex = -1;
                                });
                                if (widget.onDeleteItem == null) return;
                                widget.onDeleteItem!.call();
                              },
                              child: widget.deleteIcon ??
                                  Icon(
                                    size: widget.deleteAndMoveIconSize * 0.8,
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                            ),
                          ),
                        SwipeButton(
                            onDoubleClick: () {
                              setState(() {
                                clickedIndex = index;
                              });
                            },
                            onSwipLeft: (details) {
                              if (widget.onSwipeLeft == null) return;
                              widget.onSwipeLeft!.call();
                              // removeItem(index);
                            },
                            onSwipRight: (details) {
                              if (widget.onSwipeRight == null) return;
                              widget.onSwipeRight!.call();

                              // addItem(Center(child: Text('New Item')));
                            },
                            child: items[index]),
                        if (clickedIndex == index)
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // offset = Tween(
                                    //   begin: Offset(0, 1),
                                    //   end: Offset(0, 0),
                                    // );
                                    moveItemUp(clickedIndex);
                                    clickedIndex = -1;
                                  });
                                },
                                child: Container(
                                  height: widget.deleteAndMoveIconSize / 2,
                                  width: widget.deleteAndMoveIconSize / 2,
                                  decoration: const ShapeDecoration(
                                    color: Colors.blue,
                                    shape: StarBorder.polygon(sides: 3),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    //    offset = Tween(
                                    //   begin: Offset(0, -1),
                                    //   end: Offset(0, 0),
                                    // );
                                    moveItemDown(clickedIndex);
                                    clickedIndex = -1;
                                  });
                                },
                                child: Transform.rotate(
                                  angle: pi,
                                  child: Container(
                                    height: widget.deleteAndMoveIconSize / 2,
                                    width: widget.deleteAndMoveIconSize / 2,
                                    decoration: const ShapeDecoration(
                                      color: Colors.blue,
                                      shape: StarBorder.polygon(sides: 3),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.showAddIconItem)
            Align(
              alignment: Alignment.bottomRight,
              child: widget.showAddIconItem
                  ? IconButton(
                      onPressed: () {
                        if (widget.addedItem != null) {
                          clickedIndex == -1 ? addItem() : addItemAtIndex(clickedIndex, widget.addedItem!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 500),
                              content: Text('No item to add'),
                            ),
                          );
                        }
                        if (widget.onAddItem != null) {
                          widget.onAddItem!.call();
                        }
                      },
                      icon: widget.addItemIcon ?? const CircleAvatar(radius: 20, child: Icon(Icons.add)),
                    )
                  : const SizedBox(),
            ),
          if (widget.showRefereshItemsIcon)
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () {
                  refreshItems();
                },
                icon: widget.refereshItemsIcon ?? const CircleAvatar(radius: 20, child: Icon(Icons.refresh)),
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
  void _addItems(List<Widget> addedItems) {
    Future future = Future(
      () {},
    );
    for (var item in addedItems) {
      future = future.then(
        (_) {
          return Future.delayed(widget.delayBetweenItems ?? const Duration(milliseconds: 150), () {
            items.add(item);
            if (listKey.currentState != null) {
              listKey.currentState!.insertItem(
                items.length - 1,
                duration: widget.startOffset?.duration ??
                    const Duration(
                      milliseconds: 150,
                    ),
              );
            }
          });
        },
      );
    }
  }

  void addItemAtIndex(int index, Widget newItem) {
    if (index < 0 || index > items.length) {
      // Ensure index is valid
      return;
    }
    if (widget.addItemOffset != null) {
      offset = Tween(
        begin: widget.addItemOffset!.begin,
        end: widget.addItemOffset!.end,
      );
    }

    // Insert the new item at the specified index
    items.insert(index, newItem);
    clickedIndex++;
    if (listKey.currentState != null) {
      // Insert the new item into the AnimatedList
      listKey.currentState!.insertItem(
        index,
        duration: widget.animationType == AnimationType.scale
            ? widget.startOffset?.duration ?? const Duration(milliseconds: 250)
            : widget.addItemOffset?.duration ?? const Duration(milliseconds: 250),
      );
    }
  }

  void addItem() {
    if (widget.addedItem == null) return;
    if (widget.addItemOffset != null) {
      offset = Tween(
        begin: widget.addItemOffset!.begin,
        end: widget.addItemOffset!.end,
      );
    }
    items.add(widget.addedItem!);
    if (listKey.currentState != null) {
      listKey.currentState!.insertItem(
        items.length - 1,
        duration: widget.animationType == AnimationType.scale
            ? widget.startOffset?.duration ?? const Duration(milliseconds: 250)
            : widget.addItemOffset?.duration ?? const Duration(milliseconds: 250),
      );
    }
  }

  void removeItem(int index) {
    if (widget.removeItemOffset != null) {
      offset = Tween(
        begin: widget.removeItemOffset!.begin,
        end: widget.removeItemOffset!.end,
      );
    }
    if (index < 0 || index >= items.length) {
      // Ensure index is valid
      return;
    }

    // Remove the item from the list
    final removedItem = items.removeAt(index);

    if (listKey.currentState != null) {
      // Remove the item from the AnimatedList
      listKey.currentState!.removeItem(
        index,
        (context, animation) {
          if (widget.animationType == AnimationType.scale) {
            return ScaleTransition(
              scale: animation,
              child: removedItem,
            );
          }
          return SlideTransition(
            position: offset.animate(CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            )),
            child: removedItem,
          );
        },
        duration: widget.animationType == AnimationType.scale
            ? widget.startOffset?.duration ?? const Duration(milliseconds: 250)
            : widget.removeItemOffset?.duration ?? const Duration(milliseconds: 250),
      );
    }
  }

  void moveItemUp(int index) {
    if (widget.moveUpItemOffset != null) {
      offset = Tween(
        begin: widget.moveUpItemOffset!.begin,
        end: widget.moveUpItemOffset!.end,
      );
    } else {
      offset = Tween(
        begin: const Offset(0, 1),
        end: const Offset(0, 0),
      );
    }
    if (index <= 0 || index >= items.length) {
      // Ensure index is valid
      return;
    }
    // Swap the item with the previous item
    final currentItem = items[index];
    final previousItem = items[index - 1];
    items[index] = previousItem;
    items[index - 1] = currentItem;

    if (listKey.currentState != null) {
      // Update the positions of the items in the AnimatedList
      listKey.currentState!.removeItem(
        index,
        (context, animation) {
          return SlideTransition(
            position: offset.animate(CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            )),
            child: currentItem,
          );
        },
        duration: widget.moveUpItemOffset?.movedItemDuration ?? const Duration(milliseconds: 0),
      );

      listKey.currentState!.insertItem(
        index - 1,
        duration: widget.animationType == AnimationType.scale
            ? widget.startOffset?.duration ?? const Duration(milliseconds: 250)
            : widget.moveUpItemOffset?.duration ?? const Duration(milliseconds: 250),
      );
    }
  }

  void moveItemDown(int index) {
    if (widget.moveDownItemOffset != null) {
      offset = Tween(
        begin: widget.moveDownItemOffset!.begin,
        end: widget.moveDownItemOffset!.end,
      );
    } else {
      offset = Tween(
        begin: const Offset(0, -1),
        end: const Offset(0, 0),
      );
    }
    if (index < 0 || index >= items.length - 1) {
      // Ensure index is valid
      return;
    }
    // Swap the item with the previous item
    final currentItem = items[index];
    final previousItem = items[index + 1];
    items[index] = previousItem;
    items[index + 1] = currentItem;

    if (listKey.currentState != null) {
      // Update the positions of the items in the AnimatedList
      listKey.currentState!.removeItem(
        index,
        (context, animation) {
          return SlideTransition(
            position: offset.animate(CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            )),
            child: currentItem,
          );
        },
        duration: widget.moveDownItemOffset?.movedItemDuration ?? const Duration(milliseconds: 0),
      );

      listKey.currentState!.insertItem(
        index + 1,
        duration: widget.animationType == AnimationType.scale
            ? widget.startOffset?.duration ?? const Duration(milliseconds: 250)
            : widget.moveDownItemOffset?.duration ?? const Duration(milliseconds: 250),
      );
    }
  }

  void refreshItems() {
    setState(() {
      offset = Tween(
        begin: widget.startOffset?.begin ?? const Offset(0, -1),
        end: widget.startOffset?.end ?? const Offset(0, 0),
      );
      // Remove all items from the AnimatedList before clearing the items list
      if (listKey.currentState != null) {
        for (int i = items.length - 1; i >= 0; i--) {
          listKey.currentState!.removeItem(
            i,
            (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: Container(), // Placeholder widget
            ),
            duration: const Duration(milliseconds: 0),
          );
        }
      }
      items.clear();
      _addItems(widget.items);
    });
  }

  void removeAllItems() {
    if (listKey.currentState != null) {
      for (int i = items.length - 1; i >= 0; i--) {
        listKey.currentState!.removeItem(
          i,
          (context, animation) {
            return SlideTransition(
              position: offset.animate(CurvedAnimation(
                parent: animation,
                curve: Curves.linear,
              )),
              child: items[i],
            );
          },
          duration: widget.removeItemOffset?.duration ?? const Duration(milliseconds: 0),
        );
        items.removeAt(i);
      }
    }
  }
}

class AnimatedOffset {
  AnimatedOffset({
    required this.begin,
    required this.end,
    required this.duration,
    this.movedItemDuration,
  });

  final Offset begin;
  final Offset end;
  final Duration duration;
  final Duration? movedItemDuration;
}
