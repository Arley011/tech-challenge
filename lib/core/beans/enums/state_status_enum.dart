enum StateStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == StateStatus.initial;

  bool get isLoading => this == StateStatus.loading;

  bool get isSuccess => this == StateStatus.success;

  bool get isError => this == StateStatus.error;
}
