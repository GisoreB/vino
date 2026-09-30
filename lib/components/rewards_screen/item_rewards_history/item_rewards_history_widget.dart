import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'item_rewards_history_model.dart';
export 'item_rewards_history_model.dart';

class ItemRewardsHistoryWidget extends StatefulWidget {
  const ItemRewardsHistoryWidget({
    super.key,
    required this.points,
    required this.date,
    required this.title,
    required this.isPositive,
  });

  final int? points;
  final DateTime? date;
  final String? title;
  final bool? isPositive;

  @override
  State<ItemRewardsHistoryWidget> createState() =>
      _ItemRewardsHistoryWidgetState();
}

class _ItemRewardsHistoryWidgetState extends State<ItemRewardsHistoryWidget> {
  late ItemRewardsHistoryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ItemRewardsHistoryModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.title,
                      'N/A',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.1,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      dateTimeFormat("d MMM | HH:mm", widget!.date),
                      'N/A',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).disabledText,
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
            ),
            Text(
              '${widget!.isPositive! ? '+' : ''}${widget!.points?.toString()} Pts',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Roboto Mono',
                    color: widget!.isPositive!
                        ? FlutterFlowTheme.of(context).success
                        : FlutterFlowTheme.of(context).error,
                    fontSize: 15.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        Divider(
          height: 0.5,
          thickness: 0.5,
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
