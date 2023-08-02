import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:solar_icons/solar_icons.dart';

import 'description_text.dart';

class PodcastDetailsBody extends StatefulWidget {
  const PodcastDetailsBody({
    super.key,
    required this.podcast,
    required this.selectedPodcast,
  });

  final Podcast podcast;
  final Item selectedPodcast;

  @override
  State<PodcastDetailsBody> createState() => _PodcastDetailsBodyState();
}

class _PodcastDetailsBodyState extends State<PodcastDetailsBody> {
  late AudioPlayer _player;
  int _playingEpisodeIndex = -1;

  @override
  void initState() {
    _player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.selectedPodcast.artworkUrl600 ?? '',
                        fit: BoxFit.cover,
                        height: 170,
                        width: 170,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedPodcast.trackName ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.selectedPodcast.artistName ?? '',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                DescriptionTextWidget(
                  text: widget.podcast.description ?? '',
                ),
                const SizedBox(height: 30),
                Text(
                  'All Episodes (${widget.podcast.episodes.length})',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: widget.podcast.episodes.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final episode = widget.podcast.episodes[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.podcast.image ?? '',
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    title: Text(
                      episode.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      episode.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${episode.publicationDate?.year == DateTime.now().year ? DateFormat.MMMd().format(episode.publicationDate!) : DateFormat.yMMMd().format(episode.publicationDate!)}  • ${episode.duration?.inMinutes} min',
                          style: const TextStyle(
                            fontSize: 9,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (episode.contentUrl == null) return;
                            setState(() {
                              _playingEpisodeIndex = index;
                            });
                            if (_playingEpisodeIndex == index &&
                                _player.playing) {
                              _player.pause();
                              _playingEpisodeIndex = -1;
                              return;
                            }
                            _player.setUrl(episode.contentUrl!);
                            _player.play();
                          },
                          child: Icon(
                            _playingEpisodeIndex == index
                                ? SolarIconsBold.pauseCircle
                                : SolarIconsBold.playCircle,
                            size: 30,
                          ),
                        ),
                      ]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
