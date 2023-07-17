import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/static/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../static/color_pallet.dart';
import '../../pages/search.dart';

class RedirectableSearchBar extends StatelessWidget {
  const RedirectableSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceSize = MediaQuery.of(context).size.width;
    final bool isDarkMode =
        Provider.of<ParentProvider>(context).themePreference;
    return GestureDetector(
      onTap: () {
        showBottomSheet(
            context: context, builder: (context) => const SearchPage());
      },
      child: Padding(
        padding: EdgeInsets.only(
            //left padding
            left:
                deviceSize > 500 ? MediaQuery.sizeOf(context).width * 0.1 : 20,
            //right padding
            right:
                deviceSize > 500 ? MediaQuery.sizeOf(context).width * 0.1 : 20,
            bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? DTTColors().kMedium : DTTColors().kDarkGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.searchButtonText(context),
                        border: InputBorder.none,
                        isDense: false,
                      ),
                      autofocus: false,
                      enabled: false,
                      autocorrect: false,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  CupertinoIcons.search,
                  color: DTTColors().kLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
