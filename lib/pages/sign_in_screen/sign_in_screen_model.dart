import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'sign_in_screen_widget.dart' show SignInScreenWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInScreenModel extends FlutterFlowModel<SignInScreenWidget> {
  ///  Local state fields for this page.

  bool isFormValidated = false;

  bool tempValidator = false;

  String pass = 'password';

  String email = 'guestcafeza@yopmail.com';

  ///  State fields for stateful widgets in this page.

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
    emailTEFocusNode?.dispose();
    emailTETextController?.dispose();

    passwirdTEFocusNode?.dispose();
    passwirdTETextController?.dispose();
  }

  /// Action blocks.
  Future checkValidation(BuildContext context) async {
    bool? isValidEmail;
    bool? isValidPassword;

    await Future.wait([
      Future(() async {
        isValidEmail = await actions.isValidEmail(
          emailTETextController.text,
        );
      }),
      Future(() async {
        isValidPassword = await actions.isValidPassword(
          passwirdTETextController.text,
        );
      }),
    ]);
    tempValidator = isValidEmail! && isValidPassword!;
  }
}
