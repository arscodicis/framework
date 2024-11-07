import 'package:recase/recase.dart';

/// This stub is used to create a new Page + Controller.
String pageWithControllerStub(
        {required String className, String? creationPath}) =>
    '''
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/app/controllers/${creationPath != null ? "$creationPath/${className.snakeCase}" : className.snakeCase}_controller.dart';

class ${className.pascalCase}Page extends NyStatefulWidget<${className.pascalCase}Controller> {
  static RouteView path = ("/${className.paramCase}", (_) => ${className.pascalCase}Page());

  ${className.pascalCase}Page() : super(child: () => _${className.pascalCase}PageState());
}

class _${className.pascalCase}PageState extends NyState<${className.pascalCase}Page> {

  /// [${className.pascalCase}Controller] controller
  ${className.pascalCase}Controller get controller => widget.controller;

 @override
  get init => () {

  };
  
 @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("${className.titleCase}")
      ),
      body: SafeArea(
         child: Container(),
      ),
    );
  }
}
''';
