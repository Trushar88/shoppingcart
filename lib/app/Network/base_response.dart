// ignore_for_file: unnecessary_null_comparison

class BaseResponse<T> {
  T data;
  bool success;

  BaseResponse({required this.success, required this.data});

  factory BaseResponse.fromJson(bool isSuccess, T recordList) => BaseResponse(data: recordList, success: isSuccess);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    return data;
  }
}
