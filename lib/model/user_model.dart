class UserModel {
  String? status;
  String? message;
  int? employeeId;
  String? firstname;
  String? lastname;

  UserModel(
      {this.status,
        this.message,
        this.employeeId,
        this.firstname,
        this.lastname});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    employeeId = json['employee_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['employee_id'] = this.employeeId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
