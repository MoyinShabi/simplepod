import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({
    super.key,
    required this.text,
  });

  @override
  State<DescriptionTextWidget> createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();
    _splitText();
  }

  void _splitText() {
    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  void didUpdateWidget(covariant DescriptionTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _splitText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              (flag ? firstHalf : (firstHalf + secondHalf))
                  .replaceAll(r'\n', '\n')
                  .replaceAll(r'\r', '')
                  .replaceAll(r"\'", "'"),
              style: const TextStyle(
                fontSize: 10.5,
              ),
            )
          : Column(
              children: [
                Text.rich(
                  TextSpan(
                      text:
                          (flag ? ('$firstHalf...') : (firstHalf + secondHalf))
                              .replaceAll(r'\n', '\n\n')
                              .replaceAll(r'\r', '')
                              .replaceAll(r"\'", "'"),
                      style: const TextStyle(
                        fontSize: 10.5,
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            child: Text(
                              flag ? ' see more' : ' show less',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                flag = !flag;
                              });
                            },
                          ),
                        )
                      ]),
                ),
              ],
            ),
    );
  }
}


  /*  RichReadMoreText.fromString(
            text: podcast.description ?? '',
            textStyle: const TextStyle(
              fontSize: 10.5,
            ),
            settings: LengthModeSettings(
              trimLength: 150,
              trimCollapsedText: 'see more',
              trimExpandedText: ' show less',
              onPressReadMore: () {
                /// specific method to be called on press to show more
              },
              onPressReadLess: () {
                /// specific method to be called on press to show less
              },
              lessStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              moreStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ), */
          /*  ParsedReadMore(
            podcast.description ?? '',
            urlTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
            trimMode: TrimMode.line,
            trimLines: 3,
            delimiter: '... ',
            delimiterStyle:
                const TextStyle(color: Colors.black, fontSize: 10.5),
            style: const TextStyle(fontSize: 10.5),
            onTapLink: null,
            /* (url) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '$url is displayed because we have used custom onTap function for hyperlinks'),
                ),
              );
            }, */
            trimCollapsedText: 'see more',
            trimExpandedText: 'show less',
            moreStyle: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
            lessStyle: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ), */