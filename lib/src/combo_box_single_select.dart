import 'package:blutter/src/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class ComboBoxOption {
  final String label;
  final dynamic value;
  final bool isDisabled;
  final Widget? trailing;
  ComboBoxOption({
    required this.label,
    required this.value,
    this.trailing,
    this.isDisabled = false,
  });
}

class ComboboxSingleSelect extends StatefulWidget {
  const ComboboxSingleSelect({
    super.key,
    required this.options,
    this.onSelect,
    this.initialOption,
    this.hintText,
    this.content,
    this.textController,
    this.isSearchable = false,
    this.noOptionText,
  });

  final ComboBoxOption? initialOption;
  final TextEditingController? textController;
  final List<ComboBoxOption> options;
  final Function(dynamic)? onSelect;
  final String? hintText;
  final String? noOptionText;
  final Widget? content;
  final bool isSearchable;

  @override
  State<ComboboxSingleSelect> createState() => _ComboboxSingleSelectState();
}

class _ComboboxSingleSelectState extends State<ComboboxSingleSelect> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _searchController;

  List<ComboBoxOption> _filteredOptionsList = [];
  ComboBoxOption? _selectedOption;

  bool _showDropdown = false;

  bool get _optionIsSelected =>
      _selectedOption?.label == _searchController.text;

  // String get _inputValue => _searchController.text.trim().toLowerCase();

  @override
  void initState() {
    super.initState();
    _searchController = widget.textController ?? TextEditingController();

    if (widget.initialOption != null) {
      _searchController.text = widget.initialOption!.label;
    }
  }

  void _performSearch() {
    // FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      if (!_optionIsSelected && _selectedOption != null) _selectedOption = null;

      _filteredOptionsList =
          widget.isSearchable
              ? widget.options
                  .where(
                    (e) => e.label.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ),
                  )
                  .toList()
              : widget.options.toList();
    });

    if (widget.onSelect != null) {
      widget.onSelect!(null);
    }
  }

  void _handleSelect(ComboBoxOption option) {
    setState(() {
      _showDropdown = false;
      _searchController.text = option.label;
      _selectedOption = option;
      _focusNode.unfocus();
    });
    if (widget.onSelect != null) widget.onSelect!(option.value);
  }

  void _showAllOptionsList() {
    setState(() {
      _filteredOptionsList = widget.options;
      _showDropdown = !_showDropdown;
    });
  }

  void _handleDropdownTapOutside() {
    setState(() {
      _showDropdown = false;
      if (!_optionIsSelected) _searchController.clear();
      _focusNode.unfocus();
    });
  }

  void _handleInputTapOutside() {
    if (_focusNode.hasFocus && !_showDropdown) {
      if (!_optionIsSelected) _searchController.clear();
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    widget.textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MoonDropdown(
        show: _showDropdown,
        constrainWidthToChild: true,
        onTapOutside: () => _handleDropdownTapOutside(),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child:
              _filteredOptionsList.isEmpty
                  ? MoonMenuItem(
                    label: BText(widget.noOptionText ?? 'No results found.'),
                  )
                  : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _filteredOptionsList.length,
                    itemBuilder: (BuildContext _, int index) {
                      if (index >= _filteredOptionsList.length) {
                        return const SizedBox.shrink();
                      }
                      final ComboBoxOption option = _filteredOptionsList[index];

                      return MoonTextButton(
                        isFullWidth: true,
                        onTap:
                            option.isDisabled
                                ? null
                                : () => _handleSelect(option),
                        trailing: option.trailing,
                        label: Text(""),
                        leading: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [BText(option.label)],
                        ),
                      );
                    },
                  ),
        ),
        child: MoonTextInput(
          focusNode: _focusNode,
          hintText: widget.hintText ?? "Select single component",
          controller: _searchController,
          readOnly: !widget.isSearchable,
          canRequestFocus: widget.isSearchable,
          mouseCursor: MouseCursor.defer,
          onTap: () {
            _showDropdown = !_showDropdown;
            _performSearch();
          },
          onTapOutside: (PointerDownEvent _) => _handleInputTapOutside(),
          onChanged: (String _) {
            _showDropdown = true;
            _performSearch();
          },
          trailing: MoonButton.icon(
            buttonSize: MoonButtonSize.xs,
            hoverEffectColor: Colors.transparent,
            onTap: () => _showAllOptionsList(),
            icon: AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _showDropdown ? -0.5 : 0,
              child: const Icon(MoonIcons.controls_chevron_down_16_light),
            ),
          ),
        ),
      ),
    );
  }
}
