class User {
  int? id;
  String? email;
  String? password;
  String? mobile;
  String? username;
  String? name;
  String? age;
  String? gender;
  String? imageUrl;
  String? apiToken;
  String? address;

  User({this.id, this.email, this.password, this.mobile, this.username, this.name, this.age, this.gender, this.imageUrl, this.apiToken, this.address});
}

// YOU - current user
final User currentUser = User(
    id: 0,
    name: 'Shin Ye Eun',
    age: '24',
    gender: 'Female',
    imageUrl: 'assets/images/user-profile.jpg',
    email: 'shin@yopmail.com',
    username: '_@shin_098',
    mobile: '+91-9000000000',
    address: '125 NW 147th Way Newberry, Florida(FL), 32669');

// USERS
final User greg = User(
  id: 1,
  name: 'Dr Greg',
  imageUrl: 'https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-1.jpg',
);
final User james = User(
  id: 2,
  name: 'Dr James',
  imageUrl: 'https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-4.jpg',
);
final User john = User(
  id: 3,
  name: 'Dr John',
  imageUrl: 'https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-7.jpg',
);
final User olivia = User(
  id: 4,
  name: 'Dr Olivia',
  imageUrl: 'https://res.cloudinary.com/ladla8602/image/upload/v1611924830/DCA/doctor-8.jpg',
);
final User sam = User(
  id: 5,
  name: 'Dr Sam',
  imageUrl: 'https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-7.jpg',
);
final User sophia = User(
  id: 6,
  name: 'Dr Sophia',
  imageUrl: 'https://res.cloudinary.com/ladla8602/image/upload/v1611932469/DCA/doctor-9.jpg',
);
final User steven = User(
  id: 7,
  name: 'Dr Steven',
  imageUrl: 'https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-1.jpg',
);
