import 'package:barcode_scan2/barcode_scan2.dart';
import 'invoice_scanner_repository.dart';

class InvoiceScannerRepositoryImpl
    implements InvoiceScannerRepository {
  @override
  Future<ScanResult> scanBarcode() {
    return BarcodeScanner.scan();
  }
}
