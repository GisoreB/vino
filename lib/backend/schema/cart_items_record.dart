import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CartItemsRecord extends FirestoreRecord {
  CartItemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "pictureUrl" field.
  String? _pictureUrl;
  String get pictureUrl => _pictureUrl ?? '';
  bool hasPictureUrl() => _pictureUrl != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  bool hasSize() => _size != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "foodRef" field.
  DocumentReference? _foodRef;
  DocumentReference? get foodRef => _foodRef;
  bool hasFoodRef() => _foodRef != null;

  // "userId" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "consumedPoints" field.
  int? _consumedPoints;
  int get consumedPoints => _consumedPoints ?? 0;
  bool hasConsumedPoints() => _consumedPoints != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _pictureUrl = snapshotData['pictureUrl'] as String?;
    _type = snapshotData['type'] as String?;
    _size = snapshotData['size'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _quantity = castToType<int>(snapshotData['quantity']);
    _foodRef = snapshotData['foodRef'] as DocumentReference?;
    _userId = snapshotData['userId'] as DocumentReference?;
    _consumedPoints = castToType<int>(snapshotData['consumedPoints']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cartItems');

  static Stream<CartItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CartItemsRecord.fromSnapshot(s));

  static Future<CartItemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CartItemsRecord.fromSnapshot(s));

  static CartItemsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CartItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CartItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CartItemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CartItemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CartItemsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCartItemsRecordData({
  String? name,
  String? pictureUrl,
  String? type,
  String? size,
  double? price,
  int? quantity,
  DocumentReference? foodRef,
  DocumentReference? userId,
  int? consumedPoints,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'pictureUrl': pictureUrl,
      'type': type,
      'size': size,
      'price': price,
      'quantity': quantity,
      'foodRef': foodRef,
      'userId': userId,
      'consumedPoints': consumedPoints,
    }.withoutNulls,
  );

  return firestoreData;
}

class CartItemsRecordDocumentEquality implements Equality<CartItemsRecord> {
  const CartItemsRecordDocumentEquality();

  @override
  bool equals(CartItemsRecord? e1, CartItemsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.pictureUrl == e2?.pictureUrl &&
        e1?.type == e2?.type &&
        e1?.size == e2?.size &&
        e1?.price == e2?.price &&
        e1?.quantity == e2?.quantity &&
        e1?.foodRef == e2?.foodRef &&
        e1?.userId == e2?.userId &&
        e1?.consumedPoints == e2?.consumedPoints;
  }

  @override
  int hash(CartItemsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.pictureUrl,
        e?.type,
        e?.size,
        e?.price,
        e?.quantity,
        e?.foodRef,
        e?.userId,
        e?.consumedPoints
      ]);

  @override
  bool isValidKey(Object? o) => o is CartItemsRecord;
}
