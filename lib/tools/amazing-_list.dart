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
    this.showdeleteItem = true,
    this.onAddItem,
    this.onDeleteItem,
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
  final bool showdeleteItem;
  @override
  State<AmazingList> createState() => _AmazingListState();
}

class _AmazingListState extends State<AmazingList> {
  Tween<Offset> offset = Tween(
    begin: Offset(1, 4),
    end: Offset(0, 0),
  );
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late List<Widget> items;

  @override
  void initState() {
    super.initState();
    items = [];
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _addItems(widget.items);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          AnimatedList(
            key: listKey,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                position: offset.animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.showdeleteItem)
                      IconButton(
                        onPressed: () {
                          removeItem(index);
                          if (widget.onDeleteItem == null) return;
                          widget.onDeleteItem!.call();
                        },
                        icon: widget.deleteIcon ?? Icon(Icons.delete),
                      ),
                    SwipeButton(
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
                  ],
                ),
              );
            },
          ),
          if (widget.addedItem != null)
            Align(
              alignment: Alignment.bottomRight,
              child: widget.showAddIconItem
                  ? IconButton(
                      onPressed: () {
                        addItem();
                        if (widget.onAddItem == null) return;
                        widget.onAddItem!.call();
                      },
                      icon: widget.addItemIcon ?? CircleAvatar(radius: 20, child: Icon(Icons.add)),
                    )
                  : SizedBox(),
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
          return Future.delayed(Duration(milliseconds: 100), () {
            items.add(item);
            if (listKey.currentState != null) {
              listKey.currentState!.insertItem(
                items.length - 1,
                duration: Duration(
                  milliseconds: 500,
                ),
              );
            }
          });
        },
      );
    }
  }

  void addItem() {
    if (widget.addedItem == null) return;
    items.add(widget.addedItem!);
    if (listKey.currentState != null) {
      listKey.currentState!.insertItem(
        items.length - 1,
        duration: Duration(
          milliseconds: 500,
        ),
      );
    }
  }

  void removeItem(int index) {
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
        duration: Duration(milliseconds: 500),
      );
    }
  }

  void replaceItem(int index, Widget newItem) {
    if (index < 0 || index >= items.length) {
      // Ensure index is valid
      return;
    }

    // Replace the item in the list
    final oldItem = items[index];
    items[index] = newItem;

    if (listKey.currentState != null) {
      // Remove the old item from the AnimatedList
      listKey.currentState!.removeItem(
        index,
        (context, animation) {
          return SlideTransition(
            position: offset.animate(CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            )),
            child: oldItem,
          );
        },
        duration: Duration(milliseconds: 250),
      );

      // Insert the new item into the AnimatedList
      Future.delayed(Duration(milliseconds: 300), () {
        if (listKey.currentState != null) {
          listKey.currentState!.insertItem(
            index,
            duration: Duration(milliseconds: 250),
          );
        }
      });
    }
  }
}
