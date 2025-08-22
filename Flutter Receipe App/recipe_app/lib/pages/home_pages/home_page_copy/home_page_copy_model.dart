import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/fav_pages/fav_componant/fav_componant_widget.dart';
import '/pages/home_pages/home_page_componant/home_page_componant_widget.dart';
import '/pages/profile_page/profile_componant/profile_componant_widget.dart';
import '/pages/recipe_pages/recipe_componant/recipe_componant_widget.dart';
import 'home_page_copy_widget.dart' show HomePageCopyWidget;
import 'package:flutter/material.dart';

class HomePageCopyModel extends FlutterFlowModel<HomePageCopyWidget> {
  ///  Local state fields for this page.

  int? selectIndex = 0;

  bool isSelectcategory = true;

  String? categoryId = '';

  bool loading = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetUserApi)] action in HomePageCopy widget.
  ApiCallResponse? getUser;
  // Stores action output result for [Backend Call - API (isVerifyAccountApi)] action in HomePageCopy widget.
  ApiCallResponse? isVerifiedCheck;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for HomePageComponant component.
  late HomePageComponantModel homePageComponantModel;
  // Model for FavComponant component.
  late FavComponantModel favComponantModel;
  // Model for RecipeComponant component.
  late RecipeComponantModel recipeComponantModel;
  // Model for ProfileComponant component.
  late ProfileComponantModel profileComponantModel;

  @override
  void initState(BuildContext context) {
    homePageComponantModel =
        createModel(context, () => HomePageComponantModel());
    favComponantModel = createModel(context, () => FavComponantModel());
    recipeComponantModel = createModel(context, () => RecipeComponantModel());
    profileComponantModel = createModel(context, () => ProfileComponantModel());
  }

  @override
  void dispose() {
    homePageComponantModel.dispose();
    favComponantModel.dispose();
    recipeComponantModel.dispose();
    profileComponantModel.dispose();
  }
}
