import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWithEditAndDelete extends StatelessWidget {
  const SlidableWithEditAndDelete({
    Key? key,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.child,
  }) : super(key: key);

  final Function onEditPressed;
  final Function onDeletePressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: const Icon(
                Icons.edit,
              ),
              onPressed: () => onEditPressed.call(),
            ),
          )
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: <Widget>[
          Expanded(
            child: IconButton(
              onPressed: () => onDeletePressed.call(),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )
        ],
      ),
      child: child,
    );
  }
}
