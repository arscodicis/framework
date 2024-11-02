import 'package:recase/recase.dart';

/// Creates a network method
String networkMethodStub({
  required String methodName,
  Map<String, dynamic> queryParams = const {},
  Map<String, dynamic> headerParams = const {},
  Map<String, dynamic> dataParams = const {},
  Map<String, dynamic> pathParams = const {},
  String? model,
  bool isList = false,
  String path = "",
  required String method,
  String? urlFullPath,
}) =>
    '''
  //$method\n${urlFullPath != null ? '  /// $urlFullPath' : ''}
  Future<${_getType(model, isList: isList, isOptional: true)}> $methodName(${_mapParams(queryParams, dataParams, pathParams)}) async => await network${_getType(model, isList: isList, returnDynamic: false, addBrackets: true)}(
    ${_callBackType(headers: headerParams, method: method, path: path, queryParams: queryParams, dataParams: dataParams, pathParams: pathParams)}
    ${urlFullPath != null ? 'baseUrl: "${Uri.parse(urlFullPath).origin}"' : ''}
  );
''';

String _getType(String? model,
    {bool returnDynamic = true,
    bool isOptional = false,
    bool isList = false,
    bool addBrackets = false}) {
  if (model != null) {
    String type = model;
    String optional = isOptional ? '?' : '';
    if (addBrackets) {
      if (isList) {
        return "<List<$type>$optional>";
      }
      return '<$type$optional>';
    }
    if (isList) {
      return "List<$type>$optional";
    }
    return type + optional;
  }
  if (returnDynamic) {
    return 'dynamic';
  }
  return '';
}

String _mapDataParams(Map<String, dynamic> dataParams,
        {bool isOptional = false}) =>
    dataParams.entries
        .map((e) => '"${e.key}${isOptional ? '?' : ''}": ${e.key.camelCase}')
        .toList()
        .join(", ");

String _mapParams(Map<String, dynamic> queryParams,
    Map<String, dynamic> dataParams, Map<String, dynamic> pathParams) {
  Map<String, dynamic> params = {};
  if (queryParams.isNotEmpty) {
    params.addAll(queryParams);
  }
  if (dataParams.isNotEmpty) {
    params.addAll(dataParams);
  }
  if (pathParams.isNotEmpty) {
    params.addAll(pathParams);
  }
  if (params.entries.isEmpty) {
    return '';
  }
  // ignore: prefer_interpolation_to_compose_strings
  return "{" +
      params.entries
          .map((e) {
            String type = e.value.runtimeType.toString();
            if (type == '_InternalLinkedHashMap<String, dynamic>') {
              type = 'Map<String, dynamic>';
            }
            if (type == "_Map<String, dynamic>") {
              type = 'Map<String, dynamic>';
            }
            return "$type? ${ReCase(e.key).camelCase}";
          })
          .toList()
          .join(", ") +
      "}";
}

String _callBackType({
  required Map<String, dynamic> headers,
  required String method,
  required String path,
  required Map<String, dynamic> queryParams,
  required Map<String, dynamic> dataParams,
  required Map<String, dynamic> pathParams,
}) {
  if (headers.isEmpty) {
    return "request: (request) => ${_requestType(method, path, queryParams, dataParams, pathParams)}";
  }
  return '''request: (request) {
  request.options.headers.addAll({
    ${headers.entries.map((e) => "\"${e.key}\": '${e.value}'").toList().join(", ")}
  });
  return ${_requestType(method, path, queryParams, dataParams, pathParams).substring(0, _requestType(method, path, queryParams, dataParams, pathParams).length - 1)};
  },''';
}

String _requestType(
    String method,
    String path,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> dataParams,
    Map<String, dynamic> pathParams) {
  RegExp regExp = RegExp(r':([\w_$&+,:;=?@#!]+)');
  path = path.replaceAllMapped(regExp, (match) {
    String key = match.group(1) ?? "";
    if (key == "") return "";

    if (!pathParams.containsKey(key)) {
      return match.group(0) ?? "";
    }
    return "\$${key.camelCase}";
  });

  if (method.toLowerCase() == 'get') {
    queryParams.addAll(dataParams);
  }
  return '''
request.${method.toLowerCase()}("$path"${queryParams.isNotEmpty ? ', queryParameters: {${_mapDataParams(queryParams)}}' : ''}${method.toLowerCase() != 'get' && dataParams.isNotEmpty ? ', data: {${_mapDataParams(dataParams)}}' : ''}),''';
}
