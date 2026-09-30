import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '/components/no_reward_history_item_widget.dart';
import '/components/rewards_screen/item_rewards_history/item_rewards_history_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'rewards_screen_widget.dart' show RewardsScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RewardsScreenModel extends FlutterFlowModel<RewardsScreenWidget> {
  ///  Local state fields for this page.

  int loyaltyCardsCount = 4;

  RewardDataRecord? rewardsDataLocal;

  bool isLoading = false;

  ///  State fields for stateful widgets in this page.

  // Models for ItemRewardsHistory dynamic component.
  late FlutterFlowDynamicModels<ItemRewardsHistoryModel>
      itemRewardsHistoryModels;
  // Model for BottomNavigationBar component.
  late BottomNavigationBarModel bottomNavigationBarModel;

  @override
  void initState(BuildContext context) {
    itemRewardsHistoryModels =
        FlutterFlowDynamicModels(() => ItemRewardsHistoryModel());
    bottomNavigationBarModel =
        createModel(context, () => BottomNavigationBarModel());
  }

  @override
  void dispose() {
    itemRewardsHistoryModels.dispose();
    bottomNavigationBarModel.dispose();
  }
}
