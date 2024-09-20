package com.afundacion.fp.library;
import android.content.Context;
import android.view.View;
import android.widget.Toast;

public class ActionHandler implements View.OnClickListener{
    private Context context;

    public ActionHandler(Context context){
        this.context=context;
    }

    @Override
    public void onClick(View view){
        Toast.makeText(this.context,"¡Cuidado, que quema!",Toast.LENGTH_LONG).show();
    }
}
