import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'choice_buttons_model.dart';
export 'choice_buttons_model.dart';

class ChoiceButtonsWidget extends StatefulWidget {
  const ChoiceButtonsWidget({
    super.key,
    required this.choices,
    required this.onSelect,
    required this.initialValue,
  });

  final List<String>? choices;
  final Future Function(String value)? onSelect;
  final String? initialValue;

  @override
  State<ChoiceButtonsWidget> createState() => _ChoiceButtonsWidgetState();
}

class _ChoiceButtonsWidgetState extends State<ChoiceButtonsWidget> {
  late ChoiceButtonsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChoiceButtonsModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.selectedChip = widget!.initialValue;
      safeSetState(() {});
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
    return Builder(
      builder: (context) {
        final optionsList = widget!.choices!.toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(optionsList.length, (optionsListIndex) {
              final optionsListItem = optionsList[optionsListIndex];
              return InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  _model.selectedChip = optionsListItem;
                  safeSetState(() {});
                  await widget.onSelect?.call(
                    optionsListItem,
                  );
                },
                child: Container(
                  height: 35.0,
                  constraints: BoxConstraints(
                    minWidth: 80.0,
                  ),
                  decoration: BoxDecoration(
                    color: _model.selectedChip == optionsListItem
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 5.0, 8.0, 5.0),
                    child: Text(
                      optionsListItem,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: _model.selectedChip == optionsListItem
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : FlutterFlowTheme.of(context).primaryText,
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
              );
            })
                .divide(SizedBox(width: 8.0))
                .addToStart(SizedBox(width: 20.0))
                .addToEnd(SizedBox(width: 20.0)),
          ),
        );
      },
    );
  }
}
