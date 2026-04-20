import '../Utils/App_Lock/Internet/internet_checker.dart';

Future<void> checkConnection(context) async {
  await InternetChecker.checkInternet(
    context: context,
    onSuccess: (){
      context.pushReplacement('/main_page');
    },
  );
}