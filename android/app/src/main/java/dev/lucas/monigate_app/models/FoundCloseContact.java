package dev.lucas.monigate_app.models;


import java.util.Date;

public class FoundCloseContact {
    private final String userId;
    private final Date firstFoundTime;
    private Date lastFoundTime;

    public FoundCloseContact(String userId) {
        final Date currentDate = new Date();
        this.userId = userId;
        this.lastFoundTime = this.firstFoundTime = currentDate;
    }

    public String getUserId() {
        return userId;
    }

    public int getDuration() {
        return (int) ((lastFoundTime.getTime() - firstFoundTime.getTime()) / 1000);
    }

    public Date getFirstFoundTime() {
        return firstFoundTime;
    }

    public Date getLastFoundTime() {
        return lastFoundTime;
    }

    public void setLastFoundTime(Date lastFoundTime) {
        this.lastFoundTime = lastFoundTime;
    }
}
