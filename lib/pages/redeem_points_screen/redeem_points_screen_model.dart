import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/item_redeem_list_widget.dart';
import '/components/no_reward_history_item_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'redeem_points_screen_widget.dart' show RedeemPointsScreenWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RedeemPointsScreenModel
    extends FlutterFlowModel<RedeemPointsScreenWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  bool isRedeeming = false;

  RewardDataRecord? rewardDataLocal;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in RedeemPointsScreen widget.
  List<FoodsRecord>? queryResultFoods;
  // Models for ItemRedeemList dynamic component.
  late FlutterFlowDynamicModels<ItemRedeemListModel> itemRedeemListModels;
  // Stores action output result for [Firestore Query - Query a collection] action in ItemRedeemList widget.
  List<CartItemsRecord>? queryResultCartItems;
  // Stores action output result for [Action Block - createCartItemFirestore] action in ItemRedeemList widget.
  CartItemsRecord? createdCartItem;
  // Stores action output result for [Backend Call - Read Document] action in ItemRedeemList widget.
  RewardDataRecord? refatchedRewardData;

  @override
  void initState(BuildContext context) {
    itemRedeemListModels =
        FlutterFlowDynamicModels(() => ItemRedeemListModel());
  }

  @override
  void dispose() {
    itemRedeemListModels.dispose();
  }
}
