package com.test.UnipiMobile

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.view.ViewPager
import android.view.View
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_action_info.*
import kotlinx.android.synthetic.main.activity_event_info.*
import kotlinx.android.synthetic.main.fragment_decription.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.util.*

class ActionInfoActivity : AppCompatActivity() {
    var curActionInfo: ActionInfo? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_action_info)

        val id: Int = intent.extras.getInt("id")

        UnipiMobileApi.getActionInfo(id).enqueue(object: Callback<ActionInfo?> {
            override fun onFailure(call: Call<ActionInfo?>?, t: Throwable?) {
                Toast.makeText(this@ActionInfoActivity, "An error occurred during networking", Toast.LENGTH_SHORT).show()
            }

            override fun onResponse(call: Call<ActionInfo?>?, response: Response<ActionInfo?>?) {
                curActionInfo = response?.body()

                if (curActionInfo == null)
                    return

                tvActionName.text = curActionInfo!!.name

                var dt: Date? = StringToDate(curActionInfo!!.ea_start)
                if (dt != null)
                    actionInfoDateStart.text = dt.toString()

                dt = StringToDate(curActionInfo!!.ea_end)
                if (dt != null)
                    actionInfoDateEnd.text = dt.toString()

                actionInfoLocation.text = curActionInfo!!.location

                actionInfoDesc.text = curActionInfo!!.desc

                //val adapter = pageradapter(supportFragmentManager, CurEventInfo)
                //val pager = findViewById<View>(R.id.pager) as ViewPager
                //pager.adapter = adapter
            }
        })
    }
}
