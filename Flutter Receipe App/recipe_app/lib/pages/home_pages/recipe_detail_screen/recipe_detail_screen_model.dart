import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import 'recipe_detail_screen_widget.dart' show RecipeDetailScreenWidget;
import 'package:flutter/material.dart';

class RecipeDetailScreenModel
    extends FlutterFlowModel<RecipeDetailScreenWidget> {
  ///  Local state fields for this page.

  int? pageviewIndex = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in Container widget.
  ApiCallResponse? detailDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in Container widget.
  ApiCallResponse? detailAdd;
  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;

  @override
  void initState(BuildContext context) {
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    customAppButtonModel.dispose();
  }
}
