// To parse this JSON data, do
//
//     final nearPayModel = nearPayModelFromJson(jsonString);

import 'dart:convert';

NearPayModel nearPayModelFromJson(String str) => NearPayModel.fromJson(json.decode(str));

String nearPayModelToJson(NearPayModel data) => json.encode(data.toJson());

class NearPayModel {
    String? id;
    Merchant? merchant;
    CardScheme? cardScheme;
    String? cardSchemeSponsor;
    String? startDate;
    String? startTime;
    String? endDate;
    String? endTime;
    String? tid;
    String? systemTraceAuditNumber;
    String? posSoftwareVersionNumber;
    String? retrievalReferenceNumber;
    CardScheme? transactionType;
    bool? isApproved;
    bool? isRefunded;
    bool? isReversed;
    AmountAuthorized? approvalCode;
    String? actionCode;
    Currency? statusMessage;
    String? pan;
    String? cardExpiration;
    AmountAuthorized? amountAuthorized;
    AmountAuthorized? amountOther;
    Currency? currency;
    Currency? verificationMethod;
    Currency? receiptLineOne;
    Currency? receiptLineTwo;
    Currency? thanksMessage;
    Currency? saveReceiptMessage;
    String? entryMode;
    String? applicationIdentifier;
    String? terminalVerificationResult;
    String? transactionStateInformation;
    String? cardholaderVerficationResult;
    String? cryptogramInformationData;
    String? applicationCryptogram;
    String? kernelId;
    String? paymentAccountReference;
    String? panSuffix;
    String? qrCode;
    String? transactionUuid;

    NearPayModel({
        this.id,
        this.merchant,
        this.cardScheme,
        this.cardSchemeSponsor,
        this.startDate,
        this.startTime,
        this.endDate,
        this.endTime,
        this.tid,
        this.systemTraceAuditNumber,
        this.posSoftwareVersionNumber,
        this.retrievalReferenceNumber,
        this.transactionType,
        this.isApproved,
        this.isRefunded,
        this.isReversed,
        this.approvalCode,
        this.actionCode,
        this.statusMessage,
        this.pan,
        this.cardExpiration,
        this.amountAuthorized,
        this.amountOther,
        this.currency,
        this.verificationMethod,
        this.receiptLineOne,
        this.receiptLineTwo,
        this.thanksMessage,
        this.saveReceiptMessage,
        this.entryMode,
        this.applicationIdentifier,
        this.terminalVerificationResult,
        this.transactionStateInformation,
        this.cardholaderVerficationResult,
        this.cryptogramInformationData,
        this.applicationCryptogram,
        this.kernelId,
        this.paymentAccountReference,
        this.panSuffix,
        this.qrCode,
        this.transactionUuid,
    });

