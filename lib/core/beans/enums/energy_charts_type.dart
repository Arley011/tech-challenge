enum EnergyChartsType {
  production,
  price;
  
  String get showName {
    switch (this) {
      case EnergyChartsType.production:
        return 'Production';
      case EnergyChartsType.price:
        return 'Price';
      default:
        return '';
    }
  }
}
