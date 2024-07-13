import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecases/usecase.dart';
import 'package:spotify/domain/repository/song/song.dart';
import 'package:spotify/service_locator.dart';

class AddOrRemoveFavoriteUseCase extends Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await serviceLocator<SongRepository>()
        .addOrRemoveFavouriteSongs(params!);
  }
}
