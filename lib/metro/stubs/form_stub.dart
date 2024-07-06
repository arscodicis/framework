import 'package:recase/recase.dart';

/// This stub is used to create NyFormData.
String formStub(ReCase className) => '''
import 'package:nylo_framework/nylo_framework.dart';

/* ${className.pascalCase} Form
|--------------------------------------------------------------------------
| Usage: https://nylo.dev/docs/5.20.0/forms#how-it-works
| Casts: https://nylo.dev/docs/5.20.0/forms#form-casts
| Validation Rules: https://nylo.dev/docs/5.20.0/validation#validation-rules
|-------------------------------------------------------------------------- */

class ${className.pascalCase}Form extends NyFormData {

  ${className.pascalCase}Form({String? name}) : super(name ?? "${className.snakeCase}");

  @override
  fields() => [
     Field("Name",
        value: "Customize your form ⚡️",
        cast: FormCast.text(),
        dummyData: null,
        style: "compact"
    ),
    [
      Field("Price",
        value: "",
        cast: FormCast.currency("usd"),
        dummyData: "19.99",
        style: "compact",
      ),
      Field("Favourite Color",
        value: "",
        cast: FormCast.picker(options: [
          "Red",
          "Blue",
          "Green"
        ]),
        validate: FormValidator("contains:Red,Blue,Green"),
        dummyData: "Blue",
        style: "compact",
      ),
    ],
    Field("Bio",
        value: "",
        cast: FormCast.textArea(),
        dummyData: null,
        style: "compact"
    ),
  ];
}
''';
