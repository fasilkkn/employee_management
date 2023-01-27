class AppUrls{
  static var baseUrl = 'http://ec2-3-7-70-1.ap-south-1.compute.amazonaws.com:3000';

  // static var baseUrl = 'http://192.168.1.36:3000';

  static var loginAuth ='$baseUrl/auth';

  static var addEmp = '$baseUrl/addEmployee';

  static var loggedIn = '$baseUrl/loggedin';

  static var loggedOut = '$baseUrl/loggedout';

  static var leaveBalance = '$baseUrl/employeeLeaveBalanceGet';

  static var availedLeaveBalance = '$baseUrl/employeeTotalLeaveGet';

  static var leaveApp = '$baseUrl/leaveApproval';

  static var leaveHistory = '$baseUrl/leaveHistory';

  static var forgotPassword = '$baseUrl/forgot';
}