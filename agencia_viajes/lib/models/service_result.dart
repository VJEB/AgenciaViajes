class ServiceResult {
  final int code;
  final bool success;
  final String message;
  final DataModel data;

  ServiceResult({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ServiceResult.fromJson(Map<String, dynamic> json) {
    return ServiceResult(
      code: json['code'],
      success: json['success'],
      message: json['message'],
      data: DataModel.fromJson(json['data']),
    );
  }
}

class DataModel {
  final int codeStatus;
  final String? messageStatus;

  DataModel({
    required this.codeStatus,
    this.messageStatus,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      codeStatus: json['codeStatus'],
      messageStatus: json['messageStatus'],
    );
  }
}
