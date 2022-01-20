package dev.lucas.monigate_app.models;

public class Contact {
    private String userId;
    private boolean isSynced;

    public Contact(String userId, boolean isSynced) {
        this.userId = userId;
        this.isSynced = isSynced;
    }

    public String getUserId() {
        return userId;
    }

    public boolean isSynced() {
        return isSynced;
    }
}
