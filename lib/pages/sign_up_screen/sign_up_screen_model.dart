import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'sign_up_screen_widget.dart' show SignUpScreenWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class SignUpScreenModel extends FlutterFlowModel<SignUpScreenWidget> {
  ///  Local state fields for this page.

  bool isFormValidated = false;

  bool tempValidator = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for NameTE widget.
  FocusNode? nameTEFocusNode;
  TextEditingController? nameTETextController;
  String? Function(BuildContext, String?)? nameTETextControllerValidator;
  // State field(s) for PhoneTE widget.
  FocusNode? phoneTEFocusNode;
  TextEditingController? phoneTETextController;
  late MaskTextInputFormatter phoneTEMask;
  String? Function(BuildContext, String?)? phoneTETextControllerValidator;
  // State field(s) for EmailTE widget.
  FocusNode? emailTEFocusNode;
  TextEditingController? emailTETextController;
  String? Function(BuildContext, String?)? emailTETextControllerValidator;
  // State field(s) for PasswirdTE widget.
  FocusNode? passwirdTEFocusNode;
  TextEditingController? passwirdTETextController;
  late bool passwirdTEVisibility;
  String? Function(BuildContext, String?)? passwirdTETextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwirdTEVisibility = false;
  }

  @override
  void dispose() {
    nameTEFocusNode?.dispose();
    nameTETextController?.dispose();

    phoneTEFocusNode?.dispose();
    phoneTETextController?.dispose();

    emailTEFocusNode?.dispose();
    emailTETextController?.dispose();

    passwirdTEFocusNode?.dispose();
    passwirdTETextController?.dispose();
  }

  /// Action blocks.
  Future checkValidation(BuildContext context) async {
    bool? validEmail;
    bool? validPassword;
    bool? validPhone;

    await Future.wait([
      Future(() async {
        validEmail = await actions.isValidEmail(
          emailTETextController.text,
        );
      }),
      Future(() async {
        validPassword = await actions.isValidPassword(
          passwirdTETextController.text,
        );
      }),
      Future(() async {
        validPhone = await actions.isValidPhone(
          phoneTETextController.text,
        );
      }),
    ]);
    tempValidator = validEmail! &&
        validPassword! &&
        validPhone! &&
        (nameTETextController.text != null && nameTETextController.text != '');
  }
}
