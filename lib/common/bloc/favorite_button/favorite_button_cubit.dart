import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite.dart';
import 'package:spotify/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdated(String songId) async {
    var result =
        await serviceLocator<AddOrRemoveFavoriteUseCase>().call(params: songId);

    result.fold(
      (l) {},
      (r) {
        emit(FavoriteButtonUpdated(isFavorite: r));
      },
    );
  }
}
