import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_icon.dart';

Widget allServicesList() {

  List<Map> servicesItem = [
    {'id' : 1 ,'itemName': 'شارژ و اینترنت', 'imagePath': 'assets/svg/bank_services_page/simcard.svg'},
    {'id' : 2 ,'itemName': 'انتقال وجه', 'imagePath': 'assets/svg/bank_services_page/switch-vertical.svg'},
    {'id' : 3 ,'itemName': 'تسهیلات', 'imagePath': 'assets/svg/bank_services_page/wallet.svg'},
    {'id' : 4 ,'itemName': 'قبوض', 'imagePath': 'assets/svg/bank_services_page/receipt.svg'},
    {'id' : 5 ,'itemName': 'چک های من', 'imagePath': 'assets/svg/bank_services_page/ticket.svg'},
    {'id' : 6 ,'itemName': 'هدیه آنلاین', 'imagePath': 'assets/svg/bank_services_page/gift.svg'},
  ];

  return SizedBox(
    height: 120,
    child: Padding(
      padding: EdgeInsets.only(right: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: servicesItem.length,
        separatorBuilder: (_, __) => const SizedBox(width: 24),
        padding: const EdgeInsets.only(left: 24, top: 20),
        itemBuilder: (context, index) =>
            InkWell(
              child: CustomIcon(serviceName: servicesItem[index]['itemName'], imagePath: servicesItem[index]['imagePath']),
              onTap: (){
                if(servicesItem[index]['id'] == 1){
                  context.push('/charge_internet_page');
                }else if(servicesItem[index]['id'] == 2){
                  context.push('/fund_transfer_page');
                }else if(servicesItem[index]['id'] == 3){
                  context.push('/loan_page');
                }else if(servicesItem[index]['id'] == 4){
                  context.push('/invoices_page');
                }
              },
            ),
      ),
    ),
  );
}
