import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/static/app_localizations.dart';
import 'package:dtt/static/color_pallet.dart';
import 'package:dtt/static/shapes.dart';
import 'package:dtt/ui/custom_widgets/overview_ui_elements/all_fav_butt.dart';
import 'package:dtt/ui/custom_widgets/overview_ui_elements/progress_indicator.dart';
import 'package:dtt/ui/custom_widgets/overview_ui_elements/redirectable_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';
import '../../custom_widgets/universal_elements/custom_card.dart';
import '../../pages/detail_page.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  void initState() {
    Provider.of<ParentProvider>(context, listen: false).getData();
    Provider.of<ParentProvider>(context, listen: false).getSaves();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final providerProps = Provider.of<ParentProvider>(context);
        providerProps.nfavorites = providerProps.favoriteBox.length;
        final bool isDarkMode = providerProps.themePreference;
        return Scaffold(
          backgroundColor:
              isDarkMode ? DTTColors().kStrongGrey : DTTColors().kLightGreyBg,
          body: Consumer<ParentProvider>(
            builder: (context, provider, _) {
              if (provider.houses.isEmpty) {
                return const Center(
                  child: SizedBox(
                    width: 150,
                    child: CustomProgressIndicator(),
                  ),
                );
              } else {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      bottom: const PreferredSize(
                        preferredSize: Size.fromHeight(50.0),
                        child: RedirectableSearchBar(),
                      ),
                      pinned: true,
                      actions: const [AllFavButton()],
                      backgroundColor: isDarkMode
                          ? DTTColors().kStrongGrey
                          : DTTColors().kLightGreyBg,
                      expandedHeight: 0,
                      forceElevated: false,
                      forceMaterialTransparency: false,
                      title: Text(
                        AppLocalizations.overviewScreenTitle(context),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      centerTitle: false,
                      elevation: 0,
                      shape: Shapes().roundedShapeBorder1(),
                    ),
                  ],
                  body: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    cacheExtent: provider.houses.length.toDouble(),
                    restorationId: 'id',
                    itemCount: provider.houses.length,
                    itemBuilder: (context, index) {
                      final properties = provider.houses[index];
                      final isSaved = provider.isHouseSaved(properties.id);
                      return CustomCard(
                        //passing properties property to properties as it is required by the CustomCard widget.
                        properties: properties,
                        likeButtonIsVisible: true,
                        likeWidget: GestureDetector(
                          onTap: () {
                            //make checks on the item status(if it is stored ore not) on clicked.

                            final properties = provider.houses[index];
                            Provider.of<ParentProvider>(context, listen: false)
                                .checkSavedStatus(properties.id);
                            if (provider.isStored) {
                              Provider.of<ParentProvider>(context,
                                      listen: false)
                                  .deleteData(properties.id);
                            } else {
                              Provider.of<ParentProvider>(context,
                                      listen: false)
                                  .storeData(properties.id);
                            }
                            StatusAlert.show(
                              context,
                              duration: const Duration(seconds: 1),
                              title: isSaved
                                  ? AppLocalizations.itemRemoveText(context)
                                  : AppLocalizations.itemAddText(context),
                              configuration: const IconConfiguration(
                                icon: Icons.done,
                              ),
                            );
                          },
                          child: Icon(
                            isSaved ? Icons.star : Icons.star_border,
                            size: 25,
                            color: isSaved
                                ? DTTColors().kDefaultRed
                                : DTTColors().kMedium,
                          ),
                        ),
                        //push to details screen with inherited properties
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailScreen(
                                image: provider.imgUrl + properties.image,
                                price:
                                    "\$${provider.formatAmount(properties.price.toString())}",
                                description: properties.description,
                                longitude: properties.longitude,
                                latitude: properties.latitude,
                                nBed: properties.bedrooms,
                                nBath: properties.bathroom,
                                nLayers: properties.size,
                              );
                            }),
                          );
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
