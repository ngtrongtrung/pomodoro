import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/utils/constants.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({Key? key}) : super(key: key);

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        icon: SizedBox.shrink(),
        underline: SizedBox.shrink(),
        value: context.locale.toString(),
        items: languageCode
            .map((Locale code) => DropdownMenuItem(
                  value: code.languageCode.toString(),
                  child: Text(
                    code.languageCode.toString().toUpperCase(),
                  ),
                ))
            .toList(),
        onChanged: (String? value) {
          if (value != null) context.setLocale(Locale(value));
        },
      ),
    );
  }
}
