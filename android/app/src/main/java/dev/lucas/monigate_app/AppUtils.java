package dev.lucas.monigate_app;

import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.ParcelUuid;
import android.text.TextUtils;
import android.util.Log;

import androidx.core.app.NotificationCompat;
import androidx.core.content.ContextCompat;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;
import java.util.UUID;

import static androidx.core.app.NotificationCompat.PRIORITY_MIN;

public class AppUtils {

    public static final ParcelUuid BLE_UUID_ANDROID = new ParcelUuid(UUID.fromString(AppConstants.BLE_UUID_ANDROID));
    public static final ParcelUuid BLE_UUID_IOS = new ParcelUuid(UUID.fromString(AppConstants.BLE_UUID_IOS));
    public static final UUID BLE_UUID_CHARECTIC = UUID.fromString(AppConstants.BLE_UUID_CHARECTIC);
    public static final ParcelUuid BLE_UUID_TEST = new ParcelUuid(UUID.fromString("25AE1441-05D3-4C5B-8281-93D4E07420CF"));

    private static NotificationManager notificationManager;
    private static NotificationCompat.Builder notificationBuider;
    private static Notification notification;
    /**
     * Tao notify chanel cho app
     * @param context
     */
    public static void startNotification(Service service, Context context) {
        // Check SDK
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Tao notifi
            AppUtils.createNotificationBluezone(context);

            // check and start
            if (notification != null) {
                service.startForeground(AppConstants.NOTIFICATION_SERVICE_BLUE_ZONE_ID, notification);
            }
        }
    }

    /**
     * Tạp notification cho app
     * @param context
     */
    public static void createNotificationBluezone(Context context) {
        try {
            // Tạo channel
            createNotificationChannel(context);
            createNotification(context);
            notification = notificationBuider.build();
            notificationManager.notify(AppConstants.NOTIFICATION_SERVICE_BLUE_ZONE_ID, notification);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Tao notify chanel cho app
     * @param context
     */
    public static void createNotificationChannel(Context context) {
        // Check
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel serviceChannel = new NotificationChannel(
                    AppConstants.NOTIFICATION_CHANNEL_ID,
                    AppConstants.NOTIFICATION_CHANNEL_NAME,
                    NotificationManager.IMPORTANCE_DEFAULT);

            // create
            notificationManager = context.getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(serviceChannel);
        }
    }

    public static void createNotification(Context context) {
        Intent notificationIntent = new Intent(context, MainActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(context,
                AppConstants.NOTIFICATION_CHANNEL_ID_CODE, notificationIntent, 0);

        String content = "Bluetooth foreground service";
        String title = "Bluetooth is scanning";
        // Tao thong bao
        notificationBuider = new NotificationCompat.Builder(context, AppConstants.NOTIFICATION_CHANNEL_ID)
                .setPriority(PRIORITY_MIN)
                .setContentTitle(title)
                .setStyle(new NotificationCompat.BigTextStyle().bigText(content))
                .setContentText(content)
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentIntent(pendingIntent);
//                .setNumber(AppConstants.NOTIFY_SERVICE_NUMBER);
    }


}