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
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'my_cart_screen_widget.dart' show MyCartScreenWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyCartScreenModel extends FlutterFlowModel<MyCartScreenWidget> {
  ///  Local state fields for this page.

  double totalPrice = 0.0;

  bool isLoading = true;

  List<CartItemsRecord> cartItemsList = [];
  void addToCartItemsList(CartItemsRecord item) => cartItemsList.add(item);
  void removeFromCartItemsList(CartItemsRecord item) =>
      cartItemsList.remove(item);
  void removeAtIndexFromCartItemsList(int index) =>
      cartItemsList.removeAt(index);
  void insertAtIndexInCartItemsList(int index, CartItemsRecord item) =>
      cartItemsList.insert(index, item);
  void updateCartItemsListAtIndex(
          int index, Function(CartItemsRecord) updateFn) =>
      cartItemsList[index] = updateFn(cartItemsList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in MyCartScreen widget.
  List<CartItemsRecord>? cartQueryResult;
  // Models for CartItem dynamic component.
  late FlutterFlowDynamicModels<CartItemModel> cartItemModels;
  // Stores action output result for [Firestore Query - Query a collection] action in StartPaymentButton widget.
  List<PaymentDataRecord>? payInfoQuery;
  // Stores action output result for [Backend Call - Create Document] action in StartPaymentButton widget.
  PaymentDataRecord? createdPaymentInfo;

  @override
  void initState(BuildContext context) {
    cartItemModels = FlutterFlowDynamicModels(() => CartItemModel());
  }

  @override
  void dispose() {
    cartItemModels.dispose();
  }

  /// Action blocks.
  Future calculateTotalPrice(BuildContext context) async {
    double? outputPrice;

    outputPrice = await actions.sumOfList(
      cartItemsList.map((e) => e.price).toList().toList(),
    );
    totalPrice = outputPrice!;
  }
}
