part of archive;

/**
 * Decode a zip formatted buffer into an [Archive] object.
 */
class ZipDecoder {
  ZipDirectory directory;

  Archive decode(List<int> data, {bool verify: true}) {
    InputBuffer input = new InputBuffer(data);
    directory = new ZipDirectory(input);

    Archive archive = new Archive();

    for (ZipFileHeader zfh in directory.fileHeaders) {
      ZipFile zf = zfh.file;

      if (verify) {
        int computedCrc = getCrc32(zf.content);
        if (computedCrc != zf.crc32) {
          throw new ArchiveException('Invalid CRC for file in archive.');
        }
      }

      File file = new File(zf.filename, zf.uncompressedSize,
                           zf._content, zf.compressionMethod);
      file.crc32 = zf.crc32;

      archive.addFile(file);
    }

    return archive;
  }
}
