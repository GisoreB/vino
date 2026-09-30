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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'welcome_screen_model.dart';
export 'welcome_screen_model.dart';

class WelcomeScreenWidget extends StatefulWidget {
  const WelcomeScreenWidget({super.key});

  static String routeName = 'WelcomeScreen';
  static String routePath = '/welcomeScreen';

  @override
  State<WelcomeScreenWidget> createState() => _WelcomeScreenWidgetState();
}

class _WelcomeScreenWidgetState extends State<WelcomeScreenWidget>
    with TickerProviderStateMixin {
  late WelcomeScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WelcomeScreenModel());

    animationsMap.addAll({
      'floatingActionButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 200.0.ms,
            duration: 1000.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_model.welcomeMessagesCurrentIndex < 2) {
              await _model.welcomeMessagesController?.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            } else {
              context.goNamed(SignInScreenWidget.routeName);
            }
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.arrow_forward_rounded,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
        ).animateOnPageLoad(
            animationsMap['floatingActionButtonOnPageLoadAnimation']!),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/VinoWS.png',
                            width: 156.0,
                            height: 140.29,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: Text(
                          'Premier Vines',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'ReenieBeanie',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    fontSize: 64.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    final welcomePages = FFAppConstants.welcomeMsgs.toList();

                    return Container(
                      width: double.infinity,
                      height: 386.5,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 40.0),
                            child: PageView.builder(
                              controller: _model.welcomeMessagesController ??=
                                  PageController(
                                      initialPage: max(
                                          0, min(0, welcomePages.length - 1))),
                              scrollDirection: Axis.horizontal,
                              itemCount: welcomePages.length,
                              itemBuilder: (context, welcomePagesIndex) {
                                final welcomePagesItem =
                                    welcomePages[welcomePagesIndex];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    wrapWithModel(
                                      model: _model.welcomeTextModels.getModel(
                                        welcomePagesItem,
                                        welcomePagesIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: WelcomeTextWidget(
                                        key: Key(
                                          'Key0ac_${welcomePagesItem}',
                                        ),
                                        welcomeMessage: welcomePagesItem,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: smooth_page_indicator.SmoothPageIndicator(
                                controller: _model.welcomeMessagesController ??=
                                    PageController(
                                        initialPage: max(0,
                                            min(0, welcomePages.length - 1))),
                                count: welcomePages.length,
                                axisDirection: Axis.horizontal,
                                onDotClicked: (i) async {
                                  await _model.welcomeMessagesController!
                                      .animateToPage(
                                    i,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                  safeSetState(() {});
                                },
                                effect: smooth_page_indicator.SlideEffect(
                                  spacing: 8.0,
                                  radius: 8.0,
                                  dotWidth: 8.0,
                                  dotHeight: 8.0,
                                  dotColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  activeDotColor:
                                      FlutterFlowTheme.of(context).primary,
                                  paintStyle: PaintingStyle.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
