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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_orders_screen_model.dart';
export 'my_orders_screen_model.dart';

class MyOrdersScreenWidget extends StatefulWidget {
  const MyOrdersScreenWidget({super.key});

  static String routeName = 'MyOrdersScreen';
  static String routePath = '/myOrdersScreen';

  @override
  State<MyOrdersScreenWidget> createState() => _MyOrdersScreenWidgetState();
}

class _MyOrdersScreenWidgetState extends State<MyOrdersScreenWidget>
    with TickerProviderStateMixin {
  late MyOrdersScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyOrdersScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.checkOrders(context);
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    animationsMap.addAll({
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'tabBarOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 100.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
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
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              if (!_model.isLoading) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 22.0,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 50.0, 0.0),
                              child: Text(
                                'My Orders',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sora',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ).animateOnPageLoad(
                          animationsMap['rowOnPageLoadAnimation']!),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(0.0, 0),
                            child: TabBar(
                              labelColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              unselectedLabelColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                              unselectedLabelStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                              indicatorColor:
                                  FlutterFlowTheme.of(context).primary,
                              tabs: [
                                Tab(
                                  text: 'Ongoing orders',
                                ),
                                Tab(
                                  text: 'Previous orders',
                                ),
                              ],
                              controller: _model.tabBarController,
                              onTap: (i) async {
                                [() async {}, () async {}][i]();
                              },
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _model.tabBarController,
                              children: [
                                Builder(
                                  builder: (context) {
                                    final listviewItems = _model.ordersList
                                        .where((e) =>
                                            (e.orderStatus ==
                                                OrderStatus.ordered) ||
                                            (e.orderStatus ==
                                                OrderStatus.outForDelivery) ||
                                            (e.orderStatus ==
                                                OrderStatus.replaceInProgress))
                                        .toList();
                                    if (listviewItems.isEmpty) {
                                      return NoOrdersItemWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        20.0,
                                        0,
                                        20.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewItems.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 0.0),
                                      itemBuilder:
                                          (context, listviewItemsIndex) {
                                        final listviewItemsItem =
                                            listviewItems[listviewItemsIndex];
                                        return wrapWithModel(
                                          model:
                                              _model.orderItemModels1.getModel(
                                            listviewItemsItem.reference.id,
                                            listviewItemsIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: OrderItemWidget(
                                            key: Key(
                                              'Key73m_${listviewItemsItem.reference.id}',
                                            ),
                                            orderItem: listviewItemsItem,
                                            onTap: (orderItem) async {
                                              context.pushNamed(
                                                OrderDetailScreenWidget
                                                    .routeName,
                                                queryParameters: {
                                                  'orderInfo': serializeParam(
                                                    orderItem,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'orderInfo': orderItem,
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                Builder(
                                  builder: (context) {
                                    final listviewItems = _model.ordersList
                                        .where((e) =>
                                            (e.orderStatus ==
                                                OrderStatus.delivered) ||
                                            (e.orderStatus ==
                                                OrderStatus.canceled) ||
                                            (e.orderStatus ==
                                                OrderStatus.replaced))
                                        .toList();
                                    if (listviewItems.isEmpty) {
                                      return NoOrdersItemWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        20.0,
                                        0,
                                        20.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewItems.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 0.0),
                                      itemBuilder:
                                          (context, listviewItemsIndex) {
                                        final listviewItemsItem =
                                            listviewItems[listviewItemsIndex];
                                        return wrapWithModel(
                                          model:
                                              _model.orderItemModels2.getModel(
                                            listviewItemsIndex.toString(),
                                            listviewItemsIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: OrderItemWidget(
                                            key: Key(
                                              'Keyb9l_${listviewItemsIndex.toString()}',
                                            ),
                                            orderItem: listviewItemsItem,
                                            onTap: (orderItem) async {
                                              context.pushNamed(
                                                OrderDetailScreenWidget
                                                    .routeName,
                                                queryParameters: {
                                                  'orderInfo': serializeParam(
                                                    orderItem,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'orderInfo': orderItem,
                                                },
                                              );

                                              _model.isLoading = true;
                                              safeSetState(() {});
                                              await _model.checkOrders(context);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).animateOnPageLoad(
                          animationsMap['tabBarOnPageLoadAnimation']!),
                    ),
                  ],
                );
              } else {
                return Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    child: custom_widgets.Loader(
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
