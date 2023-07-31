import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';

import 'description_text.dart';

class PodcastDetailsBody extends StatelessWidget {
  const PodcastDetailsBody({
    super.key,
    required this.podcast,
    required this.selectedPodcast,
  });

  final Podcast podcast;
  final Item selectedPodcast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      selectedPodcast.artworkUrl600 ?? '',
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
                          selectedPodcast.trackName ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          selectedPodcast.artistName ?? '',
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
                text: podcast.description ?? '',
              ),
              const SizedBox(height: 30),
              Text(
                'All Episodes (${podcast.episodes.length})',
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
          itemCount: podcast.episodes.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final episode = podcast.episodes[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  podcast.image ?? '',
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
            );
          },
        ),
      ]

          /*  Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: podcast.episodes.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final episode = podcast.episodes[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        podcast.image ?? '',
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
                  );
                },
              ),
            ), */

          ),
    );
  }
}
