package com.afundacion.fp.clips;

import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class ClipViewHolder extends RecyclerView.ViewHolder {
    private TextView textView;

    public ClipViewHolder(@NonNull View itemView) {
        super(itemView);
        textView = itemView.findViewById(R.id.texto1);
    }
    public void bindClip(Clip clip) {
        this.textView.setText(clip.getTitle());
    }

}

