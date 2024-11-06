import 'dart:math';

import 'package:amazing_tools/tools/swipp_button.dart';
import 'package:flutter/material.dart';

class AmazingList extends StatefulWidget {
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
    required this.startAnimation,
    this.listHeight = 400,
    this.delayBetweenItems,
    this.addItemAnimation,
    this.removeItemAnimatiom,
    this.moveUpItemAniamtion,
    this.moveDownItemAnimation,
    this.listWidth = 250,
    this.listBackgroundColor,
    this.deleteAndMoveIconSize = 24,
    this.refereshItemsIcon,
    this.backgroundGradientColors,
    this.backgroundBorder,
    this.backGroundBorderRadius = 20,
    this.deleteConfirmation = false,
  });

  ///- [items] The list of items to display in the AmazingList
  final List<Widget> items;

  ///- [onSwipeRight] A callback function that is called when an item is swiped to the right
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
  final bool deleteConfirmation;
  final ItemsAnimationController startAnimation;
  final ItemsAnimationController? addItemAnimation;
  final ItemsAnimationController? removeItemAnimatiom;
  final ItemsAnimationController? moveUpItemAniamtion;
  final ItemsAnimationController? moveDownItemAnimation;
  final double listHeight;
  final double listWidth;
  final double deleteAndMoveIconSize;
  final double backGroundBorderRadius;
  final Duration? delayBetweenItems;
  final Color? listBackgroundColor;
  final Gradient? backgroundGradientColors;
  final Border? backgroundBorder;

  @override
  State<AmazingList> createState() => _AmazingListState();
}

