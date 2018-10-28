create table dw_events
(
	evt_id serial not null
		constraint dw_events_pkey
			primary key,
	evt_name varchar(100),
	evt_date_start timestamp,
	evt_date_end timestamp,
	evt_address varchar(500),
	evt_descr text,
	evt_internal char,
	evt_lat double precision,
	evt_long double precision
)
;

create table dw_event_period
(
	ep_id serial not null
		constraint dw_event_period_pk
			primary key,
	ep_event integer not null
		constraint dw_event_period_dw_events_fk
			references dw_events
				on delete cascade,
	ep_name varchar(200),
	ep_start timestamp,
	ep_end timestamp
)
;

create table dw_event_action
(
	ea_id serial not null
		constraint dw_event_action_pk
			primary key,
	ea_period integer not null
		constraint dw_event_action_dw_event_period_fk
			references dw_event_period
				on delete cascade,
	ea_name varchar(200),
	ea_desc text,
	ea_start timestamp,
	ea_end timestamp,
	ea_location varchar(500)
)
;

create table dw_images
(
	img_id integer not null
		constraint dw_images_pk
			primary key,
	img_data bytea,
	img_kind varchar(50)
)
;

comment on column dw_images.img_kind is 'Тип изображения, например image/png'
;

create table dw_event_speaker
(
	es_id integer not null
		constraint dw_event_speaker_pk
			primary key,
	es_name varchar(200),
	es_photo integer not null
		constraint dw_event_speaker_dw_images_fk
			references dw_images
				on delete cascade,
	es_empl char,
	es_org varchar(200)
)
;

create table dw_event_speakers
(
	ea_id integer not null
		constraint dw_event_speakers_dw_event_action_fk
			references dw_event_action
				on delete cascade,
	es_id integer not null
		constraint dw_event_speakers_dw_event_speaker_fk
			references dw_event_speaker
				on delete cascade
)
;

create table dw_video
(
	v_id integer not null
		constraint dw_video_pk
			primary key,
	v_name varchar(200),
	v_data bytea
)
;

create table dw_event_action_video
(
	ea_id integer not null
		constraint dw_event_action_video_dw_event_action_fk
			references dw_event_action
				on delete cascade,
	v_id integer not null
		constraint dw_event_action_video_dw_video_fk
			references dw_video
				on delete cascade
)
;

create table dw_files
(
	f_id integer not null
		constraint dw_files_pk
			primary key,
	f_name varchar(200),
	f_data bytea
)
;

create table dw_event_action_files
(
	ea_id integer not null
		constraint dw_event_action_files_dw_event_action_fk
			references dw_event_action
				on delete cascade,
	f_id integer not null
		constraint dw_event_action_files_dw_files_fk
			references dw_files
				on delete cascade
)
;

create table dw_user
(
	us_id serial not null
		constraint dw_user_pk
			primary key,
	us_name varchar(200),
	us_empl char,
	us_email varchar(200),
	us_phone varchar(200),
	us_org varchar(200),
	us_show integer,
	us_photo integer not null
		constraint dw_user_dw_images_fk
			references dw_images
				on delete set null,
	us_passw varchar(100),
	us_admin integer default 0 not null,
	us_token varchar(200) default ''::character varying not null
)
;

create table dw_fav_users
(
	us_id integer not null
		constraint dw_fav_users_dw_user_fk
			references dw_user
				on delete cascade,
	fav_us_id integer not null
		constraint dw_fav_users_dw_user_fkv2
			references dw_user
				on delete cascade
)
;

create table dw_partcipation
(
	evt_id integer not null
		constraint dw_partcipation_dw_events_fk
			references dw_events
				on delete cascade,
	us_id integer not null
		constraint dw_partcipation_dw_user_fk
			references dw_user
				on delete cascade,
	evt_reg char
)
;

create table dw_fav_events
(
	evt_id integer not null
		constraint dw_fav_events_dw_events_fk
			references dw_events
				on delete cascade,
	us_id integer not null
		constraint dw_fav_events_dw_user_fk
			references dw_user
				on delete cascade
)
;

