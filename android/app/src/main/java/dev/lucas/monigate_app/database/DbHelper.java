package dev.lucas.monigate_app.database;

import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import java.text.SimpleDateFormat;

import dev.lucas.monigate_app.models.CloseContactForDB;

public class DbHelper extends SQLiteOpenHelper {
    private static final String DATABASE_NAME = "monigate";
    private static final String TAG = "DBHelper";


    public DbHelper(Context context) {
        super(context, DATABASE_NAME, null, 2);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        Log.d(TAG, "onCreate: database");
        String createCloseContactsTable = "Create table closeContacts(id text primary key, userId text, contactWithUserId text, date text, isSynced integer)";
        String createNotificationTable = "Create table notifications(id text primary key, sourceUserId text, dateRange integer, dateReceived text)";

        db.execSQL(createCloseContactsTable);
        db.execSQL(createNotificationTable);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int i, int i1) {
////        Log.d(TAG, "onUpgrade: database");
//        String dropSqlCommand = "drop table notificaion";
//        db.execSQL(dropSqlCommand);
    }

    public void addCloseContact(CloseContactForDB closeContact) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        SQLiteDatabase db = this.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("id", closeContact.getId());
        Log.d(TAG, "addCloseContact: with id " + closeContact.getId());
        values.put("userId", closeContact.getUserId());
        values.put("date", formatter.format(closeContact.getDate()));
        values.put("contactWithUserId", closeContact.getContactWithUserId());
        values.put("isSynced", 0);

        long result = db.insert("closeContacts", null, values);
        Log.d(TAG, "addCloseContact: " + result);
        db.close();
    }


}
