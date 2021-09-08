import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.nonBankOtc,
    this.bankOtc,
    this.eWallet,
    this.creditDebitCard,
  });

  NonBankOtc? nonBankOtc;
  BankOtc? bankOtc;
  EWallet? eWallet;
  CreditDebitCard? creditDebitCard;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        nonBankOtc: NonBankOtc.fromJson(json["Non Bank OTC"]),
        bankOtc: BankOtc.fromJson(json["Bank OTC"]),
        eWallet: EWallet.fromJson(json["E-Wallet"]),
        creditDebitCard: CreditDebitCard.fromJson(json["Credit/Debit Card"]),
      );

  Map<String, dynamic> toJson() => {
        "Non Bank OTC": nonBankOtc?.toJson(),
        "Bank OTC": bankOtc?.toJson(),
        "E-Wallet": eWallet?.toJson(),
        "Credit/Debit Card": creditDebitCard?.toJson(),
      };
}

class BankOtc {
  BankOtc({
    this.unionBankOfThePhilippines,
  });

  UnionBankOfThePhilippines? unionBankOfThePhilippines;

  factory BankOtc.fromJson(Map<String, dynamic> json) => BankOtc(
        unionBankOfThePhilippines: UnionBankOfThePhilippines.fromJson(
            json["UnionBank of the Philippines"]),
      );

  Map<String, dynamic> toJson() => {
        "UnionBank of the Philippines": unionBankOfThePhilippines?.toJson(),
      };
}

class UnionBankOfThePhilippines {
  UnionBankOfThePhilippines({
    this.code,
    this.terms,
    this.instruction,
    this.extras,
  });

  String? code;
  String? terms;
  List<String>? instruction;
  Extras? extras;

  factory UnionBankOfThePhilippines.fromJson(Map<String, dynamic> json) =>
      UnionBankOfThePhilippines(
        code: json["code"],
        terms: json["terms"],
        // instruction: List<String>.from(json["instruction"].map((x) => x)),
        instruction: (json['instruction']! as List).cast<String>(),
        extras: Extras.fromJson(json["extras"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "terms": terms,
        // "instruction": List<dynamic>.from(instruction.map((x) => x)),
        "instruction": instruction,
        "extras": extras?.toJson(),
      };
}

class Extras {
  Extras({
    this.min,
    this.max,
  });

  int? min;
  int? max;

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class EWallet {
  EWallet({
    this.gCash,
  });

  UnionBankOfThePhilippines? gCash;

  factory EWallet.fromJson(Map<String, dynamic> json) => EWallet(
        gCash: UnionBankOfThePhilippines.fromJson(json["GCash"]),
      );

  Map<String, dynamic> toJson() => {
        "GCash": gCash?.toJson(),
      };
}

class CreditDebitCard {
  CreditDebitCard({
    this.visaMasterCard,
  });

  UnionBankOfThePhilippines? visaMasterCard;

  factory CreditDebitCard.fromJson(Map<String, dynamic> json) =>
      CreditDebitCard(
        visaMasterCard:
            UnionBankOfThePhilippines.fromJson(json["Visa/MasterCard"]),
      );

  Map<String, dynamic> toJson() => {
        "Visa/MasterCard": visaMasterCard?.toJson(),
      };
}

class NonBankOtc {
  NonBankOtc({
    this.the7Eleven,
  });

  UnionBankOfThePhilippines? the7Eleven;

  factory NonBankOtc.fromJson(Map<String, dynamic> json) => NonBankOtc(
        the7Eleven: UnionBankOfThePhilippines.fromJson(json["7-Eleven"]),
      );

  Map<String, dynamic> toJson() => {
        "7-Eleven": the7Eleven?.toJson(),
      };
}
