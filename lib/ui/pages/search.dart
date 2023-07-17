import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/ui/pages/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../static/color_pallet.dart';
import '../custom_widgets/search_page_ui_elements/no_search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final provider = Provider.of<ParentProvider>(context, listen: false);
    provider.searchStaffs(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ParentProvider>(context);
    final searchResults = provider.searchResults;
    return SingleChildScrollView(
      child: Material(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: MediaQuery.sizeOf(context).height - 100,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: DTTColors().kMedium,
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CupertinoSearchTextField(
                  autofocus: true,
                  enableIMEPersonalizedLearning: true,
                  style: TextStyle(
                      color: Provider.of<ParentProvider>(context).isDarkMode
                          ? DTTColors().kLight
                          : DTTColors().kStrongGrey),
                  autocorrect: false,
                  controller: _searchController,
                ),
              ),
              Visibility(
                visible: provider.isSearchNotFound,
                child: const SearchNotFoundWidget(),
              ),
              Expanded(
                child: Visibility(
                  visible: provider.isSearchNotFound ? false : true,
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (ctx, index) {
                      final staff = searchResults[index];
                      return ListTile(
                        title: Text(staff.zip),
                        subtitle: Text(staff.city),
                        trailing: Text(
                          "\$${provider.formatAmount(staff.price.toString())}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                image: provider.imgUrl + staff.image,
                                price:
                                    "\$${provider.formatAmount(staff.price.toString())}",
                                description: staff.description,
                                longitude: staff.longitude,
                                latitude: staff.latitude,
                                nBed: staff.bedrooms,
                                nBath: staff.bathroom,
                                nLayers: staff.size,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
