package com.test.UnipiMobile

import android.graphics.Bitmap
import retrofit2.Call
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query
import java.sql.Blob


data class Event(
        val evt_id:	Int,
        val evt_name: String,
        val evt_date_start: String,
        val evt_date_end: String,
        val evt_internal: Boolean
)

data class Action(
        val eaId: Int,
        val eaPeriod: Int,
        val eaName: String,
        val eaDesc: String,
        val eaStart: String,
        val eaEnd: String,
        val eaLocation: String,
        val ea_period: Int
)

data class Period(
        val epId: Int,
        val epEvent: Int,
        val epName: String,
        val epStart: String,
        val epEnd: String,
        val ep_event: Int,
        val actions: List<Action>
)

data class EventInfo(
        val evtId: Int,
        val evtName: String,
        val evtDateStart: String,
        val evtDateEnd: String,
        val evtAddress: String,
        val evtDescr: String,
        val evtInternal: Boolean,
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

    @GET("REST/event/{id}")
    fun getEventInfo(@Path("id") id: Int): Call<EventInfo>

    @GET("REST/actions/{id}")
    fun getActionInfo(@Path("id") id: Int): Call<ActionInfo>

    @GET("REST/image/{id}")
    fun getImage(@Path("id") id: Int): Call<Bitmap>

    @GET("REST/file/{id}")
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