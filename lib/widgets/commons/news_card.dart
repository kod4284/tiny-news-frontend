import 'package:flutter/material.dart';
import 'package:tiny_news/widgets/commons/tiny_icon_button.dart';
import 'package:flutter/services.dart';

class NewsCard extends StatefulWidget {
  final bool isLike;
  final String title;
  final String url;
  final String thumbnailUrl;
  final String cleanUrl;
  final String date;

  const NewsCard({
    Key? key,
    this.isLike = false,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    required this.cleanUrl,
    required this.date,
  }): super(key: key);


  @override
  State<NewsCard> createState() => _NewsCard();
}

class _NewsCard extends State<NewsCard> {
  late bool _isLike;
  
  @override
  void initState() {
    _isLike = widget.isLike;
    super.initState();
  }

  void toggle() {
    setState(() {
      _isLike = !_isLike;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
          child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.thumbnailUrl,
                            height: 200,
                            width: 800,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(6, 7, 6, 7),
                            alignment: Alignment.topLeft,
                            child: Text(widget.title,
                              style: const TextStyle(
                                  fontSize: 20
                              ),
                            )
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: const EdgeInsets.fromLTRB(6, 7, 6, 3),
                                  child: Row(
                                    children: [
                                      Text(widget.cleanUrl),
                                      const Text(" • "),
                                      Text(widget.date)
                                    ],
                                  )
                              ),
                              Container(
                                  width: 100,
                                  height: 22,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TinyIconButton(
                                        icon: _isLike ? Icons.favorite : Icons.favorite_border,
                                        width: 30,
                                        height: 30,
                                        onClick: () => {toggle()},
                                      ),
                                      TinyIconButton(
                                        icon: Icons.share,
                                        width: 30,
                                        height: 25,
                                        onClick: () => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("The news url copied into clipboard"),
                                              )),
                                          Clipboard.setData(ClipboardData(text: widget.url))
                                        },
                                      ),
                                      TinyIconButton(
                                        icon: Icons.feedback,
                                        width: 30,
                                        height: 25,
                                        onClick: () => {},
                                      ),
                                    ],
                                  )
                              )
                          ]),
                      ],
                    )
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.white12,
                ),
              ]
          ),
          onTap: () => {},
        ),
    );
  }
}
