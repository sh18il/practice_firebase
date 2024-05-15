class StudentModel {
  String? name;
  String? email;
  String? address;
  String? id;

  StudentModel({this.name, this.email, this.address, this.id});

  StudentModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    address = json["address"];
    id = json["id"];
  }
  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "address": address, "id": id};
  }
}
