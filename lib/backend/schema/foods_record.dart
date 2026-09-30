import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FoodsRecord extends FirestoreRecord {
  FoodsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "pictureUrl" field.
  String? _pictureUrl;
  String get pictureUrl => _pictureUrl ?? '';
  bool hasPictureUrl() => _pictureUrl != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "reviews" field.
  int? _reviews;
  int get reviews => _reviews ?? 0;
  bool hasReviews() => _reviews != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "sizes" field.
  List<String>? _sizes;
  List<String> get sizes => _sizes ?? const [];
  bool hasSizes() => _sizes != null;

  // "isPromoted" field.
  bool? _isPromoted;
  bool get isPromoted => _isPromoted ?? false;
  bool hasIsPromoted() => _isPromoted != null;

  // "bannerPictureUrl" field.
  String? _bannerPictureUrl;
  String get bannerPictureUrl => _bannerPictureUrl ?? '';
  bool hasBannerPictureUrl() => _bannerPictureUrl != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _type = snapshotData['type'] as String?;
    _pictureUrl = snapshotData['pictureUrl'] as String?;
    _rating = castToType<double>(snapshotData['rating']);
    _reviews = castToType<int>(snapshotData['reviews']);
    _price = castToType<double>(snapshotData['price']);
    _sizes = getDataList(snapshotData['sizes']);
    _isPromoted = snapshotData['isPromoted'] as bool?;
    _bannerPictureUrl = snapshotData['bannerPictureUrl'] as String?;
    _description = snapshotData['description'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('foods');

  static Stream<FoodsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FoodsRecord.fromSnapshot(s));

  static Future<FoodsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FoodsRecord.fromSnapshot(s));

  static FoodsRecord fromSnapshot(DocumentSnapshot snapshot) => FoodsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FoodsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FoodsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FoodsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FoodsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFoodsRecordData({
  String? name,
  String? type,
  String? pictureUrl,
  double? rating,
  int? reviews,
  double? price,
  bool? isPromoted,
  String? bannerPictureUrl,
  String? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'type': type,
      'pictureUrl': pictureUrl,
      'rating': rating,
      'reviews': reviews,
      'price': price,
      'isPromoted': isPromoted,
      'bannerPictureUrl': bannerPictureUrl,
      'description': description,
    }.withoutNulls,
  );

  return firestoreData;
}

class FoodsRecordDocumentEquality implements Equality<FoodsRecord> {
  const FoodsRecordDocumentEquality();

  @override
  bool equals(FoodsRecord? e1, FoodsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.type == e2?.type &&
        e1?.pictureUrl == e2?.pictureUrl &&
        e1?.rating == e2?.rating &&
        e1?.reviews == e2?.reviews &&
        e1?.price == e2?.price &&
        listEquality.equals(e1?.sizes, e2?.sizes) &&
        e1?.isPromoted == e2?.isPromoted &&
        e1?.bannerPictureUrl == e2?.bannerPictureUrl &&
        e1?.description == e2?.description;
  }

  @override
  int hash(FoodsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.type,
        e?.pictureUrl,
        e?.rating,
        e?.reviews,
        e?.price,
        e?.sizes,
        e?.isPromoted,
        e?.bannerPictureUrl,
        e?.description
      ]);

  @override
  bool isValidKey(Object? o) => o is FoodsRecord;
}
