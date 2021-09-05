import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({Key? key}) : super(key: key);

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  @override
  void initState() {
    super.initState();
    this._getLocalLanguage();
  }

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
        onChanged: (String? locale) async {
          if (locale != null) {
            setLocale(locale);
            SharedPreferences local = await SharedPreferences.getInstance();
            await local.setString('localLanguage', locale);
          }
        },
      ),
    );
  }

  void _getLocalLanguage() async {
    SharedPreferences local = await SharedPreferences.getInstance();
    String? locale = local.getString('localLanguage');
    if (locale != null) {
      setLocale(locale);
    }
  }

  void setLocale(String locale) async {
    await context.setLocale(Locale(locale));
  }
}
