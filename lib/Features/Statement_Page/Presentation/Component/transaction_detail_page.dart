import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Utils/Formatters/persian_date_format_special_specific.dart';


class TransactionDetailPage extends StatefulWidget {
  const TransactionDetailPage({
    super.key,
    required this.title,
    required this.transferAmount,
    required this.date,
    required this.description,
  });

  final String title;
  final String transferAmount;
  final String date;
  final String description;

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final GlobalKey _receiptKey = GlobalKey();

  Future<Uint8List?> _captureReceiptImage(Color bgColor) async {
    try {
      RenderRepaintBoundary boundary =
      _receiptKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }

  Future<void> _shareReceipt(String type) async {
    Color bgColor;
    Color textColor;

    switch (type) {
      case 'bw':
        bgColor = Colors.white;
        textColor = Colors.black;
        break;
      case 'color':
        bgColor = Colors.black87;
        textColor = Colors.white;
        break;
      case 'text':
      // فقط متن
        final text = '''
          عنوان: ${widget.title}
          مبلغ: ${widget.transferAmount.seRagham().toPersianDigit()} ریال
          تاریخ: ${persianDateFormatSpecialSpecific(DateTime.parse(widget.date))}
          توضیحات: ${widget.description}
          ''';
        await Share.share(text);
        return;
      default:
        bgColor = Colors.white;
        textColor = Colors.black;
    }

    // نمایش پیش‌نمایش قبل از شیر
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.black54,
        content: RepaintBoundary(
          key: _receiptKey,
          child: Container(
            color: bgColor,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                AppSpace.heightSpace_16,
                Text(
                  'مبلغ: ${widget.transferAmount.seRagham().toPersianDigit()} ریال',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                AppSpace.heightSpace_8,
                Text(
                  'تاریخ: ${persianDateFormatSpecialSpecific(DateTime.parse(widget.date))}',
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                AppSpace.heightSpace_8,
                Text(
                  'توضیحات: ${widget.description}',
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final imageBytes = await _captureReceiptImage(bgColor);
              if (imageBytes != null) {
                await Share.shareXFiles([
                  XFile.fromData(
                    imageBytes,
                    name: 'receipt.png',
                    mimeType: 'image/png',
                  ),
                ]);
              }
            },
            child: Text('اشتراک گذاری'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('انصراف'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        height: 44,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.splashGradiantColor1,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.12)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: 90,
                child: Icon(
                  Icons.send,
                  color: Theme.of(context).elevatedButtonTheme.style?.iconColor?.resolve({}),
                ),
              ),
              AppSpace.widthSpace_8,
              Text(
                'ارسال رسید',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appWhite,
                ),
              ),
            ],
          ),
          onPressed: () async {
            final selectedOption = await showModalBottomSheet<String>(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'نوع رسید را انتخاب کنید',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('روشن'),
                      leading: Icon(Icons.sunny),
                      onTap: () => Navigator.pop(context, 'bw'),
                    ),
                    ListTile(
                      title: Text('تاریک'),
                      leading: Icon(Icons.nightlight),
                      onTap: () => Navigator.pop(context, 'color'),
                    ),
                    ListTile(
                      title: Text('متنی'),
                      leading: Icon(Icons.short_text_outlined),
                      onTap: () => Navigator.pop(context, 'text'),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            );

            if (selectedOption != null) {
              _shareReceipt(selectedOption);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSpace.heightSpace_48,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpace.widthSpace_5,
                Text(
                  'وجه',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            AppSpace.heightSpace_240,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.transferAmount.seRagham().toPersianDigit(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
                AppSpace.widthSpace_5,
                Text(
                  'ریال',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
              ],
            ),
            AppSpace.heightSpace_24,
            Text(
              persianDateFormatSpecialSpecific(DateTime.parse(widget.date)),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            AppSpace.heightSpace_24,
            Text(
              widget.description,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
