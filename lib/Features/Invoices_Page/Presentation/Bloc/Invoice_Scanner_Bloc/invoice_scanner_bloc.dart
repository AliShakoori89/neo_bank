import 'package:barcode_scan2/gen/protos/protos.pbenum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/Repository/invoice_scanner_repository.dart';
import 'invoice_scanner_event.dart';
import 'invoice_scanner_state.dart';

class InvoiceScannerBloc
    extends Bloc<InvoiceScannerEvent, InvoiceScannerState> {

  final InvoiceScannerRepository repository;

  InvoiceScannerBloc({
    required this.repository,
  }) : super(InvoiceScannerInitial()) {

    on<ScanInvoiceBarcodeEvent>(_onScanBarcode);
  }

  Future<void> _onScanBarcode(
      ScanInvoiceBarcodeEvent event,
      Emitter<InvoiceScannerState> emit,
      ) async {
    emit(InvoiceScannerLoading());

    try {
      final result = await repository.scanBarcode();

      if (result.type == ResultType.Cancelled) {
        emit(InvoiceScannerCancelled());
        return;
      }

      if (result.type == ResultType.Error) {
        emit(
          InvoiceScannerFailure(
            'خطا در اسکن: ${result.rawContent}',
          ),
        );
        return;
      }

      if (result.rawContent.trim().isEmpty) {
        emit(InvoiceScannerCancelled());
        return;
      }

      emit(
        InvoiceScannerSuccess(
          result.rawContent.trim(),
        ),
      );
    } catch (e) {
      debugPrint('Scan Error: $e');
      emit(
        InvoiceScannerFailure(
          'خطای سیستمی در اسکن بارکد: $e',
        ),
      );
    }
  }
}