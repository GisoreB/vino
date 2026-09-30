import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '/components/choice_buttons_widget.dart';
import '/components/home_screen/item_card_home/item_card_home_widget.dart';
import '/components/no_foods_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    super.key,
    this.passedRewardData,
  });

  final RewardDataRecord? passedRewardData;

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          await Future.wait([
            Future(() async {
              // cart query
              _model.cartQueryResult = await queryCartItemsRecordOnce(
                queryBuilder: (cartItemsRecord) => cartItemsRecord.where(
                  'userId',
                  isEqualTo: currentUserReference,
                ),
              );
            }),
            Future(() async {
              // get foods query action-block
              _model.getFoodsActioBlocResult = await _model.getFoodsQuery(
                context,
                text: _model.searchbarTextController.text,
              );
            }),
          ]);
          // set cart+foods in local
          _model.cartItemsLocal =
              _model.cartQueryResult!.toList().cast<CartItemsRecord>();
          _model.foodsListLocal =
              _model.getFoodsActioBlocResult!.toList().cast<FoodsRecord>();
          _model.isLoading = false;
          _model.promotedListLocal = _model.getFoodsActioBlocResult!
              .where((e) => e.isPromoted)
              .toList()
              .toList()
              .cast<FoodsRecord>();
          safeSetState(() {});
        }),
        Future(() async {
          if ((FFAppState().myRewardData == null) ||
              (widget!.passedRewardData == null)) {
            // query rewards data for user
            _model.queryRewardData = await queryRewardDataRecordOnce(
              queryBuilder: (rewardDataRecord) => rewardDataRecord.where(
                'userId',
                isEqualTo: currentUserReference,
              ),
              singleRecord: true,
            ).then((s) => s.firstOrNull);
            if (_model.queryRewardData?.reference != null) {
              await Future.wait([
                Future(() async {
                  // set reward ref to global variable
                  FFAppState().myRewardData = _model.queryRewardData?.reference;
                }),
                Future(() async {
                  // set reward data to local variable
                  _model.myRewardsDataLocal = _model.queryRewardData;
                }),
              ]);
              return;
            } else {
              // create first reward doc

              var rewardDataRecordReference = RewardDataRecord.collection.doc();
              await rewardDataRecordReference.set({
                ...createRewardDataRecordData(
                  userId: currentUserReference,
                  availablePoints: 5,
                  loyaltyLevel: 0,
                ),
                ...mapToFirestore(
                  {
                    'history': [
                      getRewardHistoryFirestoreData(
                        createRewardHistoryStruct(
                          title: 'Welcome points',
                          points: 5,
                          date: getCurrentTimestamp,
                          clearUnsetFields: false,
                          create: true,
                        ),
                        true,
                      )
                    ],
                  },
                ),
              });
              _model.createdRewardData = RewardDataRecord.getDocumentFromData({
                ...createRewardDataRecordData(
                  userId: currentUserReference,
                  availablePoints: 5,
                  loyaltyLevel: 0,
                ),
                ...mapToFirestore(
                  {
                    'history': [
                      getRewardHistoryFirestoreData(
                        createRewardHistoryStruct(
                          title: 'Welcome points',
                          points: 5,
                          date: getCurrentTimestamp,
                          clearUnsetFields: false,
                          create: true,
                        ),
                        true,
                      )
                    ],
                  },
                ),
              }, rewardDataRecordReference);
              await Future.wait([
                Future(() async {
                  // set reward ref to global variable
                  FFAppState().myRewardData =
                      _model.createdRewardData?.reference;
                }),
                Future(() async {
                  // set reward data to local variable
                  _model.myRewardsDataLocal = _model.createdRewardData;
                }),
              ]);
              return;
            }
          } else {
            // set reward data to local variable
            _model.myRewardsDataLocal = widget!.passedRewardData;
            return;
          }
        }),
      ]);
    });

    _model.searchbarTextController ??= TextEditingController();
    _model.searchbarFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOutQuint,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: Offset(0.0, -150.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'carouselOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 150.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'choiceButtonsOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 250.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'itemCardHomeOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: null,
      ),
      'floatingActionButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 500.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 500.0.ms,
            duration: 1000.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'floatingActionButtonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
            context.goNamed(
              MyCartScreenWidget.routeName,
              extra: <String, dynamic>{
                '__transition_info__': TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: FaIcon(
            FontAwesomeIcons.cartArrowDown,
            color: FlutterFlowTheme.of(context).info,
            size: 20.0,
          ),
        )
            .animateOnPageLoad(
                animationsMap['floatingActionButtonOnPageLoadAnimation']!)
            .animateOnActionTrigger(
              animationsMap['floatingActionButtonOnActionTriggerAnimation']!,
            ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 100.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 64.0),
                            child: Container(
                              width: double.infinity,
                              height: 280.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Location',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFFA2A2A2),
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          StreamBuilder<List<UsersRecord>>(
                                            stream: queryUsersRecord(
                                              singleRecord: true,
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<UsersRecord>
                                                  circleImageUsersRecordList =
                                                  snapshot.data!;
                                              // Return an empty Container when the item does not exist.
                                              if (snapshot.data!.isEmpty) {
                                                return Container();
                                              }
                                              final circleImageUsersRecord =
                                                  circleImageUsersRecordList
                                                          .isNotEmpty
                                                      ? circleImageUsersRecordList
                                                          .first
                                                      : null;

                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                      ProfileScreenWidget
                                                          .routeName);
                                                },
                                                child: Container(
                                                  width: 45.0,
                                                  height: 45.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    imageUrl:
                                                        circleImageUsersRecord!
                                                            .photoUrl,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      'assets/images/error_image.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) =>
                                            FlutterFlowDropDown<String>(
                                          controller:
                                              _model.dropDownValueController ??=
                                                  FormFieldController<String>(
                                            _model.dropDownValue ??=
                                                valueOrDefault<String>(
                                              valueOrDefault(
                                                  currentUserDocument?.address,
                                                  ''),
                                              'Pune, Maharashtra',
                                            ),
                                          ),
                                          options: FFAppConstants.addresses,
                                          onChanged: (val) async {
                                            safeSetState(() =>
                                                _model.dropDownValue = val);
                                            unawaited(
                                              () async {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  address: _model.dropDownValue,
                                                ));
                                              }(),
                                            );
                                          },
                                          width: 200.0,
                                          height: 40.0,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                                letterSpacing: 0.0,
                                              ),
                                          hintText: 'Select address',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .accent4,
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          elevation: 0.0,
                                          borderColor: Colors.transparent,
                                          borderWidth: 0.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          hidesUnderline: true,
                                          isOverButton: false,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 20.0, 20.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 0.0, 0.0),
                                              child: Container(
                                                height: 56.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF2A2A2A),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons.search,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent4,
                                                        size: 22.0,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Container(
                                                              width: 200.0,
                                                              child:
                                                                  TextFormField(
                                                                controller: _model
                                                                    .searchbarTextController,
                                                                focusNode: _model
                                                                    .searchbarFocusNode,
                                                                onFieldSubmitted:
                                                                    (_) async {
                                                                  _model.isLoading =
                                                                      true;
                                                                  safeSetState(
                                                                      () {});
                                                                  // search query
                                                                  _model.searchFoodQueryResult =
                                                                      await _model
                                                                          .getFoodsQuery(
                                                                    context,
                                                                    text: _model
                                                                        .searchbarTextController
                                                                        .text,
                                                                  );
                                                                  _model.isLoading =
                                                                      false;
                                                                  _model.foodsListLocal = _model
                                                                      .searchFoodQueryResult!
                                                                      .toList()
                                                                      .cast<
                                                                          FoodsRecord>();
                                                                  safeSetState(
                                                                      () {});

                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                autofocus:
                                                                    false,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .search,
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  isDense: true,
                                                                  labelStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  hintText:
                                                                      'Search “wine”',
                                                                  hintStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .accent4,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0x00000000),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0x00000000),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                  focusedErrorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent4,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                cursorColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent4,
                                                                validator: _model
                                                                    .searchbarTextControllerValidator
                                                                    .asValidator(
                                                                        context),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                              child:
                                                                  FlutterFlowIconButton(
                                                                borderRadius:
                                                                    15.0,
                                                                buttonSize:
                                                                    30.0,
                                                                fillColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                icon: Icon(
                                                                  Icons
                                                                      .close_rounded,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  size: 12.0,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .searchbarTextController
                                                                        ?.clear();
                                                                  });
                                                                  _model.isLoading =
                                                                      true;
                                                                  safeSetState(
                                                                      () {});
                                                                  // non-search query
                                                                  _model.allFoodQueryResult =
                                                                      await _model
                                                                          .getFoodsQuery(
                                                                              context);
                                                                  _model.isLoading =
                                                                      false;
                                                                  _model.foodsListLocal = _model
                                                                      .allFoodQueryResult!
                                                                      .toList()
                                                                      .cast<
                                                                          FoodsRecord>();
                                                                  safeSetState(
                                                                      () {});

                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 0.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderRadius: 14.0,
                                              buttonSize: 56.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              icon: Icon(
                                                Icons.sort_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                size: 24.0,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                                animationsMap['containerOnPageLoadAnimation']!),
                          ),
                          Builder(
                            builder: (context) {
                              if (!_model.isLoading) {
                                return Builder(
                                  builder: (context) {
                                    final promotedSliderList =
                                        _model.promotedListLocal.toList();

                                    return Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 150.0,
                                      child: CarouselSlider.builder(
                                        itemCount: promotedSliderList.length,
                                        itemBuilder: (context,
                                            promotedSliderListIndex, _) {
                                          final promotedSliderListItem =
                                              promotedSliderList[
                                                  promotedSliderListIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  FoodDetailsScreenWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'food': serializeParam(
                                                      promotedSliderListItem,
                                                      ParamType.Document,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    'food':
                                                        promotedSliderListItem,
                                                  },
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: CachedNetworkImage(
                                                  fadeInDuration:
                                                      Duration(milliseconds: 0),
                                                  fadeOutDuration:
                                                      Duration(milliseconds: 0),
                                                  imageUrl:
                                                      promotedSliderListItem
                                                          .bannerPictureUrl,
                                                  width: double.infinity,
                                                  height: 150.0,
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    'assets/images/error_image.png',
                                                    width: double.infinity,
                                                    height: 150.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        carouselController:
                                            _model.carouselController ??=
                                                CarouselSliderController(),
                                        options: CarouselOptions(
                                          initialPage: max(
                                              0,
                                              min(
                                                  1,
                                                  promotedSliderList.length -
                                                      1)),
                                          viewportFraction: 1.0,
                                          disableCenter: true,
                                          enlargeCenterPage: true,
                                          enlargeFactor: 0.25,
                                          enableInfiniteScroll: true,
                                          scrollDirection: Axis.horizontal,
                                          autoPlay: true,
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 800),
                                          autoPlayInterval: Duration(
                                              milliseconds: (800 + 4000)),
                                          autoPlayCurve: Curves.linear,
                                          pauseAutoPlayInFiniteScroll: true,
                                          onPageChanged: (index, _) => _model
                                              .carouselCurrentIndex = index,
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'carouselOnPageLoadAnimation']!);
                                  },
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 150.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 20.0),
                        child: wrapWithModel(
                          model: _model.choiceButtonsModel,
                          updateCallback: () => safeSetState(() {}),
                          child: ChoiceButtonsWidget(
                            choices: FFAppConstants.coffeeTypes,
                            initialValue:
                                FFAppConstants.coffeeTypes.firstOrNull!,
                            onSelect: (value) async {
                              if (value ==
                                  FFAppConstants.coffeeTypes.firstOrNull) {
                                _model.foodsListLocal = _model
                                    .getFoodsActioBlocResult!
                                    .toList()
                                    .cast<FoodsRecord>();
                                safeSetState(() {});
                              } else {
                                _model.foodsListLocal = _model
                                    .getFoodsActioBlocResult!
                                    .where((e) => e.type == value)
                                    .toList()
                                    .cast<FoodsRecord>();
                                safeSetState(() {});
                              }
                            },
                          ),
                        ).animateOnPageLoad(
                            animationsMap['choiceButtonsOnPageLoadAnimation']!),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [],
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      if (!_model.isLoading) {
                        return Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final gridViewFoodsList =
                                    _model.foodsListLocal.toList();
                                if (gridViewFoodsList.isEmpty) {
                                  return Container(
                                    width: 300.0,
                                    height: 300.0,
                                    child: NoFoodsWidget(),
                                  );
                                }

                                return GridView.builder(
                                  padding: EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    100.0,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio:
                                        (((MediaQuery.sizeOf(context).width -
                                                        50) /
                                                    2) +
                                                16) /
                                            (((MediaQuery.sizeOf(context)
                                                            .width -
                                                        50) /
                                                    2) +
                                                140),
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: gridViewFoodsList.length,
                                  itemBuilder:
                                      (context, gridViewFoodsListIndex) {
                                    final gridViewFoodsListItem =
                                        gridViewFoodsList[
                                            gridViewFoodsListIndex];
                                    return wrapWithModel(
                                      model: _model.itemCardHomeModels.getModel(
                                        gridViewFoodsListItem.reference.id,
                                        gridViewFoodsListIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: ItemCardHomeWidget(
                                        key: Key(
                                          'Key1je_${gridViewFoodsListItem.reference.id}',
                                        ),
                                        food: gridViewFoodsListItem,
                                        onTapAddToCart: (foodItem) async {
                                          var _shouldSetState = false;
                                          if (_model.cartItemsLocal
                                              .where((e) =>
                                                  e.foodRef ==
                                                  foodItem.reference)
                                              .toList()
                                              .isNotEmpty) {
                                            // cart item for food
                                            _model.outputCartItem =
                                                await action_blocks
                                                    .cartIItemForFood(
                                              context,
                                              cartItemsList:
                                                  _model.cartItemsLocal,
                                              food: gridViewFoodsListItem,
                                            );
                                            _shouldSetState = true;
                                            // update cart item
                                            await action_blocks
                                                .updateCartItemFirestore(
                                              context,
                                              cartItem: _model.outputCartItem,
                                              foodItem: gridViewFoodsListItem,
                                              points: 0,
                                            );
                                            // reloading cart data
                                            await _model
                                                .reloadDataFromCartQuery(
                                                    context);
                                            if (animationsMap[
                                                    'floatingActionButtonOnActionTriggerAnimation'] !=
                                                null) {
                                              await animationsMap[
                                                      'floatingActionButtonOnActionTriggerAnimation']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          } else {
                                            // create new cart item
                                            _model.createdCartItem =
                                                await action_blocks
                                                    .createCartItemFirestore(
                                              context,
                                              foodName:
                                                  gridViewFoodsListItem.name,
                                              userRef: currentUserReference,
                                              foodPicture: gridViewFoodsListItem
                                                  .pictureUrl,
                                              quantity: 1,
                                              price:
                                                  gridViewFoodsListItem.price,
                                              size: gridViewFoodsListItem
                                                  .sizes.firstOrNull,
                                              type: gridViewFoodsListItem.type,
                                              foodRef: gridViewFoodsListItem
                                                  .reference,
                                              redeemedPoints: 0,
                                            );
                                            _shouldSetState = true;
                                            // reloading cart data
                                            await _model
                                                .reloadDataFromCartQuery(
                                                    context);
                                            if (animationsMap[
                                                    'floatingActionButtonOnActionTriggerAnimation'] !=
                                                null) {
                                              await animationsMap[
                                                      'floatingActionButtonOnActionTriggerAnimation']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          }

                                          if (_shouldSetState)
                                            safeSetState(() {});
                                        },
                                      ),
                                    ).animateOnPageLoad(
                                      animationsMap[
                                          'itemCardHomeOnPageLoadAnimation']!,
                                      effects: [
                                        FadeEffect(
                                          curve: Curves.easeInOut,
                                          delay: valueOrDefault<double>(
                                            ((gridViewFoodsListIndex ~/ 2) *
                                                    50) +
                                                350,
                                            350.0,
                                          ).ms,
                                          duration: 1000.0.ms,
                                          begin: 0.0,
                                          end: 1.0,
                                        ),
                                        MoveEffect(
                                          curve: Curves.easeOut,
                                          delay: valueOrDefault<double>(
                                            ((gridViewFoodsListIndex ~/ 2) *
                                                    50) +
                                                350,
                                            350.0,
                                          ).ms,
                                          duration: 500.0.ms,
                                          begin: Offset(0.0, 40.0),
                                          end: Offset(0.0, 0.0),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 300.0,
                            height: 300.0,
                            decoration: BoxDecoration(),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              child: custom_widgets.Loader(
                                width: 40.0,
                                height: 40.0,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: wrapWithModel(
                        model: _model.bottomNavigationBarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: BottomNavigationBarWidget(
                          pageIndex: 0,
                          onTap: () async {
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              RewardsScreenWidget.routeName,
                              queryParameters: {
                                'rewardsData': serializeParam(
                                  _model.myRewardsDataLocal,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'rewardsData': _model.myRewardsDataLocal,
                                '__transition_info__': TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
