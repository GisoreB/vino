// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RewardHistoryStruct extends FFFirebaseStruct {
  RewardHistoryStruct({
    String? title,
    int? points,
    DateTime? date,
    DocumentReference? orderId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _points = points,
        _date = date,
        _orderId = orderId,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "points" field.
  int? _points;
  int get points => _points ?? 0;
  set points(int? val) => _points = val;

  void incrementPoints(int amount) => points = points + amount;

  bool hasPoints() => _points != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "orderId" field.
  DocumentReference? _orderId;
  DocumentReference? get orderId => _orderId;
  set orderId(DocumentReference? val) => _orderId = val;

  bool hasOrderId() => _orderId != null;

  static RewardHistoryStruct fromMap(Map<String, dynamic> data) =>
      RewardHistoryStruct(
        title: data['title'] as String?,
        points: castToType<int>(data['points']),
        date: data['date'] as DateTime?,
        orderId: data['orderId'] as DocumentReference?,
      );

  static RewardHistoryStruct? maybeFromMap(dynamic data) => data is Map
      ? RewardHistoryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'points': _points,
        'date': _date,
        'orderId': _orderId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'points': serializeParam(
          _points,
          ParamType.int,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'orderId': serializeParam(
          _orderId,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static RewardHistoryStruct fromSerializableMap(Map<String, dynamic> data) =>
      RewardHistoryStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        points: deserializeParam(
          data['points'],
          ParamType.int,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        orderId: deserializeParam(
          data['orderId'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['orders'],
        ),
      );

  @override
  String toString() => 'RewardHistoryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RewardHistoryStruct &&
        title == other.title &&
        points == other.points &&
        date == other.date &&
        orderId == other.orderId;
  }

  @override
  int get hashCode => const ListEquality().hash([title, points, date, orderId]);
}

RewardHistoryStruct createRewardHistoryStruct({
  String? title,
  int? points,
  DateTime? date,
  DocumentReference? orderId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RewardHistoryStruct(
      title: title,
      points: points,
      date: date,
      orderId: orderId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RewardHistoryStruct? updateRewardHistoryStruct(
  RewardHistoryStruct? rewardHistory, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    rewardHistory
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRewardHistoryStructData(
  Map<String, dynamic> firestoreData,
  RewardHistoryStruct? rewardHistory,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (rewardHistory == null) {
    return;
  }
  if (rewardHistory.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && rewardHistory.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final rewardHistoryData =
      getRewardHistoryFirestoreData(rewardHistory, forFieldValue);
  final nestedData =
      rewardHistoryData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = rewardHistory.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRewardHistoryFirestoreData(
  RewardHistoryStruct? rewardHistory, [
  bool forFieldValue = false,
]) {
  if (rewardHistory == null) {
    return {};
  }
  final firestoreData = mapToFirestore(rewardHistory.toMap());

  // Add any Firestore field values
  mapToFirestore(rewardHistory.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRewardHistoryListFirestoreData(
  List<RewardHistoryStruct>? rewardHistorys,
) =>
    rewardHistorys
        ?.map((e) => getRewardHistoryFirestoreData(e, true))
        .toList() ??
    [];
