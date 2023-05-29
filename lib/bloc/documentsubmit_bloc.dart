import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_application/model/documentsubmit.dart';
import 'package:http/http.dart' as http;
part 'documentsubmit_event.dart';
part 'documentsubmit_state.dart';

class DocumentsubmitBloc
    extends Bloc<DocumentsubmitEvent, DocumentsubmitState> {
  final String apiURL;
  DocumentsubmitBloc(this.apiURL) : super(DocumentsubmitInitial()) {
    on<GetDocumentEvent>((event, emit) async {
      emit(DocumentLoading());
      final respon = await http.get(Uri.parse(apiURL));

      emit(DocumentSuccess(documents: documentSubmitFromJson(respon.body)));
    });
  }
}
