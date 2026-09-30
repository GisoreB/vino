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
import 'create_payment_method_bottom_sheet_widget.dart'
    show CreatePaymentMethodBottomSheetWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class CreatePaymentMethodBottomSheetModel
    extends FlutterFlowModel<CreatePaymentMethodBottomSheetWidget> {
  ///  Local state fields for this component.

  int loopCount = 1;

  List<OrderItemStruct> orderItems = [];
  void addToOrderItems(OrderItemStruct item) => orderItems.add(item);
  void removeFromOrderItems(OrderItemStruct item) => orderItems.remove(item);
  void removeAtIndexFromOrderItems(int index) => orderItems.removeAt(index);
  void insertAtIndexInOrderItems(int index, OrderItemStruct item) =>
      orderItems.insert(index, item);
  void updateOrderItemsAtIndex(int index, Function(OrderItemStruct) updateFn) =>
      orderItems[index] = updateFn(orderItems[index]);

  bool canContinue = false;

  String selectedProvider = 'VISA';

  ///  State fields for stateful widgets in this component.

  // State field(s) for holderTE widget.
  FocusNode? holderTEFocusNode;
  TextEditingController? holderTETextController;
  String? Function(BuildContext, String?)? holderTETextControllerValidator;
  // Stores action output result for [Action Block - validateAndRebuild] action in holderTE widget.
  bool? shouldRebuild;
  // State field(s) for bankTE widget.
  FocusNode? bankTEFocusNode;
  TextEditingController? bankTETextController;
  String? Function(BuildContext, String?)? bankTETextControllerValidator;
  // Stores action output result for [Action Block - validateAndRebuild] action in bankTE widget.
  bool? shouldRebuild2;
  // State field(s) for cardTE widget.
  FocusNode? cardTEFocusNode;
  TextEditingController? cardTETextController;
  late MaskTextInputFormatter cardTEMask;
  String? Function(BuildContext, String?)? cardTETextControllerValidator;
  // Stores action output result for [Action Block - validateAndRebuild] action in cardTE widget.
  bool? shouldRebuild3;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // Stores action output result for [Backend Call - Create Document] action in CompletePaymentButton widget.
  OrdersRecord? createdOrder;
  // Stores action output result for [Backend Call - Read Document] action in CompletePaymentButton widget.
  RewardDataRecord? fetchedRewardData;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    holderTEFocusNode?.dispose();
    holderTETextController?.dispose();

    bankTEFocusNode?.dispose();
    bankTETextController?.dispose();

    cardTEFocusNode?.dispose();
    cardTETextController?.dispose();
  }

  /// Action blocks.
  Future<bool?> validateAndRebuild(BuildContext context) async {
    if ((holderTETextController.text != null &&
            holderTETextController.text != '') &&
        (cardTETextController.text.trim().length == 19) &&
        (bankTETextController.text != null &&
            bankTETextController.text != '') &&
        (selectedProvider != null && selectedProvider != '')) {
      return canContinue == false;
    }

    return canContinue == true;
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
