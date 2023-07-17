import 'package:dtt/logic/other_providers/get_data.dart';
import 'package:dtt/logic/overview_provider.dart';
import 'package:dtt/logic/overview_providers/get_location.dart';
import 'package:dtt/logic/saves_providers/get_saves.dart';
import 'package:dtt/logic/search_providers/search_items.dart';
import 'package:dtt/logic/theme_provider/theme_switch.dart';

import '../ui/custom_widgets/details_page_ui_elements/delete_data.dart';
import 'detail_providers/font_size_enhancers.dart';
import 'detail_providers/open_map.dart';
import 'other_providers/is_saved_switch.dart';
import 'overview_providers/store_data.dart';

//serves as a bridge between overviewProvider abstract class and all mixin classes
//i do this to avoid instantiating all classes inheriting overviewProvider
class ParentProvider extends OverviewProvider
    with
        GetLocation,
        ThemeSwitch,
        FontEnhancer,
        IsSavedSwitch,
        SearchItems,
        GetSaves,
        DeleteData,
        StoreData,
        SearchItems,
        GetData,
        OpenMap {}
