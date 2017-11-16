--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: associations; Type: TABLE; Schema: public; Owner: dawnpatrol
--

CREATE TABLE associations (
    id integer NOT NULL,
    acronym text NOT NULL,
    name text NOT NULL,
    host text NOT NULL,
    rails_created_at timestamp with time zone,
    rails_updated_at timestamp with time zone
);


ALTER TABLE associations OWNER TO dawnpatrol;

--
-- Name: associations_id_seq; Type: SEQUENCE; Schema: public; Owner: dawnpatrol
--

CREATE SEQUENCE associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE associations_id_seq OWNER TO dawnpatrol;

--
-- Name: associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dawnpatrol
--

ALTER SEQUENCE associations_id_seq OWNED BY associations.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: dawnpatrol
--

CREATE TABLE events (
    id integer NOT NULL,
    city text,
    discipline text DEFAULT 'Road'::text NOT NULL,
    name text DEFAULT 'New Event'::text NOT NULL,
    rails_id integer,
    rails_created_at timestamp with time zone,
    rails_updated_at timestamp with time zone,
    starts_at timestamp with time zone NOT NULL,
    state text,
    association_id integer NOT NULL
);


ALTER TABLE events OWNER TO dawnpatrol;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: dawnpatrol
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE events_id_seq OWNER TO dawnpatrol;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dawnpatrol
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: goose_db_version; Type: TABLE; Schema: public; Owner: dawnpatrol
--

CREATE TABLE goose_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now()
);


ALTER TABLE goose_db_version OWNER TO dawnpatrol;

--
-- Name: goose_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: dawnpatrol
--

CREATE SEQUENCE goose_db_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE goose_db_version_id_seq OWNER TO dawnpatrol;

--
-- Name: goose_db_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dawnpatrol
--

ALTER SEQUENCE goose_db_version_id_seq OWNED BY goose_db_version.id;


--
-- Name: shmig_version; Type: TABLE; Schema: public; Owner: dawnpatrol
--

CREATE TABLE shmig_version (
    version integer NOT NULL,
    migrated_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE shmig_version OWNER TO dawnpatrol;

--
-- Name: associations id; Type: DEFAULT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY associations ALTER COLUMN id SET DEFAULT nextval('associations_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: goose_db_version id; Type: DEFAULT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY goose_db_version ALTER COLUMN id SET DEFAULT nextval('goose_db_version_id_seq'::regclass);


--
-- Name: associations associations_pkey; Type: CONSTRAINT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY associations
    ADD CONSTRAINT associations_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: goose_db_version goose_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY goose_db_version
    ADD CONSTRAINT goose_db_version_pkey PRIMARY KEY (id);


--
-- Name: shmig_version shmig_version_pkey; Type: CONSTRAINT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY shmig_version
    ADD CONSTRAINT shmig_version_pkey PRIMARY KEY (version);


--
-- Name: associations_acronym_idx; Type: INDEX; Schema: public; Owner: dawnpatrol
--

CREATE UNIQUE INDEX associations_acronym_idx ON associations USING btree (acronym);


--
-- Name: associations_host_idx; Type: INDEX; Schema: public; Owner: dawnpatrol
--

CREATE UNIQUE INDEX associations_host_idx ON associations USING btree (host);


--
-- Name: associations_name_idx; Type: INDEX; Schema: public; Owner: dawnpatrol
--

CREATE UNIQUE INDEX associations_name_idx ON associations USING btree (name);


--
-- Name: events_discipline_idx; Type: INDEX; Schema: public; Owner: dawnpatrol
--

CREATE INDEX events_discipline_idx ON events USING btree (discipline);


--
-- Name: events_name_idx; Type: INDEX; Schema: public; Owner: dawnpatrol
--

CREATE INDEX events_name_idx ON events USING btree (name);


--
-- Name: events_rails_id_idx; Type: INDEX; Schema: public; Owner: dawnpatrol
--

CREATE INDEX events_rails_id_idx ON events USING btree (rails_id);


--
-- Name: events_starts_at_idx; Type: INDEX; Schema: public; Owner: dawnpatrol
--

CREATE INDEX events_starts_at_idx ON events USING btree (starts_at);


--
-- Name: events events_association_id; Type: FK CONSTRAINT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_association_id FOREIGN KEY (association_id) REFERENCES associations(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- Data for Name: shmig_version; Type: TABLE DATA; Schema: public; Owner: dawnpatrol
--

COPY shmig_version (version, migrated_at) FROM stdin;
1507560488	2017-10-12 02:53:55.467747
1507776432	2017-11-04 15:43:37.426016
1509578401	2017-11-04 15:43:37.438428
1510868478	2017-11-16 22:12:08.235853
\.


--
-- PostgreSQL database dump complete
--

