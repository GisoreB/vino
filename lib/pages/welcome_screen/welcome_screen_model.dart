import '/components/welcome_screen/welcome_text/welcome_text_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'welcome_screen_widget.dart' show WelcomeScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WelcomeScreenModel extends FlutterFlowModel<WelcomeScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for WelcomeMessages widget.
  PageController? welcomeMessagesController;

  int get welcomeMessagesCurrentIndex => welcomeMessagesController != null &&
          welcomeMessagesController!.hasClients &&
          welcomeMessagesController!.page != null
      ? welcomeMessagesController!.page!.round()
      : 0;
  // Models for WelcomeText dynamic component.
  late FlutterFlowDynamicModels<WelcomeTextModel> welcomeTextModels;

  @override
  void initState(BuildContext context) {
    welcomeTextModels = FlutterFlowDynamicModels(() => WelcomeTextModel());
  }

  @override
  void dispose() {
    welcomeTextModels.dispose();
  }
}
