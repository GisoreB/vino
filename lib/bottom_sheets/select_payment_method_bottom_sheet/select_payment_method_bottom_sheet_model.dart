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
import 'select_payment_method_bottom_sheet_widget.dart'
    show SelectPaymentMethodBottomSheetWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectPaymentMethodBottomSheetModel
    extends FlutterFlowModel<SelectPaymentMethodBottomSheetWidget> {
  ///  Local state fields for this component.

  bool isLoading = true;

  String? selectedPaymentMethod;

  int loopCount = 1;

  List<OrderItemStruct> orderItems = [];
  void addToOrderItems(OrderItemStruct item) => orderItems.add(item);
  void removeFromOrderItems(OrderItemStruct item) => orderItems.remove(item);
  void removeAtIndexFromOrderItems(int index) => orderItems.removeAt(index);
  void insertAtIndexInOrderItems(int index, OrderItemStruct item) =>
      orderItems.insert(index, item);
  void updateOrderItemsAtIndex(int index, Function(OrderItemStruct) updateFn) =>
      orderItems[index] = updateFn(orderItems[index]);

  ///  State fields for stateful widgets in this component.

  // Models for ItemPaymentMethod dynamic component.
  late FlutterFlowDynamicModels<ItemPaymentMethodModel> itemPaymentMethodModels;
  // Stores action output result for [Backend Call - Create Document] action in CompletePaymentButton widget.
  OrdersRecord? createdOrder;
  // Stores action output result for [Backend Call - Read Document] action in CompletePaymentButton widget.
  RewardDataRecord? fatchedRewardData;

  @override
  void initState(BuildContext context) {
    itemPaymentMethodModels =
        FlutterFlowDynamicModels(() => ItemPaymentMethodModel());
  }

  @override
  void dispose() {
    itemPaymentMethodModels.dispose();
  }
}
