import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bottom_sheets/select_payment_method_bottom_sheet/select_payment_method_bottom_sheet_widget.dart';
import '/components/my_cart_screen/cart_item/cart_item_widget.dart';
import '/components/my_cart_screen/no_cart_item/no_cart_item_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_cart_screen_model.dart';
export 'my_cart_screen_model.dart';

class MyCartScreenWidget extends StatefulWidget {
  const MyCartScreenWidget({super.key});

  static String routeName = 'MyCartScreen';
  static String routePath = '/myCartScreen';

  @override
  State<MyCartScreenWidget> createState() => _MyCartScreenWidgetState();
}

class _MyCartScreenWidgetState extends State<MyCartScreenWidget>
    with TickerProviderStateMixin {
  late MyCartScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyCartScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.cartQueryResult = await queryCartItemsRecordOnce(
        queryBuilder: (cartItemsRecord) => cartItemsRecord.where(
          'userId',
          isEqualTo: currentUserReference,
        ),
      );
      _model.cartItemsList =
          _model.cartQueryResult!.toList().cast<CartItemsRecord>();
      await _model.calculateTotalPrice(context);
      _model.isLoading = false;
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
      'cartItemOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: null,
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 300.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
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
    context.watch<FFAppState>();

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
                  mainAxisSize: MainAxisSize.max,
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
                              context.goNamed(
                                HomePageWidget.routeName,
                                extra: <String, dynamic>{
                                  '__transition_info__': TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 50.0, 0.0),
                              child: Text(
                                'My Cart',
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
                          ),
                        ],
                      ).animateOnPageLoad(
                          animationsMap['rowOnPageLoadAnimation']!),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final listviewItems = _model.cartItemsList.toList();
                          if (listviewItems.isEmpty) {
                            return NoCartItemWidget();
                          }

                          return ListView.separated(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              20.0,
                              0,
                              20.0,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: listviewItems.length,
                            separatorBuilder: (_, __) => SizedBox(height: 20.0),
                            itemBuilder: (context, listviewItemsIndex) {
                              final listviewItemsItem =
                                  listviewItems[listviewItemsIndex];
                              return wrapWithModel(
                                model: _model.cartItemModels.getModel(
                                  listviewItemsIndex.toString(),
                                  listviewItemsIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: CartItemWidget(
                                  key: Key(
                                    'Key95e_${listviewItemsIndex.toString()}',
                                  ),
                                  cartItem: listviewItemsItem,
                                  onDelete: (item) async {
                                    // firestore delete cart item
                                    await item.reference.delete();
                                    if (listviewItemsItem.consumedPoints > 0) {
                                      // restore reward points

                                      await FFAppState().myRewardData!.update({
                                        ...mapToFirestore(
                                          {
                                            'availablePoints':
                                                FieldValue.increment(
                                                    item.consumedPoints),
                                            'history': FieldValue.arrayUnion([
                                              getRewardHistoryFirestoreData(
                                                createRewardHistoryStruct(
                                                  title:
                                                      'Restored from cart for ${item.name}',
                                                  points: item.consumedPoints,
                                                  date: getCurrentTimestamp,
                                                  clearUnsetFields: false,
                                                ),
                                                true,
                                              )
                                            ]),
                                          },
                                        ),
                                      });
                                    }
                                    // remove from local list
                                    _model.removeFromCartItemsList(
                                        listviewItemsItem);
                                    // re-calculate total price
                                    await _model.calculateTotalPrice(context);
                                    safeSetState(() {});
                                  },
                                ),
                              ).animateOnPageLoad(
                                animationsMap['cartItemOnPageLoadAnimation']!,
                                effects: [
                                  FadeEffect(
                                    curve: Curves.easeInOut,
                                    delay: ((listviewItemsIndex * 50) + 50)
                                        .toDouble()
                                        .ms,
                                    duration: 1000.0.ms,
                                    begin: 0.0,
                                    end: 1.0,
                                  ),
                                  MoveEffect(
                                    curve: Curves.easeOut,
                                    delay: ((listviewItemsIndex * 50) + 50)
                                        .toDouble()
                                        .ms,
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
                    ),
                    if (_model.cartItemsList.isNotEmpty)
                      Container(
                        width: double.infinity,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 3.0, 0.0, 0.0),
                                      child: Text(
                                        '\$${_model.totalPrice.toString()}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Sora',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    var _shouldSetState = false;
                                    // check user's payment info
                                    _model.payInfoQuery =
                                        await queryPaymentDataRecordOnce(
                                      queryBuilder: (paymentDataRecord) =>
                                          paymentDataRecord.where(
                                        'userId',
                                        isEqualTo: currentUserReference,
                                      ),
                                    );
                                    _shouldSetState = true;
                                    if (_model.payInfoQuery != null &&
                                        (_model.payInfoQuery)!.isNotEmpty) {
                                      // open payment bottomsheet
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        isDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child:
                                                  SelectPaymentMethodBottomSheetWidget(
                                                price: _model.totalPrice,
                                                cartItems: _model.cartItemsList,
                                                paymentInfo: _model
                                                    .payInfoQuery!.firstOrNull!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    } else {
                                      // firestore create paymentInfo

                                      var paymentDataRecordReference =
                                          PaymentDataRecord.collection.doc();
                                      await paymentDataRecordReference
                                          .set(createPaymentDataRecordData(
                                        userId: currentUserReference,
                                      ));
                                      _model.createdPaymentInfo =
                                          PaymentDataRecord.getDocumentFromData(
                                              createPaymentDataRecordData(
                                                userId: currentUserReference,
                                              ),
                                              paymentDataRecordReference);
                                      _shouldSetState = true;
                                      // open payment bottomsheet
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        isDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child:
                                                  SelectPaymentMethodBottomSheetWidget(
                                                price: _model.totalPrice,
                                                cartItems: _model.cartItemsList,
                                                paymentInfo:
                                                    _model.createdPaymentInfo!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }

                                    if (_shouldSetState) safeSetState(() {});
                                  },
                                  text: 'Next',
                                  icon: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 16.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: 100.0,
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
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
