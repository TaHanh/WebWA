package com.whatsweb.scanner.wa.utils.adx;

import android.content.Intent;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ProgressBar;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.whatsweb.scanner.wa.R;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.MobileAds;

import org.json.JSONObject;

import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class SplashActivity extends AppCompatActivity {

    //    private InterstitialAdsManager adsManager;
    private int reCount;
    ProgressBar progressLoading;
    FrameLayout frmAds;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.layout);
        initView();
        new Async().execute();
        MobileAds.initialize(this, getString(R.string.app_ad_id));
    }

    private void initView() {
        progressLoading = findViewById(R.id.progressLoading);
        frmAds = findViewById(R.id.frmAds);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            progressLoading.setProgressTintList(ColorStateList.valueOf(Color.RED));
        }
    }

//    void initAd(int mode) {
//        String banner = SharedPrefsUtils.getInstance(SplashActivity.this).getString(Config.AD_BANNER);
//        String inter = SharedPrefsUtils.getInstance(SplashActivity.this).getString(Config.AD_INTERSTITIAL);
//        if (mode == 1) {
//            SplashAdRequest adRequest = new SplashAdRequest();
//            adRequest.setBannerId(banner);
//            adRequest.setBannerHidePercent(0);
//            adRequest.setInterId(inter);
//            adRequest.setResLogo(R.mipmap.ic_launcher);
//            adRequest.setResBanner(R.mipmap.ic_launcher);
//            adRequest.setAlwayShowAd(true);
//            AdsExchange.loadSplashAd(this, adRequest);
//        } else {
//            adsManager = new InterstitialAdsManager();
//            adsManager.init(true, this, inter, "#000000", getString(R.string.app_name));
//        }
//    }

    @Override
    protected void onResume() {
        super.onResume();
        reCount++;
//        if (adsManager != null)
//            adsManager.onResume();
//
//        if ((adsManager == null && reCount == 2) || (adsManager != null && reCount == 3)) {
//            Intent intent = new Intent(SplashActivity.this, Config.MAIN);
//            startActivity(intent);
//            finish();
//        }
    }

    private String decrypt(String seed, String encrypted) throws Exception {
        byte[] keyb = seed.getBytes("UTF-8");
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] thedigest = md.digest(keyb);
        SecretKeySpec skey = new SecretKeySpec(thedigest, "AES/ECB/PKCS7Padding");
        Cipher dcipher = Cipher.getInstance("AES/ECB/PKCS7Padding");
        dcipher.init(Cipher.DECRYPT_MODE, skey);

        byte[] clearbyte = dcipher.doFinal(toByte(encrypted));
        return new String(clearbyte);
    }

    private byte[] toByte(String hexString) {
        int len = hexString.length() / 2;
        byte[] result = new byte[len];
        for (int i = 0; i < len; i++)
            result[i] = Integer.valueOf(hexString.substring(2 * i, 2 * i + 2), 16).byteValue();
        return result;
    }

    class Async extends AsyncTask<Void, Void, JSONObject> {

        @Override
        protected JSONObject doInBackground(Void... voids) {
            HttpJsonParser jsonParser = new HttpJsonParser();
            return jsonParser.makeHttpRequest(Config.API, "GET", null);
        }

        @Override
        protected void onPostExecute(JSONObject s) {
            super.onPostExecute(s);


            try {
                String data = decrypt(Config.ADX_API_KEY, Config.AD_DATA_DEFAULT);
//                JSONObject adObject = new JSONObject(data);

                String banner = "";
                String interstitial = "";
                boolean isShowBanner = false;
                boolean isShowInter = false;
                int mode = 1;

                if (s != null) {
//                    adObject = new JSONObject(decrypt(Config.ADX_API_KEY, s.getString("data")));
                    banner = s.getString("ad_banner_id");
                    interstitial = s.getString("ad_inter_id");
                    isShowBanner = s.getBoolean("is_show_banner");
                    isShowInter = s.getBoolean("is_show_inter");
//                    mode = adObject.getInt("ad_mode");
                }

                SharedPrefsUtils sharedPrefsUtils = SharedPrefsUtils.getInstance(SplashActivity.this);
                sharedPrefsUtils.putString(Config.AD_BANNER, banner);
                sharedPrefsUtils.putString(Config.AD_INTERSTITIAL, interstitial);
                sharedPrefsUtils.putBoolean(Config.IS_SHOW_INTER, isShowInter);
                sharedPrefsUtils.putBoolean(Config.IS_SHOW_BANNER, isShowBanner);
                Log.d("TAG", "onPostExecute: " + interstitial + "  " + banner + " " + isShowBanner + " " + isShowInter);
                progressLoading.setVisibility(View.GONE);
                if (isShowBanner) {
                    AdView adView = new AdView(SplashActivity.this);
                    adView.setAdUnitId(banner);
                    adView.setAdSize(AdSize.MEDIUM_RECTANGLE);
                    adView.loadAd(new AdRequest.Builder().build());
                    frmAds.removeAllViews();
                    frmAds.addView(adView);
                    new Handler().postDelayed(new Runnable() {
                                                  @Override
                                                  public void run() {
                                                      intentToMain();
                                                  }
                                              }, 5000
                    );
                } else {
                    intentToMain();
                }
//                initAd(mode);
            } catch (Exception e) {
                SharedPrefsUtils sharedPrefsUtils = SharedPrefsUtils.getInstance(SplashActivity.this);
                sharedPrefsUtils.putString(Config.AD_BANNER, "");
                sharedPrefsUtils.putString(Config.AD_INTERSTITIAL, "");
                sharedPrefsUtils.putBoolean(Config.IS_SHOW_INTER, false);
                sharedPrefsUtils.putBoolean(Config.IS_SHOW_BANNER, false);
                intentToMain();
                e.printStackTrace();
            }

        }
    }

    private void intentToMain() {
        Intent intent = new Intent(SplashActivity.this, Config.MAIN);
        SplashActivity.this.startActivity(intent);
        finish();
    }
}
