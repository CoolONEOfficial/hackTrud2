enum ResumeType {
  Storekeeper,
  DriverLoader,
  Waiter,
}

extension ResumeExtension on ResumeType {
  String get name {
    switch (this) {
      case ResumeType.Storekeeper:
        return 'Кладовщик';
      case ResumeType.DriverLoader:
        return 'Водитель';
      case ResumeType.Waiter:
        return 'Официант';
    }
  }

  String get engName {
    switch (this) {
      case ResumeType.Storekeeper:
        return 'STOREKEEPER';
      case ResumeType.DriverLoader:
        return 'DRIVER_LOADER';
      case ResumeType.Waiter:
        return 'WAITER';
    }
  }
}
