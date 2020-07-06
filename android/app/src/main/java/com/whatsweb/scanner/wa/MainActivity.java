package com.whatsweb.scanner.wa;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

import com.example.ratedialog.RatingDialog;
import com.whatsweb.scanner.wa.utils.*;
import com.whatsweb.scanner.wa.utils.adx.Config;
import com.google.gson.Gson;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterMain;

public class MainActivity extends FlutterActivity implements RatingDialog.RatingDialogInterFace {
    private static final String CHANNEL = "my_module";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
//    initCompanyAd();
        FlutterMain.startInitialization(this);
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {

                        switch (call.method) {
                            case "change":
                                break;
                            case "openAnotherApp":
                                open(call.argument("data"), result);
                                break;
                            case "rateAuto":
                                rateAuto();
                                break;
                            case "rateManual":
                                rateManual();
                                break;
                            case "goToMarket":
                                goToMarket();
                                break;
                            case "getAppId":
                                result.success(getPackageName());
                                break;
                            case "moveToNewApp":
                                moveToNewApp(call.argument("newAppId"));
                                break;
                            case "getAppIdAds":
//                                result.success(com.whatsweb.scanner.webscan.utils.adx.SharedPrefsUtils.getInstance(MainActivity.this).getString());
                                break;
                            case "getIdBanner":
                                result.success(SharedPrefsUtils.getInstance(MainActivity.this).getString(Config.AD_BANNER));
                                break;
                            case "getIdInter":
                                result.success(SharedPrefsUtils.getInstance(MainActivity.this).getString(Config.AD_INTERSTITIAL));
                                break;
                            case "getIsShowBanner":
                                result.success(SharedPrefsUtils.getInstance(MainActivity.this).getBoolean(Config.IS_SHOW_BANNER));
                                break;
                            case "getIsShowInter":
                                result.success(SharedPrefsUtils.getInstance(MainActivity.this).getBoolean(Config.IS_SHOW_INTER));
                                break;
                            case "getAds": {
                                result.success(new Gson().toJson(new Ads(SharedPrefsUtils.getInstance(MainActivity.this).getString(Config.AD_BANNER),
                                        SharedPrefsUtils.getInstance(MainActivity.this).getString(Config.AD_INTERSTITIAL),
                                        SharedPrefsUtils.getInstance(MainActivity.this).getBoolean(Config.IS_SHOW_INTER),
                                        SharedPrefsUtils.getInstance(MainActivity.this).getBoolean(Config.IS_SHOW_BANNER))));
                                break;
                            }
                        }

                    }
                });
//        rateAuto();
    }

    public class Ads {

        @SerializedName("ad_banner_id")
        @Expose
        private String adBannerId;
        @SerializedName("ad_inter_id")
        @Expose
        private String adInterId;
        @SerializedName("is_show_inter")
        @Expose
        private Boolean isShowInter;
        @SerializedName("is_show_banner")
        @Expose
        private Boolean isShowBanner;

        public String getAdBannerId() {
            return adBannerId;
        }

        public void setAdBannerId(String adBannerId) {
            this.adBannerId = adBannerId;
        }

        public String getAdInterId() {
            return adInterId;
        }

        public void setAdInterId(String adInterId) {
            this.adInterId = adInterId;
        }

        public Boolean getIsShowInter() {
            return isShowInter;
        }

        public void setIsShowInter(Boolean isShowInter) {
            this.isShowInter = isShowInter;
        }

        public Boolean getIsShowBanner() {
            return isShowBanner;
        }

        public void setIsShowBanner(Boolean isShowBanner) {
            this.isShowBanner = isShowBanner;
        }

        public Ads(String adBannerId, String adInterId, Boolean isShowInter, Boolean isShowBanner) {
            this.adBannerId = adBannerId;
            this.adInterId = adInterId;
            this.isShowInter = isShowInter;
            this.isShowBanner = isShowBanner;
        }
    }

    void moveToNewApp(String appId) {
        Intent intent = new Intent(new Intent(Intent.ACTION_VIEW,
                Uri.parse("http://play.google.com/store/apps/details?id=" + appId)));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);

    }

    void open(String magnet, MethodChannel.Result result) {

        Intent browserIntent = new Intent(Intent.ACTION_VIEW);
        browserIntent.setData(Uri.parse(magnet));

        try {
            startActivity(browserIntent);
            result.success(true);

        } catch (ActivityNotFoundException ex) {
            Log.d("dddddd", "abcd");

            result.success(false);
        }
    }

    void goToMarket() {
        Intent goToMarket = new Intent(Intent.ACTION_VIEW).setData(Uri.parse("market://search?q=torrent clients"));
        startActivity(goToMarket);
    }

    public static void rateApp(Context context) {
        Intent intent = new Intent(new Intent(Intent.ACTION_VIEW,
                Uri.parse("http://play.google.com/store/apps/details?id=" + context.getPackageName())));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

        context.startActivity(intent);


    }

    public void rateAuto() {
        int rate = SharedPrefsUtils.getInstance(this).getInt("rate");
        if (rate < 1) {
            RatingDialog ratingDialog = new RatingDialog(this);
            ratingDialog.setRatingDialogListener(this);
            ratingDialog.showDialog();
            SharedPrefsUtils.getInstance(this).putInt("rate", 5);
        }

    }

    void rateManual() {
        RatingDialog ratingDialog = new RatingDialog(this);
        ratingDialog.setRatingDialogListener(this);
        ratingDialog.showDialog();
    }

    @Override
    public void onDismiss() {
    }

    @Override
    public void onSubmit(float rating) {
        if (rating > 3) {
            rateApp(this);
            SharedPrefsUtils.getInstance(this).putInt("rate", 5);
        }
    }

    @Override
    public void onRatingChanged(float rating) {
    }
}
