package com.test.UnipiMobile

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
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


class PostsAdapter(private val posts: MutableList<Event>?) : RecyclerView.Adapter<PostsAdapter.ViewHolder>() {

    override fun getItemCount(): Int {
        return posts?.size ?: 0
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val v = LayoutInflater.from(parent.context).inflate(R.layout.post_item, parent, false)
        return ViewHolder(v)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val post = posts!![position]
        //if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
//            holder.post.text = Html.fromHtml(post.elementPureHtml, Html.FROM_HTML_MODE_LEGACY)
//        } else {
//            holder.post.text = Html.fromHtml(post.elementPureHtml)
//        }
        //holder.post.text = Html.fromHtml(post.elementPureHtml)
        //holder.site.text = post.site
        holder.post.text = Html.fromHtml(post.name)
        holder.site.text = post.period

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

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        posts = ArrayList<Event>()

        recyclerView = findViewById(R.id.posts_recycle_view) as RecyclerView
        val layoutManager: LinearLayoutManager = LinearLayoutManager(this)
        (recyclerView as RecyclerView).setLayoutManager(layoutManager)

        val adapter: PostsAdapter = PostsAdapter(posts)
        (recyclerView as RecyclerView).setAdapter(adapter)

        //UnipiMobileApi.getData("bash", 50).enqueue(object: Callback<List<Event>?> {
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
