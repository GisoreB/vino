import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentDataRecord extends FirestoreRecord {
  PaymentDataRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "paymentMethods" field.
  List<PaymentMethodStruct>? _paymentMethods;
  List<PaymentMethodStruct> get paymentMethods => _paymentMethods ?? const [];
  bool hasPaymentMethods() => _paymentMethods != null;

  // "userId" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  void _initializeFields() {
    _paymentMethods = getStructList(
      snapshotData['paymentMethods'],
      PaymentMethodStruct.fromMap,
    );
    _userId = snapshotData['userId'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('paymentData');

  static Stream<PaymentDataRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PaymentDataRecord.fromSnapshot(s));

  static Future<PaymentDataRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PaymentDataRecord.fromSnapshot(s));

  static PaymentDataRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PaymentDataRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PaymentDataRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PaymentDataRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PaymentDataRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PaymentDataRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPaymentDataRecordData({
  DocumentReference? userId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
    }.withoutNulls,
  );

  return firestoreData;
}

class PaymentDataRecordDocumentEquality implements Equality<PaymentDataRecord> {
  const PaymentDataRecordDocumentEquality();

  @override
  bool equals(PaymentDataRecord? e1, PaymentDataRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.paymentMethods, e2?.paymentMethods) &&
        e1?.userId == e2?.userId;
  }

  @override
  int hash(PaymentDataRecord? e) =>
      const ListEquality().hash([e?.paymentMethods, e?.userId]);

  @override
  bool isValidKey(Object? o) => o is PaymentDataRecord;
}
