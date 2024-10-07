package com.afundacion.fp.clips;

import org.json.JSONException;
import org.json.JSONObject;

public class Character {
    private String name;
    private String surname;
    private String description;
    private String imageUrl;

    public String getName() {
        return name;
    }
    public String getSurname() {
        return surname;
    }
    public String getDescription() {
        return description;
    }
    public String getImageUrl() {
        return imageUrl;
    }

    public Character(JSONObject json) throws JSONException {
        this.name = json.getString("name");
        this.surname = json.getString("surname");
        this.description = json.getString("description");
        this.imageUrl = json.getString("imageUrl");
    }


}
