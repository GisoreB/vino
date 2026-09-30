// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentMethodStruct extends FFFirebaseStruct {
  PaymentMethodStruct({
    String? cardHolderName,
    String? cardNumber,
    CardType? cardType,
    String? bankName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _cardHolderName = cardHolderName,
        _cardNumber = cardNumber,
        _cardType = cardType,
        _bankName = bankName,
        super(firestoreUtilData);

  // "cardHolderName" field.
  String? _cardHolderName;
  String get cardHolderName => _cardHolderName ?? '';
  set cardHolderName(String? val) => _cardHolderName = val;

  bool hasCardHolderName() => _cardHolderName != null;

  // "cardNumber" field.
  String? _cardNumber;
  String get cardNumber => _cardNumber ?? '';
  set cardNumber(String? val) => _cardNumber = val;

  bool hasCardNumber() => _cardNumber != null;

  // "cardType" field.
  CardType? _cardType;
  CardType get cardType => _cardType ?? CardType.visa;
  set cardType(CardType? val) => _cardType = val;

  bool hasCardType() => _cardType != null;

  // "bankName" field.
  String? _bankName;
  String get bankName => _bankName ?? '';
  set bankName(String? val) => _bankName = val;

  bool hasBankName() => _bankName != null;

  static PaymentMethodStruct fromMap(Map<String, dynamic> data) =>
      PaymentMethodStruct(
        cardHolderName: data['cardHolderName'] as String?,
        cardNumber: data['cardNumber'] as String?,
        cardType: data['cardType'] is CardType
            ? data['cardType']
            : deserializeEnum<CardType>(data['cardType']),
        bankName: data['bankName'] as String?,
      );

  static PaymentMethodStruct? maybeFromMap(dynamic data) => data is Map
      ? PaymentMethodStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'cardHolderName': _cardHolderName,
        'cardNumber': _cardNumber,
        'cardType': _cardType?.serialize(),
        'bankName': _bankName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'cardHolderName': serializeParam(
          _cardHolderName,
          ParamType.String,
        ),
        'cardNumber': serializeParam(
          _cardNumber,
          ParamType.String,
        ),
        'cardType': serializeParam(
          _cardType,
          ParamType.Enum,
        ),
        'bankName': serializeParam(
          _bankName,
          ParamType.String,
        ),
      }.withoutNulls;

  static PaymentMethodStruct fromSerializableMap(Map<String, dynamic> data) =>
      PaymentMethodStruct(
        cardHolderName: deserializeParam(
          data['cardHolderName'],
          ParamType.String,
          false,
        ),
        cardNumber: deserializeParam(
          data['cardNumber'],
          ParamType.String,
          false,
        ),
        cardType: deserializeParam<CardType>(
          data['cardType'],
          ParamType.Enum,
          false,
        ),
        bankName: deserializeParam(
          data['bankName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PaymentMethodStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PaymentMethodStruct &&
        cardHolderName == other.cardHolderName &&
        cardNumber == other.cardNumber &&
        cardType == other.cardType &&
        bankName == other.bankName;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([cardHolderName, cardNumber, cardType, bankName]);
}

PaymentMethodStruct createPaymentMethodStruct({
  String? cardHolderName,
  String? cardNumber,
  CardType? cardType,
  String? bankName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PaymentMethodStruct(
      cardHolderName: cardHolderName,
      cardNumber: cardNumber,
      cardType: cardType,
      bankName: bankName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PaymentMethodStruct? updatePaymentMethodStruct(
  PaymentMethodStruct? paymentMethod, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    paymentMethod
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPaymentMethodStructData(
  Map<String, dynamic> firestoreData,
  PaymentMethodStruct? paymentMethod,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (paymentMethod == null) {
    return;
  }
  if (paymentMethod.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && paymentMethod.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final paymentMethodData =
      getPaymentMethodFirestoreData(paymentMethod, forFieldValue);
  final nestedData =
      paymentMethodData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = paymentMethod.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPaymentMethodFirestoreData(
  PaymentMethodStruct? paymentMethod, [
  bool forFieldValue = false,
]) {
  if (paymentMethod == null) {
    return {};
  }
  final firestoreData = mapToFirestore(paymentMethod.toMap());

  // Add any Firestore field values
  mapToFirestore(paymentMethod.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPaymentMethodListFirestoreData(
  List<PaymentMethodStruct>? paymentMethods,
) =>
    paymentMethods
        ?.map((e) => getPaymentMethodFirestoreData(e, true))
        .toList() ??
    [];
