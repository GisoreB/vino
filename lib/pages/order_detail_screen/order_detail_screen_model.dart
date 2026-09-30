import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/my_cart_screen/cart_item_read_only/cart_item_read_only_widget.dart';
import '/components/my_cart_screen/no_cart_item/no_cart_item_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'order_detail_screen_widget.dart' show OrderDetailScreenWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderDetailScreenModel extends FlutterFlowModel<OrderDetailScreenWidget> {
  ///  Local state fields for this page.

  double myRating = 0.0;

  ///  State fields for stateful widgets in this page.

  // Models for CartItemReadOnly dynamic component.
  late FlutterFlowDynamicModels<CartItemReadOnlyModel> cartItemReadOnlyModels;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;

  @override
  void initState(BuildContext context) {
    cartItemReadOnlyModels =
        FlutterFlowDynamicModels(() => CartItemReadOnlyModel());
  }

  @override
  void dispose() {
    cartItemReadOnlyModels.dispose();
  }
}
