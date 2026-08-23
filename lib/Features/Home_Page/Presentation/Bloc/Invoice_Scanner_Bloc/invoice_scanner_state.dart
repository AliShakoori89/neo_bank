abstract class InvoiceScannerState {}

class InvoiceScannerInitial extends InvoiceScannerState {}

class InvoiceScannerLoading extends InvoiceScannerState {}

class InvoiceScannerSuccess extends InvoiceScannerState {
  final String barcode;

  InvoiceScannerSuccess(this.barcode);
}

class InvoiceScannerCancelled extends InvoiceScannerState {}

class InvoiceScannerFailure extends InvoiceScannerState {
  final String message;

  InvoiceScannerFailure(this.message);
}