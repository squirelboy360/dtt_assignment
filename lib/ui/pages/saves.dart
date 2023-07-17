import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/static/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';
import '../../static/color_pallet.dart';
import '../custom_widgets/universal_elements/custom_card.dart';
import 'detail_page.dart';

bool favoriteButtonValue = false;

class SavesPage extends StatefulWidget {
  const SavesPage({super.key});

  @override
  State<SavesPage> createState() => _SavesPageState();
}

class _SavesPageState extends State<SavesPage> {
  bool isHouseSaved(int id) {
    final provider = Provider.of<ParentProvider>(context);
    return provider.isStoredById(id);
  }

  @override
  void initState() {
    Provider.of<ParentProvider>(context, listen: false).getSaves();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.savesScreenTitle(context),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ParentProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: provider.savedHouses.length,
            itemBuilder: (context, index) {
              final properties = provider.savedHouses[index];
              final isSaved = isHouseSaved(properties.id);
              return Builder(
                builder: (context) => CustomCard(
                  properties: properties,
                  likeButtonIsVisible: true,
                  likeWidget: GestureDetector(
                    onTap: () {
                      Provider.of<ParentProvider>(context, listen: false)
                          .checkSavedStatus(properties.id);
                      if (isSaved) {
                        Provider.of<ParentProvider>(context, listen: false)
                            .deleteData(properties.id);
                      } else {
                        Provider.of<ParentProvider>(context, listen: false)
                            .storeData(properties.id);
                      }
                      StatusAlert.show(
                        context,
                        duration: const Duration(seconds: 1),
                        title: isSaved
                            ? AppLocalizations.itemRemoveText(context)
                            : AppLocalizations.itemAddText(context),
                        configuration:
                            const IconConfiguration(icon: Icons.done),
                      );
                    },
                    child: Icon(
                      CupertinoIcons.delete,
                      color: DTTColors().kDefaultRed,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
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
                    }));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
