package com.afundacion.fp.clips;

import android.content.Context;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class ClipViewHolder extends RecyclerView.ViewHolder {
    private TextView textView;
    private Clip clip;

    public ClipViewHolder(@NonNull View itemView) {
        super(itemView);
        textView = itemView.findViewById(R.id.texto1);

        itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int clipId = clip.getId();
                Context context = view.getContext();
                Toast.makeText(context,"Clicked on cell with clipId: " + clipId , Toast.LENGTH_SHORT).show();

            }
        });
    }

    public void bindClip(Clip clip) {
        this.textView.setText(clip.getTitle());
        this.clip = clip;
    }

}

