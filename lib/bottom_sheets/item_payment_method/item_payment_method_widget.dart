import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'item_payment_method_model.dart';
export 'item_payment_method_model.dart';

class ItemPaymentMethodWidget extends StatefulWidget {
  const ItemPaymentMethodWidget({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentMethodStruct? paymentMethod;
  final bool? isSelected;
  final Future Function(String cardNumber)? onTap;

  @override
  State<ItemPaymentMethodWidget> createState() =>
      _ItemPaymentMethodWidgetState();
}

class _ItemPaymentMethodWidgetState extends State<ItemPaymentMethodWidget> {
  late ItemPaymentMethodModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ItemPaymentMethodModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (!widget!.isSelected!) {
          await widget.onTap?.call(
            widget!.paymentMethod!.cardNumber,
          );
          return;
        } else {
          return;
        }
      },
      child: Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: widget!.isSelected!
                ? FlutterFlowTheme.of(context).primary
                : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Builder(
                builder: (context) {
                  if (widget!.isSelected ?? false) {
                    return Icon(
                      Icons.radio_button_checked,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    );
                  } else {
                    return Icon(
                      Icons.radio_button_off,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    );
                  }
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget!.paymentMethod?.bankName,
                          'N/A',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget!.paymentMethod?.cardNumber,
                            'N/A',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).disabledText,
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 500),
                  fadeOutDuration: Duration(milliseconds: 500),
                  imageUrl: (String cardType) {
                    return cardType == 'visa';
                  }(widget!.paymentMethod!.cardType.name)
                      ? 'https://cdn.visa.com/v2/assets/images/logos/visa/blue/logo.png'
                      : 'https://www.mastercard.com/content/dam/public/mastercardcom/in/en/logos/mastercard-og-image.png',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