class _AmazingListState extends State<AmazingList> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late List<Widget> items;
  late ItemsAnimationController addItemAnimation;
  late ItemsAnimationController removeItemAnimatiom;
  late ItemsAnimationController moveUpItemAniamtion;
  late ItemsAnimationController moveDownItemAnimation;
  late ItemsAnimationController itemAnimation;
  int clickedIndex = -1;
  int longPress = -1;

  @override
  void initState() {
    super.initState();
    items = [];
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        itemAnimation = widget.startAnimation;
        addItemAnimation = widget.addItemAnimation ??
            ItemsAnimationController(
              duration: widget.startAnimation.duration,
              offsetStart: const Offset(1, 0),
              offsetEnd: const Offset(0, 0),
              turnsEnd: widget.startAnimation.turnsEnd,
              curve: widget.startAnimation.curve,
            );
        moveUpItemAniamtion = widget.moveUpItemAniamtion ??
            ItemsAnimationController(
              duration: widget.startAnimation.duration,
              offsetStart: const Offset(0, 1),
              offsetEnd: const Offset(0, 0),
              scaleStart: 1,
              turnsEnd: widget.startAnimation.turnsEnd,
              curve: widget.startAnimation.curve,
            );
        moveDownItemAnimation = widget.moveDownItemAnimation ??
            ItemsAnimationController(
              duration: widget.startAnimation.duration,
              offsetStart: const Offset(0, -1),
              offsetEnd: const Offset(0, 0),
              scaleStart: 1,
              turnsEnd: widget.startAnimation.turnsEnd,
              curve: widget.startAnimation.curve,
            );
        removeItemAnimatiom = widget.removeItemAnimatiom ??
            ItemsAnimationController(
              duration: widget.startAnimation.duration,
              offsetStart: const Offset(-1, 0),
              offsetEnd: const Offset(0, 0),
              turnsEnd: widget.startAnimation.turnsEnd,
              curve: widget.startAnimation.curve,
            );

        _addItems(widget.items);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              });
            },
            child: AnimatedList(
              key: listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) {
                return SlideTransition(
                  position: Tween(
                    begin: itemAnimation.offsetStart,
                    end: itemAnimation.offsetEnd,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: itemAnimation.curve,
                  )),
                  child: RotationTransition(
                    turns: Tween(begin: itemAnimation.turnsStart, end: itemAnimation.turnsEnd).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: itemAnimation.curve,
                      ),
                    ),
                    child: FadeTransition(
                      opacity: Tween(begin: itemAnimation.fadeStart, end: itemAnimation.fadeEnd).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: itemAnimation.curve,
                        ),
                      ),
                      child: ScaleTransition(
                        scale: Tween(begin: itemAnimation.scaleStart, end: itemAnimation.scaleEnd).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: itemAnimation.curve,
                          ),
                        ),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: (clickedIndex == index || longPress==index) ? 1.2 : 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (clickedIndex == index)
                                SizedBox(
                                  width: widget.deleteAndMoveIconSize / 2,
                                  child: InkWell(
                                    onTap: () {
                                      if (widget.deleteConfirmation) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            duration: const Duration(milliseconds: 5000),
                                            content: const Text('Are you sure you want to delete this item?'),
                                            action: SnackBarAction(
                                              label: 'Yes',
                                              onPressed: () {
                                                removeItem(index);
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        removeItem(index);
                                      }
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
                                  onLongPress: () {
                                    setState(() {
                                      longPress = index;
                                    });
                                  },
                                  onLongPressDown: (details) {
                                    moveItemDown(index);
                                    setState(() {
                                      longPress = -1;
                                    });
                                  },
                                  onLongPressUp: (details) {
                                    moveItemUp(index);
                                    setState(() {
                                      longPress = -1;
                                    });
                                  },
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
              listKey.currentState!.insertItem(items.length - 1, duration: itemAnimation.duration);
            }
          });
        },
      );
    }
  }

  void addItemAtIndex(int index, Widget newItem) {
    itemAnimation = addItemAnimation;

    if (index < 0 || index > items.length) {
      // Ensure index is valid
      return;
    }

    // Insert the new item at the specified index
    items.insert(index, newItem);
    clickedIndex++;
    if (listKey.currentState != null) {
      // Insert the new item into the AnimatedList
      listKey.currentState!.insertItem(
        index,
        duration: itemAnimation.duration,
      );
    }
  }

  void addItem() {
    setState(() {
      itemAnimation = addItemAnimation;
    });

    items.add(widget.addedItem!);
  
    if (listKey.currentState != null) {
      listKey.currentState!.insertItem(
        items.length - 1,
        duration: itemAnimation.duration,
      );
    }
  }

  void removeItem(int index) {
    itemAnimation = removeItemAnimatiom;

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
          return RotationTransition(
            turns: Tween(
              begin: itemAnimation.turnsStart,
              end: itemAnimation.turnsEnd,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: itemAnimation.curve,
            )),
            child: ScaleTransition(
              scale: Tween(
                begin: itemAnimation.scaleStart,
                end: itemAnimation.scaleEnd,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: itemAnimation.curve,
              )),
              child: FadeTransition(
                opacity: Tween(
                  begin: itemAnimation.fadeStart,
                  end: itemAnimation.fadeEnd,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: itemAnimation.curve,
                )),
                child: SlideTransition(
                  position: Tween(
                    begin: itemAnimation.offsetStart,
                    end: itemAnimation.offsetEnd,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: itemAnimation.curve,
                  )),
                  child: removedItem,
                ),
              ),
            ),
          );
        },
        duration: itemAnimation.duration,
      );
    }
  }

  void moveItemUp(int index) {
    itemAnimation = moveUpItemAniamtion;

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
            position: Tween(
              begin: itemAnimation.offsetStart,
              end: itemAnimation.offsetEnd,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: itemAnimation.curve,
            )),
            child: currentItem,
          );
        },
        duration: itemAnimation.movedItemDuration,
      );

      listKey.currentState!.insertItem(
        index - 1,
        duration: itemAnimation.duration,
      );
    }
  }

  void moveItemDown(int index) {
    itemAnimation = moveDownItemAnimation;

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
            position: Tween(
              begin: itemAnimation.offsetStart,
              end: itemAnimation.offsetEnd,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: itemAnimation.curve,
            )),
            child: currentItem,
          );
        },
        duration: itemAnimation.movedItemDuration,
      );

      listKey.currentState!.insertItem(
        index + 1,
        duration: itemAnimation.duration,
      );
    }
  }

  void refreshItems() {
    setState(() {
      itemAnimation = widget.startAnimation;

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

  // void removeAllItems() {
  //   if (listKey.currentState != null) {
  //     for (int i = items.length - 1; i >= 0; i--) {
  //       listKey.currentState!.removeItem(
  //         i,
  //         (context, animation) {
  //           return SlideTransition(
  //             position: offset.animate(CurvedAnimation(
  //               parent: animation,
  //               curve: Curves.linear,
  //             )),
  //             child: items[i],
  //           );
  //         },
  //         duration: widget.removeItemAnimatiom?.duration ?? const Duration(milliseconds: 0),
  //       );
  //       items.removeAt(i);
  //     }
  //   }
  // }
}

class ItemsAnimationController {
  ItemsAnimationController({
    this.offsetStart = const Offset(0, -1),
    this.offsetEnd = const Offset(0, 0),
    this.duration = const Duration(milliseconds: 150),
    this.movedItemDuration = const Duration(milliseconds: 0),
    this.scaleStart = 0.5,
    this.scaleEnd = 1.0,
    this.turnsStart = 0.0,
    this.fadeStart = 1.0,
    this.fadeEnd = 1.0,
    this.turnsEnd = 0.0,
    this.curve = Curves.linear,
  });
  final double fadeStart;
  final double fadeEnd;
  final double scaleStart;
  final double scaleEnd;
  final double turnsStart;
  final double turnsEnd;
  final Offset offsetStart;
  final Offset offsetEnd;
  final Duration duration;
  final Duration movedItemDuration;
  final Curve curve;
}
