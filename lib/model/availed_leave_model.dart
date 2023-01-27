class AvailedLeaveModel {
  List<Data>? data;

  AvailedLeaveModel({this.data});

  AvailedLeaveModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? employeeId;
  int? casual;
  int? sick;
  int? paid;

  Data({this.id, this.employeeId, this.casual, this.sick, this.paid});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    casual = json['casual'];
    sick = json['sick'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['casual'] = this.casual;
    data['sick'] = this.sick;
    data['paid'] = this.paid;
    return data;
  }
}
