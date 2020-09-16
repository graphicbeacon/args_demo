import 'dart:io';
import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:http/http.dart' as http;

class InstallCommand extends Command {
  @override
  final name = 'install';

  @override
  final description = 'Adds a package to the project';

  @override
  void run() {
    // print(argResults.arguments);
    // print(argParser.usage);
    installPackage(argResults.arguments.first);
  }

  void installPackage(String name) async {
    final response = await http.get('https://pub.dev/api/packages/$name');
    if (response.statusCode == HttpStatus.notFound) {
      print(response.body);
      exit(1);
    }

    // Parse response body and retrieve version
    final data = json.decode(response.body);
    var version = data['latest']['version'];

    // Load current pubspec file
    final pubspec = File('pubspec.yaml').readAsStringSync();

    // Insert package and write out new file
    final updatedPubspec = pubspec.replaceFirst(
        'dependencies:\n', 'dependencies:\n  $name: ^$version\n');

    File('pubspec.yaml').writeAsStringSync(updatedPubspec);

    // Update dependencies
    Process.runSync('pub', ['get']);

    print('Installed $name@$version');
  }
}
