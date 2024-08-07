import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark.dart';
import 'package:spotify/common/widgets/app_bar/basic_app_bar.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify/core/config/constants/app_consts.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor:
            context.isDarkMode ? const Color(0xff2C2B2B) : Colors.transparent,
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(
            height: 30,
          ),
          _favoriteSongs()
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(state.userEntity.imageURL!))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(state.userEntity.email!),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return const Text('Please try again');
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAVORITE SONGS',
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SongPlayerPage(
                                            songEntity:
                                                state.songsEntities[index])));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${AppURLs.coverFirestorage}${state.songsEntities[index].artist} - ${state.songsEntities[index].title}.jpeg?${AppURLs.mediaAlt}'))),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.songsEntities[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        state.songsEntities[index].artist,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(state.songsEntities[index].duration
                                      .toString()
                                      .replaceAll('.', ':')),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  FavoriteButton(
                                    songEntity: state.songsEntities[index],
                                    key: UniqueKey(),
                                    function: () {
                                      context
                                          .read<FavoriteSongsCubit>()
                                          .removeSong(index);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: state.songsEntities.length);
                }
                if (state is FavoriteSongsFailure) {
                  return const Text('Please try again.');
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
