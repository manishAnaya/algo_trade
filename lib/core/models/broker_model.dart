class BrokerModel {
  final int brokerId;
  final String brokerName;
  final bool isActive;
  final String? brokerImage;
  final String? appIdHash;
  final String? clientId;
  final String? secretKey;
  final String? redirectUrl;

  const BrokerModel({
    required this.brokerId,
    required this.brokerName,
    required this.isActive,
    this.brokerImage,
    this.appIdHash,
    this.clientId,
    this.secretKey,
    this.redirectUrl,
  });

  factory BrokerModel.fromJson(Map<String, dynamic> json) {
    return BrokerModel(
      brokerId: json['brokerId'] as int,
      brokerName: json['brokername'] as String,
      isActive: json['isActive'] as bool,
      brokerImage: json['brokerimage'] as String?,
      appIdHash: json['appidhash'] as String?,
      clientId: json['clientid'] as String?,
      secretKey: json['secratekey'] as String?,
      redirectUrl: json['redirecturl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brokerId': brokerId,
      'brokername': brokerName,
      'isActive': isActive,
      'brokerimage': brokerImage,
      'appidhash': appIdHash,
      'clientid': clientId,
      'secratekey': secretKey,
      'redirecturl': redirectUrl,
    };
  }
}
