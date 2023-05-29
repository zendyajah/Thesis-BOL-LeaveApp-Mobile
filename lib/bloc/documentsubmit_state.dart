part of 'documentsubmit_bloc.dart';

abstract class DocumentsubmitState {}

class DocumentsubmitInitial extends DocumentsubmitState {}

class DocumentLoading extends DocumentsubmitState {}

class DocumentSuccess extends DocumentsubmitState {
  final List<DocumentSubmit> documents;
  DocumentSuccess({required this.documents});
}
