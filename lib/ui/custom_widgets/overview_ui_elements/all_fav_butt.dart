import 'package:dtt/logic/parent_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../animation/navigation/nav_anim.dart';
import '../../../static/color_pallet.dart';
import '../../pages/saves.dart';

class AllFavButton extends StatelessWidget {
  const AllFavButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final providerProps = Provider.of<ParentProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(customRoute1(const SavesPage()));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            IconButton(
              icon: Icon(
                Icons.list,
                color: DTTColors().kDefaultRed,
              ),
              onPressed: () {
                Navigator.of(context).push(customRoute1(const SavesPage()));
              },
            ),
            Builder(builder: (context) {
              return Visibility(
                visible: providerProps.isFavoriteNumberVisible,
                child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: DTTColors().kLight,
                        borderRadius: BorderRadius.circular(360)),
                    child: Center(
                        child: Text(
                      providerProps.savedHouses.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ))),
              );
            })
          ],
        ),
      ),
    );
  }
}
