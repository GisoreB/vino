import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_bar_model.dart';
export 'bottom_navigation_bar_model.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  final int? pageIndex;
  final Future Function()? onTap;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget>
    with TickerProviderStateMixin {
  late BottomNavigationBarModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavigationBarModel());

    animationsMap.addAll({
      'iconButtonOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: Offset(widget!.pageIndex == 0 ? 0.9 : 1.0,
                widget!.pageIndex == 0 ? 0.9 : 1.0),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: Offset(widget!.pageIndex == 1 ? 0.9 : 1.0,
                widget!.pageIndex == 1 ? 0.9 : 1.0),
            end: const Offset(1.0, 1.0),
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
    return Align(
      alignment: const AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: 150.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x69000000),
              offset: Offset(
                0.0,
                2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 40.0,
              hoverColor: Colors.transparent,
              icon: Icon(
                Icons.home_filled,
                color: widget!.pageIndex == 0
                    ? FlutterFlowTheme.of(context).primary
                    : FlutterFlowTheme.of(context).disabledText,
                size: 24.0,
              ),
              onPressed: () async {
                if (widget!.pageIndex != 0) {
                  await widget.onTap?.call();
                  return;
                } else {
                  return;
                }
              },
            ).animateOnPageLoad(
                animationsMap['iconButtonOnPageLoadAnimation1']!),
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 40.0,
              hoverColor: Colors.transparent,
              icon: Icon(
                Icons.card_giftcard_rounded,
                color: widget!.pageIndex == 1
                    ? FlutterFlowTheme.of(context).primary
                    : FlutterFlowTheme.of(context).disabledText,
                size: 19.0,
              ),
              onPressed: () async {
                if (widget!.pageIndex != 1) {
                  await widget.onTap?.call();
                  return;
                } else {
                  return;
                }
              },
            ).animateOnPageLoad(
                animationsMap['iconButtonOnPageLoadAnimation2']!),
          ],
        ),
      ),
    );
  }
}
