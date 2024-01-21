import 'package:dailyquotes/model/Entities/quote.dart';
import 'package:dailyquotes/model/Models/quoteModel.dart';
import 'package:dailyquotes/model/repositories/iReqRepo.dart';
import 'package:dailyquotes/model/services/Network/local/IlocalService.dart';
import 'package:dailyquotes/model/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/model/services/iReqService.dart';

class ApiReqRepo implements IReqRepo {
  late final IReqService _remoteService;
  late final ILocalService _localService;
  ApiReqRepo({
    required IReqService remoteService,
    required ILocalService localService,
  }) {
    _remoteService = remoteService;
    _localService = localService;
  }

  ///first scenario, get quote from Api then add  it to local Database
  @override
  Future<QuoteModel> reqTodayQuote() async {
    final response = await _remoteService.reqTodayService();
    final model = QuoteModel.fromRemoteJson(response.data[0]);

    await CacheHelper.saveData(
      key: 'date',
      value: DateTime.now().toString(),
    );
    return model;
  }

  ///called once when we first put our first stored quote, after calling reqTodayQuote Function
    @override
  Future<QuoteModel> addTodayQuote(QuoteModel model) async {
    await _localService.addTodayQuote(model.toMap());
    return model;
  }


  ///getting Today's quote from database
  @override
  Future<QuoteModel> getTodayQuote() async {
    var map = await _localService.getTodayQuote();

    return QuoteModel.fromLocalJson(map);
  }

  ///only updates where id =1 as todays quote is always first row and others are favourites, this method only called when we update fav state and when we get todays quote after a day been passed
  @override
  Future<QuoteModel> updateTodayQuote(QuoteModel model) async {
  

    await _localService.updateTodayQuote(model.toMap());

    return model;
  }

  @override
  Future<List<QuoteModel>> getFavQuotes() async {
    var list = await _localService.getFavQuotes();

    final res = list.map((e) => QuoteModel.fromLocalJson(e)).toList();
    return res;
  }

  @override
  Future<void> removeFromFav(String quoteText) async {
    await _localService.removeFromFav(quoteText);
  }


  @override
  Future<void> addFavQuote(QuoteModel model) async {
    await _localService.addFavQuote(model.toMap());
   
  }




 
  @override
  Future<List<Quote>> reqWithKeyRepo({required String keyword}) async {
    final List<Quote> list = [];
    final response = await _remoteService.reqWithKeyService(keyword: keyword);
    (response.data as List).map(
      (e) => list.add(QuoteModel.fromRemoteJson(e)),
    );

    return list;
  } 
}
