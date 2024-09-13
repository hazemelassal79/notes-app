import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes/constants.dart';
import 'package:notes/models/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  List<NoteModel>? notes;
  fecthAllNotes() async {
    var notesBox = Hive.box<NoteModel>(kNotesBox);
    notes = notesBox.values.toList();
    notesBox.watch().listen((event) {
      if (notes?.contains(event.value) ?? true) {
        return;
      }
      notes?.add(event.value);
      emit(FetchNotesSuccess());
    });
  }

  deleteNote(NoteModel note) {
    note.delete();
    notes?.remove(note);
    emit(DeleteNoteSuccess());
  }

  updateNote(NoteModel note, {String? title, String? content}) {
    note.title = title ?? note.title;
    note.subTitle = content ?? note.subTitle;
    note.save();
    emit(FetchNotesSuccess());
  }
}
