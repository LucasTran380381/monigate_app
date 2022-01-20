package dev.lucas.monigate_app;

import java.util.Date;
import java.util.Objects;

public class TracingModel {
    String userId;
    Date time;
    boolean isSynced;

    public TracingModel(String userId, Date time, boolean isSynced) {
        this.userId = userId;
        this.time = time;
        this.isSynced = isSynced;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TracingModel that = (TracingModel) o;
        return that.userId.equals(this.userId) && _compareTime(that.time);
    }

    private boolean _compareTime(Date time) {
        return this.time.getDate() == time.getDate() && this.time.getMonth() == time.getMonth() && this.time.getYear() == time.getMonth();
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, time, isSynced);
    }
}
