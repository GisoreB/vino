import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrdersRecord extends FirestoreRecord {
  OrdersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "orderStatus" field.
  OrderStatus? _orderStatus;
  OrderStatus? get orderStatus => _orderStatus;
  bool hasOrderStatus() => _orderStatus != null;

  // "totalPrice" field.
  double? _totalPrice;
  double get totalPrice => _totalPrice ?? 0.0;
  bool hasTotalPrice() => _totalPrice != null;

  // "orderItems" field.
  List<OrderItemStruct>? _orderItems;
  List<OrderItemStruct> get orderItems => _orderItems ?? const [];
  bool hasOrderItems() => _orderItems != null;

  // "orderTime" field.
  DateTime? _orderTime;
  DateTime? get orderTime => _orderTime;
  bool hasOrderTime() => _orderTime != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "review" field.
  String? _review;
  String get review => _review ?? '';
  bool hasReview() => _review != null;

  // "paymentMethod" field.
  PaymentMethodStruct? _paymentMethod;
  PaymentMethodStruct get paymentMethod =>
      _paymentMethod ?? PaymentMethodStruct();
  bool hasPaymentMethod() => _paymentMethod != null;

  // "deliveryAddress" field.
  String? _deliveryAddress;
  String get deliveryAddress => _deliveryAddress ?? '';
  bool hasDeliveryAddress() => _deliveryAddress != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as DocumentReference?;
    _orderStatus = snapshotData['orderStatus'] is OrderStatus
        ? snapshotData['orderStatus']
        : deserializeEnum<OrderStatus>(snapshotData['orderStatus']);
    _totalPrice = castToType<double>(snapshotData['totalPrice']);
    _orderItems = getStructList(
      snapshotData['orderItems'],
      OrderItemStruct.fromMap,
    );
    _orderTime = snapshotData['orderTime'] as DateTime?;
    _rating = castToType<double>(snapshotData['rating']);
    _review = snapshotData['review'] as String?;
    _paymentMethod = snapshotData['paymentMethod'] is PaymentMethodStruct
        ? snapshotData['paymentMethod']
        : PaymentMethodStruct.maybeFromMap(snapshotData['paymentMethod']);
    _deliveryAddress = snapshotData['deliveryAddress'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrdersRecord.fromSnapshot(s));

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrdersRecord.fromSnapshot(s));

  static OrdersRecord fromSnapshot(DocumentSnapshot snapshot) => OrdersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrdersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrdersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrdersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrdersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrdersRecordData({
  DocumentReference? userId,
  OrderStatus? orderStatus,
  double? totalPrice,
  DateTime? orderTime,
  double? rating,
  String? review,
  PaymentMethodStruct? paymentMethod,
  String? deliveryAddress,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'orderStatus': orderStatus,
      'totalPrice': totalPrice,
      'orderTime': orderTime,
      'rating': rating,
      'review': review,
      'paymentMethod': PaymentMethodStruct().toMap(),
      'deliveryAddress': deliveryAddress,
    }.withoutNulls,
  );

  // Handle nested data for "paymentMethod" field.
  addPaymentMethodStructData(firestoreData, paymentMethod, 'paymentMethod');

  return firestoreData;
}

class OrdersRecordDocumentEquality implements Equality<OrdersRecord> {
  const OrdersRecordDocumentEquality();

  @override
  bool equals(OrdersRecord? e1, OrdersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userId == e2?.userId &&
        e1?.orderStatus == e2?.orderStatus &&
        e1?.totalPrice == e2?.totalPrice &&
        listEquality.equals(e1?.orderItems, e2?.orderItems) &&
        e1?.orderTime == e2?.orderTime &&
        e1?.rating == e2?.rating &&
        e1?.review == e2?.review &&
        e1?.paymentMethod == e2?.paymentMethod &&
        e1?.deliveryAddress == e2?.deliveryAddress;
  }

  @override
  int hash(OrdersRecord? e) => const ListEquality().hash([
        e?.userId,
        e?.orderStatus,
        e?.totalPrice,
        e?.orderItems,
        e?.orderTime,
        e?.rating,
        e?.review,
        e?.paymentMethod,
        e?.deliveryAddress
      ]);

  @override
  bool isValidKey(Object? o) => o is OrdersRecord;
}
