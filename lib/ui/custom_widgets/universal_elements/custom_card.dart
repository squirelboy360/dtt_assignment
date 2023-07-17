import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/model/overview_model.dart';
import 'package:dtt/ui/custom_widgets/universal_elements/custom_card_sub_widgets/row_dashboards.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../static/color_pallet.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.likeButtonIsVisible,
    required this.likeWidget,
    required this.onTap,
    required this.properties,
  });
  final OverviewModel properties;
  final bool likeButtonIsVisible;
  final Widget likeWidget;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final providerProps = Provider.of<ParentProvider>(context);
      final bool isDarkMode = providerProps.themePreference;
      double deviceSize = MediaQuery.of(context).size.width;
      double screenWidth = MediaQuery.of(context).size.width;
      double lPaddingBS = 20;
      double rPaddingBS = 20;

      if (screenWidth > 600) {
        if (kDebugMode) {
          print(screenWidth);
        }
        lPaddingBS = screenWidth * 0.2;
        rPaddingBS = screenWidth * 0.2;
      }
      return Padding(
        padding: EdgeInsets.only(
            left: deviceSize > 600 ? lPaddingBS : 20,
            right: deviceSize > 600 ? rPaddingBS : 20,
            bottom: 10,
            top: 10),
        child: InkWell(
          highlightColor: Colors.transparent,
          mouseCursor: MouseCursor.uncontrolled,
          onTap: () {
            onTap();
          },
          child: SizedBox(
            width: 100,
            child: Card(
              color:
                  isDarkMode ? DTTColors().kStrongGrey : DTTColors().kWhiteCard,
              child: ListTile(
                selectedColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                mouseCursor: MouseCursor.defer,
                hoverColor: Colors.transparent,
                title: Row(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: providerProps.onlineImageNotifier
                              ? Image.network(
                                  //size//
                                  providerProps.imgUrl + properties.image,
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  width:
                                      MediaQuery.of(context).size.width / 5.5,
                                  fit: BoxFit.cover,
                                )

                              ///in case of no internet i use this container. i replaced the shimmer animation
                              ///because of performance issues.
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  width:
                                      MediaQuery.of(context).size.width / 5.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                      child: CircularProgressIndicator())),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///Price////
                          Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: AutoSizeText(
                              maxLines: 1,
                              "\$${providerProps.formatAmount(properties.price.toString())}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkMode == false
                                      ? DTTColors().kStrongGrey
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),

                          ///Address////
                          AutoSizeText(
                              maxLines: 1,
                              '${properties.zip} ${properties.city}',
                              style: TextStyle(
                                color: DTTColors().kMedium,
                                fontSize: 10,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: RowDashboards(
                              nBed: properties.size,
                              nBath: properties.bathroom,
                              nLayers: properties.bedrooms,
                              distance: providerProps.calculateDistance(
                                  providerProps.defaultUserLat,
                                  providerProps.defaultUserLong,
                                  properties.latitude.toDouble(),
                                  properties.longitude.toDouble()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  child: likeWidget,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
