package com.test.UnipiMobile

import retrofit2.Call
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query
import java.sql.Blob


data class Event(
        val id:	Int,
        val name: String,
        val period: String,
        val internal: Boolean
)

data class Action(
        val id: Int,
        val name: String,
        val ea_start: String,
        val ea_end: String
)

data class Period(
        val name: String,
        val ep_start: String,
        val ep_end: String,
        val actions: List<Action>
)

data class EventInfo(
        val id: Int,
        val name: String,
        val date_start: String,
        val date_end: String,
        val internal: Boolean,
        val address: String,
        val descr: String,
        val periods: List<Period>
)

data class ActionInfo(
        val name: String,
        val desc: String,
        val location: String,
        val ea_start: String,
        val ea_end: String,
        val speakers: List<Speaker>,
        val files: List<File>,
        val video: Int
)

data class Speaker(
        val name: String,
        val photo: Int,
        val org: String
)

data class File(
        val name: String,
        val id: Int
)

interface UnipiMobileRestApi {
    @GET("REST/events")
    fun getEvents(): Call<List<Event>>

    @GET("REST/events/id")
    fun getEventInfo(@Path("id") id: Int): Call<EventInfo>

    @GET("REST/actions/id")
    fun getActionInfo(@Path("id") id: Int): Call<ActionInfo>

    @GET("REST/image/id")
    fun getImage(@Path("id") id: Int): Call<Blob>

    @GET("REST/file/id")
    fun getFile(@Path("id") id: Int): Call<Blob>
}

//companion
object UnipiMobileRestApiImpl{
    fun create(): UnipiMobileRestApi {

        val retrofit = Retrofit.Builder()

                .addConverterFactory(
                        GsonConverterFactory.create())
                //.baseUrl("https://umorili.herokuapp.com/")
                .baseUrl("http://62.109.16.88/")
                .build()

        return retrofit.create(UnipiMobileRestApi::class.java)
    }
}

val UnipiMobileApi by lazy {
    UnipiMobileRestApiImpl.create()
}