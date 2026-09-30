import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/orders_screen/no_orders_item/no_orders_item_widget.dart';
import '/components/orders_screen/order_item/order_item_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'my_orders_screen_widget.dart' show MyOrdersScreenWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyOrdersScreenModel extends FlutterFlowModel<MyOrdersScreenWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  List<OrdersRecord> ordersList = [];
  void addToOrdersList(OrdersRecord item) => ordersList.add(item);
  void removeFromOrdersList(OrdersRecord item) => ordersList.remove(item);
  void removeAtIndexFromOrdersList(int index) => ordersList.removeAt(index);
  void insertAtIndexInOrdersList(int index, OrdersRecord item) =>
      ordersList.insert(index, item);
  void updateOrdersListAtIndex(int index, Function(OrdersRecord) updateFn) =>
      ordersList[index] = updateFn(ordersList[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for OrderItem dynamic component.
  late FlutterFlowDynamicModels<OrderItemModel> orderItemModels1;
  // Models for OrderItem dynamic component.
  late FlutterFlowDynamicModels<OrderItemModel> orderItemModels2;

  @override
  void initState(BuildContext context) {
    orderItemModels1 = FlutterFlowDynamicModels(() => OrderItemModel());
    orderItemModels2 = FlutterFlowDynamicModels(() => OrderItemModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    orderItemModels1.dispose();
    orderItemModels2.dispose();
  }

  /// Action blocks.
  Future checkOrders(BuildContext context) async {
    List<OrdersRecord>? orderQuery;

    orderQuery = await queryOrdersRecordOnce(
      queryBuilder: (ordersRecord) => ordersRecord
          .where(
            'userId',
            isEqualTo: currentUserReference,
          )
          .orderBy('orderTime', descending: true),
    );
    ordersList = orderQuery!.toList().cast<OrdersRecord>();
    isLoading = false;
  }
}
