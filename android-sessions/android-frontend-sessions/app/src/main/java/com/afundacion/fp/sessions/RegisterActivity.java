package com.afundacion.fp.sessions;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

public class RegisterActivity extends AppCompatActivity {
    private EditText editTextUser;
    private EditText editTextPassword;
    private Button buttonRegister;
    private Context context = this;
    private RequestQueue queue;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);
        editTextUser = findViewById(R.id.nameBox);
        editTextPassword = findViewById(R.id.passBox);
        buttonRegister =findViewById(R.id.registerButton);
        queue = Volley.newRequestQueue(this);

        buttonRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(context,"Nombre "+editTextUser.getText().toString(),Toast.LENGTH_SHORT).show();
                sendPostRequest();
            }
        });


    }

    private void sendPostRequest(){
        JSONObject requestBody = new JSONObject();
        try {
            requestBody.put("username", editTextUser.getText().toString());
            requestBody.put("password", editTextPassword.getText().toString());
        }catch(JSONException e){
            throw new RuntimeException(e);
        }
        JsonObjectRequest request = new JsonObjectRequest(
                Request.Method.POST,
                Server.name + "/users",
                requestBody,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        Toast.makeText(context, "Registro correcto", Toast.LENGTH_LONG).show();
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        if (error.networkResponse == null) {
                            Toast.makeText(context, "No se pudo establecer la conexión", Toast.LENGTH_LONG).show();
                        } else {
                            int serverCode = error.networkResponse.statusCode;
                            Toast.makeText(context, "El servidor respondió con " + serverCode, Toast.LENGTH_SHORT).show();
                        }

                    }
                }
        );
        this.queue.add(request);
    }


}