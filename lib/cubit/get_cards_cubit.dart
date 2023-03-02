import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nt_sixth_exam/cubit/get_cards_state.dart';
import 'package:nt_sixth_exam/data/repository/cards_repository.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit(
    this.reviewRepository,
  ) : super(InitialCardsState()) {
    _fetchReviewsInfo();
  }

  final CardRepository reviewRepository;

  _fetchReviewsInfo() async {
    emit(LoadCardsInProgress());
    reviewRepository.getCards().listen((reviews) {
      emit(LoadCardsInSuccess(cardModel: reviews));
    });
  }
}
