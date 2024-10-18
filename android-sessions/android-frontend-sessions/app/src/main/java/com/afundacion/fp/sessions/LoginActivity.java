package com.afundacion.fp.sessions;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.MediaCodec;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.JsonRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import javax.net.ssl.SSLEngineResult;

public class LoginActivity extends AppCompatActivity {
    private Button botonToLogin;
    private Context context = this;
    private Button botonLogin;
    private RequestQueue requestQueue;
    private EditText editTextUser;
    private EditText editTextPassword;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        botonToLogin =findViewById(R.id.registerButtonOrigin);
        botonLogin =findViewById(R.id.loginButton);
        requestQueue = Volley.newRequestQueue(this);
        editTextUser = findViewById(R.id.nameText);
        editTextPassword = findViewById(R.id.passText);

        botonToLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(context, RegisterActivity.class);
                startActivity(intent);
            }
        });

        botonLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                sendLoginRequest();
            }
        });
    }
    private void sendLoginRequest() {

        JSONObject requestBody = new JSONObject();
        try {
            requestBody.put("username", editTextUser.getText().toString());
            requestBody.put("password",  editTextPassword.getText().toString());
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
        JsonObjectRequest request = new JsonObjectRequest(
                Request.Method.POST,
                Server.name + "/sessions",
                requestBody,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        String receivedToken;
                        try {
                            receivedToken = response.getString("sessionToken");
                        } catch (JSONException e) {
                            // Si el JSON de la respuesta NO contiene "sessionToken", vamos a lanzar
                            // una RuntimeException para que la aplicación rompa.
                            // En preferible que sea NOTORIO el problema del servidor, pues desde
                            // la aplicación no podemos hacer nada. Estamos 'vendidos'.
                            throw new RuntimeException(e);
                        }
                        // Si la respuesta está OK, mostramos un Toast
                        Toast.makeText(context, "Token: " + receivedToken, Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(context, StatusActivity.class);
                        startActivity(intent);
                        // Instanciamos un objeto de tipo SharedPreferences
                        // En el constructor pasamos un String. SIEMPRE será el mismo para nuestra aplicación.
                        SharedPreferences preferences = context.getSharedPreferences("SESSIONS_APP_PREFS", MODE_PRIVATE);
                        SharedPreferences.Editor editor = preferences.edit();
                        editor.putString("VALID_USERNAME", editTextUser.getText().toString() );
                        editor.putString("VALID_TOKEN", receivedToken);
                        // .apply() es preferible y cuando se usa, el sistema almacena
                        // los datos en segundo plano de forma más lenta

                        // .commit() es bloqueante y los almacena inmediatamente. Debe
                        // usarse sólo si es crítico que los datos se guarden de forma
                        // instantánea. ¡En nuestro caso es así!
                        editor.commit();

                        // Un detalle extra:
                        // Añadamos 'finish()' para que, tras un Login exitoso, la
                        // LoginActivity se termine. Así evitamos que al pulsar Atrás
                        // el usuario regrese a dicha LoginActivity.
                        // ¡Sería confuso!
                        finish();


                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        if (error.networkResponse == null) {
                            Toast.makeText(context, "Error de conexión", Toast.LENGTH_LONG).show();
                        } else {
                            int serverCode = error.networkResponse.statusCode;
                            Toast.makeText(context, "El servidor respondió con " + serverCode, Toast.LENGTH_LONG).show();
                        }

                    }
                }

        );
        this.requestQueue.add(request);
    }


}
