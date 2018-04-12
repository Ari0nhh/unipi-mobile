package com.test.UnipiMobile

import android.graphics.Bitmap
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_event_info.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.sql.Blob

class EventInfoActivity : AppCompatActivity() {
    var id: Int = -1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_event_info)

        id = intent.extras.getInt("id")

        UnipiMobileApi.getEventInfo(id).enqueue(object: Callback<EventInfo?> {
            override fun onFailure(call: Call<EventInfo?>?, t: Throwable?) {
                Toast.makeText(this@EventInfoActivity, "An error occurred during networking", Toast.LENGTH_SHORT).show()
            }

            override fun onResponse(call: Call<EventInfo?>?, response: Response<EventInfo?>?) {
                textView1.text = response?.body()!!.evtDescr
            }
        })

        /*
        UnipiMobileApi.getImage(1).enqueue(object: Callback<Bitmap?> {
            override fun onFailure(call: Call<Bitmap?>?, t: Throwable?) {
                Toast.makeText(this@EventInfoActivity, "An error occurred during networking", Toast.LENGTH_SHORT).show()
            }

            override fun onResponse(call: Call<Bitmap?>?, response: Response<Bitmap?>?) {
                textView1.text = "))"
            }
        })
        */
    }
}
