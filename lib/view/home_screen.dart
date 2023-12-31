import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news_channels_headlines_models.dart';
import 'package:news/view_model/news_view_model.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MM dd yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(


      appBar: AppBar(
        leading: IconButton(onPressed: (){},
            icon: Image.asset('assets/images/category_icon.png')),
        title: Text('NEWS' ,
          style: GoogleFonts.poppins(fontSize: 24,
              fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),


      body: ListView(
        children: [
          Container(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModels>(
                future: newsViewModel.fetchNewsChannelHeadlinesApi(),
                builder: (BuildContext context, snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }
                  else{
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){

                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());

                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * .02
                                ),
                                height : height * 0.6,
                                width: width * .9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(child: spinKit2,),
                                  errorWidget: (context,url,error) => const Icon(
                                    Icons.error_outline, color: Colors.red,),
                                ),
                              ),
                            ),

                              Positioned(
                                bottom : 10,
                                child: Card(
                                  elevation: 5,
                                  color : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    height: height * .22,
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width* .7,
                                          child: Text(snapshot.data!.articles![index].title.toString(),
                                          maxLines : 2,
                                          overflow : TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),),
                                        ),

                                        Spacer(),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(),
                                              maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                                                    fontSize: 17),
                                              ),

                                              Text(format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                                                    fontSize: 17),
                                              ),

                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]
                          ),

                        );
                      });
                  }
                }),
          )
        ],
      )
    );
  }


}

const spinKit2 = SpinKitCircle(
  color: Colors.amber,
  size: 50,
);
