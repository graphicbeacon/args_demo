import 'dart:io';

import 'package:args/args.dart';

void main(List<String> args) {
  final parser = ArgParser()
    ..addOption('name', abbr: 'n', help: 'Provide your name')
    ..addFlag('help',
        abbr: 'h', help: 'Print out usage instructions', negatable: false)
    ..addSeparator('=== Developer tools')
    ..addOption('paas',
        help: 'What is your favourite Platform as a Service?',
        allowed: [
          'Amazon Web Services',
          'Google Cloud',
          'Heroku',
          'Microsoft Azure',
        ],
        defaultsTo: 'Microsoft Azure')
    ..addMultiOption('browser',
        abbr: 'b',
        help: 'Choose your browsers',
        allowed: [
          'Chrome',
          'Firefox',
          'Edge',
          'Opera',
          'Safari'
        ],
        allowedHelp: {
          'Chrome': 'By Google',
          'Firefox': 'By Mozilla',
          'Edge': 'By Microsoft',
          'Opera': 'By Opera',
          'Safari': 'By Apple',
        });

  final results = parser.parse(args);

  if (results.wasParsed('help')) {
    print(parser.usage);
    exit(0);
  }

  if (results.wasParsed('name')) {
    print('=> ${results['name']}');
  }

  print('PAAS => ${results['paas']}');

  if (results.wasParsed('browser')) {
    print('Browser => ${results['browser']}');
  }
}
