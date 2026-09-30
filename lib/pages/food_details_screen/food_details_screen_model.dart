import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'food_details_screen_widget.dart' show FoodDetailsScreenWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FoodDetailsScreenModel extends FlutterFlowModel<FoodDetailsScreenWidget> {
  ///  Local state fields for this page.

  int quantity = 1;

  double price = 0.0;

  CartItemsRecord? cartItem;

  bool isLoading = true;

  String selectedSize = '';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in FoodDetailsScreen widget.
  List<CartItemsRecord>? cartItemList;
  // State field(s) for SIzesChoiceChips widget.
  FormFieldController<List<String>>? sIzesChoiceChipsValueController;
  String? get sIzesChoiceChipsValue =>
      sIzesChoiceChipsValueController?.value?.firstOrNull;
  set sIzesChoiceChipsValue(String? val) =>
      sIzesChoiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - Create Document] action in AddToCartButton widget.
  CartItemsRecord? onUpdateToCart;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future setPrice(BuildContext context) async {
    price = ((quantity * widget!.food!.price * 100).toInt()) / 100;
  }
}
