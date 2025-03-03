# AlcoCalc Development Guidelines

## Commands
- Run all tests: `dart test`
- Run a single test: `dart test test/brix_test.dart`
- Run a specific test: `dart test test/liqueur_dilution_test.dart -n "should correctly dilute"`
- Lint code: `dart analyze`
- Format code: `dart format .`

## Code Style
- **Imports**: Organize with `directives_ordering` rule, avoid relative lib imports
- **Naming**: camelCase for variables/functions, PascalCase for classes/types
- **Types**: Always declare return types, use strong typing
- **Formatting**: Follow standard Dart formatting with `dart format`
- **Documentation**: Use triple-slash (`///`) doc comments for functions and classes
- **Error Handling**: Avoid empty catches, use proper exception handling
- **Testing**: Write comprehensive unit tests with descriptive names
- **Precision**: Maintain precise decimal calculations for alcohol formulas
- **Style**: Follow functional programming style for calculation functions

## Project Structure
- `lib/`: Core calculation functions and tables
- `bin/`: Command-line applications for specific use cases
- `test/`: Unit tests for core functionality