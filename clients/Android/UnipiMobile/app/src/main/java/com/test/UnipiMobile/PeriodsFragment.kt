package com.test.UnipiMobile

import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import kotlinx.android.synthetic.main.fragment_periods.*
import java.util.*


class ActionsAdapter(private val actions: List<Action>?) : RecyclerView.Adapter<ActionsAdapter.ViewHolder>() {

    override fun getItemCount(): Int {
        return actions?.size ?: 0
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val v = LayoutInflater.from(parent.context).inflate(R.layout.activity_action, parent, false)
        return ViewHolder(v)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = actions!![position]

        holder.post.text = item.eaName

        var dt: Date? = StringToDate(item.eaStart)
        if (dt != null)
            holder.dates.text = dt.toString()
        //holder.dates.text = item.epStart

        //holder.post.setOnClickListener{clickListener(item)}
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var post: TextView
        var dates: TextView

        init {
            post = itemView.findViewById(R.id.actionName) as TextView
            dates = itemView.findViewById(R.id.actionDates) as TextView
        }
    }
}

class PeriodsAdapter(private val periods: MutableList<Period>?) : RecyclerView.Adapter<PeriodsAdapter.ViewHolder>() {

    override fun getItemCount(): Int {
        return periods?.size ?: 0
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val v = LayoutInflater.from(parent.context).inflate(R.layout.activity_period, parent, false)
        return ViewHolder(v)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = periods!![position]

        holder.post.text = item.epName

        var dt: Date? = StringToDate(item.epStart)
        if (dt != null)
            holder.dates.text = dt.toString()
        //holder.dates.text = item.epStart
        val layoutManager: LinearLayoutManager = LinearLayoutManager(holder.itemView.context)
        holder.recyclerView.setLayoutManager(layoutManager)

        val adapter: ActionsAdapter = ActionsAdapter(item.actions)
        holder.recyclerView.setAdapter(adapter)

        //holder.post.setOnClickListener{clickListener(item)}
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var post: TextView
        var dates: TextView
        var recyclerView: RecyclerView

        init {
            post = itemView.findViewById(R.id.periodName) as TextView
            dates = itemView.findViewById(R.id.periodDates) as TextView
            recyclerView = itemView.findViewById(R.id.actions_recycle_view) as RecyclerView
        }
    }
}

class PeriodsFragment : Fragment() {
    var periods: MutableList<Period>? = null
    var recyclerView: RecyclerView? = null

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {

        val view = inflater.inflate(R.layout.fragment_periods, container, false)
        recyclerView = view?.findViewById(R.id.periods_recycle_view)

        val layoutManager: LinearLayoutManager = LinearLayoutManager(this.context)
        recyclerView?.setLayoutManager(layoutManager)

        val adapter: PeriodsAdapter = PeriodsAdapter(periods)
        recyclerView?.setAdapter(adapter)
        //recyclerView?.getAdapter()?.notifyDataSetChanged()

        return view
    }

    fun SetData(prds: List<Period>?) {
        if (prds == null)
            return

        periods = ArrayList<Period>(prds)
        //periods.addAll(prds!!)
    }



}
