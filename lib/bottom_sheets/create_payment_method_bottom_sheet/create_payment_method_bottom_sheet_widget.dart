import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'create_payment_method_bottom_sheet_model.dart';
export 'create_payment_method_bottom_sheet_model.dart';

class CreatePaymentMethodBottomSheetWidget extends StatefulWidget {
  const CreatePaymentMethodBottomSheetWidget({
    super.key,
    required this.price,
    required this.cartItems,
    this.paymentInfo,
  });

  final double? price;
  final List<CartItemsRecord>? cartItems;
  final PaymentDataRecord? paymentInfo;

  @override
  State<CreatePaymentMethodBottomSheetWidget> createState() =>
      _CreatePaymentMethodBottomSheetWidgetState();
}

class _CreatePaymentMethodBottomSheetWidgetState
    extends State<CreatePaymentMethodBottomSheetWidget>
    with TickerProviderStateMixin {
  late CreatePaymentMethodBottomSheetModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreatePaymentMethodBottomSheetModel());

    _model.holderTETextController ??= TextEditingController();
    _model.holderTEFocusNode ??= FocusNode();

    _model.bankTETextController ??= TextEditingController();
    _model.bankTEFocusNode ??= FocusNode();

    _model.cardTETextController ??= TextEditingController();
    _model.cardTEFocusNode ??= FocusNode();

    _model.cardTEMask = MaskTextInputFormatter(mask: '####-####-####-####');
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
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 160.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 160.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 160.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 160.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 160.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 160.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'radioButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 250.0.ms,
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
                    'Add Payment method',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
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
            ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation']!),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.person_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20.0,
                      ),
                      SizedBox(
                        height: 25.0,
                        child: VerticalDivider(
                          width: 20.0,
                          thickness: 0.2,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _model.holderTETextController,
                          focusNode: _model.holderTEFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.holderTETextController',
                            Duration(milliseconds: 2000),
                            () async {
                              var _shouldSetState = false;
                              _model.shouldRebuild =
                                  await _model.validateAndRebuild(context);
                              _shouldSetState = true;
                              if (_model.shouldRebuild!) {
                                _model.canContinue = !_model.canContinue;
                                safeSetState(() {});
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              } else {
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Card holder name',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).disabledText,
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0.0,
                                  ),
                          keyboardType: TextInputType.name,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.holderTETextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ],
              ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.book,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20.0,
                      ),
                      SizedBox(
                        height: 25.0,
                        child: VerticalDivider(
                          width: 20.0,
                          thickness: 0.2,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _model.bankTETextController,
                          focusNode: _model.bankTEFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.bankTETextController',
                            Duration(milliseconds: 2000),
                            () async {
                              var _shouldSetState = false;
                              _model.shouldRebuild2 =
                                  await _model.validateAndRebuild(context);
                              _shouldSetState = true;
                              if (_model.shouldRebuild2!) {
                                _model.canContinue = !_model.canContinue;
                                safeSetState(() {});
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              } else {
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Bank name',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).disabledText,
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0.0,
                                  ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.bankTETextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ],
              ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation2']!),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.add_card,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20.0,
                      ),
                      SizedBox(
                        height: 25.0,
                        child: VerticalDivider(
                          width: 20.0,
                          thickness: 0.2,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _model.cardTETextController,
                          focusNode: _model.cardTEFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.cardTETextController',
                            Duration(milliseconds: 2000),
                            () async {
                              var _shouldSetState = false;
                              _model.shouldRebuild3 =
                                  await _model.validateAndRebuild(context);
                              _shouldSetState = true;
                              if (_model.shouldRebuild3!) {
                                _model.canContinue = !_model.canContinue;
                                safeSetState(() {});
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              } else {
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Card number',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).disabledText,
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0.0,
                                  ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.cardTETextControllerValidator
                              .asValidator(context),
                          inputFormatters: [_model.cardTEMask],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ],
              ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: FlutterFlowRadioButton(
                  options: FFAppConstants.cardProviders.toList(),
                  onChanged: (val) async {
                    safeSetState(() {});
                    _model.selectedProvider = _model.radioButtonValue!;
                  },
                  controller: _model.radioButtonValueController ??=
                      FormFieldController<String>(
                          FFAppConstants.cardProviders.firstOrNull!),
                  optionHeight: 32.0,
                  optionWidth: MediaQuery.sizeOf(context).width * 0.4,
                  textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Poppins',
                        letterSpacing: 0.0,
                      ),
                  selectedTextStyle:
                      FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0.0,
                          ),
                  buttonPosition: RadioButtonPosition.left,
                  direction: Axis.horizontal,
                  radioButtonColor: FlutterFlowTheme.of(context).primary,
                  inactiveRadioButtonColor:
                      FlutterFlowTheme.of(context).secondaryText,
                  toggleable: false,
                  horizontalAlignment: WrapAlignment.start,
                  verticalAlignment: WrapCrossAlignment.start,
                ).animateOnPageLoad(
                    animationsMap['radioButtonOnPageLoadAnimation']!),
              ),
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
                        onPressed: !_model.canContinue
                            ? null
                            : () async {
                                var _shouldSetState = false;
                                if (!(widget!.paymentInfo!.paymentMethods
                                    .where((e) =>
                                        e.cardNumber ==
                                        _model.cardTETextController.text)
                                    .toList()
                                    .isNotEmpty)) {
                                  while (_model.loopCount <=
                                      widget!.cartItems!.length) {
                                    // Delete Cart Item
                                    await widget!.cartItems!
                                        .elementAtOrNull(_model.loopCount - 1)!
                                        .reference
                                        .delete();
                                    // Add Order Item
                                    _model.addToOrderItems(OrderItemStruct(
                                      price: widget!.cartItems
                                          ?.elementAtOrNull(
                                              _model.loopCount - 1)
                                          ?.price,
                                      quantity: widget!.cartItems
                                          ?.elementAtOrNull(
                                              _model.loopCount - 1)
                                          ?.quantity,
                                      foodName: widget!.cartItems
                                          ?.elementAtOrNull(
                                              _model.loopCount - 1)
                                          ?.name,
                                      foodPictureUrl: widget!.cartItems
                                          ?.elementAtOrNull(
                                              _model.loopCount - 1)
                                          ?.pictureUrl,
                                      size: widget!.cartItems
                                          ?.elementAtOrNull(
                                              _model.loopCount - 1)
                                          ?.size,
                                      type: widget!.cartItems
                                          ?.elementAtOrNull(
                                              _model.loopCount - 1)
                                          ?.type,
                                    ));
                                    _model.loopCount = _model.loopCount + 1;
                                  }
                                  await Future.wait([
                                    Future(() async {
                                      // Add payment method info

                                      await widget!.paymentInfo!.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'paymentMethods':
                                                FieldValue.arrayUnion([
                                              getPaymentMethodFirestoreData(
                                                createPaymentMethodStruct(
                                                  cardHolderName: _model
                                                      .holderTETextController
                                                      .text,
                                                  cardNumber: _model
                                                      .cardTETextController
                                                      .text,
                                                  cardType:
                                                      _model.selectedProvider ==
                                                              'VISA'
                                                          ? CardType.visa
                                                          : CardType.masterCard,
                                                  bankName: _model
                                                      .bankTETextController
                                                      .text,
                                                  clearUnsetFields: false,
                                                ),
                                                true,
                                              )
                                            ]),
                                          },
                                        ),
                                      });
                                    }),
                                    Future(() async {
                                      // Firestore - Create Order

                                      var ordersRecordReference =
                                          OrdersRecord.collection.doc();
                                      await ordersRecordReference.set({
                                        ...createOrdersRecordData(
                                          userId: currentUserReference,
                                          orderStatus: OrderStatus.ordered,
                                          totalPrice: widget!.price,
                                          orderTime: getCurrentTimestamp,
                                          paymentMethod:
                                              createPaymentMethodStruct(
                                            cardHolderName: _model
                                                .holderTETextController.text,
                                            cardNumber: _model
                                                .cardTETextController.text,
                                            bankName: _model
                                                .bankTETextController.text,
                                            cardType: _model.selectedProvider ==
                                                    'VISA'
                                                ? CardType.visa
                                                : CardType.masterCard,
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
                                          paymentMethod:
                                              createPaymentMethodStruct(
                                            cardHolderName: _model
                                                .holderTETextController.text,
                                            cardNumber: _model
                                                .cardTETextController.text,
                                            bankName: _model
                                                .bankTETextController.text,
                                            cardType: _model.selectedProvider ==
                                                    'VISA'
                                                ? CardType.visa
                                                : CardType.masterCard,
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
                                      _shouldSetState = true;
                                    }),
                                  ]);
                                  // fatch reward data
                                  _model.fetchedRewardData =
                                      await RewardDataRecord.getDocumentOnce(
                                          FFAppState().myRewardData!);
                                  _shouldSetState = true;
                                  // update reward data

                                  await FFAppState().myRewardData!.update({
                                    ...createRewardDataRecordData(
                                      loyaltyLevel: (int previousLevel) {
                                        return previousLevel < 8
                                            ? ++previousLevel
                                            : 0;
                                      }(_model.fetchedRewardData!.loyaltyLevel),
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
                                              orderId: _model
                                                  .createdOrder?.reference,
                                              clearUnsetFields: false,
                                            ),
                                            true,
                                          )
                                        ]),
                                      },
                                    ),
                                  });
                                  if (_model.fetchedRewardData?.loyaltyLevel ==
                                      8) {
                                    // firesetore give points for loyalty

                                    await FFAppState().myRewardData!.update({
                                      ...mapToFirestore(
                                        {
                                          'availablePoints':
                                              FieldValue.increment(50),
                                          'history': FieldValue.arrayUnion([
                                            getRewardHistoryFirestoreData(
                                              createRewardHistoryStruct(
                                                title:
                                                    'Awarded for loyalty level 8/8',
                                                points: 50,
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
                                  // Close BottomSheet
                                  Navigator.pop(context);
                                } else {
                                  // Card already exist error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Card already exist in your accout',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).error,
                                    ),
                                  );
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }

                                if (Navigator.of(context).canPop()) {
                                  context.pop();
                                }
                                context.pushNamed(
                                    OrderSuccessScreenWidget.routeName);

                                if (_shouldSetState) safeSetState(() {});
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
                          color: _model.canContinue
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
