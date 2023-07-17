import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/static/app_localizations.dart';
import 'package:dtt/ui/custom_widgets/details_page_ui_elements/back_button.dart';
import 'package:dtt/ui/custom_widgets/details_page_ui_elements/map_layer.dart';
import 'package:dtt/ui/custom_widgets/details_page_ui_elements/font_size_enhancer_butt.dart';
import 'package:dtt/ui/custom_widgets/universal_elements/custom_card_sub_widgets/row_dashboards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../logic/detail_providers/font_size_enhancers.dart';
import '../../static/color_pallet.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    Key? key,
    required this.image,
    required this.price,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.nBed,
    required this.nBath,
    required this.nLayers,
  }) : super(key: key);

  final String image;
  final String price;
  final String description;
  final int nBed;
  final int nBath;
  final int nLayers;
  final int longitude;
  final int latitude;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Provider.of<ParentProvider>(context).themePreference;
    final provider = Provider.of<ParentProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          provider.onlineImageNotifier
              ? Image.network(widget.image)
              : Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  enabled: true,
                  baseColor: DTTColors().kDarkGrey,
                  highlightColor: DTTColors().kLight,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? DTTColors().kStrongGrey : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                height: MediaQuery.of(context).size.height / 1.3,
                width: double.infinity,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            //Amount
                            child: AutoSizeText(
                              widget.price,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RowDashboards(
                              nBed: widget.nBed,
                              nBath: widget.nBath,
                              nLayers: widget.nLayers,
                              distance: provider.calculateDistance(
                                  provider.defaultUserLat,
                                  provider.defaultUserLong,
                                  widget.latitude.toDouble(),
                                  widget.longitude.toDouble()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15),
                      child: Text(
                        AppLocalizations.descriptionHeading(context),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: Provider.of<ParentProvider>(context)
                              .defaultFontSize,
                          color: DTTColors().kMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15),
                      child: Text(
                        AppLocalizations.locationHeading(context),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MapLayer(
                        longitude: widget.longitude, latitude: widget.latitude)
                  ],
                ),
              ),
            ],
          ),
          CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FontSizeEnhancer(
              onTap: () {
                Provider.of<ParentProvider>(context, listen: false)
                    .fontSizeIncrement();
              },
              icon: CupertinoIcons.add,
              text: AppLocalizations.fontSizeText(context)),
          const Padding(padding: EdgeInsets.all(2)),
          FontSizeEnhancer(
              onTap: () {
                Provider.of<ParentProvider>(context, listen: false)
                    .fontSizeDecrement();
              },
              icon: CupertinoIcons.minus,
              text: AppLocalizations.fontSizeText(context)),
        ],
      ),
    );
  }
}
