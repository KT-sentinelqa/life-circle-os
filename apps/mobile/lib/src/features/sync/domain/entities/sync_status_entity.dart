/// Represents the lifecycle status of a sync operation.
enum SyncStatusEntity {
  /// Waiting to be processed.
  pending,

  /// Currently being sent to the server.
  inProgress,

  /// Successfully synchronized.
  completed,

  /// Encountered a recoverable error.
  failed,

  /// Encountered an unrecoverable error or max retries exceeded.
  deadLetter,
}
