/// Architecture Compliance Tests (Phase 4 Sprint 1)
///
/// These tests programmatically scan the lib/ source tree and enforce
/// the ADR-007 boundary rules at build-time.
/// A failing test means a PR has introduced an architectural violation.
import 'dart:io';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

void main() {
  final libRoot = p.normalize('${Directory.current.path}/lib/src/features');

  // --- Helper: collect all .dart source files under a given feature dir ---
  List<File> dartFilesUnder(String featurePath) {
    final dir = Directory(p.join(libRoot, featurePath));
    if (!dir.existsSync()) return [];
    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .toList();
  }

  // --- Helper: extract all import lines from a file ---
  List<String> importsOf(File file) {
    return file
        .readAsLinesSync()
        .where((l) => l.trimLeft().startsWith("import '") || l.trimLeft().startsWith('import "'))
        .toList();
  }

  // Bounded-context feature names (must stay isolated from each other)
  const domains = [
    'finance',
    'medicines',
    'documents',
    'vehicles',
    'trust',
    'planning',
    'family',
    'household',
    'timeline',
  ];

  // ---------------------------------------------------------------------------
  // PILLAR 1: No Cross-Domain Aggregate or Repository Imports
  // Each domain folder must NOT import internal files from any sibling domain.
  // ---------------------------------------------------------------------------
  group('Pillar 1 — Cross-Domain Import Isolation', () {
    for (final domain in domains) {
      test('$domain does not import sibling domain internals', () {
        final files = dartFilesUnder(domain);
        final violations = <String>[];

        for (final file in files) {
          for (final import in importsOf(file)) {
            for (final other in domains) {
              if (other == domain) continue;
              // Allow SDK imports (public contract) but block internal imports
              if (import.contains('/features/$other/domain/') ||
                  import.contains('/features/$other/infrastructure/') ||
                  import.contains('/features/$other/application/')) {
                violations.add('${p.relative(file.path)} → $import');
              }
            }
          }
        }

        expect(
          violations,
          isEmpty,
          reason: 'Cross-domain internal imports detected in "$domain":\n${violations.join('\n')}',
        );
      });
    }
  });

  // ---------------------------------------------------------------------------
  // PILLAR 2: Domain Layer Must Not Import Flutter
  // Aggregates, Entities, Value Objects, and Events must remain pure Dart.
  // ---------------------------------------------------------------------------
  group('Pillar 2 — Domain Layer Flutter Independence', () {
    const domainSubpaths = ['aggregates', 'entities', 'value_objects', 'events'];

    for (final domain in domains) {
      for (final subpath in domainSubpaths) {
        test('$domain/domain/$subpath has no Flutter imports', () {
          final files = dartFilesUnder('$domain/domain/$subpath');
          final violations = <String>[];

          for (final file in files) {
            for (final import in importsOf(file)) {
              // Allow flutter/foundation.dart (for @immutable annotation only)
              // but block all other flutter/* imports
              if (import.contains("'package:flutter/") &&
                  !import.contains("'package:flutter/foundation.dart'")) {
                violations.add('${p.relative(file.path)} → $import');
              }
            }
          }

          expect(
            violations,
            isEmpty,
            reason: 'Flutter imports detected in domain layer of "$domain/$subpath":\n${violations.join('\n')}',
          );
        });
      }
    }
  });

  // ---------------------------------------------------------------------------
  // PILLAR 3: Network Prohibition in Domain & Application Layers
  // Forbidden: package:http, package:dio, dart:io (network usage)
  // ---------------------------------------------------------------------------
  group('Pillar 3 — No Direct Network Calls in Domain/Application', () {
    const forbiddenPackages = ["'package:http", "'package:dio"];

    for (final domain in domains) {
      test('$domain domain/application contains no direct network imports', () {
        final files = [
          ...dartFilesUnder('$domain/domain'),
          ...dartFilesUnder('$domain/application'),
        ];
        final violations = <String>[];

        for (final file in files) {
          for (final import in importsOf(file)) {
            for (final banned in forbiddenPackages) {
              if (import.contains(banned)) {
                violations.add('${p.relative(file.path)} → $import');
              }
            }
          }
        }

        expect(
          violations,
          isEmpty,
          reason: 'Direct network imports found in domain/application layer of "$domain":\n${violations.join('\n')}',
        );
      });
    }
  });
}
