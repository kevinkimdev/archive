library archive_test;

import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:test/test.dart';

import '../bin/tar.dart' as tar_command;

part 'adler32_test.dart';
part 'bzip2_test.dart';
part 'commands_test.dart';
part 'crc32_test.dart';
part 'deflate_test.dart';
part 'gzip_test.dart';
part 'inflate_test.dart';
part 'input_stream_test.dart';
part 'output_stream_test.dart';
part 'pub_test.dart';
part 'tar_test.dart';
part 'zip_test.dart';
part 'zlib_test.dart';

void compare_bytes(List<int> a, List<int> b) {
  expect(a.length, equals(b.length));
  int len = a.length;
  for (int i = 0; i < len; ++i) {
    expect(a[i], equals(b[i]), verbose: false);
  }
}

const String a_txt = """this is a test
of the
zip archive
format.
this is a test
of the
zip archive
format.
this is a test
of the
zip archive
format.
""";

void main() {
  defineInputStreamTests();
  defineOutputStreamTests();
  defineAdlerTests();
  defineCrc32Tests();
  defineBzip2Tests();
  defineDeflateTests();
  defineInflateTests();
  defineZlibTests();
  defineGZipTests();
  defineTarTests();
  defineZipTests();
  defineCommandTests();
  definePubTests();
}
