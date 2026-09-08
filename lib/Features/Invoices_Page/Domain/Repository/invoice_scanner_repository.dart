import 'package:barcode_scan2/barcode_scan2.dart';

abstract class InvoiceScannerRepository {
  Future<ScanResult> scanBarcode();
}
