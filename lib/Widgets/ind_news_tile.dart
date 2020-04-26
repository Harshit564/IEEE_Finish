import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListTile extends StatelessWidget {
  final String newsTitle;
  final String newsDescription;
  final String imageUrl;
  final String webUrl;

  NewsListTile({
    @required this.imageUrl,
    @required this.newsTitle,
    @required this.newsDescription,
    @required this.webUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Color(0xffCBE7EA),
          elevation: 8.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => Center(
                      child: Container(
                        width: 100.0,
                        height: 50.0,
                        child: Center(
                          child: Text(
                            'Loading...',
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  bottom: 5.0,
                  right: 8.0,
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        newsTitle,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                        //textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Divider(
                  thickness: 1.0,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  bottom: 8.0,
                  right: 8.0,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    newsDescription,
                    style: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              /*            Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  bottom: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  children: <Widget>[
                    Text('Visit Website: ',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        //color: Color(0xff607D8B),
                      ),),
                    Link(
                      child: Text('Tap to visit the Website',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.blue,
                            decoration: TextDecoration.underline
                        ),
                      ),
                      url: webUrl,
                    )
                  ],
                ),
              ),
*/

              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  bottom: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Visit Website: ',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                          //color: Color(0xff607D8B),
                          ),
                    ),
                    InkWell(
                        child: new Text(
                          'Tap to visit the Website',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () => launch(webUrl)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
