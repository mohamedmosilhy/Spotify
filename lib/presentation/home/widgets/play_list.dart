import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark.dart';
import 'package:spotify/core/config/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotify/presentation/home/bloc/play_list_state.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if (state is PlayListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PlayList",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        "See More",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xffc6c6c6)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _songs(state.songs),
                ],
              ),
            );
          }

          return const Text("No PlayLists Founded.");
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0), // Add padding for better spacing
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : const Color(0xffE6E6E6),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode
                          ? const Color(0xff959595)
                          : const Color(0xff555555),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index].title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        songs[index].artist,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(songs[index].duration.toString().replaceAll(".", ":")),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: songs.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
    );
  }
}
