package com.afundacion.fp.clips;

import org.json.JSONException;
import org.json.JSONObject;

public class Clip {
    private int id;
    private String title;
    private String videoUrl;

    public Clip(JSONObject json) throws JSONException {
        this.id = json.getInt("id");
        this.title = json.getString("title");
        this.videoUrl = json.getString("videoUrl");
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getVideoUrl() {
        return videoUrl;
    }



}
