package com.test.UnipiMobile

import android.content.Context
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.content.ContextCompat.startActivity
import android.view.View

import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.Response

import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.text.Html
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView

import retrofit2.Retrofit
import retrofit2.Callback

import android.widget.Toast
import retrofit2.http.Path



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

        holder.post.text = post.evt_name //Html.fromHtml
        holder.site.text = post.evt_date_start

        holder.post.setOnClickListener{clickListener(post)}
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var post: TextView
        var site: TextView

        init {
            post = itemView.findViewById(R.id.postitem_post) as TextView
            site = itemView.findViewById(R.id.postitem_site) as TextView
        }
    }
}

class MainActivity : AppCompatActivity() {

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

        posts = ArrayList<Event>()

        recyclerView = findViewById(R.id.posts_recycle_view) as RecyclerView
        val layoutManager: LinearLayoutManager = LinearLayoutManager(this)
        recyclerView!!.setLayoutManager(layoutManager)

        val adapter: PostsAdapter = PostsAdapter(posts, { eventItem : Event -> eventItemClicked(eventItem) })
        recyclerView!!.setAdapter(adapter)

        UnipiMobileApi.getEvents().enqueue(object: Callback<List<Event>?> {
            override fun onFailure(call: Call<List<Event>?>?, t: Throwable?) {
                Toast.makeText(this@MainActivity, "An error occurred during networking", Toast.LENGTH_SHORT).show()
            }

            override fun onResponse(call: Call<List<Event>?>?, response: Response<List<Event>?>?) {
                posts?.addAll(response?.body()!!) //(response?.body())
                recyclerView?.getAdapter()?.notifyDataSetChanged()
            }
        })
    }

}
