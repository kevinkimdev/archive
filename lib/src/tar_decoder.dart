part of archive;

/**
 * Decode a tar formatted buffer into an [Archive] object.
 */
class TarDecoder {
  List<TarFile> files = [];

  Archive decodeBytes(List<int> data, {bool verify: false}) {
    return decodeBuffer(new InputStream(data), verify: verify);
  }

  Archive decodeBuffer(InputStream input, {bool verify: false}) {
    Archive archive = new Archive();
    files.clear();

    //TarFile paxHeader = null;
    while (!input.isEOS) {
      // End of archive when two consecutive 0's are found.
      if (input[0] == 0 && input[1] == 0) {
        break;
      }

      TarFile tf = new TarFile.read(input);
      // In POSIX formatted tar files, a separate 'PAX' file contains extended
      // metadata for files. These are identified by having a type flag 'X'.
      // TODO parse these metadata values.
      if (tf.typeFlag == TarFile.TYPE_G_EX_HEADER ||
          tf.typeFlag == TarFile.TYPE_G_EX_HEADER2) {
        // TODO handle PAX global header.
      }
      if (tf.typeFlag == TarFile.TYPE_EX_HEADER ||
          tf.typeFlag == TarFile.TYPE_EX_HEADER2) {
        //paxHeader = tf;
      } else {
        files.add(tf);

        ArchiveFile file = new ArchiveFile(
            tf.filename, tf.fileSize, tf._rawContent);

        file.mode = tf.mode;
        file.ownerId = tf.ownerId;
        file.groupId = tf.groupId;
        file.lastModTime = tf.lastModTime;
        file.isFile = tf.isFile;

        archive.addFile(file);
      }
    }

    return archive;
  }
}
