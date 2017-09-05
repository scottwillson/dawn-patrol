--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

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
-- Name: events; Type: TABLE; Schema: public; Owner: dawnpatrol
--

CREATE TABLE events (
    id integer NOT NULL,
    discipline text NOT NULL default 'Road',
    name text NOT NULL default 'New Event',
    starts_at timestamp with time zone NOT NULL
);

CREATE INDEX ON events (discipline);
CREATE INDEX ON events (name);
CREATE INDEX ON events (starts_at);

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
-- Name: events id; Type: DEFAULT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: goose_db_version id; Type: DEFAULT; Schema: public; Owner: dawnpatrol
--

ALTER TABLE ONLY goose_db_version ALTER COLUMN id SET DEFAULT nextval('goose_db_version_id_seq'::regclass);


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
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

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
-- Data for Name: goose_db_version; Type: TABLE DATA; Schema: public; Owner: dawnpatrol
--

COPY goose_db_version (id, version_id, is_applied, tstamp) FROM stdin;
1	0	t	2017-08-02 16:28:34.147545
2	20170730080737	t	2017-08-02 16:28:34.175074
\.


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dawnpatrol
--

SELECT pg_catalog.setval('goose_db_version_id_seq', 2, true);


--
-- PostgreSQL database dump complete
--
