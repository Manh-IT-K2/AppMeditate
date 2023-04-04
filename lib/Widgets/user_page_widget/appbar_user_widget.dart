import 'package:flutter/material.dart';
import 'package:meditation_app/Pages/detail_setting_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class AppBarUserWidget extends StatelessWidget {
  const AppBarUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bg_favorite.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Q Mạnh',
                style: Primaryfont.bold(16).copyWith(color: Colors.black),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("$DetailSettingUser");
            },
            //borderRadius: BorderRadius.circular(20),
            hoverColor: Colors.transparent,
            child: const Icon(
              Icons.settings_suggest_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
