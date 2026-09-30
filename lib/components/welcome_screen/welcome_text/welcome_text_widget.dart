import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'welcome_text_model.dart';
export 'welcome_text_model.dart';

class WelcomeTextWidget extends StatefulWidget {
  const WelcomeTextWidget({
    super.key,
    required this.welcomeMessage,
  });

  final String? welcomeMessage;

  @override
  State<WelcomeTextWidget> createState() => _WelcomeTextWidgetState();
}

class _WelcomeTextWidgetState extends State<WelcomeTextWidget> {
  late WelcomeTextModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WelcomeTextModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
      child: Container(
        width: 240.0,
        decoration: BoxDecoration(),
        child: Text(
          valueOrDefault<String>(
            widget!.welcomeMessage,
            'Sip. Savor. Celebrate.',
          ),
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Poppins',
                fontSize: 28.0,
                letterSpacing: 0.0,
              ),
        ),
      ),
    );
  }
}
