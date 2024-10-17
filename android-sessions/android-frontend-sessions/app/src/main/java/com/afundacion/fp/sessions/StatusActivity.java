package com.afundacion.fp.sessions;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import org.json.JSONException;
import org.json.JSONObject;

public class StatusActivity extends AppCompatActivity {
    private Context context = this;
    private RequestQueue queue;
    private TextView textViewStatus;
    private FloatingActionButton buttonChangeStatus;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_status);
        textViewStatus = findViewById(R.id.cargandoText);
        queue = Volley.newRequestQueue(this);
        retrieveUserStatus();
        buttonChangeStatus = findViewById(R.id.button_open_dialog);
        buttonChangeStatus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AlertDialog.Builder myBuilder = new AlertDialog.Builder(context);
                myBuilder.setPositiveButton("Actualizar", null); // Esto añade un botón al diálogo
                AlertDialog myDialog = myBuilder.create(); // Esta línea es como 'new AlertDialog'
                myDialog.show();

            }
        });


    }

    private void retrieveUserStatus() {
        SharedPreferences preferences = getSharedPreferences("SESSIONS_APP_PREFS", MODE_PRIVATE);
        String username = preferences.getString("VALID_USERNAME", null);

        JsonObjectRequestWithAuthentication request = new JsonObjectRequestWithAuthentication(
                Request.Method.GET,
                Server.name + "/users/" + username + "/status",
                null,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        Toast.makeText(context, "Estado recibido", Toast.LENGTH_LONG).show();
                        try {
                            textViewStatus.setText(response.getString("status"));
                        } catch (JSONException e) {
                            throw new RuntimeException(e);
                        }
                    }

                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Toast.makeText(context, "Problema con la petición de estado", Toast.LENGTH_LONG).show();
                    }
                },
                context
        );
        this.queue.add(request);

    }

}