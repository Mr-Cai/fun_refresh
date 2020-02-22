import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../model/event/drawer_nav_bloc.dart';
import '../model/mock/smash_model.dart';

class AnchorBar extends StatefulWidget {
  AnchorBar({
    this.items,
    this.centerItem,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
    this.elevation,
    this.notchMargin = 8.0,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<NavItemBTM> items;
  final Widget centerItem;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  final double elevation;
  final double notchMargin;

  @override
  _AnchorBarState createState() => _AnchorBarState();
}

class _AnchorBarState extends State<AnchorBar> {
  int _selectedIndex = 0;
  NavigationBloc navContext;
  void _updateIndex(index) {
    navContext = BlocProvider.of<NavigationBloc>(context);
    widget.onTabSelected(index);
    setState(() {
      switch (index) {
        case 0:
          navContext.add(NavigationEvent.game);
          break;
        case 1:
          navContext.add(NavigationEvent.video);
          break;
        case 2:
          navContext.add(NavigationEvent.extend);
          break;
        case 3:
          navContext.add(NavigationEvent.message);
          break;
        default:
          navContext.add(NavigationEvent.game);
      }
      return _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(
      widget.items.length,
      (index) => _buildTabItems(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      ),
    );
    items.insert(items.length >> 1, _buildMiddleTabItems());
    return BottomAppBar(
      elevation: widget.elevation,
      notchMargin: widget.notchMargin,
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  _buildMiddleTabItems() => Expanded(
        child: SizedBox(
          height: widget.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: widget.iconSize),
              widget.centerItem ?? Container()
            ],
          ),
        ),
      );

  _buildTabItems({NavItemBTM item, int index, ValueChanged<int> onPressed}) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: InkWell(
        onTap: () => onPressed(index),
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: SizedBox(
          height: widget.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(item.iconPath,
                  width: widget.iconSize, height: widget.iconSize),
              SizedBox(height: 3.0),
              Text(item.text, style: TextStyle(color: color, fontSize: 12.0))
            ],
          ),
        ),
      ),
    );
  }
}
