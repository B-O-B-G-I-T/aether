import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeBloc() : super(QrCodeInitial()) {
    on<QrCodeEvent>((event, emit) {
      // implement event handler
    });
  }
}
