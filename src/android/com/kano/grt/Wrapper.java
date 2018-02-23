package com.kano.grt;

import java.util.UUID;
import java.util.HashMap;

public class Wrapper<T> {
    private HashMap<String, T> instances;

    public Wrapper() {
        instances = new HashMap<String, T>();
    }

    public T newInstance() {
        return null;
    }

    public String create() {
        String id = UUID.randomUUID().toString();
        instances.put(id, newInstance());
        return id;
    }

    public T getFromId(String id) {
        if (!instances.containsKey(id)) {
            return null;
        }
        return instances.get(id);
    }
}