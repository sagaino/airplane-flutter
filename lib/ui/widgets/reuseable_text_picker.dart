import 'package:flutter/material.dart';

class ReusePicker extends StatefulWidget {
  final String value;
  final List<String> options;
  final Function(String value) onItemSelected;
  final String? label;

  const ReusePicker({
    Key? key,
    required this.value,
    required this.onItemSelected,
    required this.options,
    this.label,
  }) : super(key: key);

  @override
  State<ReusePicker> createState() => _ReusePickerState();
}

class _ReusePickerState extends State<ReusePicker> {
  String selectedValue = "";

  showPickerPopUp() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Selected Picker"),
          ),
          body: Column(
            children: [
              ListView.builder(
                itemCount: widget.options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = widget.options[index];
                  return InkWell(
                    onTap: () {
                      selectedValue = item;
                      widget.onItemSelected(item);
                      Navigator.pop(context);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(item),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(),
      child: LayoutBuilder(builder: (context, constraints) {
        return Autocomplete<String>(
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return InkWell(
              onTap: () async {
                await showPickerPopUp();
                textEditingController.text = selectedValue;
              },
              child: AbsorbPointer(
                child: TextField(
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
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
        );
      }),
    );
  }
}
