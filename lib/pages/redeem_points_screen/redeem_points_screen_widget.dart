import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/item_redeem_list_widget.dart';
import '/components/no_reward_history_item_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'redeem_points_screen_model.dart';
export 'redeem_points_screen_model.dart';

class RedeemPointsScreenWidget extends StatefulWidget {
  const RedeemPointsScreenWidget({
    super.key,
    required this.rewardsData,
  });

  final RewardDataRecord? rewardsData;

  static String routeName = 'RedeemPointsScreen';
  static String routePath = '/redeemPointsScreen';

  @override
  State<RedeemPointsScreenWidget> createState() =>
      _RedeemPointsScreenWidgetState();
}

class _RedeemPointsScreenWidgetState extends State<RedeemPointsScreenWidget>
    with TickerProviderStateMixin {
  late RedeemPointsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RedeemPointsScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.queryResultFoods = await queryFoodsRecordOnce();
      _model.isLoading = false;
      _model.rewardDataLocal = widget!.rewardsData;
      safeSetState(() {});
    });

    animationsMap.addAll({
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'itemRedeemListOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: null,
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              if (!_model.isLoading) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 22.0,
                            ),
                            onPressed: () async {
                              if (_model.isRedeeming) {
                                return;
                              }

                              if (Navigator.of(context).canPop()) {
                                context.pop();
                              }
                              context.pushNamed(
                                RewardsScreenWidget.routeName,
                                queryParameters: {
                                  'rewardsData': serializeParam(
                                    _model.rewardDataLocal,
                                    ParamType.Document,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'rewardsData': _model.rewardDataLocal,
                                  '__transition_info__': TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );

                              return;
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Redeem points',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Sora',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.pinterest,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                3.0, 0.0, 20.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                _model.rewardDataLocal?.availablePoints
                                    ?.toString(),
                                '0',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ).animateOnPageLoad(
                          animationsMap['rowOnPageLoadAnimation']!),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Builder(
                              builder: (context) {
                                final foodsList =
                                    _model.queryResultFoods?.toList() ?? [];
                                if (foodsList.isEmpty) {
                                  return Center(
                                    child: NoRewardHistoryItemWidget(),
                                  );
                                }

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: foodsList.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 15.0),
                                  itemBuilder: (context, foodsListIndex) {
                                    final foodsListItem =
                                        foodsList[foodsListIndex];
                                    return wrapWithModel(
                                      model:
                                          _model.itemRedeemListModels.getModel(
                                        foodsListIndex.toString(),
                                        foodsListIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: ItemRedeemListWidget(
                                        key: Key(
                                          'Keyamf_${foodsListIndex.toString()}',
                                        ),
                                        foodPictureUrl:
                                            foodsListItem.pictureUrl,
                                        foodName: foodsListItem.name,
                                        subtitle: 'can change any time',
                                        points:
                                            (foodsListItem.price * 5).toInt(),
                                        onTapRedeem: (points) async {
                                          var _shouldSetState = false;
                                          if (_model.rewardDataLocal!
                                                  .availablePoints >=
                                              points) {
                                            _model.isRedeeming = true;
                                            _model.queryResultCartItems =
                                                await queryCartItemsRecordOnce(
                                              queryBuilder: (cartItemsRecord) =>
                                                  cartItemsRecord
                                                      .where(
                                                        'userId',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'foodRef',
                                                        isEqualTo: foodsListItem
                                                            .reference,
                                                      ),
                                            );
                                            _shouldSetState = true;
                                            if (_model.queryResultCartItems !=
                                                    null &&
                                                (_model.queryResultCartItems)!
                                                    .isNotEmpty) {
                                              await action_blocks
                                                  .updateCartItemFirestore(
                                                context,
                                                cartItem: _model
                                                    .queryResultCartItems
                                                    ?.where((e) =>
                                                        e.foodRef ==
                                                        foodsListItem.reference)
                                                    .toList()
                                                    ?.firstOrNull,
                                                foodItem: foodsListItem,
                                                points: points,
                                              );
                                            } else {
                                              _model.createdCartItem =
                                                  await action_blocks
                                                      .createCartItemFirestore(
                                                context,
                                                foodName: foodsListItem.name,
                                                userRef: currentUserReference,
                                                foodPicture:
                                                    foodsListItem.pictureUrl,
                                                quantity: 1,
                                                price: 0.0,
                                                size: foodsListItem
                                                    .sizes.firstOrNull,
                                                type: foodsListItem.type,
                                                foodRef:
                                                    foodsListItem.reference,
                                                redeemedPoints: points,
                                              );
                                              _shouldSetState = true;
                                            }

                                            // firestore refatch rewardinfo
                                            _model.refatchedRewardData =
                                                await RewardDataRecord
                                                    .getDocumentOnce(widget!
                                                        .rewardsData!
                                                        .reference);
                                            _shouldSetState = true;
                                            // is redeeming , reward-data
                                            _model.isRedeeming = false;
                                            _model.rewardDataLocal =
                                                _model.refatchedRewardData;
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          } else {
                                            // error for not enough points
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Not enough points',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                              ),
                                            );
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          }

                                          if (_shouldSetState)
                                            safeSetState(() {});
                                        },
                                      ),
                                    ).animateOnPageLoad(
                                      animationsMap[
                                          'itemRedeemListOnPageLoadAnimation']!,
                                      effects: [
                                        FadeEffect(
                                          curve: Curves.easeInOut,
                                          delay: valueOrDefault<double>(
                                            (foodsListIndex * 50) + 50,
                                            200.0,
                                          ).ms,
                                          duration: 1000.0.ms,
                                          begin: 0.0,
                                          end: 1.0,
                                        ),
                                        MoveEffect(
                                          curve: Curves.easeOut,
                                          delay: valueOrDefault<double>(
                                            (foodsListIndex * 50) + 50,
                                            200.0,
                                          ).ms,
                                          duration: 500.0.ms,
                                          begin: Offset(0.0, 40.0),
                                          end: Offset(0.0, 0.0),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ]
                              .divide(SizedBox(height: 15.0))
                              .addToStart(SizedBox(height: 15.0))
                              .addToEnd(SizedBox(height: 15.0)),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    child: custom_widgets.Loader(
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
