class InfixApi{

 static String root = 'https://infixedu.com/android/';
 static String base_api = root+'api/';
 static String login(String email,String password){
   return base_api+'login?email='+email+'&password='+password;
 }

}