package dev.lucas.monigate_app;

import android.app.Notification;
import android.app.Service;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.le.AdvertiseCallback;
import android.bluetooth.le.AdvertiseData;
import android.bluetooth.le.AdvertiseSettings;
import android.bluetooth.le.BluetoothLeAdvertiser;
import android.bluetooth.le.BluetoothLeScanner;
import android.bluetooth.le.ScanCallback;
import android.bluetooth.le.ScanFilter;
import android.bluetooth.le.ScanResult;
import android.bluetooth.le.ScanSettings;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.IBinder;
import android.os.ParcelUuid;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import dev.lucas.monigate_app.models.CloseContact;
import dev.lucas.monigate_app.models.Contact;
import dev.lucas.monigate_app.models.ContactTracing;


public class BleService extends Service {

    public static final int STATUS_SCAN_FINISH = 0;
    public static final int STATUS_SCAN_SETUP = 1;
    public static final int STATUS_SCANNING = 2;

    // Bluetooth scan devices
    private BluetoothScanBroadCast mScanDevicesReceiver;
    private BluetoothAdapter mBluetoothAdapter;
    private int mStatusScanDevices = STATUS_SCAN_FINISH;

    // Bluetooth scan LE
    private BluetoothLeScanner mBluetoothLeScanner;
    private ScanCallback mScanCallback;
    private int mStatusScanBle = STATUS_SCAN_FINISH;

    // Bluetooth broadcast LE
    private BluetoothLeAdvertiser mBluetoothLeAdvertiser;
    private AdvertiseCallback mAdvertiseCallback;
    private int mStatusAdvertising = STATUS_SCAN_FINISH;


    private boolean mIsReport = false;

    private long mLastTimeScanCallBack;

    private static final String TAG = "BLEService";
    private final Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
    private SharedPreferences flutterPref;


    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();

        // Log
        Log.e(TAG, "Starting BLEService");
        // Initialize Bluetooth notification
//        AppUtils.startNotification(this, getApplicationContext());

        initBluetooth();

        initStatus();

        flutterPref = getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE);

        //TODO: Write Timer for Request permission here

    }

    private List<CloseContact> _loadContactTracings() {
        String json = flutterPref.getString("flutter.close_contacts", "not found");
        Log.d(TAG, "_loadContactTracings: " + json);
        if (!json.equals("not found")) {
            return new ArrayList<>(Arrays.asList(gson.fromJson(json, CloseContact[].class)));
        }

        return new ArrayList<>();
    }

    /**
     * Khoi tao cac bien
     */
    private void initBluetooth() {
        // Init
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        mBluetoothLeScanner = BluetoothAdapter.getDefaultAdapter().getBluetoothLeScanner();
        mBluetoothLeAdvertiser = BluetoothAdapter.getDefaultAdapter().getBluetoothLeAdvertiser();
    }

    /**
     * Init status
     */
    private void initStatus() {
        // Flag
        mStatusScanBle = STATUS_SCAN_FINISH;
        mStatusAdvertising = STATUS_SCAN_FINISH;
        mStatusScanDevices = STATUS_SCAN_FINISH;
    }

    private void sendNotification(String dataIntent) {
//        Intent intent = new Intent(this, MainActivity.class);
//        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);

        Notification notification = new NotificationCompat.Builder(this, MyApplication.CHANNEL_ID)
                .setContentTitle("Truy vết tiếp xúc đang hoạt động")
                .setContentText(dataIntent)
                .setSmallIcon(R.mipmap.ic_launcher)
//                .setContentIntent(pendingIntent)
                .build();
        startForeground(1, notification);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.e(TAG, "On Start Command");
        String dataIntent = intent.getStringExtra("key_data_intent");
        sendNotification(dataIntent);
        // TODO: Initialize scheduler like TraceCovidService

        // Check Bluetooth and enable all service
        startAll();

        return START_STICKY;

    }

    private void startAll() {
        startBroadCastBLE();
        startScanBle();
    }

    /**
     * Phat song BLE
     */
    public void startBroadCastBLE() {
        try {
            // Check
            if (mBluetoothLeAdvertiser != null && mStatusAdvertising == STATUS_SCAN_FINISH) {
                // Set lai status
                mStatusAdvertising = STATUS_SCAN_SETUP;

                // Log
                Log.e(TAG, "startBroadCastBle setup");

                // Advertise build
                AdvertiseSettings.Builder advertiseSettings = new AdvertiseSettings.Builder();

                // Setting advertisde
                advertiseSettings.setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY);
                advertiseSettings.setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_LOW);
                advertiseSettings.setConnectable(true);

                // data advertise BLE
                AdvertiseData.Builder builder = new AdvertiseData.Builder();
                builder.setIncludeDeviceName(false);
                builder.setIncludeTxPowerLevel(false);

                // Add Manufacturer
                final SharedPreferences flutterPref = getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE);
                final String userId = flutterPref.getString("flutter.userId", "unknown");
                Log.d(TAG, "startBroadCastBLE: userId" + userId);
