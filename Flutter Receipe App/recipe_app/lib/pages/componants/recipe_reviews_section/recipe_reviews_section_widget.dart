import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'recipe_reviews_section_model.dart';
export 'recipe_reviews_section_model.dart';

class RecipeReviewsSectionWidget extends StatefulWidget {
  const RecipeReviewsSectionWidget({
    super.key,
    required this.recipeId,
    this.averageRating,
    this.totalReviews,
  });

  final String recipeId;
  final double? averageRating;
  final int? totalReviews;

  @override
  State<RecipeReviewsSectionWidget> createState() =>
      _RecipeReviewsSectionWidgetState();
}

class _RecipeReviewsSectionWidgetState
    extends State<RecipeReviewsSectionWidget> {
  late RecipeReviewsSectionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecipeReviewsSectionModel());

    // Load reviews when component initializes
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadReviews());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _loadReviews() async {
    if (mounted) {
      setState(() {
        _model.isLoading = true;
      });

      try {
        _model.getReviewsApiResult = await RecipeAppGroup.getReviewByRecipeIdApiCall.call(
          recipeId: widget.recipeId,
        );

        if (_model.getReviewsApiResult?.succeeded ?? false) {
          final reviewsData = _model.getReviewsApiResult?.jsonBody;
          if (reviewsData != null && reviewsData['status'] == true) {
            final reviewsList = List<dynamic>.from(reviewsData['data'] ?? []);
            
            // Calculate rating statistics
            double totalRating = 0.0;
            int validReviews = 0;
            
            for (var review in reviewsList) {
              final rating = review['rating'];
              if (rating != null && rating is num) {
                totalRating += rating.toDouble();
                validReviews++;
              }
            }
            
            setState(() {
              _model.reviews = reviewsList;
              _model.calculatedTotalReviews = validReviews;
              _model.calculatedAverageRating = validReviews > 0 ? (totalRating / validReviews) : 0.0;
              _model.isLoading = false;
            });
            
            // Debug output
            print('=== Reviews Debug Info ===');
            print('Total reviews loaded: ${reviewsList.length}');
            print('Valid ratings: $validReviews');
            print('Calculated average: ${_model.calculatedAverageRating}');
            print('API averageRating: ${widget.averageRating}');
            print('API totalReviews: ${widget.totalReviews}');
            print('========================');
            
          } else {
            setState(() {
              _model.reviews = [];
              _model.calculatedTotalReviews = 0;
              _model.calculatedAverageRating = 0.0;
              _model.isLoading = false;
            });
          }
        } else {
          setState(() {
            _model.reviews = [];
            _model.calculatedTotalReviews = 0;
            _model.calculatedAverageRating = 0.0;
            _model.isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          _model.reviews = [];
          _model.isLoading = false;
        });
      }
    }
  }

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
          color: index < rating 
            ? FlutterFlowTheme.of(context).warning
            : FlutterFlowTheme.of(context).lightGrey,
          size: 12.0,
        );
      }),
    );
  }

  String _formatTimeAgo(String dateTimeString) {
    try {
      final DateTime dateTime = DateTime.parse(dateTimeString);
      final Duration difference = DateTime.now().difference(dateTime);
      
      if (difference.inDays > 7) {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  Widget _buildCompactReviewItem(dynamic review) {
    final user = review['userId'] ?? {};
    final firstName = user['firstname'] ?? '';
    final lastName = user['lastname'] ?? '';
    final avatar = user['avatar'] ?? '';
    final rating = review['rating'] ?? 0;
    final comment = review['comment'] ?? '';
    final createdAt = review['createdAt'] ?? '';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).samewhite,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).lightGrey.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info row - compact
          Row(
            children: [
              // Smaller avatar
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).lightGrey,
                  shape: BoxShape.circle,
                ),
                child: avatar.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          'http://localhost:8190/uploads/user/$avatar',
                          width: 32.0,
                          height: 32.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 16.0,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.person,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 16.0,
                      ),
              ),
              const SizedBox(width: 8.0),
              // User name và rating compact
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$firstName $lastName'.trim().isNotEmpty 
                          ? '$firstName $lastName'.trim()
                          : 'Anonymous',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: false,
                      ),
                    ),
                    Row(
                      children: [
                        _buildStarRating(rating),
                        const SizedBox(width: 6.0),
                        Text(
                          _formatTimeAgo(createdAt),
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'SF Pro Display',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11.0,
                            useGoogleFonts: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Comment - truncated if too long
          if (comment.isNotEmpty) ...[
            const SizedBox(height: 8.0),
            Text(
              comment.length > 100 ? '${comment.substring(0, 100)}...' : comment,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'SF Pro Display',
                fontSize: 13.0,
                lineHeight: 1.3,
                useGoogleFonts: false,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if there are any reviews to display
    final totalReviews = widget.totalReviews ?? 
        (_model.calculatedTotalReviews > 0 
            ? _model.calculatedTotalReviews 
            : _model.reviews.length);
    
    // If no reviews and not loading, don't show the reviews section at all
    if (!_model.isLoading && totalReviews == 0 && _model.reviews.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compact Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).samewhite,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: FlutterFlowTheme.of(context).black10.withOpacity(0.1),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.rate_review_outlined,
                  color: FlutterFlowTheme.of(context).primaryTheme,
                  size: 20.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Reviews',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts: false,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12.0),
          
          // Reviews Content
          if (_model.isLoading)
            Container(
              width: double.infinity,
              height: 60.0,
              alignment: Alignment.center,
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primaryTheme,
                  ),
                ),
              ),
            )
          else if (_model.reviews.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).samewhite,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).lightGrey.withOpacity(0.5),
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 32.0,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'No reviews yet',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: false,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Be the first to review!',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'SF Pro Display',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 12.0,
                      useGoogleFonts: false,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                // Show reviews only when expanded, otherwise just show button
                if (_model.showAllReviews) ...[
                  // Display all reviews when expanded
                  ..._model.reviews 
                      .map((review) => _buildCompactReviewItem(review))
                      .toList(),
                  const SizedBox(height: 8.0),
                ],
                
                // Always show the toggle button
                InkWell(
                  onTap: () {
                      setState(() {
                        _model.showAllReviews = !_model.showAllReviews;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).samewhite,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryTheme.withOpacity(0.3),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(
                            builder: (context) {
                              // Use the same logic as header for consistency
                              final totalReviews = widget.totalReviews ?? 
                                  (_model.calculatedTotalReviews > 0 
                                      ? _model.calculatedTotalReviews 
                                      : _model.reviews.length);
                              
                              return Text(
                                _model.showAllReviews 
                                    ? 'Hide Reviews'
                                    : totalReviews == 1 
                                        ? 'View 1 Review'
                                        : 'View All $totalReviews Reviews',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).primaryTheme,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                  useGoogleFonts: false,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 4.0),
                          Icon(
                            _model.showAllReviews 
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).primaryTheme,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
