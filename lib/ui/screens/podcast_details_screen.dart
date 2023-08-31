import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:simplepod/core/services/podcast_service.dart';

import '../components/podcast_details_body.dart';

class PodcastDetailsScreen extends StatelessWidget {
  final Item selectedPodcast;
  const PodcastDetailsScreen({super.key, required this.selectedPodcast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
            final Podcast? podcastDetails = snapshot.data;
            if (podcastDetails == null) {
              return const Center(
                child: Text('Sorry, podcast details not available...'),
              );
            }
            return PodcastDetailsBody(
                podcast: podcastDetails, selectedPodcast: selectedPodcast);
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
      ),
    );
  }
}
