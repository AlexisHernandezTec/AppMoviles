import 'package:flutter/material.dart';

Widget customDropDown(List<String> items, String value, void onChange(val)) {
    return DropdownButton<String>(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
        value: value,
        onChanged: (val){
            onChange(val);
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(
                value: value,
                child: Text(value),
            );
        }).toList(),
    );
}
