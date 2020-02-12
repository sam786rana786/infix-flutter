import 'package:infixedu/screens/admin/ApiProvider/StaffApiProvider.dart';
import 'package:infixedu/utils/modal/LibraryCategoryMember.dart';
import 'package:infixedu/utils/modal/Staff.dart';

class StaffRepository{


  StaffApiProvider _provider = StaffApiProvider();

  Future<LibraryMemberList> getStaff(){
    return _provider.getAllCategory();
  }

  Future<StaffList> getStaffList(int id){
    return _provider.getAllStaff(id);
  }

}