import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecases/usecase.dart';
import 'package:spotify/domain/repository/song/song.dart';
import 'package:spotify/service_locator.dart';

class GetUserFavoriteSongsUseCase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await serviceLocator<SongRepository>().getUserFavoriteSongs();
  }
}
