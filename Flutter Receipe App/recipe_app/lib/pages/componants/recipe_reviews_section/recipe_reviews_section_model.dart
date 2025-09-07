import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'recipe_reviews_section_widget.dart' show RecipeReviewsSectionWidget;
import 'package:flutter/material.dart';

class RecipeReviewsSectionModel
    extends FlutterFlowModel<RecipeReviewsSectionWidget> {
  ///  Local state fields for this component.

  bool isLoading = true;
  List<dynamic> reviews = [];
  bool showAllReviews = false;
  double calculatedAverageRating = 0.0;
  int calculatedTotalReviews = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (GetReviewByRecipeId)] action in RecipeReviewsSection widget.
  ApiCallResponse? getReviewsApiResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  void addToReviews(dynamic item) => reviews.add(item);
  void removeFromReviews(dynamic item) => reviews.remove(item);
  void removeAtIndexFromReviews(int index) => reviews.removeAt(index);
  void insertAtIndexInReviews(int index, dynamic item) =>
      reviews.insert(index, item);
  void updateReviewsAtIndex(int index, Function(dynamic) updateFn) =>
      reviews[index] = updateFn(reviews[index]);
}
