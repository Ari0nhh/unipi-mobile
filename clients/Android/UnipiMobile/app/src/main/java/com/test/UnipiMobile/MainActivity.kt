package com.test.UnipiMobile

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.design.widget.NavigationView
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.CardView
import android.support.v4.content.ContextCompat.startActivity
import android.support.v4.view.GravityCompat
import android.support.v7.app.ActionBarDrawerToggle
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.Response
import android.text.Html
import android.view.*
import com.test.UnipiMobile.R.id.nav_view
import com.test.UnipiMobile.R.id.toolbar
import com.test.UnipiMobile.R.layout.activity_main
import retrofit2.Retrofit
import retrofit2.Callback

import retrofit2.http.Path
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.app_bar_main.*
import java.util.*


class PostsAdapter(private val posts: MutableList<Event>?, val clickListener: (Event) -> Unit) : RecyclerView.Adapter<PostsAdapter.ViewHolder>() {

    override fun getItemCount(): Int {
        return posts?.size ?: 0
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val v = LayoutInflater.from(parent.context).inflate(R.layout.post_item, parent, false)
        return ViewHolder(v)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val post = posts!![position]
        val dateSt: Date? = StringToDate(post.evt_date_start)
        val dateEnd: Date? = StringToDate(post.evt_date_end)

        holder.post.text = post.evt_name //Html.fromHtml
//        holder.site.text = post.evt_date_start
//        holder.imgStatus.setImageResource(0)

        holder.post.setOnClickListener{clickListener(post)}
    }

//    override fun onAttachedToRecyclerView(recyclerView: RecyclerView) {
//        super.onAttachedToRecyclerView(recyclerView)
//    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var cv: CardView
        var post: TextView
        var site: TextView
        var imgStatus: ImageView

        init {
            cv = itemView.findViewById<View>(R.id.cardview_event) as CardView
            post = itemView.findViewById(R.id.postitem_post) as TextView
            site = itemView.findViewById(R.id.postitem_site) as TextView
            imgStatus = itemView.findViewById<View>(R.id.img_status) as ImageView
        }
    }
}

class MainActivity : AppCompatActivity(), NavigationView.OnNavigationItemSelectedListener  {

    var recyclerView: RecyclerView? = null
    var posts: MutableList<Event>? = null

    private fun eventItemClicked(eventItem : Event) {
        //Toast.makeText(this, "Clicked: ${partItem.itemName}", Toast.LENGTH_LONG).show()
        val intent = Intent(this@MainActivity, EventInfoActivity::class.java)
        intent.putExtra("id", eventItem.evt_id)
        startActivity(intent)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
//        setSupportActionBar(toolbar)

        val toggle = ActionBarDrawerToggle(
                this, activity_main, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close)
        activity_main.addDrawerListener(toggle)
        toggle.syncState()

        nav_view.setNavigationItemSelectedListener(this)

        posts = ArrayList<Event>()

//        recyclerView = findViewById(R.id.posts_recycle_view) as RecyclerView
//        val layoutManager: LinearLayoutManager = LinearLayoutManager(this)
//        recyclerView!!.setLayoutManager(layoutManager)
//
//        val adapter: PostsAdapter = PostsAdapter(posts, { eventItem : Event -> eventItemClicked(eventItem) })
//        recyclerView!!.setAdapter(adapter)
//
//        UnipiMobileApi.getEvents().enqueue(object: Callback<List<Event>?> {
//            override fun onFailure(call: Call<List<Event>?>?, t: Throwable?) {
//                Toast.makeText(this@MainActivity, "An error occurred during networking", Toast.LENGTH_SHORT).show()
//            }
//
//            override fun onResponse(call: Call<List<Event>?>?, response: Response<List<Event>?>?) {
//                posts?.addAll(response?.body()!!) //(response?.body())
//                recyclerView?.getAdapter()?.notifyDataSetChanged()
//            }
//        })


    }

    override fun onBackPressed() {
        if (activity_main.isDrawerOpen(GravityCompat.START)) {
            activity_main.closeDrawer(GravityCompat.START)
        } else {
            super.onBackPressed()
        }
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.main, menu)
        return true
    }

    override fun onNavigationItemSelected(item: MenuItem): Boolean {
        // Handle navigation view item clicks here.
        when (item.itemId) {
            R.id.nav_news -> {

            }

            R.id.nav_program -> {

            }
            R.id.nav_speakers -> {

            }
            R.id.nav_members -> {

            }
            R.id.nav_manage -> {

            }
            R.id.nav_send -> {

            }
        }

        activity_main.closeDrawer(GravityCompat.START)
        return true
    }


}
