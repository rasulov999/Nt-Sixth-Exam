import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nt_sixth_exam/data/model/card_model.dart';
import 'package:nt_sixth_exam/data/repository/cards_repository.dart';


part 'add_card_event.dart';

part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  AddCardBloc(this.cardRepository)
      : super(
          const AddCardState(
            status: Status.pure,
          ),
        ) {
    on<AddCard>(_addCard);
  }

  final CardRepository cardRepository;

  _addCard(AddCard event, Emitter<AddCardState> emit) async {
    emit(state.copyWith(status: Status.loading));
    var isAdded = await cardRepository.addCard(cardModel: event.cardModel);
    if (isAdded) {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }
}
