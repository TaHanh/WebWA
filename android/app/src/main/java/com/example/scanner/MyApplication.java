package com.example.scanner;

import com.flurry.android.FlurryAgent;

public class MyApplication extends io.flutter.app.FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        new FlurryAgent.Builder()
                .withLogEnabled(true)
                .build(this, "9RG84W8YY39XGFHK4DFB");
    }
}
