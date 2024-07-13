import 'package:spotify/core/usecases/usecase.dart';
import 'package:spotify/domain/repository/song/song.dart';
import 'package:spotify/service_locator.dart';

class IsFavoriteUseCase extends Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await serviceLocator<SongRepository>().isFavouriteSong(params!);
  }
}
