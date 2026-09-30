import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/profile_screen/profile_item/profile_item_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'profile_screen_widget.dart' show ProfileScreenWidget;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreenModel extends FlutterFlowModel<ProfileScreenWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  UsersRecord? profileData;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in ProfileScreen widget.
  UsersRecord? usrData;
  // Model for ProfileItem component.
  late ProfileItemModel profileItemModel1;
  // Model for ProfileItem component.
  late ProfileItemModel profileItemModel2;
  // Model for ProfileItem component.
  late ProfileItemModel profileItemModel3;
  // Model for ProfileItem component.
  late ProfileItemModel profileItemModel4;

  @override
  void initState(BuildContext context) {
    profileItemModel1 = createModel(context, () => ProfileItemModel());
    profileItemModel2 = createModel(context, () => ProfileItemModel());
    profileItemModel3 = createModel(context, () => ProfileItemModel());
    profileItemModel4 = createModel(context, () => ProfileItemModel());
  }

  @override
  void dispose() {
    profileItemModel1.dispose();
    profileItemModel2.dispose();
    profileItemModel3.dispose();
    profileItemModel4.dispose();
  }
}
