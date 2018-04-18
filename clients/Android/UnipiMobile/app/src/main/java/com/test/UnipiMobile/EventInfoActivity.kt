package com.test.UnipiMobile

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.FragmentStatePagerAdapter
import android.support.v4.view.ViewPager
import android.view.View
import android.widget.Toast
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class pageradapter (fm: android.support.v4.app.FragmentManager) : FragmentStatePagerAdapter(fm){
    override fun getItem(position: Int): android.support.v4.app.Fragment{
        when (position) {

            0 -> return DecriptionFragment()
            1 -> return PeriodsFragment()
            else -> return DecriptionFragment()
        }
    }

    override fun getCount(): Int {
        return 2
    }

}

class EventInfoActivity : AppCompatActivity() {
    var CurEventInfo: EventInfo? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_event_info)

        val id: Int = intent.extras.getInt("id")

        val adapter = pageradapter(supportFragmentManager)
        val pager = findViewById<View>(R.id.pager) as ViewPager

        pager.adapter = adapter

        UnipiMobileApi.getEventInfo(id).enqueue(object: Callback<EventInfo?> {
            override fun onFailure(call: Call<EventInfo?>?, t: Throwable?) {
                Toast.makeText(this@EventInfoActivity, "An error occurred during networking", Toast.LENGTH_SHORT).show()
            }

            override fun onResponse(call: Call<EventInfo?>?, response: Response<EventInfo?>?) {
                CurEventInfo = response?.body()
                //pager.text = response?.body()!!.evtDescr
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
