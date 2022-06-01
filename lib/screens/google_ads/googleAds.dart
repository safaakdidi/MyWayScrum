import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleads/Layout/theme_helper.dart';
import 'package:googleads/api/ads_manager_api/ads_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:googleads/Layout/footer.dart';
import 'package:googleads/Layout/header_widget.dart';
import 'package:hexcolor/hexcolor.dart';
class GoogleAds extends StatefulWidget {

  @override
  State<GoogleAds> createState() => _GoogleAdsState();
}

class _GoogleAdsState extends State<GoogleAds> {
  late RewardedAd _rewardedAd ;
  bool _isRewardedAdReady = false ;
  var _balance = 0 ;
  @override
  void initState() {
    _initGoogleMobileAds() ;
    _loadRewardedAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 150 ;
    Color _primaryColor = HexColor('#80FF72');
    Color _accentColor = HexColor('#7EE8FA') ;
    return Scaffold(
        appBar: AppBar(
          title: Text("Ads Page" ,
              style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
          ),
          elevation: 0.5 ,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end : Alignment.bottomRight ,
                    colors: <Color>[Theme.of(context).primaryColor , Theme.of(context).accentColor]
                ),
              )
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(top: 16, right: 16),
                child:Stack(
                  children: <Widget>[
                    Icon(Icons.notifications),
                    Positioned(right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6),),
                          constraints : BoxConstraints(minWidth: 12 , minHeight: 12) ,
                          child: Text('5', style: TextStyle(color: Colors.white , fontSize: 8), textAlign: TextAlign.center,),


                        ))
                  ],
                )
            )
          ],
        ),
        body:Stack(

          children: [
            Center(
              child: Container(

                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,colors: [_accentColor,Colors.white,Colors.white]),
                ),
              ),
            ),
            Container( height: _headerHeight,
                child : HeaderWidget(_headerHeight, false,Icons.notifications_active )),
            Positioned(
              top: 150,
              child: Column(
                children: [
                  Container(
                      child:Lottie.asset('assets/67203-3d-coin.json',
                        height: MediaQuery.of(context).size.width/2.5,
                        width: MediaQuery.of(context).size.height/2,
                      )
                  ),
                  Center(
                    child :Text(
                      'Your balance is : ' ,
                      style:Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Center(
                    child: Text(
                      '$_balance',
                      style:Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 50.0,
                    child: RaisedButton(
    onPressed: (){
    _showRewardedAd() ;
    },
                      shape: ThemeHelper().Shape(),
                      padding: EdgeInsets.all(0.0),
                      child:ThemeHelper().inkStyle(context,"Submit") ,
                    ),
                  ),


                ],
              ),
            ),
            Footer(),
          ],
        )

    );
  }
  Future<InitializationStatus>_initGoogleMobileAds(){
    return MobileAds.instance.initialize() ;
  }
  void _loadRewardedAd(){
    RewardedAd.load(
        adUnitId: AdsManager.rewardedAdUnitId,
        request: const AdRequest() ,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad){
              setState(() =>_rewardedAd=ad);
              ad.fullScreenContentCallback = FullScreenContentCallback(onAdDismissedFullScreenContent: (ad){
                setState(() => _isRewardedAdReady= false);
                _loadRewardedAd();

              });
              setState(()=>_isRewardedAdReady=true);
            },
            onAdFailedToLoad:(errer){
              print('Failed to load $errer');
            })
    ) ;
  }
//show Rewarded Ad
  void _showRewardedAd(){
    _rewardedAd.show(onUserEarnedReward:(AdWithoutView ad , RewardItem item){
      setState(() =>_balance += item.amount.toInt() );
    });
  }
}
