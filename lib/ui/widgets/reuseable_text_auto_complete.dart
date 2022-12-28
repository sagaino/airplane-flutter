import 'package:flutter/material.dart';

class ReuseAutoComplete extends StatefulWidget {
  final String value;
  final Function(String value) onItemSelected;
  final List<String> options;
  final String? label;

  const ReuseAutoComplete({
    Key? key,
    required this.value,
    required this.onItemSelected,
    required this.options,
    this.label,
  }) : super(key: key);

  @override
  State<ReuseAutoComplete> createState() => _ReuseAutoCompleteState();
}

class _ReuseAutoCompleteState extends State<ReuseAutoComplete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(),
      child: LayoutBuilder(builder: (context, constraints) {
        return Autocomplete<String>(
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              onSubmitted: (text) => onFieldSubmitted(),
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: const TextStyle(
                  color: Colors.blueGrey,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            );
          },
          initialValue: TextEditingValue(
            text: widget.value,
          ),
          onSelected: (String value) => widget.onItemSelected(value),
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return widget.options.where((String option) {
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
        );
      }),
    );
  }
}
