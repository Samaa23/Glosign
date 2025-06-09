class ApiResponseModel {
  final String? resultText;
  final String? signUrl;

  ApiResponseModel({this.resultText, this.signUrl});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      resultText: json['result'],
      signUrl: json['result_url'],
    );
  }
}
