-- ====  UP  ====
CREATE TABLE associations(
  id integer NOT NULL,
  acronym text not null,
  name text not null
);

CREATE UNIQUE INDEX ON associations(acronym);
CREATE UNIQUE INDEX ON associations(name);

CREATE SEQUENCE associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE associations_id_seq OWNED BY associations.id;
ALTER TABLE ONLY associations ALTER COLUMN id SET DEFAULT nextval('associations_id_seq'::regclass);
ALTER TABLE ONLY associations ADD CONSTRAINT associations_pkey PRIMARY KEY (id);

-- ==== DOWN ====
DROP TABLE associations;
