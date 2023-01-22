class User {
  final String firstname;
  final String middlename;
  final String lastname;
  final String contact_no;
  final String date_of_birth;
  final String place_of_birth;
  final String civil_status;
  final String height;
  final String sex;
  final String nationality;
  final String address;

  const User({
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.contact_no,
    required this.date_of_birth,
    required this.place_of_birth,
    required this.civil_status,
    required this.height,
    required this.sex,
    required this.nationality,
    required this.address,
  });

  static List<User> getUsers() {
    return <User>[
      User(
        firstname: "Aal",
        middlename: "asd",
        lastname: 'kk',
        contact_no: '12321321',
        date_of_birth: '12-20-2200',
        place_of_birth: 'qweqwe',
        civil_status: 'Siongqwe',
        height: '5ft4',
        sex: "male",
        nationality: 'ASd',
        address: 'asdsad',
      ),
      User(
        firstname: "zxcal",
        middlename: "asd",
        lastname: 'kk',
        contact_no: '12321321',
        date_of_birth: '12-20-2200',
        place_of_birth: 'qweqwe',
        civil_status: 'Siongqwe',
        height: '5ft4',
        sex: "male",
        nationality: 'ASd',
        address: 'asdsad',
      ),
      User(
        firstname: "qwal",
        middlename: "asd",
        lastname: 'kk',
        contact_no: '12321321',
        date_of_birth: '12-20-2200',
        place_of_birth: 'qweqwe',
        civil_status: 'Siongqwe',
        height: '5ft4',
        sex: "male",
        nationality: 'ASd',
        address: 'asdsad',
      ),
      User(
        firstname: "dsadal",
        middlename: "asd",
        lastname: 'kk',
        contact_no: '12321321',
        date_of_birth: '12-20-2200',
        place_of_birth: 'qweqwe',
        civil_status: 'Siongqwe',
        height: '5ft4',
        sex: "male",
        nationality: 'ASd',
        address: 'asdsad',
      ),
    ];
  }

  contains(String lowerCase) {}
}
