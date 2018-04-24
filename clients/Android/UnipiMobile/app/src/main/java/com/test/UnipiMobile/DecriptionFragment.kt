package com.test.UnipiMobile


import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.TextView
import kotlinx.android.synthetic.main.fragment_decription.*
import java.text.SimpleDateFormat
import java.time.Instant
import java.util.*


// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 *
 */
class DecriptionFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        // Inflate the layout for this fragment
        var desc: String = this.arguments.getString("desc")
        var address: String = this.arguments.getString("address")
        var dt_start: String = this.arguments.getString("dt_start")
        var dt_end: String = this.arguments.getString("dt_end")

        val view = inflater.inflate(R.layout.fragment_decription, container, false)
        val _tvDesc: TextView? = view?.findViewById(R.id.tvDesc)
        val _tvAddress: TextView? = view?.findViewById(R.id.tvAddress)
        val _dtStart: TextView? = view?.findViewById(R.id.tvDtStart)
        val _dtEnd: TextView? = view?.findViewById(R.id.tvDtEnd)

        _tvDesc?.text = desc
        _dtStart?.text = dt_start
        _dtEnd?.text = dt_end
        _tvAddress?.text = address

        val date: Date? = StringToDate(dt_end)

        return view
    }


}
