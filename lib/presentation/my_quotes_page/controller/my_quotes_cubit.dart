import 'package:dailyquotes/core/di/injection.dart';

import 'package:dailyquotes/data/repositories/quote_repo.dart';
import 'package:dailyquotes/presentation/my_quotes_page/controller/my_quotes_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/domain/entity/quote_entity.dart';

class MyQuotesCubit extends Cubit<MyQuotesPageStates> {
  MyQuotesCubit() : super(MyQuotesPageInitialState());

  List<QuoteEntity> myQuotes = [];

  getMyQuotes() async {
    emit(GetMyQuotesPageLoadingState());

    final res = await locators.get<QuoteRepo>().getMyQuotesPage();

    if (res.isSuccess) {
      myQuotes = res.data!;
      emit(GetMyQuotesPageSuccessState());
    } else {
      emit(GetMyQuotesPageErrorState(res.errorMessage!));
    }
  }

  removeMyQuote(int id) {
    emit(RemoveMyQuoteLoadingState());
    locators.get<QuoteRepo>().deleteMyQuote(id).then((value) {
      emit(RemoveMyQuoteSuccessState());
      getMyQuotes();
    }).catchError((onError) {
      emit(RemoveMyQuoteErrorState(onError.toString()));
    });
  }

  shareQuote(QuoteEntity quote) async {
    try {
      await Share.share(
        '“${quote.quote}”\n\n- ${quote.author}\n\n\n$sharingMyGit',
      );
    } catch (e) {
      emit(SharingQuoteErrorState(e.toString()));
    }
  }
}
