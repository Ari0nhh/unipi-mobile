package com.test.UnipiMobile

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v4.app.FragmentStatePagerAdapter
import android.support.v4.view.ViewPager
import android.view.View
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_event_info.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class pageradapter (fm: android.support.v4.app.FragmentManager, evInfo: EventInfo?) : FragmentStatePagerAdapter(fm){
    var cueEventInfo: EventInfo? = evInfo

    override fun getItem(position: Int): android.support.v4.app.Fragment{
        val frag: Fragment
        var bundle = Bundle()

        when (position) {

            0 -> {
                if (cueEventInfo != null) {
                    bundle.putString("desc", cueEventInfo?.evtDescr)
                    bundle.putString("address", cueEventInfo?.evtAddress)
                    bundle.putString("dt_start", cueEventInfo?.evtDateStart)
                    bundle.putString("dt_end", cueEventInfo?.evtDateEnd)
                }
                frag = DecriptionFragment()
            }
            1 -> {
                var fragPrds: PeriodsFragment = PeriodsFragment()
                fragPrds.SetData(cueEventInfo?.periods)
                frag = fragPrds
            }
            else -> frag = DecriptionFragment()
        }

        frag.arguments = bundle
        return frag
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

        UnipiMobileApi.getEventInfo(id).enqueue(object: Callback<EventInfo?> {
            override fun onFailure(call: Call<EventInfo?>?, t: Throwable?) {
                Toast.makeText(this@EventInfoActivity, "An error occurred during networking", Toast.LENGTH_SHORT).show()
            }

            override fun onResponse(call: Call<EventInfo?>?, response: Response<EventInfo?>?) {
                CurEventInfo = response?.body()

                if (CurEventInfo != null)
                    tvEventName.text = CurEventInfo?.evtName

                val adapter = pageradapter(supportFragmentManager, CurEventInfo)
                val pager = findViewById<View>(R.id.pager) as ViewPager
                pager.adapter = adapter
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
