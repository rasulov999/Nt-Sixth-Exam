

class CardModel {
  final String cardId;
  final String gradient;
  final String cardNumber;
  final String moneyAmount;
  final String owner;
  final String expireData;
  final String iconImage;
  final String userId;
  final String cardName;

  CardModel({
    required this.cardId,
    required this.gradient,
    required this.cardNumber,
    required this.moneyAmount,
    required this.owner,
    required this.expireData,
    required this.iconImage,
    required this.userId,
    required this.cardName,
  });

  factory CardModel.fromJson(Map<String, Object?> json) {
    return CardModel(
      cardId: json["cardId"] as String? ?? "",
      gradient: json["gradient"] as String? ?? "",
      cardNumber: json["cardNumber"] as String? ?? "",
      moneyAmount: json["moneyAmount"] as String? ?? "",
      owner: json["owner"] as String? ?? "",
      expireData: json["expireData"] as String? ?? "",
      iconImage: json["iconImage"] as String? ?? "",
      userId: json["userId"] as String? ?? "",
      cardName: json["cardName"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'gradient': gradient,
      'cardNumber': cardNumber,
      'moneyAmount': moneyAmount,
      'owner': owner,
      'expireData': expireData,
      'iconImage': iconImage,
      'userId': userId,
      'cardName': cardName,
    };
  }
}
