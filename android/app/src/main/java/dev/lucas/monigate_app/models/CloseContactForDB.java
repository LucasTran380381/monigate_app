package dev.lucas.monigate_app.models;

import android.util.Log;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

public class CloseContactForDB {
    private final String TAG = this.getClass().toString();
    private String id, userId, contactWithUserId;
    private Date date;
    private boolean isSynced;

    public CloseContactForDB(String contactWithUserId, String userId) {
        this.contactWithUserId = contactWithUserId;
        this.userId = userId;
        this.date = _generateDate();
        this.id = _generateId();
        this.isSynced = false;
    }

    private Date _generateDate() {
        Date currentDate = new Date();
        currentDate.setMinutes(0);
        currentDate.setHours(0);
        currentDate.setSeconds(0);
        return currentDate;
    }

    private String _generateId() {
        return contactWithUserId + date.getDate() + date.getMonth() + date.getYear();
    }

    public String getId() {
        Date currentDate = new Date();
        String formattedDate = new SimpleDateFormat("dd/MM/yy").format(currentDate);
        return contactWithUserId + "/" + formattedDate;
    }

    public String getUserId() {
        return userId;
    }

    public String getContactWithUserId() {
        return contactWithUserId;
    }

    public Date getDate() {
        return date;
    }

    public boolean isSynced() {
        return isSynced;
    }
}
