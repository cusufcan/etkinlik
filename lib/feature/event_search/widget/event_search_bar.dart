import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/feature/event_search/widget/search_action_button.dart';
import 'package:flutter/material.dart';

class EventSearchBar extends StatefulWidget {
  const EventSearchBar({
    super.key,
    required this.onSearchChange,
  });

  final void Function(String value) onSearchChange;

  @override
  State<EventSearchBar> createState() => _EventSearchBarState();
}

class _EventSearchBarState extends State<EventSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  void _clearSearch() {
    _controller.clear();
    widget.onSearchChange(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppNum.small),
      child: SearchBar(
        controller: _controller,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppNum.xSmall),
          ),
        ),
        focusNode: _focusNode,
        autoFocus: true,
        hintText: 'Etkinlik Ara',
        trailing: [
          if (!_hasFocus)
            SearchActionButton(
              onTap: () {},
              icon: Icons.search_outlined,
            ),
          if (_hasFocus)
            SearchActionButton(
              onTap: _clearSearch,
              icon: Icons.clear_outlined,
            )
        ],
        onChanged: widget.onSearchChange,
      ),
    );
  }
}
