class Applicant {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String contactNo;
  final String dateOfBirth;
  final String placeOfBirth;
  final String civilStatus;
  final String height;
  // final int age;
  final String sex;
  final String nationality;
  final int addressId;

  Applicant({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.contactNo,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.civilStatus,
    required this.height,
    // required this.age,
    required this.sex,
    required this.nationality,
    required this.addressId,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
        id: json['id'],
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        contactNo: json['contact_no'],
        dateOfBirth: json['date_of_birth'],
        placeOfBirth: json['place_of_birth'],
        civilStatus: json['civil_status'],
        height: json['height'],
        // age: json['age'],
        sex: json['sex'],
        nationality: json['nationality'],
        addressId: json['address_id'],
      );
}
