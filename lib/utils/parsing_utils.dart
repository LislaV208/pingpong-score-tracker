T tryParse<T>({
  required T Function() parse,
  required T fallbackValue,
}) {
  var value = fallbackValue;

  try {
    value = parse();
  } on Exception catch (_) {
    // TODO log error

  }

  return value;
}
