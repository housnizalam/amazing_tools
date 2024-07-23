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
    this.onAddItem,
    this.onDeleteItem,
    this.startOffset,
    this.listHeight = 400,
    this.itemsWaitDuration,
    this.addItemOffset,
    this.removeItemOffset,
    this.moveUpItemOffset,
    this.moveDownItemOffset,
  });
  final List<Widget> items;
  final Function? onSwipeRight;
  final Function? onSwipeLeft;
  final Function? onAddItem;
  final Function? onDeleteItem;
  final Widget? addedItem;
  final Widget? deleteIcon;
  final Widget? addItemIcon;
  final bool showAddIconItem;
  final AnimatedOffset? startOffset;
  final AnimatedOffset? addItemOffset;
  final AnimatedOffset? removeItemOffset;
  final AnimatedOffset? moveUpItemOffset;
  final AnimatedOffset? moveDownItemOffset;
  final double listHeight;
  final Duration? itemsWaitDuration;
  @override
  State<AmazingList> createState() => _AmazingListState();
}

class _AmazingListState extends State<AmazingList> {
  late Tween<Offset> offset;
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
        _addItems(widget.items);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.listHeight,
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
                            width: 18,
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
                                  const Icon(
                                    size: 22,
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
                                  height: 12,
                                  width: 12,
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
                                    height: 12,
                                    width: 12,
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
          if (widget.addedItem != null)
            Align(
              alignment: Alignment.bottomRight,
              child: widget.showAddIconItem
                  ? IconButton(
                      onPressed: () {
                        clickedIndex == -1 ? addItem() : addItemAtIndex(clickedIndex + 1, widget.addedItem!);
                        if (widget.onAddItem == null) return;
                        widget.onAddItem!.call();
                      },
                      icon: widget.addItemIcon ?? const CircleAvatar(radius: 20, child: Icon(Icons.add)),
                    )
                  : const SizedBox(),
            ),
        ],
      ),
    );
  }

  void _addItems(List<Widget> addedItems) {
    Future future = Future(
      () {},
    );
    for (var item in addedItems) {
      future = future.then(
        (_) {
          return Future.delayed(widget.itemsWaitDuration ?? const Duration(milliseconds: 150), () {
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

    if (listKey.currentState != null) {
      // Insert the new item into the AnimatedList
      listKey.currentState!.insertItem(
        index,
        duration: widget.addItemOffset?.duration ?? const Duration(milliseconds: 250),
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
        duration: widget.addItemOffset?.duration ??
            const Duration(
              milliseconds: 250,
            ),
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
          return SlideTransition(
            position: offset.animate(CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            )),
            child: removedItem,
          );
        },
        duration:widget.removeItemOffset?.duration?? const Duration(milliseconds: 250),
      );
    }
  }

  void moveItemUp(int index) {
    if (widget.moveUpItemOffset != null) {
      offset = Tween(
        begin: widget.moveUpItemOffset!.begin,
        end: widget.moveUpItemOffset!.end,
      );
    }else{
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
        duration:widget.moveUpItemOffset?.movedItemDuration?? const Duration(milliseconds: 0),
      );

      listKey.currentState!.insertItem(
        index - 1,
        duration:widget.moveUpItemOffset?.duration?? const Duration(milliseconds: 250),
      );
    }
  }

  void moveItemDown(int index) {
    if (widget.moveDownItemOffset != null) {
      offset = Tween(
        begin: widget.moveDownItemOffset!.begin,
        end: widget.moveDownItemOffset!.end,
      );
    }else{
      offset = Tween(
        begin: const Offset(0, -1),
        end: const Offset(0, 0),
      );
    }
    if (index <= 0 || index >= items.length - 1) {
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
        duration:widget.moveDownItemOffset?.movedItemDuration?? const Duration(milliseconds: 0),
      );

      listKey.currentState!.insertItem(
        index + 1,
        duration:widget.moveDownItemOffset?.duration?? const Duration(milliseconds: 250),
      );
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
