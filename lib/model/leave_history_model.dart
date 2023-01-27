class LeaveHistoryModel {
  List<Data>? data;

  LeaveHistoryModel({this.data});

  LeaveHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String? leaveType;
  String? reason;
  String? fromDate;
  String? toDate;
  String? status;
  String? name;

  Data(
      {this.id,
        this.employeeId,
        this.leaveType,
        this.reason,
        this.fromDate,
        this.toDate,
        this.status,
        this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    leaveType = json['leave_type'];
    reason = json['reason'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['leave_type'] = this.leaveType;
    data['reason'] = this.reason;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}
