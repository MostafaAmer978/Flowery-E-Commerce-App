class DriverDataEntity {
  final String firstName;
  final String lastName;
  final String phone;
  final String photo;
  final String vehicleType;

  const DriverDataEntity({
    required this.firstName,

    required this.lastName,
    required this.phone,
    required this.photo,
    required this.vehicleType,
  });

  factory DriverDataEntity.empty() => const DriverDataEntity(
    firstName: "",

    lastName: "",
    phone: "",
    photo: "",
    vehicleType: "",
  );
}
