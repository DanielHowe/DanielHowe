package com.example.danielhowe.myapplication;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Creating objects to be used in the application for the user to select
        Button submitButton = (Button) findViewById(R.id.submit_button);

        //Create a listener for the button above
        submitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //When the Submit button is clicked then the state of the checkboxes is collected
                CheckBox cst300checkbox = (CheckBox) findViewById(R.id.cst300_checkBox);
                CheckBox cst205checkbox = (CheckBox) findViewById(R.id.cst205_checkBox);
                CheckBox cst336checkbox = (CheckBox) findViewById(R.id.cst336_checkBox);
                CheckBox cst363checkbox = (CheckBox) findViewById(R.id.cst363_checkBox);
                CheckBox cst311checkbox = (CheckBox) findViewById(R.id.cst311_checkBox);
                CheckBox cst361checkbox = (CheckBox) findViewById(R.id.cst361_checkBox);
                CheckBox cst370checkbox = (CheckBox) findViewById(R.id.cst370_checkBox);
                CheckBox cst338checkbox = (CheckBox) findViewById(R.id.cst338_checkBox);

                //An event could be instantiated here...e.g. send mail to user defined email address
                //Do something here..
            }
        });

    }
}

