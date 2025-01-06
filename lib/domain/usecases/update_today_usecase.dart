import '../../core/helpers/api_result_helper.dart';
import '../../data/repositories/quote_repo.dart';
import '../entity/quote_entity.dart';

class UpdateTodayQuoteUseCase {
  final QuoteRepo _quoteRepo;

  UpdateTodayQuoteUseCase(this._quoteRepo);

  Future<ApiResult> updateTodayQuote(QuoteEntity entity) async {
    entity.toggleFav();
    print('55555555555555555555555555555 ${entity.fav}');

    return await _quoteRepo.updateTodayQuote(entity);
  }
}