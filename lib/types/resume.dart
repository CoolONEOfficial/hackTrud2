enum ResumeType {
  Mover,
  Waiter,
}

extension ResumeExtension on ResumeType {
  String get name {
    switch (this) {
      case ResumeType.Mover:
        return 'Грузчик';
      case ResumeType.Waiter:
        return 'Официант';
      default:
        return null;
    }
  }
}
