class Generics {
  dynamic jsonElement;

  Generics(this.jsonElement);

  List<T> getAsList<T>(T Function(Map<String, dynamic>) fromJsonFunction) {
    if (jsonElement is List<dynamic>) {
      List<dynamic> dataList = jsonElement as List<dynamic>;
      return dataList.map((json) => fromJsonFunction(json)).toList();
    } else if (jsonElement is Map<String, dynamic>) {
      return [fromJsonFunction(jsonElement)];
    }
    return [];
  }

  T? getAsObject<T>(T Function(Map<String, dynamic>) fromJsonFunction) {
    if (jsonElement is List<dynamic>) {
      return fromJsonFunction(jsonElement[0]);
    } else if (jsonElement is Map<String, dynamic>) {
      return fromJsonFunction(jsonElement);
    }
    return null;
  }
}
