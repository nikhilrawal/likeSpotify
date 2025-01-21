import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/domain/entities/song/song_entity.dart';
import 'package:spotify/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NewsSongsCubit()..getNewsSongs(),
        child: SizedBox(
            height: 200,
            child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
              builder: (context, state) {
                if (state is NewsSongsLoaded) {
                  return _songs(state.songs);
                }
                if (state is NewsSongsLoadFailure) {
                  log('this is inside loading failed');
                  return Container();
                }
                ;
                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              },
            )));
  }

  Widget _songs(List<SongEntity> listsongs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SongPlayerPage(songEntity: listsongs[index])));
          },
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppUrls.coverfirestorage +
                              listsongs[index].artist +
                              ' - ' +
                              listsongs[index].title +
                              '.jpg' +
                              AppUrls.mediaAlt)),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 40,
                        width: 40,
                        transform: Matrix4.translationValues(10, 10, 0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode
                                ? AppColors.darkgrey
                                : Color(0xffE6E6E6)),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: context.isDarkMode
                              ? Color(0xff959595)
                              : Color(0xff555555),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  listsongs[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  listsongs[index].artist,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 14,
        );
      },
      itemCount: listsongs.length,
    );
  }
}
