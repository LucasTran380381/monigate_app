package dev.lucas.monigate_app.models;

import android.provider.ContactsContract;

import java.util.Date;
import java.util.Objects;

public class CloseContact {
    private String id, userId;
    private Date date;
    private boolean isSynced;

    public CloseContact(String userId, Date date) {
        this.userId = userId;
        this.date = _generateDate(date);
        this.id = _generateId();
        this.isSynced = false;
    }

    public CloseContact(String id, String userId, Date date, boolean isSynced) {
        this.id = id;
        this.userId = userId;
        this.date = date;
        this.isSynced = isSynced;
    }

    private Date _generateDate(Date date) {
        return new Date(date.getYear(), date.getMonth(), date.getDate());
    }

    private String _generateId() {
        return userId + date.getDate() + date.getMonth() + date.getYear();
    }

    public String getId() {
        return id;
    }

    public String getUserId() {
        return userId;
    }

    public Date getDate() {
        return date;
    }

    public boolean isSynced() {
        return isSynced;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CloseContact that = (CloseContact) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, userId, date, isSynced);
    }
}
