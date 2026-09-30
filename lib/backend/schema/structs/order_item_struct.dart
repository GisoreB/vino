// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderItemStruct extends FFFirebaseStruct {
  OrderItemStruct({
    double? price,
    int? quantity,
    String? foodName,
    String? foodPictureUrl,
    String? size,
    String? type,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _price = price,
        _quantity = quantity,
        _foodName = foodName,
        _foodPictureUrl = foodPictureUrl,
        _size = size,
        _type = type,
        super(firestoreUtilData);

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "foodName" field.
  String? _foodName;
  String get foodName => _foodName ?? '';
  set foodName(String? val) => _foodName = val;

  bool hasFoodName() => _foodName != null;

  // "foodPictureUrl" field.
  String? _foodPictureUrl;
  String get foodPictureUrl => _foodPictureUrl ?? '';
  set foodPictureUrl(String? val) => _foodPictureUrl = val;

  bool hasFoodPictureUrl() => _foodPictureUrl != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  set size(String? val) => _size = val;

  bool hasSize() => _size != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  static OrderItemStruct fromMap(Map<String, dynamic> data) => OrderItemStruct(
        price: castToType<double>(data['price']),
        quantity: castToType<int>(data['quantity']),
        foodName: data['foodName'] as String?,
        foodPictureUrl: data['foodPictureUrl'] as String?,
        size: data['size'] as String?,
        type: data['type'] as String?,
      );

  static OrderItemStruct? maybeFromMap(dynamic data) => data is Map
      ? OrderItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'price': _price,
        'quantity': _quantity,
        'foodName': _foodName,
        'foodPictureUrl': _foodPictureUrl,
        'size': _size,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'foodName': serializeParam(
          _foodName,
          ParamType.String,
        ),
        'foodPictureUrl': serializeParam(
          _foodPictureUrl,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
      }.withoutNulls;

  static OrderItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      OrderItemStruct(
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        foodName: deserializeParam(
          data['foodName'],
          ParamType.String,
          false,
        ),
        foodPictureUrl: deserializeParam(
          data['foodPictureUrl'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OrderItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OrderItemStruct &&
        price == other.price &&
        quantity == other.quantity &&
        foodName == other.foodName &&
        foodPictureUrl == other.foodPictureUrl &&
        size == other.size &&
        type == other.type;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([price, quantity, foodName, foodPictureUrl, size, type]);
}

OrderItemStruct createOrderItemStruct({
  double? price,
  int? quantity,
  String? foodName,
  String? foodPictureUrl,
  String? size,
  String? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OrderItemStruct(
      price: price,
      quantity: quantity,
      foodName: foodName,
      foodPictureUrl: foodPictureUrl,
      size: size,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OrderItemStruct? updateOrderItemStruct(
  OrderItemStruct? orderItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    orderItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOrderItemStructData(
  Map<String, dynamic> firestoreData,
  OrderItemStruct? orderItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (orderItem == null) {
    return;
  }
  if (orderItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && orderItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final orderItemData = getOrderItemFirestoreData(orderItem, forFieldValue);
  final nestedData = orderItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = orderItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOrderItemFirestoreData(
  OrderItemStruct? orderItem, [
  bool forFieldValue = false,
]) {
  if (orderItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(orderItem.toMap());

  // Add any Firestore field values
  mapToFirestore(orderItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOrderItemListFirestoreData(
  List<OrderItemStruct>? orderItems,
) =>
    orderItems?.map((e) => getOrderItemFirestoreData(e, true)).toList() ?? [];
