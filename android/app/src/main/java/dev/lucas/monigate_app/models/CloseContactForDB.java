package dev.lucas.monigate_app.models;

import java.time.LocalDate;
import java.util.Date;
import java.util.Timer;

public class CloseContactForDB {
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
        return id;
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
