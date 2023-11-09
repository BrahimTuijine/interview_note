import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:interview_note_app/blocs/note/note_bloc.dart';
import 'package:interview_note_app/core/theme/theme_cubit.dart';
import 'package:interview_note_app/model/note.dart';
import 'package:interview_note_app/pages/edit_note_page.dart';
import 'package:interview_note_app/pages/login_page.dart';
import 'package:interview_note_app/pages/note_detail_page.dart';

import '../widget/note_card_widget.dart';

class NotesPage extends HookWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchCntr = useTextEditingController();
    final isSearched = useState<bool>(false);
    useEffect(() {
      context.read<NoteBloc>().add(GetNotesEvent());
      return null;
    }, const []);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Notes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          TextField(
                            controller: searchCntr,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Center(
                        child: ElevatedButton(
                          child: const Text('search'),
                          onPressed: () {
                            BlocProvider.of<NoteBloc>(context)
                                .add(SearchNoteEvent(word: searchCntr.text));
                            isSearched.value = true;
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 12),
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              return IconButton(
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                icon: Icon(state ? Icons.dark_mode : Icons.light_mode),
              );
            },
          ),
          const SizedBox(width: 12),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('By Date'),
                onTap: () => context
                    .read<NoteBloc>()
                    .add(GetNotesEvent(filter: NoteFields.time)),
              ),
              PopupMenuItem(
                child: const Text('By Title'),
                onTap: () => context
                    .read<NoteBloc>()
                    .add(GetNotesEvent(filter: NoteFields.title)),
              )
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return state.listNote.isEmpty
                ? Center(
                    child: Text(
                      'No Notes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  )
                : StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    children: List.generate(
                      state.listNote.length,
                      (index) {
                        final note = state.listNote[index];

                        return StaggeredGridTile.fit(
                          crossAxisCellCount: 1,
                          child: GestureDetector(
                            onTap: () async {
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) =>
                                    NoteDetailPage(note: note),
                              ));
                            },
                            child: NoteCardWidget(note: note, index: index),
                          ),
                        );
                      },
                    ));
          }
          return Container();
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isSearched.value)
            FloatingActionButton(
              // backgroundColor: Colors.black,
              child: const Icon(Icons.refresh),
              onPressed: () {
                searchCntr.text = '';
                BlocProvider.of<NoteBloc>(context)
                    .add(SearchNoteEvent(word: ''));
                isSearched.value = false;
              },
            ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            // backgroundColor: Colors.black,
            child: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddEditNotePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
