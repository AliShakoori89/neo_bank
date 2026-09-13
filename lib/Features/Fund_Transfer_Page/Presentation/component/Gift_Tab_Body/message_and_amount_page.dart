import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Spacing/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Widgets/custom_button.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../../Core/Theme/app_colors.dart';
import '../enter_amount_box.dart';

class MessageAndAmountPage extends StatefulWidget {
  MessageAndAmountPage({
    super.key,
    required this.phoneNumber,
    required this.imgPath,
    required this.cardTitle,
  });

  final String phoneNumber;
  final String imgPath;
  final String cardTitle;

  @override
  State<MessageAndAmountPage> createState() => _MessageAndAmountPageState();
}

class _MessageAndAmountPageState extends State<MessageAndAmountPage> {
  TextEditingController messageController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  GlobalKey<FormState> messageFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> balanceFormKey = GlobalKey<FormState>();

  List<Map> amountItem = [
    {'id' : 1 ,'itemAmount': '10'},
    {'id' : 2 ,'itemAmount': '20'},
    {'id' : 3 ,'itemAmount': '50'},
    {'id' : 4 ,'itemAmount': '100'},
    {'id' : 5 ,'itemAmount': '200'},
    {'id' : 6 ,'itemAmount': '500'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(title: 'پیام و مبلغ', hasBackArrow: true),
            AppSpace.heightSpace_32,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('پیام خود را وارد نمایید:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .primaryFixed,
                    ),
                  ),
                  AppSpace.heightSpace_8,
                  Form(
                    key: messageFormKey,
                    child: TextFormField(
                      maxLines: 5,
                      minLines: 3,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.multiline,
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'پیام خود را بنویسید...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.splashGradiantColor1,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفا پیام مورد نظر خود را بنویسید';
                        }
                        return null;
                      },
                    ),
                  ),

                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: CustomButton(
                  buttonTitle: 'انتخاب مبلغ دلخواه',
                  buttonOnPressed: (){

                    if(messageFormKey.currentState!.validate()){
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              height: 400,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(22),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  left: 16,
                                  right: 16,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'مبلغ مورد نظر:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primaryFixed,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () => Navigator.pop(context),
                                          )
                                        ],
                                      ),

                                      AppSpace.heightSpace_16,

                                      SizedBox(
                                        height: 100,
                                        child: GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 15.0,
                                            mainAxisSpacing: 15.0,
                                            childAspectRatio: 3,
                                          ),
                                          itemCount: amountItem.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  final rawAmount = "${amountItem[index]['itemAmount']}000000";
                                                  amountController.text = rawAmount
                                                      .seRagham()
                                                      .replaceAll(',', '٬')
                                                      .toPersianDigit();
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        amountItem[index]['itemAmount'].toString().toPersianDigit().seRagham(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).colorScheme.surfaceBright,
                                                          fontWeight: FontWeight.w100,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      AppSpace.widthSpace_5,
                                                      Text(
                                                        'میلیون ریال',
                                                        style: TextStyle(
                                                          color: Theme.of(context).colorScheme.surfaceBright,
                                                          fontWeight: FontWeight.w100,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      AppSpace.heightSpace_16,
                                      EnterAmountBox(
                                          amountController: amountController,
                                          formKey: balanceFormKey
                                      ),
                                      AppSpace.heightSpace_24,
                                      CustomButton(
                                          buttonTitle: 'تایید و ادامه',
                                          buttonOnPressed: (){

                                            if(balanceFormKey.currentState!.validate()){
                                              context.push('/gift_details_page', extra: {
                                                'phoneNumber': widget.phoneNumber,
                                                'imgPath': widget.imgPath,
                                                'cardTitle': widget.cardTitle,
                                                'amount': amountController.text,
                                                'message': messageController.text,
                                              });
                                            }
                                          }),
                                      AppSpace.heightSpace_48,
                                    ],
                                  ),
                                ),
                              ),
                            )
                          );
                          }
                      );
                    }


                  }),
            )

          ],
        ),
      ),
    );
  }
}
