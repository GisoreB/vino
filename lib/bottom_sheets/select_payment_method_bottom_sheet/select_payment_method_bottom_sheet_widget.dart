import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/bottom_sheets/create_payment_method_bottom_sheet/create_payment_method_bottom_sheet_widget.dart';
import '/bottom_sheets/item_payment_method/item_payment_method_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'select_payment_method_bottom_sheet_model.dart';
export 'select_payment_method_bottom_sheet_model.dart';

class SelectPaymentMethodBottomSheetWidget extends StatefulWidget {
  const SelectPaymentMethodBottomSheetWidget({
    super.key,
    required this.price,
    required this.cartItems,
    required this.paymentInfo,
  });

  final double? price;
  final List<CartItemsRecord>? cartItems;
  final PaymentDataRecord? paymentInfo;

  @override
  State<SelectPaymentMethodBottomSheetWidget> createState() =>
      _SelectPaymentMethodBottomSheetWidgetState();
}

class _SelectPaymentMethodBottomSheetWidgetState
    extends State<SelectPaymentMethodBottomSheetWidget>
    with TickerProviderStateMixin {
  late SelectPaymentMethodBottomSheetModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectPaymentMethodBottomSheetModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
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
      'itemPaymentMethodOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: null,
      ),
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: ((valueOrDefault<int>(
                          _model.orderItems.length,
                          0,
                        ) *
                        50) +
                    150)
                .ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: ((valueOrDefault<int>(
                          _model.orderItems.length,
                          0,
                        ) *
                        50) +
                    150)
                .ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: ((valueOrDefault<int>(
                          _model.orderItems.length,
                          0,
                        ) *
                        50) +
                    200)
                .ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: ((valueOrDefault<int>(
                          _model.orderItems.length,
                          0,
                        ) *
                        50) +
                    200)
                .ms,
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
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Payment method',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation']!),
                ),
                FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 30.0,
                  icon: Icon(
                    Icons.close_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 14.0,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            if (widget!.paymentInfo?.paymentMethods != null &&
                (widget!.paymentInfo?.paymentMethods)!.isNotEmpty)
              Builder(
                builder: (context) {
                  final paymentMethodsList =
                      widget!.paymentInfo?.paymentMethods?.toList() ?? [];

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(paymentMethodsList.length,
                              (paymentMethodsListIndex) {
                        final paymentMethodsListItem =
                            paymentMethodsList[paymentMethodsListIndex];
                        return wrapWithModel(
                          model: _model.itemPaymentMethodModels.getModel(
                            paymentMethodsListIndex.toString(),
                            paymentMethodsListIndex,
                          ),
                          updateCallback: () => safeSetState(() {}),
                          child: ItemPaymentMethodWidget(
                            key: Key(
                              'Keys2v_${paymentMethodsListIndex.toString()}',
                            ),
                            isSelected: paymentMethodsListItem.cardNumber ==
                                _model.selectedPaymentMethod,
                            paymentMethod: paymentMethodsListItem,
                            onTap: (cardNumber) async {
                              _model.selectedPaymentMethod = cardNumber;
                              safeSetState(() {});
                            },
                          ),
                        ).animateOnPageLoad(
                          animationsMap[
                              'itemPaymentMethodOnPageLoadAnimation']!,
                          effects: [
                            FadeEffect(
                              curve: Curves.easeInOut,
                              delay: ((paymentMethodsListIndex * 50) + 50).ms,
                              duration: 1000.0.ms,
                              begin: 0.0,
                              end: 1.0,
                            ),
                            MoveEffect(
                              curve: Curves.easeOut,
                              delay: ((paymentMethodsListIndex * 50) + 50).ms,
                              duration: 500.0.ms,
                              begin: Offset(0.0, 40.0),
                              end: Offset(0.0, 0.0),
                            ),
                          ],
                        );
                      })
                          .divide(SizedBox(height: 15.0))
                          .addToStart(SizedBox(height: 15.0)),
                    ),
                  );
                },
              ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 15.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: CreatePaymentMethodBottomSheetWidget(
                          price: widget!.price!,
                          cartItems: widget!.cartItems!,
                          paymentInfo: widget!.paymentInfo,
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                text: 'Add Payment Method',
                icon: Icon(
                  Icons.add_box,
                  size: 25.0,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 100.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconColor: FlutterFlowTheme.of(context).primaryText,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(15.0),
                  hoverColor: FlutterFlowTheme.of(context).secondaryBackground,
                  hoverBorderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                  hoverTextColor: FlutterFlowTheme.of(context).primaryText,
                ),
                showLoadingIndicator: false,
              ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation']!),
            ),
            Container(
              width: double.infinity,
              height: 100.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  )
                ],
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
                              '\$${widget!.price?.toString()}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Sora',
                                    color: FlutterFlowTheme.of(context).primary,
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: (_model.selectedPaymentMethod != null &&
                                    _model.selectedPaymentMethod != ''
                                ? false
                                : true)
                            ? null
                            : () async {
                                while (_model.loopCount <=
                                    widget!.cartItems!.length) {
                                  // firestore delete cart item
                                  await widget!.cartItems!
                                      .elementAtOrNull(_model.loopCount - 1)!
                                      .reference
                                      .delete();
                                  // added item to orderItems
                                  _model.addToOrderItems(OrderItemStruct(
                                    price: widget!.cartItems
                                        ?.elementAtOrNull(_model.loopCount - 1)
                                        ?.price,
                                    quantity: widget!.cartItems
                                        ?.elementAtOrNull(_model.loopCount - 1)
                                        ?.quantity,
                                    foodName: widget!.cartItems
                                        ?.elementAtOrNull(_model.loopCount - 1)
                                        ?.name,
                                    foodPictureUrl: widget!.cartItems
                                        ?.elementAtOrNull(_model.loopCount - 1)
                                        ?.pictureUrl,
                                    size: widget!.cartItems
                                        ?.elementAtOrNull(_model.loopCount - 1)
                                        ?.size,
                                    type: widget!.cartItems
                                        ?.elementAtOrNull(_model.loopCount - 1)
                                        ?.type,
                                  ));
                                  _model.loopCount = _model.loopCount + 1;
                                }
                                // create order

                                var ordersRecordReference =
                                    OrdersRecord.collection.doc();
                                await ordersRecordReference.set({
                                  ...createOrdersRecordData(
                                    userId: currentUserReference,
                                    orderStatus: OrderStatus.ordered,
                                    totalPrice: widget!.price,
                                    orderTime: getCurrentTimestamp,
                                    paymentMethod: updatePaymentMethodStruct(
                                      widget!.paymentInfo?.paymentMethods
                                          ?.where((e) =>
                                              e.cardNumber ==
                                              _model.selectedPaymentMethod)
                                          .toList()
                                          ?.firstOrNull,
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                    deliveryAddress: valueOrDefault(
                                        currentUserDocument?.address, ''),
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'orderItems':
                                          getOrderItemListFirestoreData(
                                        _model.orderItems,
                                      ),
                                    },
                                  ),
                                });
                                _model.createdOrder =
                                    OrdersRecord.getDocumentFromData({
                                  ...createOrdersRecordData(
                                    userId: currentUserReference,
                                    orderStatus: OrderStatus.ordered,
                                    totalPrice: widget!.price,
                                    orderTime: getCurrentTimestamp,
                                    paymentMethod: updatePaymentMethodStruct(
                                      widget!.paymentInfo?.paymentMethods
                                          ?.where((e) =>
                                              e.cardNumber ==
                                              _model.selectedPaymentMethod)
                                          .toList()
                                          ?.firstOrNull,
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                    deliveryAddress: valueOrDefault(
                                        currentUserDocument?.address, ''),
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'orderItems':
                                          getOrderItemListFirestoreData(
                                        _model.orderItems,
                                      ),
                                    },
                                  ),
                                }, ordersRecordReference);
                                // fatch reward data
                                _model.fatchedRewardData =
                                    await RewardDataRecord.getDocumentOnce(
                                        FFAppState().myRewardData!);
                                // update reward data

                                await _model.fatchedRewardData!.reference
                                    .update({
                                  ...createRewardDataRecordData(
                                    loyaltyLevel: (int previousLevel) {
                                      return previousLevel < 8
                                          ? ++previousLevel
                                          : 0;
                                    }(_model.fatchedRewardData!.loyaltyLevel),
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'availablePoints': FieldValue.increment(
                                          (widget!.price!) ~/ 5),
                                      'history': FieldValue.arrayUnion([
                                        getRewardHistoryFirestoreData(
                                          createRewardHistoryStruct(
                                            title:
                                                'Ordered ${widget!.cartItems?.length?.toString()} items',
                                            points: (widget!.price!) ~/ 5,
                                            date: getCurrentTimestamp,
                                            orderId:
                                                _model.createdOrder?.reference,
                                            clearUnsetFields: false,
                                          ),
                                          true,
                                        )
                                      ]),
                                    },
                                  ),
                                });
                                // dismiss bottomsheet
                                Navigator.pop(context);
                                // navigate to the success page
                                if (Navigator.of(context).canPop()) {
                                  context.pop();
                                }
                                context.pushNamed(
                                    OrderSuccessScreenWidget.routeName);

                                safeSetState(() {});
                              },
                        text: 'Pay',
                        icon: Icon(
                          Icons.payment,
                          size: 20.0,
                        ),
                        options: FFButtonOptions(
                          width: 100.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: _model.selectedPaymentMethod != null &&
                                  _model.selectedPaymentMethod != ''
                              ? FlutterFlowTheme.of(context).primary
                              : Color(0xFF585451),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
            ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
          ].addToStart(SizedBox(height: 10.0)).addToEnd(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
