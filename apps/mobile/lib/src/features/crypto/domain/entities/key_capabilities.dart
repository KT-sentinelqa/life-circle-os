enum KeyPurpose {
  dataEncryption,
  digitalSignature,
  keyEncryption,
  authentication,
}

enum BackupPolicy {
  never,
  controlled,
  allowed,
}

class KeyCapabilities {
  const KeyCapabilities({
    required this.isHardwareBacked,
    required this.isExportable,
    required this.backupPolicy,
    required this.purpose,
  });

  final bool isHardwareBacked;
  final bool isExportable;
  final BackupPolicy backupPolicy;
  final KeyPurpose purpose;

  KeyCapabilities copyWith({
    bool? isHardwareBacked,
    bool? isExportable,
    BackupPolicy? backupPolicy,
    KeyPurpose? purpose,
  }) {
    return KeyCapabilities(
      isHardwareBacked: isHardwareBacked ?? this.isHardwareBacked,
      isExportable: isExportable ?? this.isExportable,
      backupPolicy: backupPolicy ?? this.backupPolicy,
      purpose: purpose ?? this.purpose,
    );
  }
}
