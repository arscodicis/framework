import 'package:recase/recase.dart';

/// This stub is used to create a new NyForm.
String formStub(ReCase className) => '''
import 'package:nylo_framework/nylo_framework.dart';

class ${className.pascalCase}Form extends NyFormData {

  ${className.pascalCase}Form({String? name}) : super(name ?? "${className.snakeCase}");

  @override
  fields() => [
    Field("Name", value: "Customize your form ⚡️"),
    [
      Field("Price"),
      Field("Favourite Color", value: ["Red", "Blue", "Green"], selected: "Green"),
    ],
  ];

  /// Cast the fields to their respective types
  /// All available types are below
  /// https://nylo.dev/docs/5.20.0/form#casts
  @override
  Map<String, dynamic> cast() => {
    "Name": FormCast(),
    "Price": FormCast.currency("usd"),
    "Favourite Color": FormCast.picker(),
  };

  /// Validate the fields
  /// All available validations are below
  /// https://nylo.dev/docs/5.20.0/validation#validation-rules
  @override
  Map<String, dynamic> validate() => {
    "Name": FormValidator("not_empty|max:20"),
    "Price": FormValidator("not_empty"),
    "Favourite Color": FormValidator("not_empty"),
  };

  /// Dummy data for the form
  /// This is used to populate the form with dummy data
  /// It will be removed when your .env file is set to production
  @override
  Map<String, dynamic> dummyData() => {
    // "Name": "John Doe",
    // "Price": 123.45,
  };

  /// Style the TextFields
  /// This is used to style the fields
  /// Options: compact
  @override
  Map<String, dynamic> style() => {
    // "Name": "compact",
    // "Price": "compact",
  };
}
''';
