import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:simplepod/core/services/podcast_service.dart';

class PodcastDetailsScreen extends StatelessWidget {
  final Item selectedPodcast;
  const PodcastDetailsScreen({super.key, required this.selectedPodcast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: FutureBuilder<Podcast>(
          future: PodcastService()
              .getPodcastDetails(feedUrl: selectedPodcast.feedUrl),
          builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
            if (snapshot.hasData) {
              final podcast = snapshot.data;
              if (podcast == null) {
                return const Center(
                  child: Text('Sorry, podcast details not available...'),
                );
              }
              return PodcastDetailsBody(
                  podcast: podcast, selectedPodcast: selectedPodcast);
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                    'Oops! Something went wrong. Please check your internet connection.'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  podcast.image ?? '',
                  fit: BoxFit.cover,
                  height: 170,
                  width: 170,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedPodcast.trackName ?? '',
                      style: const TextStyle(
                        fontSize: 20,
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
        ],
      ),
    );
  }
}
