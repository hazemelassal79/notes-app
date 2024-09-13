part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class FetchNotesSuccess extends NotesState {}
class DeleteNoteSuccess extends NotesState {}
