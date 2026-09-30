import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RewardDataRecord extends FirestoreRecord {
  RewardDataRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "availablePoints" field.
  int? _availablePoints;
  int get availablePoints => _availablePoints ?? 0;
  bool hasAvailablePoints() => _availablePoints != null;

  // "history" field.
  List<RewardHistoryStruct>? _history;
  List<RewardHistoryStruct> get history => _history ?? const [];
  bool hasHistory() => _history != null;

  // "loyaltyLevel" field.
  int? _loyaltyLevel;
  int get loyaltyLevel => _loyaltyLevel ?? 0;
  bool hasLoyaltyLevel() => _loyaltyLevel != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as DocumentReference?;
    _availablePoints = castToType<int>(snapshotData['availablePoints']);
    _history = getStructList(
      snapshotData['history'],
      RewardHistoryStruct.fromMap,
    );
    _loyaltyLevel = castToType<int>(snapshotData['loyaltyLevel']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rewardData');

  static Stream<RewardDataRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RewardDataRecord.fromSnapshot(s));

  static Future<RewardDataRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RewardDataRecord.fromSnapshot(s));

  static RewardDataRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RewardDataRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RewardDataRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RewardDataRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RewardDataRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RewardDataRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRewardDataRecordData({
  DocumentReference? userId,
  int? availablePoints,
  int? loyaltyLevel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'availablePoints': availablePoints,
      'loyaltyLevel': loyaltyLevel,
    }.withoutNulls,
  );

  return firestoreData;
}

class RewardDataRecordDocumentEquality implements Equality<RewardDataRecord> {
  const RewardDataRecordDocumentEquality();

  @override
  bool equals(RewardDataRecord? e1, RewardDataRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userId == e2?.userId &&
        e1?.availablePoints == e2?.availablePoints &&
        listEquality.equals(e1?.history, e2?.history) &&
        e1?.loyaltyLevel == e2?.loyaltyLevel;
  }

  @override
  int hash(RewardDataRecord? e) => const ListEquality()
      .hash([e?.userId, e?.availablePoints, e?.history, e?.loyaltyLevel]);

  @override
  bool isValidKey(Object? o) => o is RewardDataRecord;
}
