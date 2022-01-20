package dev.lucas.monigate_app.models;

import java.util.Date;
import java.util.List;

public class ContactTracing {
    private Date date;
    private List<Contact> contacts;

    public ContactTracing(Date date, List<Contact> contacts) {
        this.date = date;
        this.contacts = contacts;
    }

    public Date getDate() {
        return date;
    }

    public List<Contact> getContacts() {
        return contacts;
    }
}
