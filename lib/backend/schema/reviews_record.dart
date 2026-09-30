import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReviewsRecord extends FirestoreRecord {
  ReviewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "review" field.
  String? _review;
  String get review => _review ?? '';
  bool hasReview() => _review != null;

  // "reviewerId" field.
  DocumentReference? _reviewerId;
  DocumentReference? get reviewerId => _reviewerId;
  bool hasReviewerId() => _reviewerId != null;

  // "foodId" field.
  DocumentReference? _foodId;
  DocumentReference? get foodId => _foodId;
  bool hasFoodId() => _foodId != null;

  // "reviewerPictureUrl" field.
  String? _reviewerPictureUrl;
  String get reviewerPictureUrl => _reviewerPictureUrl ?? '';
  bool hasReviewerPictureUrl() => _reviewerPictureUrl != null;

  // "reviewTime" field.
  DateTime? _reviewTime;
  DateTime? get reviewTime => _reviewTime;
  bool hasReviewTime() => _reviewTime != null;

  void _initializeFields() {
    _rating = castToType<double>(snapshotData['rating']);
    _review = snapshotData['review'] as String?;
    _reviewerId = snapshotData['reviewerId'] as DocumentReference?;
    _foodId = snapshotData['foodId'] as DocumentReference?;
    _reviewerPictureUrl = snapshotData['reviewerPictureUrl'] as String?;
    _reviewTime = snapshotData['reviewTime'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reviews');

  static Stream<ReviewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReviewsRecord.fromSnapshot(s));

  static Future<ReviewsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReviewsRecord.fromSnapshot(s));

  static ReviewsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReviewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReviewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReviewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReviewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReviewsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReviewsRecordData({
  double? rating,
  String? review,
  DocumentReference? reviewerId,
  DocumentReference? foodId,
  String? reviewerPictureUrl,
  DateTime? reviewTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'rating': rating,
      'review': review,
      'reviewerId': reviewerId,
      'foodId': foodId,
      'reviewerPictureUrl': reviewerPictureUrl,
      'reviewTime': reviewTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReviewsRecordDocumentEquality implements Equality<ReviewsRecord> {
  const ReviewsRecordDocumentEquality();

  @override
  bool equals(ReviewsRecord? e1, ReviewsRecord? e2) {
    return e1?.rating == e2?.rating &&
        e1?.review == e2?.review &&
        e1?.reviewerId == e2?.reviewerId &&
        e1?.foodId == e2?.foodId &&
        e1?.reviewerPictureUrl == e2?.reviewerPictureUrl &&
        e1?.reviewTime == e2?.reviewTime;
  }

  @override
  int hash(ReviewsRecord? e) => const ListEquality().hash([
        e?.rating,
        e?.review,
        e?.reviewerId,
        e?.foodId,
        e?.reviewerPictureUrl,
        e?.reviewTime
      ]);

  @override
  bool isValidKey(Object? o) => o is ReviewsRecord;
}