    factory NearPayModel.fromJson(Map<String, dynamic> json) => NearPayModel(
        id: json["id"],
        merchant: json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]),
        cardScheme: json["card_scheme"] == null ? null : CardScheme.fromJson(json["card_scheme"]),
        cardSchemeSponsor: json["card_scheme_sponsor"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        tid: json["tid"],
        systemTraceAuditNumber: json["system_trace_audit_number"],
        posSoftwareVersionNumber: json["pos_software_version_number"],
        retrievalReferenceNumber: json["retrieval_reference_number"],
        transactionType: json["transaction_type"] == null ? null : CardScheme.fromJson(json["transaction_type"]),
        isApproved: json["is_approved"],
        isRefunded: json["is_refunded"],
        isReversed: json["is_reversed"],
        approvalCode: json["approval_code"] == null ? null : AmountAuthorized.fromJson(json["approval_code"]),
        actionCode: json["action_code"],
        statusMessage: json["status_message"] == null ? null : Currency.fromJson(json["status_message"]),
        pan: json["pan"],
        cardExpiration: json["card_expiration"],
        amountAuthorized: json["amount_authorized"] == null ? null : AmountAuthorized.fromJson(json["amount_authorized"]),
        amountOther: json["amount_other"] == null ? null : AmountAuthorized.fromJson(json["amount_other"]),
        currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
        verificationMethod: json["verification_method"] == null ? null : Currency.fromJson(json["verification_method"]),
        receiptLineOne: json["receipt_line_one"] == null ? null : Currency.fromJson(json["receipt_line_one"]),
        receiptLineTwo: json["receipt_line_two"] == null ? null : Currency.fromJson(json["receipt_line_two"]),
        thanksMessage: json["thanks_message"] == null ? null : Currency.fromJson(json["thanks_message"]),
        saveReceiptMessage: json["save_receipt_message"] == null ? null : Currency.fromJson(json["save_receipt_message"]),
        entryMode: json["entry_mode"],
        applicationIdentifier: json["application_identifier"],
        terminalVerificationResult: json["terminal_verification_result"],
        transactionStateInformation: json["transaction_state_information"],
        cardholaderVerficationResult: json["cardholader_verfication_result"],
        cryptogramInformationData: json["cryptogram_information_data"],
        applicationCryptogram: json["application_cryptogram"],
        kernelId: json["kernel_id"],
        paymentAccountReference: json["payment_account_reference"],
        panSuffix: json["pan_suffix"],
        qrCode: json["qr_code"],
        transactionUuid: json["transaction_uuid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "merchant": merchant?.toJson(),
        "card_scheme": cardScheme?.toJson(),
        "card_scheme_sponsor": cardSchemeSponsor,
        "start_date": startDate,
        "start_time": startTime,
        "end_date": endDate,
        "end_time": endTime,
        "tid": tid,
        "system_trace_audit_number": systemTraceAuditNumber,
        "pos_software_version_number": posSoftwareVersionNumber,
        "retrieval_reference_number": retrievalReferenceNumber,
        "transaction_type": transactionType?.toJson(),
        "is_approved": isApproved,
        "is_refunded": isRefunded,
        "is_reversed": isReversed,
        "approval_code": approvalCode?.toJson(),
        "action_code": actionCode,
        "status_message": statusMessage?.toJson(),
        "pan": pan,
        "card_expiration": cardExpiration,
        "amount_authorized": amountAuthorized?.toJson(),
        "amount_other": amountOther?.toJson(),
        "currency": currency?.toJson(),
        "verification_method": verificationMethod?.toJson(),
        "receipt_line_one": receiptLineOne?.toJson(),
        "receipt_line_two": receiptLineTwo?.toJson(),
        "thanks_message": thanksMessage?.toJson(),
        "save_receipt_message": saveReceiptMessage?.toJson(),
        "entry_mode": entryMode,
        "application_identifier": applicationIdentifier,
        "terminal_verification_result": terminalVerificationResult,
        "transaction_state_information": transactionStateInformation,
        "cardholader_verfication_result": cardholaderVerficationResult,
        "cryptogram_information_data": cryptogramInformationData,
        "application_cryptogram": applicationCryptogram,
        "kernel_id": kernelId,
        "payment_account_reference": paymentAccountReference,
        "pan_suffix": panSuffix,
        "qr_code": qrCode,
        "transaction_uuid": transactionUuid,
    };
}

class AmountAuthorized {
    Currency? label;
    String? value;

    AmountAuthorized({
        this.label,
        this.value,
    });

    factory AmountAuthorized.fromJson(Map<String, dynamic> json) => AmountAuthorized(
        label: json["label"] == null ? null : Currency.fromJson(json["label"]),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "label": label?.toJson(),
        "value": value,
    };
}

class Currency {
    String? arabic;
    String? english;

    Currency({
        this.arabic,
        this.english,
    });

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        arabic: json["arabic"],
        english: json["english"],
    );

    Map<String, dynamic> toJson() => {
        "arabic": arabic,
        "english": english,
    };
}

class CardScheme {
    Currency? name;
    String? id;

    CardScheme({
        this.name,
        this.id,
    });

    factory CardScheme.fromJson(Map<String, dynamic> json) => CardScheme(
        name: json["name"] == null ? null : Currency.fromJson(json["name"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name?.toJson(),
        "id": id,
    };
}

class Merchant {
    String? id;
    Currency? name;
    Currency? address;
    String? categoryCode;

    Merchant({
        this.id,
        this.name,
        this.address,
        this.categoryCode,
    });

    factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["id"],
        name: json["name"] == null ? null : Currency.fromJson(json["name"]),
        address: json["address"] == null ? null : Currency.fromJson(json["address"]),
        categoryCode: json["category_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name?.toJson(),
        "address": address?.toJson(),
        "category_code": categoryCode,
    };
}
