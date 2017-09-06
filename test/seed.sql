--
-- Name: habari__poststatus_pkey_seq; Type: SEQUENCE; Schema: public; Owner: habari
--

CREATE SEQUENCE habari__poststatus_pkey_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE habari__poststatus_pkey_seq OWNER TO habari;

--
-- Name: habari__poststatus; Type: TABLE; Schema: public; Owner: habari; Tablespace: 
--

CREATE TABLE habari__poststatus (
    id integer DEFAULT nextval('habari__poststatus_pkey_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    internal smallint
);

ALTER TABLE habari__poststatus OWNER TO habari;

--
-- Name: habari__posttype_pkey_seq; Type: SEQUENCE; Schema: public; Owner: habari
--

CREATE SEQUENCE habari__posttype_pkey_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE habari__posttype_pkey_seq OWNER TO habari;

--
-- Name: habari__posttype; Type: TABLE; Schema: public; Owner: habari; Tablespace: 
--

CREATE TABLE habari__posttype (
    id integer DEFAULT nextval('habari__posttype_pkey_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    active smallint DEFAULT 1
);


ALTER TABLE habari__posttype OWNER TO habari;

--
-- Name: habari__posts_pkey_seq; Type: SEQUENCE; Schema: public; Owner: habari
--

CREATE SEQUENCE habari__posts_pkey_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE habari__posts_pkey_seq OWNER TO habari;

--
-- Name: habari__posts; Type: TABLE; Schema: public; Owner: habari; Tablespace: 
--

CREATE TABLE habari__posts (
    id bigint DEFAULT nextval('habari__posts_pkey_seq'::regclass) NOT NULL,
    slug character varying(255) NOT NULL,
    content_type integer NOT NULL,
    title character varying(255) NOT NULL,
    guid character varying(255) NOT NULL,
    content text NOT NULL,
    cached_content text NOT NULL,
    user_id integer NOT NULL,
    status integer NOT NULL,
    pubdate integer NOT NULL,
    updated integer NOT NULL,
    modified integer NOT NULL
);


--
-- Data for Name: habari__poststatus; Type: TABLE DATA; Schema: public; Owner: habari
--

COPY habari__poststatus (id, name, internal) FROM stdin;
1	draft	0
2	published	0
3	scheduled	1
4	deleted	1
\.


--
-- Name: habari__poststatus_pkey_seq; Type: SEQUENCE SET; Schema: public; Owner: habari
--

SELECT pg_catalog.setval('habari__poststatus_pkey_seq', 4, true);
--
-- Data for Name: habari__posttype; Type: TABLE DATA; Schema: public; Owner: habari
--

COPY habari__posttype (id, name, active) FROM stdin;
1	entry	1
2	page	1
\.


--
-- Name: habari__posttype_pkey_seq; Type: SEQUENCE SET; Schema: public; Owner: habari
--

SELECT pg_catalog.setval('habari__posttype_pkey_seq', 2, true);


--
-- Data for Name: habari__posts; Type: TABLE DATA; Schema: public; Owner: habari
--

COPY habari__posts (id, slug, content_type, title, guid, content, cached_content, user_id, status, pubdate, updated, modified) FROM stdin;
5	coming-soon	2	Coming soon... 	tag:portal.mind.unm.edu,2011:coming-soon/1294882026	MICIS manual: a step by step guide to navigating MICIS and all of the NI tools. \n		2	2	1294882048	1294882048	1433276791
2	new-ursi-project-description	1	Overview of NI tools now available	tag:portal.mind.unm.edu,2010:new-ursi-project-description/1292953221			2	1	1292953221	1292953221	1433276795
3	new-ursi-project-description-1	1	New URSI Project Description	tag:portal.mind.unm.edu,2010:new-ursi-project-description-1/1292955279	Click the following link to view the description of the New URSI Project. <a href="http://portal.mind.unm.edu/habari/user/files/NewURSIProjectDescription.pdf">NewURSIProjectDescription.pdf</a>		2	2	1292955823	1292955823	1331252184
8	calculated-fields	1	Calculated Fields	tag:portal.mind.unm.edu,2011:calculated-fields/1299694727	Click the following link to access instructions for Calculated Fields in Assessment Manager. <a href="http://portal.mind.unm.edu/habari/user/files/Calculated Fields.pdf">Calculated Fields.pdf</a>		2	1	1299694785	1299694785	1331252195
4	overview-of-ni-tools-now-available	1	Overview of NI tools now available	tag:portal.mind.unm.edu,2011:overview-of-ni-tools-now-available/1294248818	Click the following link to open an overview of the NI tools. <a href="http://portal.mind.unm.edu/habari/user/files/MRN NI Core.pdf">MRN NI Core.pdf</a>		2	1	1294249624	1294249624	1331252265
30	march-15th-2012-coins-weekly-tips-and-updates	1	March 15th, 2012 COINS' Weekly Tips and Updates	tag:portal.mrn.org,2012:march-15th-2012-coins-weekly-tips-and-updates/1340659535	Updates\n\nNI Updates Page\n\nYou may have noticed a change in the format of the Updates for Neuroinformatics located on the homepages in COINS. Under Navigation there are different pages that you can click on to access overview and training documents. We are working on creating more training materials for our users, including video tutorials.\n\nAssessment Manager\n\nIf you have a study visit that you are no longer entering data for, you can now hide it from the data entry cover sheets, this will eliminate the possibility of an operator entering data for a visit in error. To hide a study visit, go to the study details page in MICIS and click on the Study Visits button at the top of the page. You will be directed to a page that lists all of the study visits, select Edit next to the visit that you would like to hide. You will then check the box next to Hidden? and click Continue.\n\nHelpful Tips\n\nGo to  Studies below and select How to create subject types.pdf to view a training guide on creating subject types for your study. 		2	2	1340659535	1340659535	1340659715
\.


--
-- Name: habari__posts_pkey_seq; Type: SEQUENCE SET; Schema: public; Owner: habari
--

SELECT pg_catalog.setval('habari__posts_pkey_seq', 137, true);


