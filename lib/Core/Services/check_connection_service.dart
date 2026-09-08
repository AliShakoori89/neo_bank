
import '../Network/Internet/check_page_internet.dart';

Future<void> checkConnection(context) async {
  await InternetChecker.checkPageInternet(
    context: context,
    onSuccess: (){
      context.pushReplacement('/main_page');
    },
  );
}