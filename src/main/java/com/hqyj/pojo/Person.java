package com.hqyj.pojo;

import java.io.Serializable;

public class Person implements Serializable {
    private String personId;

    private String personName;

    private String personPassword;

    public Person(String personId, String personName, String personPassword) {
        this.personId = personId;
        this.personName = personName;
        this.personPassword = personPassword;
    }

    public Person() {
    }

    @Override
    public String toString() {
        return "Person{" +
                "personId='" + personId + '\'' +
                ", personName='" + personName + '\'' +
                ", personPassword='" + personPassword + '\'' +
                '}';
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getPersonPassword() {
        return personPassword;
    }

    public void setPersonPassword(String personPassword) {
        this.personPassword = personPassword;
    }
}