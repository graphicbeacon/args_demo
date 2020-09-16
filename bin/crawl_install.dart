import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'package:args_demo/install_command.dart';

void main(List<String> args) async {
//   final parser = ArgParser()
//     ..addOption('install', abbr: 'i', help: 'Adds a package to the project')
//     ..addFlag('help', abbr: 'h', help: 'See instructions', negatable: false);

//   final results = parser.parse(args);

//   if (results.wasParsed('help')) {
//     print('''
// crawl: manage packages in your Dart project

// ${parser.usage}
// ''');
//   }
  final runner = CommandRunner('crawl', 'manage packages in your Dart project')
    ..addCommand(InstallCommand());

  await runner.run(args);
}