//                String userId = "KLMNEF"; //TODO: This should be discussed. How to generate a proper, unique manufacturer data
                builder.addManufacturerData(AppConstants.BLE_ID, userId.getBytes());
                builder.addServiceUuid(AppUtils.BLE_UUID_ANDROID);

                Log.e(TAG, "UUID " + AppUtils.BLE_UUID_ANDROID.toString());
                // Callback start
                mAdvertiseCallback = new AdvertiseCallback() {
                    @Override
                    public void onStartSuccess(AdvertiseSettings settingsInEffect) {
                        super.onStartSuccess(settingsInEffect);
                        // Set bien
                        mStatusAdvertising = STATUS_SCANNING;
                        // Log
                        Log.e(TAG, "Start: BluetoothLeAdvertiser : start : success");
                    }

                    @Override
                    public void onStartFailure(int errorCode) {
                        super.onStartFailure(errorCode);
                        // Set bien
                        mStatusAdvertising = STATUS_SCAN_FINISH;
                        // Log
                        Log.e(TAG, "Start: BluetoothLeAdvertiser : start : fail : Code: " + errorCode);
                    }
                };

                // Start broadCast ble
                mBluetoothLeAdvertiser.startAdvertising(advertiseSettings.build(), builder.build(), mAdvertiseCallback);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Stop broadcast ble
     */
    private void stopBroadcastBle() {
        try {
            // Check phat va stop
            if (mBluetoothLeAdvertiser != null && mAdvertiseCallback != null) {
                mBluetoothLeAdvertiser.stopAdvertising(mAdvertiseCallback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Scan BLE
     */
    public void startScanBle() {
        try {
            // Check
            if (mBluetoothLeScanner != null && mStatusScanBle == STATUS_SCAN_FINISH) {
                // set status
                mStatusScanBle = STATUS_SCAN_SETUP;

                mLastTimeScanCallBack = System.currentTimeMillis();

                // Log
                Log.e(TAG, "startScanBle setup");

                // Setting BLE Scan
                ScanSettings.Builder scanSettings = new ScanSettings.Builder();
                scanSettings.setScanMode(ScanSettings.SCAN_MODE_LOW_LATENCY);
                if (mIsReport) {
                    mIsReport = false;
                    scanSettings.setReportDelay(AppConstants.Config.TIME_SCAN_BLE_REPORT_DELAY);
                } else {
                    mIsReport = true;
                }
                // Build filter
                // Build filter Android
                ScanFilter.Builder scanFilterAndroid = new ScanFilter.Builder();
                scanFilterAndroid.setServiceUuid(AppUtils.BLE_UUID_ANDROID);
                // Add filter
                List<ScanFilter> listFilter = new ArrayList<>();
                listFilter.add(scanFilterAndroid.build());

                final List<TracingModel> tracingModels = new ArrayList<>();


                final String json = flutterPref.getString("flutter.tracing_test", "not found");
                if (!json.contains("not found")) {
//                    final List<TracingModel> tracing = new ArrayList(gson.fromJson(json, TracingModel[].class));
                    final TracingModel[] decode = gson.fromJson(json, TracingModel[].class);
                    tracingModels.addAll(Arrays.asList(decode));
//                    tracingModels = new ArrayList<>(Arrays.asList(decode));
                }


//                tracingModels.add(new TracingModel("test userid", new Date(), false));
//                final Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
//                final String json = gson.toJson(tracingModels);
//                flutterPref.edit().putString("flutter.tracing_test", json).apply();
//                Log.d(TAG, "startScanBle: json: " + json);

                // Callback khi scan bluetooth
                mScanCallback = new ScanCallback() {
                    @Override
                    public void onScanResult(int callbackType, ScanResult result) {
                        Log.e(TAG, "On scan Result");
                        super.onScanResult(callbackType, result);
                        mStatusScanBle = STATUS_SCANNING;
                        byte[] blidContact = result.getScanRecord().getManufacturerSpecificData(AppConstants.BLE_ID);
//                        String deviceName = result.getDevice().getName();
                        int rssi = result.getRssi();
//                        String address = result.getDevice().getAddress();
//                        List<ParcelUuid> serviceUUIDs = result.getScanRecord().getServiceUuids();
//                        Log.d(TAG, "put to share pref");
//                        final SharedPreferences flutterPref = getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE);
//                        flutterPref.edit().putString("flutter.scan", UUID.randomUUID().toString()).apply();
                        final String userId = new String(blidContact, StandardCharsets.UTF_8);
                        final Date time = new Date();
//                        Log.d(TAG, "onScanResult: found userId: " + userId + " in time: " + time + " with rssi: " +rssi);


                        _saveContact(userId, time);


//                        final TracingModel tracing = new TracingModel(userId, time, false);
//
//                        boolean isDuplicate = _checkDuplicateDevice(tracing, tracingModels);
//                        if (!isDuplicate) {
//                            tracingModels.add(new TracingModel(new String(blidContact, StandardCharsets.UTF_8), new Date(), false));
//                        }


//                        Log.e(TAG, "Detect on Scan " + deviceName + " " + rssi + "  " + address
//                                + " Service : " + serviceUUIDs + " Manufacture " + new String(blidContact, StandardCharsets.UTF_8));
                    }

                    @Override
                    public void onBatchScanResults(List<ScanResult> results) {
                        Log.e(TAG, "On batch scan Result");
                        super.onBatchScanResults(results);
                        mStatusScanBle = STATUS_SCANNING;
                        for (ScanResult result : results) {
                            byte[] blidContact = result.getScanRecord().getManufacturerSpecificData(AppConstants.BLE_ID);
                            String deviceName = result.getDevice().getName();
                            int rssi = result.getRssi();
                            String address = result.getDevice().getAddress();
                            List<ParcelUuid> serviceUUIDs = result.getScanRecord().getServiceUuids();
                            Log.e(TAG, "Detect on Batch Scan " + deviceName + " " + rssi + "  " + address
                                    + " Service : " + serviceUUIDs + " Manufacture " + new String(blidContact, StandardCharsets.UTF_8));
                        }
                    }

                    @Override
                    public void onScanFailed(int errorCode) {
                        super.onScanFailed(errorCode);
                        mStatusScanBle = STATUS_SCAN_FINISH;
                        Log.e(TAG, "startScanBle: fail : Code: " + errorCode);
                    }
                };

                // Start scan
                Log.e(TAG, "starting to scan");
                mBluetoothLeScanner.startScan(listFilter, scanSettings.build(), mScanCallback);
//                mBluetoothLeScanner.startScan(mScanCallback);

                // Status
                mStatusScanBle = STATUS_SCANNING;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void _saveContact(String userId, Date time) {
        List<CloseContact> contacts = _loadContactTracings();

        for (CloseContact contact : contacts) {
//            if exist in contact not save
            if (contact.equals(new CloseContact(userId, time))) {
                return;
            }
        }

        contacts.add(new CloseContact(userId, time));

//        Log.d(TAG, "_saveContact: " + gson.toJson(contacts));
//        ContactTracing foundedContactTracing = _getContactTracing(time);
//        if (foundedContactTracing == null){
//            foundedContactTracing = new ContactTracing(time,new ArrayList<>());
//            contactTracings.add(foundedContactTracing);
//        }
//
//        _addNewContact(foundedContactTracing, userId);


        flutterPref.edit().putString("flutter.close_contacts", gson.toJson(contacts)).apply();
    }

    private void _addNewContact(ContactTracing contactTracing, String userId) {
        for (Contact contact : contactTracing.getContacts()) {
            if (contact.getUserId().equals(userId)) {
                return;
            }
        }

        contactTracing.getContacts().add(new Contact(userId, false));
    }


    private boolean _checkDuplicateDevice(TracingModel tracing, List<TracingModel> tracingModels) {
        for (TracingModel tracingModel : tracingModels) {
            if (tracingModel.equals(tracing)) {
                return true;
            }
        }
        return false;
    }


    /**
     * Stop scan ble
     */
    private void stopScanBle() {
        try {
            if (mBluetoothLeScanner != null && mScanCallback != null) {
                Log.e(TAG, "stopping BLE scanning");
                mBluetoothLeScanner.stopScan(mScanCallback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        stopBroadcastBle();
        stopScanBle();
    }


    /**
     * Broadcast để nhận các bluetooth bình thường đã quét đc thiết bị điện thoại và các thiết bị ngoại vi, ...
     */
    class BluetoothScanBroadCast extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            try {
                // nếu tìm thấy
                if (intent.getAction().equals(BluetoothDevice.ACTION_FOUND)) {

                    // lấy dữ liệu
                    BluetoothDevice bluetoothDevice = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
                    int rssi = intent.getShortExtra(BluetoothDevice.EXTRA_RSSI, Short.MIN_VALUE);

                    // Lay ten
                    String name = bluetoothDevice.getName();
                    String address = bluetoothDevice.getAddress();
                    String userIdRN = "";
                    String nameRN = "";
                    String platform = "";
                    int type = 0;

                    Log.e(TAG, "Receive " + name + " rssi : " + rssi + " address : " + address);
                }

                // Check su kien ket thuc
                if (intent.getAction().equals(BluetoothAdapter.ACTION_DISCOVERY_FINISHED)) {
                    // Log
                    Log.e(TAG, "Stop Discovery and restart discovery");

                    // Start
                    // bắt đầu quét.
                    if (!mBluetoothAdapter.startDiscovery()) {
                        // Set bien
                        mStatusScanDevices = STATUS_SCAN_FINISH;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}