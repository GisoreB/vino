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
import 'home_page_widget.dart' show HomePageWidget;
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

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  List<CartItemsRecord> cartItemsLocal = [];
  void addToCartItemsLocal(CartItemsRecord item) => cartItemsLocal.add(item);
  void removeFromCartItemsLocal(CartItemsRecord item) =>
      cartItemsLocal.remove(item);
  void removeAtIndexFromCartItemsLocal(int index) =>
      cartItemsLocal.removeAt(index);
  void insertAtIndexInCartItemsLocal(int index, CartItemsRecord item) =>
      cartItemsLocal.insert(index, item);
  void updateCartItemsLocalAtIndex(
          int index, Function(CartItemsRecord) updateFn) =>
      cartItemsLocal[index] = updateFn(cartItemsLocal[index]);

  RewardDataRecord? myRewardsDataLocal;

  bool isLoading = true;

  List<FoodsRecord> foodsListLocal = [];
  void addToFoodsListLocal(FoodsRecord item) => foodsListLocal.add(item);
  void removeFromFoodsListLocal(FoodsRecord item) =>
      foodsListLocal.remove(item);
  void removeAtIndexFromFoodsListLocal(int index) =>
      foodsListLocal.removeAt(index);
  void insertAtIndexInFoodsListLocal(int index, FoodsRecord item) =>
      foodsListLocal.insert(index, item);
  void updateFoodsListLocalAtIndex(int index, Function(FoodsRecord) updateFn) =>
      foodsListLocal[index] = updateFn(foodsListLocal[index]);

  List<FoodsRecord> promotedListLocal = [];
  void addToPromotedListLocal(FoodsRecord item) => promotedListLocal.add(item);
  void removeFromPromotedListLocal(FoodsRecord item) =>
      promotedListLocal.remove(item);
  void removeAtIndexFromPromotedListLocal(int index) =>
      promotedListLocal.removeAt(index);
  void insertAtIndexInPromotedListLocal(int index, FoodsRecord item) =>
      promotedListLocal.insert(index, item);
  void updatePromotedListLocalAtIndex(
          int index, Function(FoodsRecord) updateFn) =>
      promotedListLocal[index] = updateFn(promotedListLocal[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  List<CartItemsRecord>? cartQueryResult;
  // Stores action output result for [Action Block - getFoodsQuery] action in HomePage widget.
  List<FoodsRecord>? getFoodsActioBlocResult;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  RewardDataRecord? queryRewardData;
  // Stores action output result for [Backend Call - Create Document] action in HomePage widget.
  RewardDataRecord? createdRewardData;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for Searchbar widget.
  FocusNode? searchbarFocusNode;
  TextEditingController? searchbarTextController;
  String? Function(BuildContext, String?)? searchbarTextControllerValidator;
  // Stores action output result for [Action Block - getFoodsQuery] action in Searchbar widget.
  List<FoodsRecord>? searchFoodQueryResult;
  // Stores action output result for [Action Block - getFoodsQuery] action in IconButton widget.
  List<FoodsRecord>? allFoodQueryResult;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // Model for ChoiceButtons component.
  late ChoiceButtonsModel choiceButtonsModel;
  // Models for ItemCardHome dynamic component.
  late FlutterFlowDynamicModels<ItemCardHomeModel> itemCardHomeModels;
  // Stores action output result for [Action Block - cartIItemForFood] action in ItemCardHome widget.
  CartItemsRecord? outputCartItem;
  // Stores action output result for [Action Block - createCartItemFirestore] action in ItemCardHome widget.
  CartItemsRecord? createdCartItem;
  // Model for BottomNavigationBar component.
  late BottomNavigationBarModel bottomNavigationBarModel;

  @override
  void initState(BuildContext context) {
    choiceButtonsModel = createModel(context, () => ChoiceButtonsModel());
    itemCardHomeModels = FlutterFlowDynamicModels(() => ItemCardHomeModel());
    bottomNavigationBarModel =
        createModel(context, () => BottomNavigationBarModel());
  }

  @override
  void dispose() {
    searchbarFocusNode?.dispose();
    searchbarTextController?.dispose();

    choiceButtonsModel.dispose();
    itemCardHomeModels.dispose();
    bottomNavigationBarModel.dispose();
  }

  /// Action blocks.
  Future reloadDataFromCartQuery(BuildContext context) async {
    List<CartItemsRecord>? newCartQuery;

    // Requery for new cart data
    newCartQuery = await queryCartItemsRecordOnce(
      queryBuilder: (cartItemsRecord) => cartItemsRecord.where(
        'userId',
        isEqualTo: currentUserReference,
      ),
    );
    // assign cartdata to local
    cartItemsLocal = newCartQuery!.toList().cast<CartItemsRecord>();
  }

  Future<List<FoodsRecord>?> getFoodsQuery(
    BuildContext context, {
    String? text,
  }) async {
    List<FoodsRecord>? searchFoodQueryResult;
    List<FoodsRecord>? nonSearchFoodQueryResult;

    if (text != null && text != '') {
      // search foods query
      searchFoodQueryResult = await queryFoodsRecordOnce(
        queryBuilder: (foodsRecord) => foodsRecord.where(
          'name',
          isEqualTo: text,
        ),
      );
    } else {
      // non-search foods query
      nonSearchFoodQueryResult = await queryFoodsRecordOnce();
      return nonSearchFoodQueryResult;
    }

    return searchFoodQueryResult;
  }
}
