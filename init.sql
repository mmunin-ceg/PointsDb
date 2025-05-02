--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE mmunin;
ALTER ROLE mmunin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:Exzys2FAZAOsnIQly0QUzQ==$2E+O+UHE0k/B+OFFoRZ8yPRMKNQci0gkdQXjGxi5x+M=:B0ivNPHa6+4RK0+YNlRCMZjqn/ggBMzZnluq5fYPlJM=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "points" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: points; Type: DATABASE; Schema: -; Owner: mmunin
--

CREATE DATABASE points WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE points OWNER TO mmunin;

\connect points

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_provider; Type: TABLE; Schema: public; Owner: mmunin
--

CREATE TABLE public.api_provider (
    id integer NOT NULL,
    name text NOT NULL,
    is_internal boolean DEFAULT false
);


ALTER TABLE public.api_provider OWNER TO mmunin;

--
-- Name: api_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: mmunin
--

CREATE SEQUENCE public.api_provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.api_provider_id_seq OWNER TO mmunin;

--
-- Name: api_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mmunin
--

ALTER SEQUENCE public.api_provider_id_seq OWNED BY public.api_provider.id;


--
-- Name: data_interface; Type: TABLE; Schema: public; Owner: mmunin
--

CREATE TABLE public.data_interface (
    id integer NOT NULL,
    name text NOT NULL,
    protocol text,
    provider_id integer NOT NULL,
    is_internal boolean DEFAULT false,
    description text,
    CONSTRAINT data_interface_protocol_check CHECK ((protocol = ANY (ARRAY['Modbus'::text, 'DNP3'::text, 'SEL'::text, 'Other'::text])))
);


ALTER TABLE public.data_interface OWNER TO mmunin;

--
-- Name: data_interface_id_seq; Type: SEQUENCE; Schema: public; Owner: mmunin
--

CREATE SEQUENCE public.data_interface_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_interface_id_seq OWNER TO mmunin;

--
-- Name: data_interface_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mmunin
--

ALTER SEQUENCE public.data_interface_id_seq OWNED BY public.data_interface.id;


--
-- Name: map_point; Type: TABLE; Schema: public; Owner: mmunin
--

CREATE TABLE public.map_point (
    id integer NOT NULL,
    version_id integer NOT NULL,
    point_name text NOT NULL,
    object_name text NOT NULL,
    register text NOT NULL,
    data_type text NOT NULL,
    bit_offset text,
    units text,
    scale real,
    alarm_state text,
    on_state text,
    off_state text,
    alarm_limits text,
    alarm_profile text,
    enumeration_table text,
    comments text
);


ALTER TABLE public.map_point OWNER TO mmunin;

--
-- Name: map_point_id_seq; Type: SEQUENCE; Schema: public; Owner: mmunin
--

CREATE SEQUENCE public.map_point_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.map_point_id_seq OWNER TO mmunin;

--
-- Name: map_point_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mmunin
--

ALTER SEQUENCE public.map_point_id_seq OWNED BY public.map_point.id;


--
-- Name: map_version; Type: TABLE; Schema: public; Owner: mmunin
--

CREATE TABLE public.map_version (
    id integer NOT NULL,
    interface_id integer NOT NULL,
    version text NOT NULL,
    release_date date,
    changelog text
);


ALTER TABLE public.map_version OWNER TO mmunin;

--
-- Name: map_version_id_seq; Type: SEQUENCE; Schema: public; Owner: mmunin
--

CREATE SEQUENCE public.map_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.map_version_id_seq OWNER TO mmunin;

--
-- Name: map_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mmunin
--

ALTER SEQUENCE public.map_version_id_seq OWNED BY public.map_version.id;


--
-- Name: project; Type: TABLE; Schema: public; Owner: mmunin
--

CREATE TABLE public.project (
    id integer NOT NULL,
    name text NOT NULL,
    location text,
    notes text
);


ALTER TABLE public.project OWNER TO mmunin;

--
-- Name: project_id_seq; Type: SEQUENCE; Schema: public; Owner: mmunin
--

CREATE SEQUENCE public.project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_id_seq OWNER TO mmunin;

--
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mmunin
--

ALTER SEQUENCE public.project_id_seq OWNED BY public.project.id;


--
-- Name: project_map_usage; Type: TABLE; Schema: public; Owner: mmunin
--

CREATE TABLE public.project_map_usage (
    id integer NOT NULL,
    project_id integer NOT NULL,
    interface_id integer NOT NULL,
    version_id integer NOT NULL,
    notes text
);


ALTER TABLE public.project_map_usage OWNER TO mmunin;

--
-- Name: project_map_usage_id_seq; Type: SEQUENCE; Schema: public; Owner: mmunin
--

CREATE SEQUENCE public.project_map_usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_map_usage_id_seq OWNER TO mmunin;

--
-- Name: project_map_usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mmunin
--

ALTER SEQUENCE public.project_map_usage_id_seq OWNED BY public.project_map_usage.id;


--
-- Name: api_provider id; Type: DEFAULT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.api_provider ALTER COLUMN id SET DEFAULT nextval('public.api_provider_id_seq'::regclass);


--
-- Name: data_interface id; Type: DEFAULT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.data_interface ALTER COLUMN id SET DEFAULT nextval('public.data_interface_id_seq'::regclass);


--
-- Name: map_point id; Type: DEFAULT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.map_point ALTER COLUMN id SET DEFAULT nextval('public.map_point_id_seq'::regclass);


--
-- Name: map_version id; Type: DEFAULT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.map_version ALTER COLUMN id SET DEFAULT nextval('public.map_version_id_seq'::regclass);


--
-- Name: project id; Type: DEFAULT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.project ALTER COLUMN id SET DEFAULT nextval('public.project_id_seq'::regclass);


--
-- Name: project_map_usage id; Type: DEFAULT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.project_map_usage ALTER COLUMN id SET DEFAULT nextval('public.project_map_usage_id_seq'::regclass);


--
-- Data for Name: api_provider; Type: TABLE DATA; Schema: public; Owner: mmunin
--

COPY public.api_provider (id, name, is_internal) FROM stdin;
2	CEG	t
18	Nexttracker	f
17	Nevados	f
6	Groundwork	f
4	Sungrow	f
\.


--
-- Data for Name: data_interface; Type: TABLE DATA; Schema: public; Owner: mmunin
--

COPY public.data_interface (id, name, protocol, provider_id, is_internal, description) FROM stdin;
1	PPC to RTU-1	DNP3	2	t	\N
2	Inverters to PPC - SG3600	Modbus	4	t	\N
3	Inverters to PPC - SG4400UD	Modbus	4	t	\N
4	Met Tower to PPC	Modbus	6	t	\N
5	Met Tower ALB to Ignition	Modbus	6	t	\N
6	Soiling to PPC - Eclipse 1.0	Modbus	6	t	\N
7	Soiling to PPC - DustIQ	Modbus	6	t	\N
8	Albedometers to PPC	Modbus	6	t	\N
9	Orbit POA to PPC	Modbus	6	t	\N
10	PPC to Ignition - SG3600	DNP3	2	t	\N
11	PPC to Ignition - SG4400UD	DNP3	2	t	\N
12	PPC to Ignition - Environmental	DNP3	2	t	\N
13	PPC to Ignition - PPC	DNP3	2	t	\N
14	Trackers to Ignition - Nexttack	DNP3	2	t	\N
15	Battery Monitors to Ignition	Modbus	17	t	\N
16	test	Modbus	2	t	test
\.


--
-- Data for Name: map_point; Type: TABLE DATA; Schema: public; Owner: mmunin
--

COPY public.map_point (id, version_id, point_name, object_name, register, data_type, bit_offset, units, scale, alarm_state, on_state, off_state, alarm_limits, alarm_profile, enumeration_table, comments) FROM stdin;
1	1	Global_horizontal_irradiance_W_m2	Analog input	18	16-bit signed integer	\N	W/mΓö¼Γûô	10	\N	\N	\N	\N	\N	\N	\N
2	1	Average_plant_atmospheric_pressure_bar	Analog input	19	16-bit signed integer	\N	bar	100	\N	\N	\N	\N	\N	\N	\N
3	1	Average_plant_temperature_degC	Analog input	20	16-bit signed integer	\N	Γö¼ΓûæC	100	\N	\N	\N	\N	\N	\N	\N
4	1	Max_gen_limit_feedback_MW	Analog input	21	16-bit signed integer	\N	MW	100	\N	\N	\N	\N	\N	\N	\N
5	1	Potential_power_MW	Analog input	22	16-bit signed integer	\N	MW	100	\N	\N	\N	\N	\N	\N	\N
6	1	Global_horizontal_irradiance_W_m2	Analog input	23	16-bit signed integer	\N	W/mΓö¼Γûô	10	\N	\N	\N	\N	\N	\N	\N
7	1	Average_plant_atmospheric_pressure_bar	Analog input	24	16-bit signed integer	\N	bar	100	\N	\N	\N	\N	\N	\N	\N
8	1	Average_plant_temperature_degC	Analog input	25	16-bit signed integer	\N	Γö¼ΓûæC	100	\N	\N	\N	\N	\N	\N	\N
9	1	Max_gen_limit_feedback_MW	Analog input	26	16-bit signed integer	\N	MW	100	\N	\N	\N	\N	\N	\N	\N
10	1	Potential_power_MW	Analog input	27	16-bit signed integer	\N	MW	100	\N	\N	\N	\N	\N	\N	\N
11	2	Protocol Number	Input Register	315000	32-bit unsigned integer	\N	unitless	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
12	2	Protocol Version	Input Register	315002	32-bit unsigned integer	\N	unitless	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
13	2	Serial Number	Input Register	315004	String	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
14	2	Machine Type	Input Register	315012	String	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
15	2	U1 DC input #1	Input Register	315030	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
16	2	U1 DC input #2	Input Register	315031	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
17	2	U1 DC input #3	Input Register	315032	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
18	2	U1 DC input #4	Input Register	315033	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
19	2	U1 DC input #5	Input Register	315034	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
20	2	U1 DC input #6	Input Register	315035	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
21	2	U1 DC input #7	Input Register	315036	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
22	2	U1 DC input #8	Input Register	315037	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
23	2	U1 DC input #9	Input Register	315038	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
24	2	U1 DC input #10	Input Register	315039	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
25	2	U1 DC input #11	Input Register	315040	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
26	2	U1 DC input #12	Input Register	315041	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
27	2	U1 DC input #13	Input Register	315042	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
28	2	U1 DC input #14	Input Register	315043	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
29	2	U1 DC input #15	Input Register	315044	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
30	2	U1 DC input #16	Input Register	315045	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
31	2	U2 DC input #1	Input Register	315048	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
32	2	U2 DC input #2	Input Register	315049	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
33	2	U2 DC input #3	Input Register	315050	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
34	2	U2 DC input #4	Input Register	315051	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
35	2	U2 DC input #5	Input Register	315052	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
36	2	U2 DC input #6	Input Register	315053	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
37	2	U2 DC input #7	Input Register	315054	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
38	2	U2 DC input #8	Input Register	315055	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
39	2	U2 DC input #9	Input Register	315056	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
40	2	U2 DC input #10	Input Register	315057	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
41	2	U2 DC input #11	Input Register	315058	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
42	2	U2 DC input #12	Input Register	315059	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
43	2	U2 DC input #13	Input Register	315060	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
44	2	U2 DC input #14	Input Register	315061	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
45	2	U2 DC input #15	Input Register	315062	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
46	2	U2 DC input #16	Input Register	315063	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
47	2	Device Type Code	Input Register	315070	16-bit unsigned integer	\N	unitless	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
48	2	Rated active power	Input Register	315071	16-bit unsigned integer	\N	kW	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
49	2	Daily Power yield	Input Register	315073	32-bit unsigned integer	\N	kWh	10	\N	\N	\N	\N	\N	\N	\N
50	2	Monthly Power yield	Input Register	315075	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
51	2	Total Power yield	Input Register	315077	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	\N
52	2	CO2 emission reduction	Input Register	315079	32-bit unsigned integer	\N	kg	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
53	2	Daily grid connected minutes	Input Register	315081	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
54	2	Total Running Hours	Input Register	315082	32-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
55	2	Total DC Power	Input Register	315092	32-bit unsigned integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
56	2	A-B Line Voltage	Input Register	315094	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
57	2	B-C Line Voltage	Input Register	315095	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
58	2	C-A Line Voltage	Input Register	315096	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
59	2	Phase A Current	Input Register	315097	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
60	2	Phase B Current	Input Register	315098	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
61	2	Phase C Current	Input Register	315099	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
62	2	Total active power	Input Register	315100	32-bit unsigned integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
63	2	Total reactive power	Input Register	315102	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
64	2	Total appearant power	Input Register	315104	32-bit unsigned integer	\N	VA	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
65	2	Power Factor	Input Register	315106	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
66	2	Frequency	Input Register	315107	16-bit unsigned integer	\N	Hz	10	\N	\N	\N	\N	\N	\N	\N
67	2	Rated reactive power	Input Register	315108	16-bit unsigned integer	\N	kvar	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
68	2	Power limit actual value feedback	Input Register	315109	32-bit unsigned integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
69	2	Reactive power adjustment actual value feedback	Input Register	315111	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
70	2	Power factor feedback	Input Register	315113	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
71	2	Transformer node state	Input Register	315114	16-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
72	2	Transformer gas buildup trip	Input Register	315114.0	Boolean	0	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
73	2	Transformer gas buildup alarm	Input Register	315114.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
74	2	Transformer oil temperature alarm	Input Register	315114.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
75	2	Transformer oil temperature trip	Input Register	315114.3	Boolean	3	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
76	2	Transformer low oil level trip	Input Register	315114.4	Boolean	4	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
77	2	Transformer low oil level alarm	Input Register	315114.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
78	2	Transformer pressure relief valve trip	Input Register	315114.6	Boolean	6	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
79	2	Transformer pressure relief valve alarm	Input Register	315114.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
80	2	U1 load switch status	Input Register	315114.8	Boolean	8	\N	\N	None	Open	Closed	\N	\N	\N	\N
81	2	U2 load switch status	Input Register	315114.9	Boolean	9	\N	\N	None	Open	Closed	\N	\N	\N	\N
82	2	Circuit breaker status	Input Register	315114.10	Boolean	10	\N	\N	None	Open	Closed	\N	\N	\N	\N
83	2	Disconnector status	Input Register	315114.11	Boolean	11	\N	\N	None	Open	Closed	\N	\N	\N	\N
84	2	Overcurrent protection trip	Input Register	315114.12	Boolean	12	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
85	2	Transformer high oil level alarm	Input Register	315114.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
86	2	Annual power yields	Input Register	315115	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
87	2	Overall work state	Input Register	315117	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
88	2	Running	Input Register	315117.0	Boolean	0	\N	\N	None	Running	Not Running	\N	\N	\N	\N
89	2	Stopped	Input Register	315117.1	Boolean	1	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
90	2	External emergency stop overall work state	Input Register	315117.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
91	2	Remote emergency stop	Input Register	315117.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
92	2	Door opening protection	Input Register	315117.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
93	2	Smoke alarm trip	Input Register	315117.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
94	2	Local emergency stop	Input Register	315117.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
95	2	Transformer oil temperature	Input Register	315119	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
96	2	Winding temperature	Input Register	315120	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
97	2	MV Node State 1	Input Register	315126	16-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
98	2	HV compartment door open alarm	Input Register	315126.6	Boolean	6	\N	\N	Off (0)	Closed	Open	\N	\N	\N	\N
99	2	SF6 low pressure alarm	Input Register	315126.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
100	2	External emergency stop mv node state	Input Register	315126.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
101	2	MV fuse blown alarm	Input Register	315126.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
102	2	HV compartment smoke alarm	Input Register	315126.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
103	2	HV Local remote switch status	Input Register	315126.14	Boolean	14	\N	\N	On (1)	Local	Remote	\N	\N	\N	\N
104	2	Overall alarm state	Input Register	315127	16-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
105	2	Smoke sensor abnormal alarm	Input Register	315127.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
106	2	Temperature sensor abnormal alarm	Input Register	315127.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
107	2	Digital input state	Input Register	315129	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
108	2	DI1 status	Input Register	315129.0	Boolean	0	\N	\N	None	On	Off	\N	\N	\N	\N
109	2	DI2 status	Input Register	315129.1	Boolean	1	\N	\N	None	Off	On	\N	\N	\N	\N
110	2	DI3 status	Input Register	315129.2	Boolean	2	\N	\N	None	Off	On	\N	\N	\N	\N
111	2	DI4 status	Input Register	315129.3	Boolean	3	\N	\N	None	Off	On	\N	\N	\N	\N
112	2	DI5 status	Input Register	315129.4	Boolean	4	\N	\N	None	On	Off	\N	\N	\N	\N
113	2	DI6 status	Input Register	315129.5	Boolean	5	\N	\N	None	On	Off	\N	\N	\N	\N
114	2	DI7 status	Input Register	315129.6	Boolean	6	\N	\N	None	On	Off	\N	\N	\N	\N
115	2	DI8 status	Input Register	315129.7	Boolean	7	\N	\N	None	On	Off	\N	\N	\N	\N
116	2	DI9 status	Input Register	315129.8	Boolean	8	\N	\N	None	On	Off	\N	\N	\N	\N
117	2	DI10 status	Input Register	315129.9	Boolean	9	\N	\N	None	On	Off	\N	\N	\N	\N
118	2	DI11 status	Input Register	315129.10	Boolean	10	\N	\N	None	On	Off	\N	\N	\N	\N
119	2	DI12 status	Input Register	315129.11	Boolean	11	\N	\N	None	On	Off	\N	\N	\N	\N
120	2	DI13 status	Input Register	315129.12	Boolean	12	\N	\N	None	On	Off	\N	\N	\N	\N
121	2	DI14 status	Input Register	315129.13	Boolean	13	\N	\N	None	On	Off	\N	\N	\N	\N
122	2	DI15 status	Input Register	315129.14	Boolean	14	\N	\N	None	On	Off	\N	\N	\N	\N
123	2	DI16 status	Input Register	315129.15	Boolean	15	\N	\N	None	On	Off	\N	\N	\N	\N
124	2	DI17 status	Input Register	315129.16	Boolean	16	\N	\N	None	On	Off	\N	\N	\N	\N
125	2	DI18 status	Input Register	315129.17	Boolean	17	\N	\N	None	On	Off	\N	\N	\N	\N
126	2	DI19 status	Input Register	315129.18	Boolean	18	\N	\N	None	On	Off	\N	\N	\N	\N
127	2	DI20 status	Input Register	315129.19	Boolean	19	\N	\N	None	On	Off	\N	\N	\N	\N
128	2	DI21 status	Input Register	315129.20	Boolean	20	\N	\N	None	On	Off	\N	\N	\N	\N
129	2	MV Node state 2	Input Register	315131	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
130	2	MV load switch status	Input Register	315131.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
131	2	HV remote trip	Input Register	315131.1	Boolean	1	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
132	2	Transformer compartment door	Input Register	315131.7	Boolean	7	\N	\N	Off (0)	Closed	Open	\N	\N	\N	\N
133	2	Transformer compartment smoke alarm	Input Register	315131.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
134	2	UPS fault	Input Register	315131.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
135	2	U1 Daily power yield	Input Register	315150	32-bit unsigned integer	\N	kWh	10	\N	\N	\N	\N	\N	\N	\N
136	2	U1 Monthly power yield	Input Register	315152	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
137	2	U1 Total power yield	Input Register	315154	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	\N
138	2	U1 Daily grid connected minutes	Input Register	315156	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
139	2	U1 Total running hours	Input Register	315157	32-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
140	2	U1 Internal Module Temperature	Input Register	315159	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
141	2	U1 DC Voltage	Input Register	315160	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
142	2	U1 DC Current	Input Register	315161	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
143	2	U1 DC Power	Input Register	315162	32-bit unsigned integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
144	2	U1 Voltage A-B	Input Register	315164	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
145	2	U1 Voltage B-C	Input Register	315165	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
146	2	U1 Voltage C-A	Input Register	315166	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
147	2	U1 Phase A Current	Input Register	315167	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
148	2	U1 Phase B Current	Input Register	315168	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
149	2	U1 Phase C Current	Input Register	315169	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
150	2	U1 Active Power	Input Register	315170	32-bit unsigned integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
151	2	U1 Reactive Power	Input Register	315172	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
152	2	U1 Power Factor	Input Register	315174	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
153	2	U1 Frequency	Input Register	315175	16-bit unsigned integer	\N	Hz	10	\N	\N	\N	\N	\N	\N	\N
154	2	U1 Efficiency	Input Register	315176	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	\N
155	2	U1 Clock Year	Input Register	315178	16-bit unsigned integer	\N	year	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
156	2	U1 Clock Month	Input Register	315179	16-bit unsigned integer	\N	month	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
157	2	U1 Clock Day	Input Register	315180	16-bit unsigned integer	\N	day	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
158	2	U1 Clock Hour	Input Register	315181	16-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
159	2	U1 Clock Minute	Input Register	315182	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
160	2	U1 Clock Second	Input Register	315183	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
161	2	U1 Fault State 1	Input Register	315186	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
162	2	U1 DC undervoltage alarm	Input Register	315186.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
163	2	U1 DC overvoltage alarm	Input Register	315186.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
164	2	U1 AC undervoltage alarm	Input Register	315186.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
165	2	U1 AC overvoltage alarm	Input Register	315186.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
166	2	U1 Underfrequency alarm	Input Register	315186.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
167	2	U1 Overfrequency alarm	Input Register	315186.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
168	2	U1 Contactor fault	Input Register	315186.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
169	2	U1 Anti islanding protection active	Input Register	315186.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
170	2	U1 Sensor failure	Input Register	315186.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
171	2	U1 PDP protection active	Input Register	315186.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
172	2	U1 Module overtemperature alarm	Input Register	315186.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
173	2	U1 Reactor overtemperature alarm	Input Register	315186.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
174	2	U1 Transformer overtemperature alarm	Input Register	315186.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
175	2	U1 DC leakage current protection alarm	Input Register	315186.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
176	2	U1 AC leakage current protection alarm	Input Register	315186.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
177	2	U1 Overload protection active	Input Register	315186.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
178	2	U1 GFDI protection active	Input Register	315186.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
179	2	U1 Fan fault	Input Register	315186.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
180	2	U1 DC fuse failure	Input Register	315186.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
181	2	U1 Detection fuse failure	Input Register	315186.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
182	2	U1 DC overcurrent	Input Register	315186.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
183	2	U1 AC overcurrent	Input Register	315186.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
184	2	U1 Frequency abnormal	Input Register	315186.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
185	2	U1 Temperature abnormal	Input Register	315186.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
186	2	U1 Hardware fault	Input Register	315186.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
187	2	U1 Grounding fault	Input Register	315186.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
188	2	U1 Bus overvoltage	Input Register	315186.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
189	2	U1 Bus undervoltage	Input Register	315186.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
190	2	U1 Inverter overvoltage	Input Register	315186.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
191	2	U1 Fault State 2	Input Register	315188	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
192	2	U1 Insulation impedance fault	Input Register	315188.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
193	2	U1 AC SPD fault	Input Register	315188.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
194	2	U1 Sampling fault	Input Register	315188.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
195	2	U1 DC polarity reversed alarm	Input Register	315188.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
196	2	U1 Control power supply fault	Input Register	315188.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
197	2	U1 Backup power supply fault	Input Register	315188.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
198	2	U1 AC current imballance	Input Register	315188.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
199	2	U1 AC fuse fault	Input Register	315188.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
200	2	U1 DC SPD fault	Input Register	315188.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
201	2	U1 Buffer contactor fault	Input Register	315188.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
202	2	U1 DC injection fault	Input Register	315188.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
203	2	U1 DC switch fault	Input Register	315188.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
204	2	U1 Device code repeat fault	Input Register	315188.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
205	2	U1 Parallel operation communication failure	Input Register	315188.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
206	2	U1 Control cabinet temperature alarm	Input Register	315188.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
207	2	U1 DC fuse grounding fault	Input Register	315188.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
208	2	U1 Reversed branch over current	Input Register	315188.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
209	2	U1 Grid voltage imballance	Input Register	315188.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
210	2	U1 AC cabinet temperature alarm	Input Register	315188.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
211	2	U1 AC switch disconnection	Input Register	315188.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
212	2	U1 AC switch fault	Input Register	315188.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
213	2	U1 Soft start fault	Input Register	315188.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
214	2	U1 DC voltage sampling fault	Input Register	315188.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
215	2	U1 Fan 2 fault	Input Register	315188.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
216	2	U1 Current unbalance 2	Input Register	315188.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
217	2	U1 Current unbalance 3	Input Register	315188.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
218	2	U1 Drive board fault	Input Register	315188.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
219	2	U1 DC cabinet temperature alarm	Input Register	315188.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
220	2	U1 Neutral point potential shift alarm	Input Register	315188.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
221	2	U1 Carrier sync failure	Input Register	315188.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
222	2	U1 Node State 1	Input Register	315194	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
223	2	U1 AC circuit breaker status	Input Register	315194.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
224	2	U1 AC main contactor status	Input Register	315194.1	Boolean	1	\N	\N	None	Closed	Open	\N	\N	\N	\N
225	2	U1 ABC fault	Input Register	315194.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
226	2	U1 ABC local remote status	Input Register	315194.13	Boolean	13	\N	\N	Off (0)	Remote	Local	\N	\N	\N	\N
227	2	U1 Node State 2	Input Register	315196	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
228	2	U1 SPD status	Input Register	315196.12	Boolean	12	\N	\N	None	Closed	Open	\N	\N	\N	\N
229	2	U1 DC switch 1 status	Input Register	315196.20	Boolean	20	\N	\N	None	Closed	Open	\N	\N	\N	\N
230	2	U1 DC switch 2 status	Input Register	315196.21	Boolean	21	\N	\N	None	Closed	Open	\N	\N	\N	\N
231	2	U1 DC switch 3 status	Input Register	315196.22	Boolean	22	\N	\N	None	Closed	Open	\N	\N	\N	\N
232	2	U1 DC switch 4 status	Input Register	315196.23	Boolean	23	\N	\N	None	Closed	Open	\N	\N	\N	\N
233	2	U1 Temperature 1	Input Register	315198	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
234	2	U1 Temperature 2	Input Register	315199	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
235	2	U1 Temperature 3	Input Register	315200	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
236	2	U1 Temperature 4	Input Register	315201	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
237	2	U1 Temperature 5	Input Register	315202	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
238	2	U1 Temperature 6	Input Register	315203	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
239	2	U1 Positive Resistance to Ground	Input Register	315204	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
240	2	U1 Negative Resistance to Ground	Input Register	315206	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
241	2	U1 Work State	Input Register	315208	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
242	2	U1 Running	Input Register	315208.0	Boolean	0	\N	\N	None	Running	Not Running	\N	\N	\N	\N
243	2	U1 Stopped	Input Register	315208.1	Boolean	1	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
244	2	U1 Initial Standby	Input Register	315208.2	Boolean	2	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
245	2	U1 Key Stop	Input Register	315208.3	Boolean	3	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
246	2	U1 Standby	Input Register	315208.4	Boolean	4	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
247	2	U1 Emergency Stop	Input Register	315208.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
248	2	U1 Starting	Input Register	315208.6	Boolean	6	\N	\N	None	Starting	Not Starting	\N	\N	\N	\N
249	2	U1 Stopping	Input Register	315208.7	Boolean	7	\N	\N	None	Stopping	Not Stopping	\N	\N	\N	\N
250	2	U1 Fault Stop	Input Register	315208.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
251	2	U1 Alarm running	Input Register	315208.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
252	2	U1 Derating running	Input Register	315208.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
253	2	U1 IO-DSP communication failure	Input Register	315208.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
254	2	U1 Inverter is running	Input Register	315208.17	Boolean	17	\N	\N	None	Running	Not Running	\N	\N	\N	\N
255	2	U1 Inverter is stopped	Input Register	315208.18	Boolean	18	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
256	2	U1 Anti-PID active	Input Register	315208.19	Boolean	19	\N	\N	On (1)	Active	Not-Active	\N	\N	\N	\N
257	2	U1 IO-MDC communication abnormal	Input Register	315208.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
258	2	U1 Alarm State	Input Register	315210	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
259	2	U1 Temperature alarm	Input Register	315210.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
260	2	U1 Low insulation resistance alarm	Input Register	315210.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
261	2	U1 GFRT operation alarm	Input Register	315210.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1210	3	U3 Fault State 2	Input Register	315428	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
262	2	U1 CT unbalance	Input Register	315210.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
263	2	U1 DC fuse failure	Input Register	315210.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
264	2	U1 DSP-MDC communication failure	Input Register	315210.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
265	2	U1 DC sensor fault	Input Register	315210.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
266	2	U1 DC SPD fault	Input Register	315210.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
267	2	U1 AC SPD fault	Input Register	315210.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
268	2	U1 Bypass circuit breaker fault	Input Register	315210.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
269	2	U1 Bypass fuse abnormal / branch fault	Input Register	315210.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
270	2	U1 Ground fuse fault	Input Register	315210.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
271	2	U1 DC switch fault	Input Register	315210.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
272	2	U1 Anti-PID power supply	Input Register	315210.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
273	2	U1 Fan fault	Input Register	315210.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
274	2	U1 External power supply fault	Input Register	315210.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
275	2	U1 DC bypass forward overcurrent alarm	Input Register	315210.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
276	2	U1 DC bypass reverse overcurrent alarm	Input Register	315210.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
277	2	U1 Tributary board communication failure	Input Register	315210.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
278	2	U1 AC circuit breaker fault	Input Register	315210.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
279	2	U1 Meter communication failure	Input Register	315210.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
280	2	U1 Fan 2 fault	Input Register	315210.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
281	2	U1 Contactor contact fault	Input Register	315210.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
282	2	U1 Temperature and humidity sensor fault	Input Register	315210.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
283	2	U1 Frequency deviation active power regulation	Input Register	315210.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
284	2	U1 Voltage deviation reactive power regulation	Input Register	315210.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
285	2	U1 Insulation impedance sensor fault	Input Register	315210.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
286	2	U1 Busbar temperature alarm	Input Register	315210.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
287	2	U1 Abnormal derating of fan	Input Register	315210.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
288	2	U1 Frequency abnormal	Input Register	315210.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
289	2	U1 Negative Voltage to Ground	Input Register	315212	16-bit signed integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
290	2	U1 Annual Power Yield	Input Register	315213	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
291	2	U1 CO2 Emission Reduction	Input Register	315215	32-bit unsigned integer	\N	kg	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
292	2	U2 Daily power yield	Input Register	315270	32-bit unsigned integer	\N	kWh	10	\N	\N	\N	\N	\N	\N	\N
293	2	U2 Monthly power yield	Input Register	315272	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
294	2	U2 Total power yield	Input Register	315274	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	\N
295	2	U2 Daily grid connected minutes	Input Register	315276	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
296	2	U2 Total runninghours	Input Register	315277	32-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
297	2	U2 Internal Module Temperature	Input Register	315279	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
298	2	U2 DC Voltage	Input Register	315280	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
299	2	U2 DC Current	Input Register	315281	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
300	2	U2 DC Power	Input Register	315282	32-bit unsigned integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
301	2	U2 Voltage A-B	Input Register	315284	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
302	2	U2 Voltage B-C	Input Register	315285	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
303	2	U2 Voltage C-A	Input Register	315286	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
304	2	U2 Phase A Current	Input Register	315287	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
305	2	U2 Phase B Current	Input Register	315288	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
306	2	U2 Phase C Current	Input Register	315289	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
307	2	U2 Active Power	Input Register	315290	32-bit unsigned integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
308	2	U2 Reactive Power	Input Register	315292	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
309	2	U2 Power Factor	Input Register	315294	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
310	2	U2 Frequency	Input Register	315295	16-bit unsigned integer	\N	Hz	10	\N	\N	\N	\N	\N	\N	\N
311	2	U2 Efficiency	Input Register	315296	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	\N
312	2	U2 Clock Year	Input Register	315298	16-bit unsigned integer	\N	year	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
313	2	U2 Clock Month	Input Register	315299	16-bit unsigned integer	\N	month	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
314	2	U2 Clock Day	Input Register	315300	16-bit unsigned integer	\N	day	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
315	2	U2 Clock Hour	Input Register	315301	16-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
316	2	U2 Clock Minute	Input Register	315302	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
317	2	U2 Clock Second	Input Register	315303	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
318	2	U2 Fault State 1	Input Register	315306	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
319	2	U2 DC undervoltage alarm	Input Register	315306.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
320	2	U2 DC overvoltage alarm	Input Register	315306.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
321	2	U2 AC undervoltage alarm	Input Register	315306.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
322	2	U2 AC overvoltage alarm	Input Register	315306.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
323	2	U2 Underfrequency alarm	Input Register	315306.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
324	2	U2 Overfrequency alarm	Input Register	315306.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
325	2	U2 Contactor fault	Input Register	315306.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
326	2	U2 Anti islanding protection active	Input Register	315306.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
327	2	U2 Sensor failure	Input Register	315306.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
328	2	U2 PDP protection active	Input Register	315306.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
329	2	U2 Module overtemperature alarm	Input Register	315306.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
330	2	U2 Reactor overtemperature alarm	Input Register	315306.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
331	2	U2 Transformer overtemperature alarm	Input Register	315306.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
332	2	U2 DC leakage current protection alarm	Input Register	315306.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
333	2	U2 AC leakage current protection alarm	Input Register	315306.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
334	2	U2 Overload protection active	Input Register	315306.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
335	2	U2 GFDI protection active	Input Register	315306.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
336	2	U2 Fan fault	Input Register	315306.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
337	2	U2 DC fuse failure	Input Register	315306.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
338	2	U2 Detection fuse failure	Input Register	315306.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
339	2	U2 DC overcurrent	Input Register	315306.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
340	2	U2 AC overcurrent	Input Register	315306.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
341	2	U2 Frequency abnormal	Input Register	315306.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
342	2	U2 Temperature abnormal	Input Register	315306.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
343	2	U2 Hardware fault	Input Register	315306.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
344	2	U2 Grounding fault	Input Register	315306.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
345	2	U2 Bus overvoltage	Input Register	315306.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
346	2	U2 Bus undervoltage	Input Register	315306.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
347	2	U2 Inverter overvoltage	Input Register	315306.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
348	2	U2 Fault State 2	Input Register	315308	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
349	2	U2 Insulation impedance fault	Input Register	315308.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
350	2	U2 AC SPD fault	Input Register	315308.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
351	2	U2 Sampling fault	Input Register	315308.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
352	2	U2 DC polarity reversed alarm	Input Register	315308.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
353	2	U2 Control power supply fault	Input Register	315308.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
354	2	U2 Backup power supply fault	Input Register	315308.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
355	2	U2 AC current imballance	Input Register	315308.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
356	2	U2 AC fuse fault	Input Register	315308.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
357	2	U2 DC SPD fault	Input Register	315308.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
358	2	U2 Buffer contactor fault	Input Register	315308.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
359	2	U2 DC injection fault	Input Register	315308.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
360	2	U2 DC switch fault	Input Register	315308.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
361	2	U2 Device code repeat fault	Input Register	315308.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
362	2	U2 Parallel operation communication failure	Input Register	315308.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
363	2	U2 Control cabinet temperature alarm	Input Register	315308.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
364	2	U2 DC fuse grounding fault	Input Register	315308.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
365	2	U2 Reversed branch over current	Input Register	315308.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
366	2	U2 Grid voltage imballance	Input Register	315308.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
367	2	U2 AC cabinet temperature alarm	Input Register	315308.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
368	2	U2 AC switch disconnection	Input Register	315308.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
369	2	U2 AC switch fault	Input Register	315308.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
370	2	U2 Soft start fault	Input Register	315308.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
371	2	U2 DC voltage sampling fault	Input Register	315308.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
372	2	U2 Fan 2 fault	Input Register	315308.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
373	2	U2 Current unbalance 2	Input Register	315308.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
374	2	U2 Current unbalance 3	Input Register	315308.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
375	2	U2 Drive board fault	Input Register	315308.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
376	2	U2 DC cabinet temperature alarm	Input Register	315308.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
377	2	U2 Neutral point potential shift alarm	Input Register	315308.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
378	2	U2 Carrier sync failure	Input Register	315308.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
379	2	U2 Node State 1	Input Register	315314	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
380	2	U2 AC circuit breaker status	Input Register	315314.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
381	2	U2 AC main contactor status	Input Register	315314.1	Boolean	1	\N	\N	None	Closed	Open	\N	\N	\N	\N
382	2	U2 ABC fault	Input Register	315314.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
383	2	U2 ABC local remote status	Input Register	315314.13	Boolean	13	\N	\N	Off (0)	Remote	Local	\N	\N	\N	\N
384	2	U2 Node State 2	Input Register	315316	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
385	2	U2 SPD status	Input Register	315316.12	Boolean	12	\N	\N	None	Closed	Open	\N	\N	\N	\N
386	2	U2 DC switch 1 status	Input Register	315316.20	Boolean	20	\N	\N	None	Closed	Open	\N	\N	\N	\N
387	2	U2 DC switch 2 status	Input Register	315316.21	Boolean	21	\N	\N	None	Closed	Open	\N	\N	\N	\N
388	2	U2 DC switch 3 status	Input Register	315316.22	Boolean	22	\N	\N	None	Closed	Open	\N	\N	\N	\N
389	2	U2 DC switch 4 status	Input Register	315316.23	Boolean	23	\N	\N	None	Closed	Open	\N	\N	\N	\N
390	2	U2 Temperature 1	Input Register	315318	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
391	2	U2 Temperature 2	Input Register	315319	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
392	2	U2 Temperature 3	Input Register	315320	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
393	2	U2 Temperature 4	Input Register	315321	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
394	2	U2 Temperature 5	Input Register	315322	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
395	2	U2 Temperature 6	Input Register	315323	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
396	2	U2 Positive Resistance to Ground	Input Register	315324	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
397	2	U2 Negative Resistance to Ground	Input Register	315326	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
398	2	U2 Work State	Input Register	315328	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
399	2	U2 Running	Input Register	315328.0	Boolean	0	\N	\N	None	Running	Not Running	\N	\N	\N	\N
400	2	U2 Stopped	Input Register	315328.1	Boolean	1	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
401	2	U2 Initial Standby	Input Register	315328.2	Boolean	2	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
402	2	U2 Key Stop	Input Register	315328.3	Boolean	3	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
403	2	U2 Standby	Input Register	315328.4	Boolean	4	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
404	2	U2 Emergency Stop	Input Register	315328.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
405	2	U2 Starting	Input Register	315328.6	Boolean	6	\N	\N	None	Starting	Not Starting	\N	\N	\N	\N
406	2	U2 Stopping	Input Register	315328.7	Boolean	7	\N	\N	None	Stopping	Not Stopping	\N	\N	\N	\N
407	2	U2 Fault Stop	Input Register	315328.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
408	2	U2 Alarm running	Input Register	315328.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
409	2	U2 Derating running	Input Register	315328.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
410	2	U2 IO-DSP communication failure	Input Register	315328.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
411	2	U2 Inverter is running	Input Register	315328.17	Boolean	17	\N	\N	None	Running	Not Running	\N	\N	\N	\N
412	2	U2 Inverter is stopped	Input Register	315328.18	Boolean	18	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
413	2	U2 Anti-PID active	Input Register	315328.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
414	2	U2 IO-MDC communication abnormal	Input Register	315328.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
415	2	U2 Alarm State	Input Register	315330	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
416	2	U2 Temperature alarm	Input Register	315330.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
417	2	U2 Low insulation resistance alarm	Input Register	315330.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
418	2	U2 GFRT operation alarm	Input Register	315330.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
419	2	U2 CT unbalance	Input Register	315330.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
420	2	U2 DC fuse failure	Input Register	315330.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
421	2	U2 DSP-MDC communication failure	Input Register	315330.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
422	2	U2 DC sensor fault	Input Register	315330.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
423	2	U2 DC SPD fault	Input Register	315330.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
424	2	U2 AC SPD fault	Input Register	315330.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
425	2	U2 Bypass circuit breaker fault	Input Register	315330.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
426	2	U2 Bypass fuse abnormal / branch fault	Input Register	315330.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
427	2	U2 Ground fuse fault	Input Register	315330.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
428	2	U2 DC switch fault	Input Register	315330.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
429	2	U2 Anti-PID power supply	Input Register	315330.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
430	2	U2 Fan fault	Input Register	315330.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
431	2	U2 External power supply fault	Input Register	315330.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
432	2	U2 DC bypass forward overcurrent alarm	Input Register	315330.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
433	2	U2 DC bypass reverse overcurrent alarm	Input Register	315330.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
434	2	U2 Tributary board communication failure	Input Register	315330.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
435	2	U2 AC circuit breaker fault	Input Register	315330.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
436	2	U2 Meter communication failure	Input Register	315330.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
437	2	U2 Fan 2 fault	Input Register	315330.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
438	2	U2 Contactor contact fault	Input Register	315330.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
439	2	U2 Temperature and humidity sensor fault	Input Register	315330.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
440	2	U2 Frequency deviation active power regulation	Input Register	315330.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
441	2	U2 Voltage deviation reactive power regulation	Input Register	315330.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
442	2	U2 Insulation impedance sensor fault	Input Register	315330.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
443	2	U2 Busbar temperature alarm	Input Register	315330.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
444	2	U2 Abnormal derating of fan	Input Register	315330.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
445	2	U2 Frequency abnormal	Input Register	315330.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
446	2	U2 Negative Voltage to Ground	Input Register	315332	16-bit signed integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
447	2	U2 Annual Power Yield	Input Register	315333	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
448	2	U2 CO2 Emission Reduction	Input Register	315335	32-bit unsigned integer	\N	kg	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
449	2	Certified Software Version	Input Register	315635	String	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
450	2	Overexcitation Specified Active Power	Input Register	315700	32-bit signed integer	\N	kW	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
451	2	Underexcitation Specified Active Power	Input Register	315702	32-bit signed integer	\N	kW	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
452	2	Commercial Plant Running Status	Input Register	315704	16-bit unsigned integer	\N	boolean	\N	Off (0)	Running	Offline	\N	\N	\N	This point is not mapped to ignition
453	2	Maximum Appearant Power	Input Register	315705	16-bit unsigned integer	\N	kVA	10	\N	\N	\N	\N	\N	\N	\N
454	2	Maximum Discharging Power	Input Register	315706	16-bit unsigned integer	\N	kW	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
455	2	Maximum inductive reactive power	Input Register	315707	16-bit signed integer	\N	kvar	10	\N	\N	\N	\N	\N	\N	\N
456	2	Maximum capacitive reactive power	Input Register	315708	16-bit signed integer	\N	kvar	10	\N	\N	\N	\N	\N	\N	\N
457	2	Grid connected status of commercial plant	Input Register	315709	16-bit unsigned integer	\N	boolean	\N	Off (0)	Connected	Disconnected	\N	\N	\N	This point is not mapped to ignition
458	2	Nominal AC voltage	Input Register	315710	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
459	2	Max AC Voltage	Input Register	315711	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
460	2	Min AC Voltage	Input Register	315712	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
461	2	QU Reference Voltage Current Value	Input Register	315733	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
462	2	U1 Valid Recorder Quantity	Input Register	315734	16-bit unsigned integer	\N	count	\N	\N	\N	\N	\N	\N	\N	\N
463	2	U2 Valid Recorder Quantity	Input Register	315735	16-bit unsigned integer	\N	count	\N	\N	\N	\N	\N	\N	\N	\N
464	2	Zone Monitor Work State	Input Register	316000	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Zone Monitor Work State:\n0: Disable\n1: Self-Study\n2: Fault Detection\n	\N
465	2	Branch Open Circuit Alarm	Input Register	316001	32-bit bitfield	\N	unitless	\N	\N	\N	\N	\N	\N	\N	\N
466	2	U1 open circuit fault branch 1	Input Register	316001.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
467	2	U1 open circuit fault branch 2	Input Register	316001.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
468	2	U1 open circuit fault branch 3	Input Register	316001.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
469	2	U1 open circuit fault branch 4	Input Register	316001.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
470	2	U1 open circuit fault branch 5	Input Register	316001.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
471	2	U1 open circuit fault branch 6	Input Register	316001.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
472	2	U1 open circuit fault branch 7	Input Register	316001.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
473	2	U1 open circuit fault branch 8	Input Register	316001.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
474	2	U1 open circuit fault branch 9	Input Register	316001.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
475	2	U1 open circuit fault branch 10	Input Register	316001.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
476	2	U1 open circuit fault branch 11	Input Register	316001.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
477	2	U1 open circuit fault branch 12	Input Register	316001.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
478	2	U1 open circuit fault branch 13	Input Register	316001.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
479	2	U1 open circuit fault branch 14	Input Register	316001.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
480	2	U1 open circuit fault branch 15	Input Register	316001.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
481	2	U1 open circuit fault branch 16	Input Register	316001.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
482	2	U2 open circuit fault branch 1	Input Register	316001.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
483	2	U2 open circuit fault branch 2	Input Register	316001.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
484	2	U2 open circuit fault branch 3	Input Register	316001.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
485	2	U2 open circuit fault branch 4	Input Register	316001.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
486	2	U2 open circuit fault branch 5	Input Register	316001.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
487	2	U2 open circuit fault branch 6	Input Register	316001.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
488	2	U2 open circuit fault branch 7	Input Register	316001.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
489	2	U2 open circuit fault branch 8	Input Register	316001.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
490	2	U2 open circuit fault branch 9	Input Register	316001.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
491	2	U2 open circuit fault branch 10	Input Register	316001.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
492	2	U2 open circuit fault branch 11	Input Register	316001.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
493	2	U2 open circuit fault branch 12	Input Register	316001.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
494	2	U2 open circuit fault branch 13	Input Register	316001.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
495	2	U2 open circuit fault branch 14	Input Register	316001.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
496	2	U2 open circuit fault branch 15	Input Register	316001.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
497	2	U2 open circuit fault branch 16	Input Register	316001.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
498	2	Branch String Alarm	Input Register	316003	32-bit bitfield	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
499	2	U1 string failure branch 1	Input Register	316003.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
500	2	U1 string failure branch 2	Input Register	316003.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
501	2	U1 string failure branch 3	Input Register	316003.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
502	2	U1 string failure branch 4	Input Register	316003.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
503	2	U1 string failure branch 5	Input Register	316003.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
504	2	U1 string failure branch 6	Input Register	316003.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
505	2	U1 string failure branch 7	Input Register	316003.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
506	2	U1 string failure branch 8	Input Register	316003.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
507	2	U1 string failure branch 9	Input Register	316003.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
508	2	U1 string failure branch 10	Input Register	316003.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
509	2	U1 string failure branch 11	Input Register	316003.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
510	2	U1 string failure branch 12	Input Register	316003.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
511	2	U1 string failure branch 13	Input Register	316003.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
512	2	U1 string failure branch 14	Input Register	316003.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
513	2	U1 string failure branch 15	Input Register	316003.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
514	2	U1 string failure branch 16	Input Register	316003.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
515	2	U2 string failure branch 1	Input Register	316003.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
516	2	U2 string failure branch 2	Input Register	316003.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
517	2	U2 string failure branch 3	Input Register	316003.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
518	2	U2 string failure branch 4	Input Register	316003.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
519	2	U2 string failure branch 5	Input Register	316003.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
520	2	U2 string failure branch 6	Input Register	316003.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
521	2	U2 string failure branch 7	Input Register	316003.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
522	2	U2 string failure branch 8	Input Register	316003.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
523	2	U2 string failure branch 9	Input Register	316003.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
524	2	U2 string failure branch 10	Input Register	316003.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
525	2	U2 string failure branch 11	Input Register	316003.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
526	2	U2 string failure branch 12	Input Register	316003.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
527	2	U2 string failure branch 13	Input Register	316003.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
528	2	U2 string failure branch 14	Input Register	316003.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
529	2	U2 string failure branch 15	Input Register	316003.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
530	2	U2 string failure branch 16	Input Register	316003.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
531	2	U1 Warning Number of Strings Branch 1	Input Register	316005	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
532	2	U1 Warning Number of Strings Branch 2	Input Register	316006	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
533	2	U1 Warning Number of Strings Branch 3	Input Register	316007	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
534	2	U1 Warning Number of Strings Branch 4	Input Register	316008	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
535	2	U1 Warning Number of Strings Branch 5	Input Register	316009	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
536	2	U1 Warning Number of Strings Branch 6	Input Register	316010	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
537	2	U1 Warning Number of Strings Branch 7	Input Register	316011	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
538	2	U1 Warning Number of Strings Branch 8	Input Register	316012	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
539	2	U1 Warning Number of Strings Branch 9	Input Register	316013	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
540	2	U1 Warning Number of Strings Branch 10	Input Register	316014	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
541	2	U1 Warning Number of Strings Branch 11	Input Register	316015	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
542	2	U1 Warning Number of Strings Branch 12	Input Register	316016	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
543	2	U1 Warning Number of Strings Branch 13	Input Register	316017	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
544	2	U1 Warning Number of Strings Branch 14	Input Register	316018	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
545	2	U1 Warning Number of Strings Branch 15	Input Register	316019	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
546	2	U1 Warning Number of Strings Branch 16	Input Register	316020	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
547	2	U2 Warning Number of Strings Branch 1	Input Register	316021	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
548	2	U2 Warning Number of Strings Branch 2	Input Register	316022	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
549	2	U2 Warning Number of Strings Branch 3	Input Register	316023	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
550	2	U2 Warning Number of Strings Branch 4	Input Register	316024	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
551	2	U2 Warning Number of Strings Branch 5	Input Register	316025	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
552	2	U2 Warning Number of Strings Branch 6	Input Register	316026	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
553	2	U2 Warning Number of Strings Branch 7	Input Register	316027	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
554	2	U2 Warning Number of Strings Branch 8	Input Register	316028	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
555	2	U2 Warning Number of Strings Branch 9	Input Register	316029	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
556	2	U2 Warning Number of Strings Branch 10	Input Register	316030	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
557	2	U2 Warning Number of Strings Branch 11	Input Register	316031	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
558	2	U2 Warning Number of Strings Branch 12	Input Register	316032	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
559	2	U2 Warning Number of Strings Branch 13	Input Register	316033	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
560	2	U2 Warning Number of Strings Branch 14	Input Register	316034	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
561	2	U2 Warning Number of Strings Branch 15	Input Register	316035	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
562	2	U2 Warning Number of Strings Branch 16	Input Register	316036	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
563	2	Set system clock year	Holding Register	415000	16-bit unsigned integer	\N	year	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
564	2	Set system clock month	Holding Register	415001	16-bit unsigned integer	\N	month	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
565	2	Set system clock day	Holding Register	415002	16-bit unsigned integer	\N	day	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
566	2	Set system clock hour	Holding Register	415003	16-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
567	2	Set system clock minute	Holding Register	415004	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
568	2	Set system clock second	Holding Register	415005	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
569	2	Start stop command	Holding Register	415006	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Start Stop Enumeration:\n16#CE - Stop\n16#CF - Start\nAll others no operation	\N
570	2	Emergency stop command	Holding Register	415007	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Start Stop Enumeration:\n16#CF - Emergency Stop\nAll others no operation	\N
571	2	Active power percent	Holding Register	415008	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
572	2	Local remote control	Holding Register	415010	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Matt Munin:\n1 - Remote Only\n2 - Local Only\n3 - Remote and Local Control	This point is not mapped to ignition
573	2	Reactive power mode	Holding Register	415011	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Reactive Power Mode:\n16#55 - OFF\n16#A1 - Power factor mode\n16#A2 - Reactive output mode\n16#A3 - QU mode\n16#A4 - Voltage mode\n16#A5 - QP mode\n	\N
574	2	Reactive power percent setpoint	Holding Register	415012	16-bit signed integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
575	2	Power factor setpoint	Holding Register	415013	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
576	2	Power limit actual value setpoint	Holding Register	415014	16-bit unsigned integer	\N	kW	10	\N	\N	\N	\N	\N	\N	\N
577	2	Reactive power actual limit setpoint	Holding Register	415015	16-bit signed integer	\N	kvar	10	\N	\N	\N	\N	\N	\N	\N
578	2	Active power ramp up rate setpoint	Holding Register	415016	16-bit unsigned integer	\N	%/s	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
579	2	Active power ramp down rate setpoint	Holding Register	415017	16-bit unsigned integer	\N	%/s	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
580	2	Stop delay time	Holding Register	415020	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
581	2	Stop slope	Holding Register	415021	16-bit unsigned integer	\N	%/s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
582	2	High voltage load switch remote switch	Holding Register	415026	16-bit unsigned integer	\N	boolean	\N	On (1)	Local	Remote	\N	\N	\N	This point is not mapped to ignition
583	2	Reactive power ramp up rate setpoint	Holding Register	415027	16-bit unsigned integer	\N	%/s	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
584	2	Reactive power ramp down rate setpoint	Holding Register	415028	16-bit unsigned integer	\N	%/s	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
585	2	Qu activation power point	Holding Register	415029	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
586	2	Qu operation mode	Holding Register	415030	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	QU Operation Mode:\n16#A1 - Reactive power ratio mode\n16#A2 - Active power ratio mode\n16#A3 - Power factor mode	This point is not mapped to ignition
587	2	Qu input voltage source	Holding Register	415031	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Voltage Source:\n16#B1 - real time voltage\n16#B2 - record voltage\n	This point is not mapped to ignition
588	2	Qu inductive reactive power limit setpoint	Holding Register	415032	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
589	2	Qu capacitive reactive power limit setpoint	Holding Register	415033	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
590	2	Qu power factor end point	Holding Register	415034	16-bit unsigned integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
591	2	Qu power factor start point	Holding Register	415035	16-bit unsigned integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
592	2	Qu voltage rise start point	Holding Register	415037	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
593	2	Qu voltage rise end point	Holding Register	415038	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
594	2	Qu voltage drop start point	Holding Register	415039	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
595	2	Qu voltage drop end point	Holding Register	415040	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
596	2	Automatic voltage regulation benchmark	Holding Register	415043	16-bit unsigned integer	\N	%	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
597	2	Automatic voltage regulation hysterisis	Holding Register	415044	16-bit unsigned integer	\N	%	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
598	2	Qu reactive power rising start	Holding Register	415051	16-bit signed integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
599	2	Qu reactive power decline start	Holding Register	415052	16-bit signed integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
600	2	Enable pu	Holding Register	415055	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Enable Disable P(U):\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
601	2	Pu active power rising gradiant	Holding Register	415056	16-bit unsigned integer	\N	%	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
602	2	Pu active power decline gradiant	Holding Register	415057	16-bit unsigned integer	\N	%	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
603	2	Dc switch open close	Holding Register	415060	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	DC Switch Open/Close:\n16#55 - Close\n16#AA - Open\n	\N
604	2	Night svg enable disable	Holding Register	415061	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Night SVG Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
605	2	Start waiting time	Holding Register	415062	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
606	2	Time for automatic recovery from fault	Holding Register	415063	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
607	2	Overfrequency recovery threshold	Holding Register	415064	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
608	2	Underfrequency recovery threshold	Holding Register	415065	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
609	2	Dc starting voltage	Holding Register	415066	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
610	2	Overall mppt	Holding Register	415069	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	MPPT Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
611	2	Overall mppt calculation period	Holding Register	415070	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
612	2	Frequency modulation enable	Holding Register	415073	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Frequency modulation Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
613	2	Frequency regulation output change benchmark	Holding Register	415074	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Frequency output change benchmark:\n16#A1 - function u nknown\n16#A2 - function unknown	This point is not mapped to ignition
614	2	Overfrequency derating start point	Holding Register	415075	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
615	2	Overfrequency derating end point	Holding Register	415076	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
616	2	Overfrequency derating factor	Holding Register	415077	16-bit unsigned integer	\N	PU	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
617	2	Overfrequency derating limit	Holding Register	415078	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
618	2	Frequency regulation input source	Holding Register	415079	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Frequency Source:\n16#B1 - real time frequency\n16#B2 - record frequency\n	This point is not mapped to ignition
619	2	Frequency regulation active power	Holding Register	415080	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
620	2	Underfrequency rising start point	Holding Register	415081	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
621	2	Underfrequency rising end point	Holding Register	415082	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
622	2	Underfrequency rise factor	Holding Register	415083	16-bit unsigned integer	\N	PU	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
623	2	Underfrequency rising limit	Holding Register	415084	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
624	2	Leakage current protection value	Holding Register	415088	16-bit unsigned integer	\N	A	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
625	2	Ac overvoltage level 1 protection	Holding Register	415120	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
626	2	Ac overvoltage level 2 protection	Holding Register	415121	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
627	2	Ac overvoltage level 3 protection	Holding Register	415122	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
628	2	Ac overvoltage level 4 protection	Holding Register	415123	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
629	2	Ac overvoltage level 5 protection	Holding Register	415124	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
630	2	Vmax recover	Holding Register	415130	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
631	2	Ac undervoltage level 1 protection	Holding Register	415131	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
632	2	Ac undervoltage level 2 protection	Holding Register	415132	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
633	2	Ac undervoltage level 3 protection	Holding Register	415133	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
634	2	Ac undervoltage level 4 protection	Holding Register	415134	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
635	2	Ac undervoltage level 5 protection	Holding Register	415135	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
636	2	Vmin recover	Holding Register	415141	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
637	2	Grid over frequency level 1 protection	Holding Register	415142	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
638	2	Grid over frequency level 2 protection	Holding Register	415143	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
639	2	Grid over frequency level 3 protection	Holding Register	415144	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
640	2	Grid over frequency level 4 protection	Holding Register	415145	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
641	2	Grid over frequency level 5 protection	Holding Register	415146	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
642	2	Fmax recover	Holding Register	415152	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
643	2	AC under frequency level 1 protection	Holding Register	415153	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
644	2	AC under frequency level 2 protection	Holding Register	415154	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
645	2	AC under frequency level 3 protection	Holding Register	415155	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
646	2	AC under frequency level 4 protection	Holding Register	415156	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
647	2	AC under frequency level 5 protection	Holding Register	415157	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
648	2	Fmin recover	Holding Register	415163	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
649	2	Floating mode	Holding Register	415168	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
650	2	Over voltage level 1 trip time	Holding Register	415170	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
651	2	Over voltage level 2 trip time	Holding Register	415172	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
652	2	Over voltage level 3 trip time	Holding Register	415174	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
653	2	Over voltage level 4 trip time	Holding Register	415176	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
654	2	Over voltage level 5 trip time	Holding Register	415178	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
655	2	Under voltage level 1 trip time	Holding Register	415180	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
656	2	Under voltage level 2 trip time	Holding Register	415182	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
657	2	Under voltage level 3 trip time	Holding Register	415184	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
658	2	Under voltage level 4 trip time	Holding Register	415186	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
659	2	Under voltage level 5 trip time	Holding Register	415188	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
660	2	Over frequency level 1 trip time	Holding Register	415190	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
661	2	Over frequency level 2 trip time	Holding Register	415192	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
662	2	Over frequency level 3 trip time	Holding Register	415194	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
663	2	Over frequency level 4 trip time	Holding Register	415196	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
664	2	Over frequency level 5 trip time	Holding Register	415198	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
665	2	Under frequency level 1 trip time	Holding Register	415200	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
666	2	Under frequency level 2 trip time	Holding Register	415202	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
667	2	Under frequency level 3 trip time	Holding Register	415204	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
668	2	Under frequency level 4 trip time	Holding Register	415206	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
669	2	Under frequency level 5 trip time	Holding Register	415208	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
670	2	Active power control closed loop enable disable	Holding Register	415212	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Active Power Closed Loop Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
671	2	Reactive power control closed loop enable disable	Holding Register	415213	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Reactive Power Closed Loop Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
672	2	Reactive power response time	Holding Register	415224	16-bit unsigned integer	\N	s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
673	2	QP_K1	Holding Register	415225	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
674	2	QP_K2	Holding Register	415226	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
675	2	QP_K3	Holding Register	415227	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
676	2	QP_P1	Holding Register	415228	16-bit unsigned integer	\N	PU	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
677	2	QP_P2	Holding Register	415229	16-bit unsigned integer	\N	PU	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
678	2	QP_P3	Holding Register	415230	16-bit unsigned integer	\N	PU	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
679	2	QP mode	Holding Register	415231	Enumeration	\N	unitless	\N	\N	\N	\N	\N	\N	Frequency output change benchmark:\n16#A1 - function u nknown\n16#A2 - function unknown	This point is not mapped to ignition
680	2	Heartbeat	Holding Register	415248	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
681	2	Heartbeat timeout period	Holding Register	415249	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
682	2	Grid connection maximum voltage	Holding Register	415257	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
683	2	Grid connection minimum voltage	Holding Register	415258	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
684	2	Grid connection maximum frequency	Holding Register	415259	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
685	2	Grid connection minimum frequency	Holding Register	415260	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
686	2	Grid detection before connection	Holding Register	415261	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
687	2	Boot waiting time	Holding Register	415262	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
688	2	Specified overexcitation PF	Holding Register	415265	16-bit signed integer	\N	PU	0.001	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
689	2	Specified underrexcitation PF	Holding Register	415266	16-bit signed integer	\N	PU	0.001	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
690	2	QU reference voltage automatic adjustment	Holding Register	415267	16-bit signed integer	\N	unitless	\N	\N	\N	\N	\N	\N	Reactive Power Closed Loop Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
691	2	QU reference voltage adjustment	Holding Register	415268	16-bit unsigned integer	\N	%	0.1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
692	2	QU reference voltage automatic adjustment time	Holding Register	415269	16-bit signed integer	\N	s	0.1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
693	2	Overvoltage derating start point	Holding Register	415270	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
694	2	Overvoltage derating power start point	Holding Register	415271	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
695	2	Overvoltage derating end point	Holding Register	415272	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
696	2	Overvoltage derating power end point	Holding Register	415273	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
697	2	Voltage derating response time	Holding Register	415274	16-bit unsigned integer	\N	s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
698	2	Over frequency response time	Holding Register	415275	16-bit unsigned integer	\N	s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
699	2	Under frequency response time	Holding Register	415276	16-bit unsigned integer	\N	s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
700	2	Over frequency response delay time	Holding Register	415281	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
701	2	Under frequency response delay time	Holding Register	415282	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
702	2	Zone monitoring	Holding Register	415800	16-bit unsigned integer	\N	boolean	\N	State change	Enable	Disable	\N	\N	\N	This point is not mapped to ignition
703	2	Sensitivity	Holding Register	415802	16-bit unsigned integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
704	2	Clear zone monitor data	Holding Register	415803	16-bit unsigned integer	\N	boolean	\N	On (1)	Clear	No Action	\N	\N	\N	This point is not mapped to ignition
705	2	Clear fault	Holding Register	415804	16-bit unsigned integer	\N	boolean	\N	On (1)	Clear	No Action	\N	\N	\N	This point is not mapped to ignition
706	2	U1 number of strings on branch 1	Holding Register	415805	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
707	2	U1 number of strings on branch 2	Holding Register	415806	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
708	2	U1 number of strings on branch 3	Holding Register	415807	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
709	2	U1 number of strings on branch 4	Holding Register	415808	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
710	2	U1 number of strings on branch 5	Holding Register	415809	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
711	2	U1 number of strings on branch 6	Holding Register	415810	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
712	2	U1 number of strings on branch 7	Holding Register	415811	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
713	2	U1 number of strings on branch 8	Holding Register	415812	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
714	2	U1 number of strings on branch 9	Holding Register	415813	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
715	2	U1 number of strings on branch 10	Holding Register	415814	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
716	2	U1 number of strings on branch 11	Holding Register	415815	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
717	2	U1 number of strings on branch 12	Holding Register	415816	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
718	2	U1 number of strings on branch 13	Holding Register	415817	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
719	2	U1 number of strings on branch 14	Holding Register	415818	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
720	2	U1 number of strings on branch 15	Holding Register	415819	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
721	2	U1 number of strings on branch 16	Holding Register	415820	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
722	2	U2 number of strings on branch 1	Holding Register	415821	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
723	2	U2 number of strings on branch 2	Holding Register	415822	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
724	2	U2 number of strings on branch 3	Holding Register	415823	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
725	2	U2 number of strings on branch 4	Holding Register	415824	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
726	2	U2 number of strings on branch 5	Holding Register	415825	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
727	2	U2 number of strings on branch 6	Holding Register	415826	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
728	2	U2 number of strings on branch 7	Holding Register	415827	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
729	2	U2 number of strings on branch 8	Holding Register	415828	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
730	2	U2 number of strings on branch 9	Holding Register	415829	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
731	2	U2 number of strings on branch 10	Holding Register	415830	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
732	2	U2 number of strings on branch 11	Holding Register	415831	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
733	2	U2 number of strings on branch 12	Holding Register	415832	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
734	2	U2 number of strings on branch 13	Holding Register	415833	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
735	2	U2 number of strings on branch 14	Holding Register	415834	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
736	2	U2 number of strings on branch 15	Holding Register	415835	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
737	2	U2 number of strings on branch 16	Holding Register	415836	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
738	3	Protocol Number	Input Register	315000	32-bit unsigned integer	\N	unitless	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
739	3	Protocol Version	Input Register	315002	32-bit unsigned integer	\N	unitless	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
740	3	Serial Number	Input Register	315004	String	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
741	3	Machine Model	Input Register	315012	String	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
742	3	Device Type Code	Input Register	315070	16-bit unsigned integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
743	3	Rated active power	Input Register	315071	16-bit unsigned integer	\N	kW	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
744	3	Daily Power yield	Input Register	315073	32-bit unsigned integer	\N	kWh	10	\N	\N	\N	\N	\N	\N	\N
745	3	Monthly Power yield	Input Register	315075	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
746	3	Total Power yield	Input Register	315077	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	\N
747	3	CO2 emission reduction	Input Register	315079	32-bit unsigned integer	\N	kg	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
748	3	Daily grid connected minutes	Input Register	315081	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
749	3	Total Running Hours	Input Register	315082	32-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
750	3	Total DC Power	Input Register	315092	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
751	3	A-B Line Voltage	Input Register	315094	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
752	3	B-C Line Voltage	Input Register	315095	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
753	3	C-A Line Voltage	Input Register	315096	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
754	3	Phase A Current	Input Register	315097	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
755	3	Phase B Current	Input Register	315098	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
756	3	Phase C Current	Input Register	315099	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
757	3	Total active power	Input Register	315100	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
758	3	Total reactive power	Input Register	315102	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
759	3	Total appearant power	Input Register	315104	32-bit unsigned integer	\N	VA	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
760	3	Power Factor	Input Register	315106	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
761	3	Frequency	Input Register	315107	16-bit unsigned integer	\N	Hz	10	\N	\N	\N	\N	\N	\N	\N
762	3	Rated reactive power	Input Register	315108	16-bit unsigned integer	\N	kvar	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
763	3	Power limit actual value feedback	Input Register	315109	32-bit unsigned integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
764	3	Reactive power adjustment actual value feedback	Input Register	315111	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
765	3	Power factor feedback	Input Register	315113	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
766	3	Transformer node state	Input Register	315114	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
767	3	Transformer gas buildup trip	Input Register	315114.0	Boolean	0	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
768	3	Transformer gas buildup alarm	Input Register	315114.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
769	3	Transformer oil temperature alarm	Input Register	315114.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
770	3	Transformer oil temperature trip	Input Register	315114.3	Boolean	3	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
771	3	Transformer low oil level trip	Input Register	315114.4	Boolean	4	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
772	3	Transformer low oil level alarm	Input Register	315114.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
773	3	Transformer pressure relief valve trip	Input Register	315114.6	Boolean	6	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
774	3	MV  load switch 1 status	Input Register	315114.8	Boolean	8	\N	\N	None	Closed	Open	\N	\N	\N	\N
775	3	MV  load switch 2 status	Input Register	315114.9	Boolean	9	\N	\N	None	Closed	Open	\N	\N	\N	\N
776	3	Disconnector status	Input Register	315114.11	Boolean	11	\N	\N	None	Closed	Open	\N	\N	\N	\N
777	3	Transformer high oil level alarm	Input Register	315114.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
778	3	Transformer winding temperature trip	Input Register	315114.14	Boolean	14	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
779	3	Transformer winding temperature alarm	Input Register	315114.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
780	3	Annual power yields	Input Register	315115	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
781	3	Overall work state	Input Register	315117	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
782	3	Running	Input Register	315117.0	Boolean	0	\N	\N	None	Running	Not Running	\N	\N	\N	\N
783	3	Stopped	Input Register	315117.1	Boolean	1	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
784	3	Remote emergency stop	Input Register	315117.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
785	3	Local emergency stop	Input Register	315117.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
786	3	SCU master fault	Input Register	315117.7	Boolean	7	\N	\N	On (1)	Faulted	Normal	\N	\N	\N	\N
787	3	Running	Input Register	315117.8	Boolean	8	\N	\N	None	Running	Not Running	\N	\N	\N	\N
788	3	Warn run	Input Register	315117.9	Boolean	9	\N	\N	None	Alarm Running	Not Running	\N	\N	\N	\N
789	3	Faulted	Input Register	315117.10	Boolean	10	\N	\N	None	Faulted	Not Faulted	\N	\N	\N	\N
790	3	Stopped	Input Register	315117.11	Boolean	11	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
791	3	AC insulation fault	Input Register	315117.12	Boolean	12	\N	\N	On (1)	Faulted	Normal	\N	\N	\N	\N
792	3	SCU slave fault	Input Register	315117.13	Boolean	13	\N	\N	On (1)	Faulted	Normal	\N	\N	\N	\N
793	3	24h insulation fault	Input Register	315117.15	Boolean	15	\N	\N	On (1)	Faulted	Normal	\N	\N	\N	\N
794	3	24h DC insulation fault	Input Register	315117.16	Boolean	16	\N	\N	On (1)	Faulted	Normal	\N	\N	\N	\N
795	3	24h AC insulation fault	Input Register	315117.17	Boolean	17	\N	\N	On (1)	Faulted	Normal	\N	\N	\N	\N
796	3	Transformer oil temperature	Input Register	315119	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
797	3	Winding temperature	Input Register	315120	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
798	3	MV Node State 1	Input Register	315126	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
799	3	External emergency stop mv node state	Input Register	315126.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
800	3	MV fuse blown alarm	Input Register	315126.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
801	3	HV compartment smoke alarm	Input Register	315126.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
802	3	HV Local remote switch status	Input Register	315126.14	Boolean	14	\N	\N	On (1)	Local	Remote	\N	\N	\N	\N
803	3	Overall alarm state	Input Register	315127	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
804	3	MV fan status	Input Register	315127.1	Boolean	1	\N	\N	\N	Abnormal	Normal	\N	\N	\N	\N
805	3	AC insulation detection communication status	Input Register	315127.4	Boolean	4	\N	\N	\N	Abnormal	Normal	\N	\N	\N	\N
806	3	24h insulation alarm	Input Register	315127.6	Boolean	6	\N	\N	\N	Abnormal	Normal	\N	\N	\N	\N
807	3	SCU master-slave communication status	Input Register	315127.7	Boolean	7	\N	\N	\N	Abnormal	Normal	\N	\N	\N	\N
808	3	Heartbeat status	Input Register	315127.8	Boolean	8	\N	\N	\N	Abnormal	Normal	\N	\N	\N	\N
809	3	PMD IO board communication status	Input Register	315127.9	Boolean	9	\N	\N	\N	Abnormal	Normal	\N	\N	\N	\N
810	3	Inverter IO board communication status	Input Register	315127.11	Boolean	11	\N	\N	\N	Abnormal	Normal	\N	\N	\N	\N
811	3	ISO board communication status	Input Register	315127.14	Boolean	14	\N	\N	\N	Abnormal	Normal	\N	\N	\N	\N
812	3	Digital input state	Input Register	315129	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
813	3	DI1 status	Input Register	315129.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
814	3	DI2 status	Input Register	315129.1	Boolean	1	\N	\N	None	Closed	Open	\N	\N	\N	\N
815	3	DI3 status	Input Register	315129.2	Boolean	2	\N	\N	None	Closed	Closed	\N	\N	\N	\N
816	3	DI4 status	Input Register	315129.3	Boolean	3	\N	\N	None	Closed	Closed	\N	\N	\N	\N
817	3	DI5 status	Input Register	315129.4	Boolean	4	\N	\N	None	Closed	Closed	\N	\N	\N	\N
818	3	DI6 status	Input Register	315129.5	Boolean	5	\N	\N	None	Closed	Open	\N	\N	\N	\N
819	3	DI7 status	Input Register	315129.6	Boolean	6	\N	\N	None	Closed	Open	\N	\N	\N	\N
820	3	DI8 status	Input Register	315129.7	Boolean	7	\N	\N	None	Closed	Open	\N	\N	\N	\N
821	3	DI9 status	Input Register	315129.8	Boolean	8	\N	\N	None	Closed	Open	\N	\N	\N	\N
822	3	DI10 status	Input Register	315129.9	Boolean	9	\N	\N	None	Closed	Open	\N	\N	\N	\N
823	3	DI11 status	Input Register	315129.10	Boolean	10	\N	\N	None	Closed	Open	\N	\N	\N	\N
824	3	DI12 status	Input Register	315129.11	Boolean	11	\N	\N	None	Closed	Open	\N	\N	\N	\N
825	3	DI13 status	Input Register	315129.12	Boolean	12	\N	\N	None	Closed	Open	\N	\N	\N	\N
826	3	DI14 status	Input Register	315129.13	Boolean	13	\N	\N	None	Closed	Open	\N	\N	\N	\N
827	3	DI15 status	Input Register	315129.14	Boolean	14	\N	\N	None	Closed	Open	\N	\N	\N	\N
828	3	DI16 status	Input Register	315129.15	Boolean	15	\N	\N	None	Closed	Open	\N	\N	\N	\N
829	3	DI17 status	Input Register	315129.16	Boolean	16	\N	\N	None	Closed	Open	\N	\N	\N	\N
830	3	DI18 status	Input Register	315129.17	Boolean	17	\N	\N	None	Closed	Open	\N	\N	\N	\N
831	3	DI19 status	Input Register	315129.18	Boolean	18	\N	\N	None	Closed	Open	\N	\N	\N	\N
832	3	DI20 status	Input Register	315129.19	Boolean	19	\N	\N	None	Closed	Open	\N	\N	\N	\N
833	3	DI21 status	Input Register	315129.20	Boolean	20	\N	\N	None	Closed	Open	\N	\N	\N	\N
834	3	DI22 status	Input Register	315129.21	Boolean	21	\N	\N	None	Closed	Open	\N	\N	\N	\N
835	3	DI23 status	Input Register	315129.22	Boolean	22	\N	\N	None	Closed	Open	\N	\N	\N	\N
836	3	DI24 status	Input Register	315129.23	Boolean	23	\N	\N	None	Closed	Open	\N	\N	\N	\N
837	3	MV Node state 2	Input Register	315131	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
838	3	MV load switch status	Input Register	315131.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
839	3	HV remote trip	Input Register	315131.1	Boolean	1	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
840	3	HV remote closing	Input Register	315131.6	Boolean	6	\N	\N	On (1)	Closed	Open	\N	\N	\N	\N
841	3	Transformer compartment door	Input Register	315131.7	Boolean	7	\N	\N	On (1)	Open	Closed	\N	\N	\N	\N
842	3	Transformer compartment smoke alarm	Input Register	315131.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
843	3	UPS fault	Input Register	315131.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
844	3	MV earthing switch status	Input Register	315131.11	Boolean	11	\N	\N	None	Closed	Open	\N	\N	\N	\N
845	3	MV earthing switch 1 status	Input Register	315131.12	Boolean	12	\N	\N	None	Closed	Open	\N	\N	\N	\N
846	3	MV earthing switch 2 status	Input Register	315131.13	Boolean	13	\N	\N	None	Closed	Open	\N	\N	\N	\N
847	3	MV earthing switch 3 status	Input Register	315131.14	Boolean	14	\N	\N	None	Closed	Open	\N	\N	\N	\N
848	3	High level trip	Input Register	315131.15	Boolean	15	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
849	3	Load switch T-A status	Input Register	315131.18	Boolean	18	\N	\N	None	Closed	Open	\N	\N	\N	\N
850	3	Load switch T-B status	Input Register	315131.19	Boolean	19	\N	\N	None	Closed	Open	\N	\N	\N	\N
851	3	Load switch T-AB status	Input Register	315131.20	Boolean	20	\N	\N	None	Closed	Open	\N	\N	\N	\N
852	3	Load switch A-B status	Input Register	315131.21	Boolean	21	\N	\N	None	Closed	Open	\N	\N	\N	\N
853	3	PMD_IODI input status	Input Register	315142	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
854	3	DI1	Input Register	315142.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
855	3	DI2	Input Register	315142.1	Boolean	1	\N	\N	None	Closed	Open	\N	\N	\N	\N
856	3	DI3	Input Register	315142.2	Boolean	2	\N	\N	None	Closed	Open	\N	\N	\N	\N
857	3	DI4	Input Register	315142.3	Boolean	3	\N	\N	None	Closed	Open	\N	\N	\N	\N
858	3	DI5	Input Register	315142.4	Boolean	4	\N	\N	None	Closed	Open	\N	\N	\N	\N
859	3	DI6	Input Register	315142.5	Boolean	5	\N	\N	None	Closed	Open	\N	\N	\N	\N
860	3	DI7	Input Register	315142.6	Boolean	6	\N	\N	None	Closed	Open	\N	\N	\N	\N
861	3	DI8	Input Register	315142.7	Boolean	7	\N	\N	None	Closed	Open	\N	\N	\N	\N
862	3	DI9	Input Register	315142.8	Boolean	8	\N	\N	None	Closed	Open	\N	\N	\N	\N
863	3	DI10	Input Register	315142.9	Boolean	9	\N	\N	None	Closed	Open	\N	\N	\N	\N
864	3	DI11	Input Register	315142.10	Boolean	10	\N	\N	None	Closed	Open	\N	\N	\N	\N
865	3	DI12	Input Register	315142.11	Boolean	11	\N	\N	None	Closed	Open	\N	\N	\N	\N
866	3	UPS conversion status	Input Register	315146	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
867	3	UPS conversion  	Input Register	315146.0	Boolean	0	\N	\N	None	Conversion	No Conversion	\N	\N	\N	\N
868	3	UPS alarm status	Input Register	315147	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
869	3	UPS fault alarm	Input Register	315147.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
870	3	UPS bypass alarm	Input Register	315147.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
871	3	UPS battery undervoltage alarm	Input Register	315147.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
872	3	UPS mains disconnection alarm	Input Register	315147.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
873	3	U1 Daily power yield	Input Register	315150	32-bit unsigned integer	\N	kWh	10	\N	\N	\N	\N	\N	\N	\N
874	3	U1 Monthly power yield	Input Register	315152	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
875	3	U1 Total power yield	Input Register	315154	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	\N
876	3	U1 Daily grid connected minutes	Input Register	315156	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
877	3	U1 Total running hours	Input Register	315157	32-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
878	3	U1 Internal Module Temperature	Input Register	315159	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
879	3	U1 DC Voltage	Input Register	315160	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
880	3	U1 DC Current	Input Register	315161	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
881	3	U1 DC Power	Input Register	315162	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
882	3	U1 Voltage A-B	Input Register	315164	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
883	3	U1 Voltage B-C	Input Register	315165	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
884	3	U1 Voltage C-A	Input Register	315166	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
885	3	U1 Phase A Current	Input Register	315167	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
886	3	U1 Phase B Current	Input Register	315168	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
887	3	U1 Phase C Current	Input Register	315169	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
888	3	U1 Active Power	Input Register	315170	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
889	3	U1 Reactive Power	Input Register	315172	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
890	3	U1 Power Factor	Input Register	315174	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
891	3	U1 Frequency	Input Register	315175	16-bit unsigned integer	\N	Hz	10	\N	\N	\N	\N	\N	\N	\N
892	3	U1 Efficiency	Input Register	315176	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	\N
893	3	U1 Clock Year	Input Register	315178	16-bit unsigned integer	\N	year	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
894	3	U1 Clock Month	Input Register	315179	16-bit unsigned integer	\N	month	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
895	3	U1 Clock Day	Input Register	315180	16-bit unsigned integer	\N	day	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
896	3	U1 Clock Hour	Input Register	315181	16-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
897	3	U1 Clock Minute	Input Register	315182	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
898	3	U1 Clock Second	Input Register	315183	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
899	3	U1 Fault State 1	Input Register	315186	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
900	3	U1 DC undervoltage alarm	Input Register	315186.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
901	3	U1 DC overvoltage alarm	Input Register	315186.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
902	3	U1 AC undervoltage alarm	Input Register	315186.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
903	3	U1 AC overvoltage alarm	Input Register	315186.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
904	3	U1 Anti islanding protection active	Input Register	315186.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
905	3	U1 PDP protection active	Input Register	315186.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
906	3	U1 Module overtemperature alarm	Input Register	315186.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
907	3	U1 Reactor overtemperature alarm	Input Register	315186.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
908	3	U1 AC leakage current protection alarm	Input Register	315186.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
909	3	U1 GFDI protection active	Input Register	315186.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
910	3	U1 Fan fault	Input Register	315186.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
911	3	U1 DC overcurrent	Input Register	315186.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
912	3	U1 AC overcurrent	Input Register	315186.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
913	3	U1 Frequency abnormal	Input Register	315186.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
914	3	U1 Temperature abnormal	Input Register	315186.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
915	3	U1 Hardware fault	Input Register	315186.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
916	3	U1 Grounding fault	Input Register	315186.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
917	3	U1 Bus overvoltage	Input Register	315186.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
918	3	U1 Bus undervoltage	Input Register	315186.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
919	3	U1 Inverter overvoltage	Input Register	315186.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
920	3	U1 Fault State 2	Input Register	315188	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
921	3	U1 Insulation impedance fault	Input Register	315188.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
922	3	U1 AC SPD fault	Input Register	315188.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
923	3	U1 Sampling fault	Input Register	315188.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
924	3	U1 DC polarity reversed alarm	Input Register	315188.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
925	3	U1 Control power supply fault	Input Register	315188.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
926	3	U1 Backup power supply fault	Input Register	315188.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
927	3	U1 AC current imballance	Input Register	315188.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
928	3	U1 AC fuse fault	Input Register	315188.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
929	3	U1 DC SPD fault	Input Register	315188.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
930	3	U1 Buffer contactor fault	Input Register	315188.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
931	3	U1 DC injection fault	Input Register	315188.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
932	3	U1 DC switch fault	Input Register	315188.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
933	3	U1 Device code repeat fault	Input Register	315188.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
934	3	U1 Parallel operation communication failure	Input Register	315188.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
935	3	U1 Control cabinet temperature alarm	Input Register	315188.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
936	3	U1 DC fuse grounding fault	Input Register	315188.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
937	3	U1 Reversed branch over current	Input Register	315188.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
938	3	U1 Grid voltage imballance	Input Register	315188.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
939	3	U1 inverter cabinet temperature alarm	Input Register	315188.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
940	3	U1 AC cabinet temperature alarm	Input Register	315188.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
941	3	U1 AC switch disconnection	Input Register	315188.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
942	3	U1 AC switch fault	Input Register	315188.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
943	3	U1 Soft start fault	Input Register	315188.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
944	3	U1 DC voltage sampling fault	Input Register	315188.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
945	3	U1 Fan 2 fault	Input Register	315188.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
946	3	U1 Current unbalance 2	Input Register	315188.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
947	3	U1 Current unbalance 3	Input Register	315188.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
948	3	U1 DC cabinet temperature alarm	Input Register	315188.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
949	3	U1 Neutral point potential shift alarm	Input Register	315188.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
950	3	U1 Carrier sync failure	Input Register	315188.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
951	3	U1 Fault State 3	Input Register	315190	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
952	3	U1 smoke sensing fault	Input Register	315190.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
953	3	U1 access control fault	Input Register	315190.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
954	3	U1 Emergency fault shutdown fault	Input Register	315190.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
955	3	U1 Node State 1	Input Register	315194	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
956	3	U1 AC circuit breaker status	Input Register	315194.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
957	3	U1 DC switch 1 status	Input Register	315194.3	Boolean	3	\N	\N	None	Closed	Open	\N	\N	\N	\N
958	3	U1 smoke node status	Input Register	315194.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
959	3	U1 access node status	Input Register	315194.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
960	3	U1 emergency shutdown status	Input Register	315194.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
961	3	U1 Temperature 1	Input Register	315198	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
962	3	U1 Temperature 3	Input Register	315200	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
963	3	U1 Temperature 5	Input Register	315202	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
964	3	U1 Positive Resistance to Ground	Input Register	315204	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
965	3	U1 Negative Resistance to Ground	Input Register	315206	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
966	3	U1 Work State	Input Register	315208	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
967	3	U1 Running	Input Register	315208.0	Boolean	0	\N	\N	None	Running	Not Running	\N	\N	\N	\N
968	3	U1 Stopped	Input Register	315208.1	Boolean	1	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
969	3	U1 Initial Standby	Input Register	315208.2	Boolean	2	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
970	3	U1 Press to shutdown	Input Register	315208.3	Boolean	3	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
971	3	U1 Standby	Input Register	315208.4	Boolean	4	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
972	3	U1 Emergency Stop	Input Register	315208.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
973	3	U1 Starting	Input Register	315208.6	Boolean	6	\N	\N	None	Starting	Not Starting	\N	\N	\N	\N
974	3	U1 Stopping	Input Register	315208.7	Boolean	7	\N	\N	None	Stopping	Not Stopping	\N	\N	\N	\N
975	3	U1 Fault Stop	Input Register	315208.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
976	3	U1 Alarm running	Input Register	315208.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
977	3	U1 Derating running	Input Register	315208.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
978	3	U1 IO-DSP communication failure	Input Register	315208.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
979	3	U1 Inverter is running	Input Register	315208.17	Boolean	17	\N	\N	None	Running	Not Running	\N	\N	\N	\N
980	3	U1 Inverter is stopped	Input Register	315208.18	Boolean	18	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
981	3	U1 Anti-PID active	Input Register	315208.19	Boolean	19	\N	\N	On (1)	Active	Not-Active	\N	\N	\N	\N
982	3	U1 Alarm State	Input Register	315210	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
983	3	U1 Temperature alarm	Input Register	315210.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
984	3	U1 Low insulation resistance alarm	Input Register	315210.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
985	3	U1 GFRT operation alarm	Input Register	315210.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
986	3	U1 CT unbalance	Input Register	315210.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
987	3	U1 DC sensor fault	Input Register	315210.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
988	3	U1 DC SPD fault	Input Register	315210.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
989	3	U1 AC SPD fault	Input Register	315210.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
990	3	U1 DC switch fault	Input Register	315210.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
991	3	U1 Anti-PID power supply	Input Register	315210.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
992	3	U1 Fan fault	Input Register	315210.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
993	3	U1 DC bypass forward overcurrent alarm	Input Register	315210.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
994	3	U1 DC bypass reverse overcurrent alarm	Input Register	315210.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
995	3	U1 AC circuit breaker fault	Input Register	315210.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
996	3	U1 Meter communication failure	Input Register	315210.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
997	3	U1 Fan 2 fault	Input Register	315210.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
998	3	U1 Temperature and humidity sensor fault	Input Register	315210.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
999	3	U1 Frequency deviation active power regulation	Input Register	315210.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1000	3	U1 Voltage deviation reactive power regulation	Input Register	315210.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1001	3	U1 Busbar temperature alarm	Input Register	315210.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1002	3	U1 Abnormal derating of fan	Input Register	315210.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1003	3	U1 Frequency abnormal	Input Register	315210.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1004	3	U1 Negative Voltage to Ground	Input Register	315212	16-bit signed integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1005	3	U1 Annual Power Yield	Input Register	315213	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1006	3	U1 CO2 Emission Reduction	Input Register	315215	32-bit unsigned integer	\N	kg	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1007	3	U1 leakage current	Input Register	315237	16-bit unsigned integer	\N	A	100	\N	\N	\N	\N	\N	\N	\N
1008	3	U1 DC Input #1	Input Register	315250	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1009	3	U1 DC Input #2	Input Register	315251	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1010	3	U1 DC Input #3	Input Register	315252	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1011	3	U1 DC Input #4	Input Register	315253	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1012	3	U1 DC Input #5	Input Register	315254	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1013	3	U1 DC Input #6	Input Register	315255	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1014	3	U1 DC Input #7	Input Register	315256	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1015	3	U1 running status	Input Register	315262	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1016	3	U1 HVRT operation	Input Register	315262.1	Boolean	1	\N	\N	None	On	Off	\N	\N	\N	\N
1017	3	U1 LVRT operation	Input Register	315262.2	Boolean	2	\N	\N	None	On	Off	\N	\N	\N	\N
1018	3	U2 Daily power yield	Input Register	315270	32-bit unsigned integer	\N	kWh	10	\N	\N	\N	\N	\N	\N	\N
1019	3	U2 Monthly power yield	Input Register	315272	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1020	3	U2 Total power yield	Input Register	315274	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	\N
1021	3	U2 Daily grid connected minutes	Input Register	315276	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
1022	3	U2 Total running hours	Input Register	315277	32-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
1023	3	U2 Internal Module Temperature	Input Register	315279	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1024	3	U2 DC Voltage	Input Register	315280	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1025	3	U2 DC Current	Input Register	315281	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1026	3	U2 DC Power	Input Register	315282	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
1027	3	U2 Voltage A-B	Input Register	315284	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1028	3	U2 Voltage B-C	Input Register	315285	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1029	3	U2 Voltage C-A	Input Register	315286	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1030	3	U2 Phase A Current	Input Register	315287	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1031	3	U2 Phase B Current	Input Register	315288	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1032	3	U2 Phase C Current	Input Register	315289	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1033	3	U2 Active Power	Input Register	315290	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
1034	3	U2 Reactive Power	Input Register	315292	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
1035	3	U2 Power Factor	Input Register	315294	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
1036	3	U2 Frequency	Input Register	315295	16-bit unsigned integer	\N	Hz	10	\N	\N	\N	\N	\N	\N	\N
1037	3	U2 Efficiency	Input Register	315296	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	\N
1038	3	U2 Clock Year	Input Register	315298	16-bit unsigned integer	\N	year	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1039	3	U2 Clock Month	Input Register	315299	16-bit unsigned integer	\N	month	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1040	3	U2 Clock Day	Input Register	315300	16-bit unsigned integer	\N	day	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1041	3	U2 Clock Hour	Input Register	315301	16-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1042	3	U2 Clock Minute	Input Register	315302	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1043	3	U2 Clock Second	Input Register	315303	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1044	3	U2 Fault State 1	Input Register	315306	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1045	3	U2 DC undervoltage alarm	Input Register	315306.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1046	3	U2 DC overvoltage alarm	Input Register	315306.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1047	3	U2 AC undervoltage alarm	Input Register	315306.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1048	3	U2 AC overvoltage alarm	Input Register	315306.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1049	3	U2 Anti islanding protection active	Input Register	315306.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1050	3	U2 PDP protection active	Input Register	315306.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1051	3	U2 Module overtemperature alarm	Input Register	315306.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1052	3	U2 Reactor overtemperature alarm	Input Register	315306.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1053	3	U2 AC leakage current protection alarm	Input Register	315306.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1054	3	U2 GFDI protection active	Input Register	315306.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1055	3	U2 Fan fault	Input Register	315306.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1056	3	U2 DC overcurrent	Input Register	315306.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1057	3	U2 AC overcurrent	Input Register	315306.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1058	3	U2 Frequency abnormal	Input Register	315306.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1059	3	U2 Temperature abnormal	Input Register	315306.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1060	3	U2 Hardware fault	Input Register	315306.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1061	3	U2 Grounding fault	Input Register	315306.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1062	3	U2 Bus overvoltage	Input Register	315306.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1063	3	U2 Bus undervoltage	Input Register	315306.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1064	3	U2 Inverter overvoltage	Input Register	315306.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1065	3	U2 Fault State 2	Input Register	315308	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1066	3	U2 Insulation impedance fault	Input Register	315308.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1067	3	U2 AC SPD fault	Input Register	315308.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1068	3	U2 Sampling fault	Input Register	315308.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1069	3	U2 DC polarity reversed alarm	Input Register	315308.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1070	3	U2 Control power supply fault	Input Register	315308.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1071	3	U2 Backup power supply fault	Input Register	315308.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1072	3	U2 AC current imballance	Input Register	315308.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1073	3	U2 AC fuse fault	Input Register	315308.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1074	3	U2 DC SPD fault	Input Register	315308.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1075	3	U2 Buffer contactor fault	Input Register	315308.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1076	3	U2 DC injection fault	Input Register	315308.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1077	3	U2 DC switch fault	Input Register	315308.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1078	3	U2 Device code repeat fault	Input Register	315308.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1079	3	U2 Parallel operation communication failure	Input Register	315308.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1080	3	U2 Control cabinet temperature alarm	Input Register	315308.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1081	3	U2 DC fuse grounding fault	Input Register	315308.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1082	3	U2 Reversed branch over current	Input Register	315308.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1083	3	U2 Grid voltage imballance	Input Register	315308.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1084	3	U2 inverter cabinet temperature alarm	Input Register	315308.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1085	3	U2 AC cabinet temperature alarm	Input Register	315308.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1086	3	U2 AC switch disconnection	Input Register	315308.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1087	3	U2 AC switch fault	Input Register	315308.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1088	3	U2 Soft start fault	Input Register	315308.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1089	3	U2 DC voltage sampling fault	Input Register	315308.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1090	3	U2 Fan 2 fault	Input Register	315308.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1091	3	U2 Current unbalance 2	Input Register	315308.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1092	3	U2 Current unbalance 3	Input Register	315308.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1093	3	U2 DC cabinet temperature alarm	Input Register	315308.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1094	3	U2 Neutral point potential shift alarm	Input Register	315308.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1095	3	U2 Carrier sync failure	Input Register	315308.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1096	3	U2 Fault State 3	Input Register	315310	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1097	3	U2 smoke sensing fault	Input Register	315310.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1098	3	U2 access control fault	Input Register	315310.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1099	3	U2 Emergency fault shutdown fault	Input Register	315310.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1100	3	U2 Node State 1	Input Register	315314	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1101	3	U2 AC circuit breaker status	Input Register	315314.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
1102	3	U2 DC switch 1 status	Input Register	315314.3	Boolean	3	\N	\N	None	Closed	Open	\N	\N	\N	\N
1103	3	U2 smoke node status	Input Register	315314.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1104	3	U2 access node status	Input Register	315314.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1105	3	U2 emergency shutdown status	Input Register	315314.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1106	3	U2 Temperature 1	Input Register	315318	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1107	3	U2 Temperature 3	Input Register	315320	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1108	3	U2 Temperature 5	Input Register	315322	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1109	3	U2 Positive Resistance to Ground	Input Register	315324	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
1110	3	U2 Negative Resistance to Ground	Input Register	315326	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
1111	3	U2 Work State	Input Register	315328	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1112	3	U2 Running	Input Register	315328.0	Boolean	0	\N	\N	None	Running	Not Running	\N	\N	\N	\N
1113	3	U2 Stopped	Input Register	315328.1	Boolean	1	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1114	3	U2 Initial Standby	Input Register	315328.2	Boolean	2	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
1115	3	U2 Press to shutdown	Input Register	315328.3	Boolean	3	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1116	3	U2 Standby	Input Register	315328.4	Boolean	4	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
1117	3	U2 Emergency Stop	Input Register	315328.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1118	3	U2 Starting	Input Register	315328.6	Boolean	6	\N	\N	None	Starting	Not Starting	\N	\N	\N	\N
1119	3	U2 Stopping	Input Register	315328.7	Boolean	7	\N	\N	None	Stopping	Not Stopping	\N	\N	\N	\N
1120	3	U2 Fault Stop	Input Register	315328.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1121	3	U2 Alarm running	Input Register	315328.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1122	3	U2 Derating running	Input Register	315328.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1123	3	U2 IO-DSP communication failure	Input Register	315328.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1124	3	U2 Inverter is running	Input Register	315328.17	Boolean	17	\N	\N	None	Running	Not Running	\N	\N	\N	\N
1125	3	U2 Inverter is stopped	Input Register	315328.18	Boolean	18	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1126	3	U2 Anti-PID active	Input Register	315328.19	Boolean	19	\N	\N	On (1)	Active	Not-Active	\N	\N	\N	\N
1127	3	U2 Alarm State	Input Register	315330	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1128	3	U2 Temperature alarm	Input Register	315330.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1129	3	U2 Low insulation resistance alarm	Input Register	315330.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1130	3	U2 GFRT operation alarm	Input Register	315330.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1131	3	U2 CT unbalance	Input Register	315330.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1132	3	U2 DC sensor fault	Input Register	315330.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1133	3	U2 DC SPD fault	Input Register	315330.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1134	3	U2 AC SPD fault	Input Register	315330.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1135	3	U2 DC switch fault	Input Register	315330.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1136	3	U2 Anti-PID power supply	Input Register	315330.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1137	3	U2 Fan fault	Input Register	315330.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1138	3	U2 DC bypass forward overcurrent alarm	Input Register	315330.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1139	3	U2 DC bypass reverse overcurrent alarm	Input Register	315330.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1140	3	U2 AC circuit breaker fault	Input Register	315330.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1141	3	U2 Meter communication failure	Input Register	315330.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1142	3	U2 Fan 2 fault	Input Register	315330.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1143	3	U2 Temperature and humidity sensor fault	Input Register	315330.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1144	3	U2 Frequency deviation active power regulation	Input Register	315330.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1145	3	U2 Voltage deviation reactive power regulation	Input Register	315330.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1146	3	U2 Busbar temperature alarm	Input Register	315330.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1147	3	U2 Abnormal derating of fan	Input Register	315330.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1148	3	U2 Frequency abnormal	Input Register	315330.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1149	3	U2 Negative Voltage to Ground	Input Register	315332	16-bit signed integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1150	3	U2 Annual Power Yield	Input Register	315333	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1151	3	U2 CO2 Emission Reduction	Input Register	315335	32-bit unsigned integer	\N	kg	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1152	3	U2 leakage current	Input Register	315357	16-bit unsigned integer	\N	A	100	\N	\N	\N	\N	\N	\N	\N
1153	3	U2 DC Input #1	Input Register	315370	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1154	3	U2 DC Input #2	Input Register	315371	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1155	3	U2 DC Input #3	Input Register	315372	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1156	3	U2 DC Input #4	Input Register	315373	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1157	3	U2 DC Input #5	Input Register	315374	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1158	3	U2 DC Input #6	Input Register	315375	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1159	3	U2 DC Input #7	Input Register	315376	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1160	3	U2 running status	Input Register	315382	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1161	3	U2 HVRT operation	Input Register	315382.1	Boolean	1	\N	\N	None	On	Off	\N	\N	\N	\N
1162	3	U2 LVRT operation	Input Register	315382.2	Boolean	2	\N	\N	None	On	Off	\N	\N	\N	\N
1163	3	U3 Daily power yield	Input Register	315390	32-bit unsigned integer	\N	kWh	10	\N	\N	\N	\N	\N	\N	\N
1164	3	U3 Monthly power yield	Input Register	315392	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1165	3	U3 Total power yield	Input Register	315394	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	\N
1166	3	U3 Daily grid connected minutes	Input Register	315396	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
1167	3	U3 Total running hours	Input Register	315397	32-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
1168	3	U3 Internal Module Temperature	Input Register	315399	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1169	3	U3 DC Voltage	Input Register	315400	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1170	3	U3 DC Current	Input Register	315401	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1171	3	U3 DC Power	Input Register	315402	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
1172	3	U3 Voltage A-B	Input Register	315404	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1173	3	U3 Voltage B-C	Input Register	315405	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1174	3	U3 Voltage C-A	Input Register	315406	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1175	3	U3 Phase A Current	Input Register	315407	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1176	3	U3 Phase B Current	Input Register	315408	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1177	3	U3 Phase C Current	Input Register	315409	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1178	3	U3 Active Power	Input Register	315410	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
1179	3	U3 Reactive Power	Input Register	315412	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
1180	3	U3 Power Factor	Input Register	315414	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
1181	3	U3 Frequency	Input Register	315415	16-bit unsigned integer	\N	Hz	10	\N	\N	\N	\N	\N	\N	\N
1182	3	U3 Efficiency	Input Register	315416	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	\N
1183	3	U3 Clock Year	Input Register	315418	16-bit unsigned integer	\N	year	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1184	3	U3 Clock Month	Input Register	315419	16-bit unsigned integer	\N	month	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1185	3	U3 Clock Day	Input Register	315420	16-bit unsigned integer	\N	day	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1186	3	U3 Clock Hour	Input Register	315421	16-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1187	3	U3 Clock Minute	Input Register	315422	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1188	3	U3 Clock Second	Input Register	315423	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1189	3	U3 Fault State 1	Input Register	315426	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1190	3	U3 DC undervoltage alarm	Input Register	315426.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1191	3	U3 DC overvoltage alarm	Input Register	315426.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1192	3	U3 AC undervoltage alarm	Input Register	315426.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1193	3	U3 AC overvoltage alarm	Input Register	315426.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1194	3	U3 Anti islanding protection active	Input Register	315426.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1195	3	U3 PDP protection active	Input Register	315426.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1196	3	U3 Module overtemperature alarm	Input Register	315426.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1197	3	U3 Reactor overtemperature alarm	Input Register	315426.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1198	3	U3 AC leakage current protection alarm	Input Register	315426.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1199	3	U3 GFDI protection active	Input Register	315426.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1200	3	U3 Fan fault	Input Register	315426.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1201	3	U3 DC overcurrent	Input Register	315426.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1202	3	U3 AC overcurrent	Input Register	315426.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1203	3	U3 Frequency abnormal	Input Register	315426.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1204	3	U3 Temperature abnormal	Input Register	315426.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1205	3	U3 Hardware fault	Input Register	315426.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1206	3	U3 Grounding fault	Input Register	315426.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1207	3	U3 Bus overvoltage	Input Register	315426.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1208	3	U3 Bus undervoltage	Input Register	315426.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1209	3	U3 Inverter overvoltage	Input Register	315426.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1211	3	U3 Insulation impedance fault	Input Register	315428.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1212	3	U3 AC SPD fault	Input Register	315428.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1213	3	U3 Sampling fault	Input Register	315428.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1214	3	U3 DC polarity reversed alarm	Input Register	315428.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1215	3	U3 Control power supply fault	Input Register	315428.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1216	3	U3 Backup power supply fault	Input Register	315428.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1217	3	U3 AC current imballance	Input Register	315428.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1218	3	U3 AC fuse fault	Input Register	315428.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1219	3	U3 DC SPD fault	Input Register	315428.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1220	3	U3 Buffer contactor fault	Input Register	315428.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1221	3	U3 DC injection fault	Input Register	315428.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1222	3	U3 DC switch fault	Input Register	315428.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1223	3	U3 Device code repeat fault	Input Register	315428.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1224	3	U3 Parallel operation communication failure	Input Register	315428.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1225	3	U3 Control cabinet temperature alarm	Input Register	315428.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1226	3	U3 DC fuse grounding fault	Input Register	315428.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1227	3	U3 Reversed branch over current	Input Register	315428.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1228	3	U3 Grid voltage imballance	Input Register	315428.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1229	3	U3 inverter cabinet temperature alarm	Input Register	315428.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1230	3	U3 AC cabinet temperature alarm	Input Register	315428.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1231	3	U3 AC switch disconnection	Input Register	315428.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1232	3	U3 AC switch fault	Input Register	315428.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1233	3	U3 Soft start fault	Input Register	315428.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1234	3	U3 DC voltage sampling fault	Input Register	315428.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1235	3	U3 Fan 2 fault	Input Register	315428.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1236	3	U3 Current unbalance 2	Input Register	315428.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1237	3	U3 Current unbalance 3	Input Register	315428.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1238	3	U3 DC cabinet temperature alarm	Input Register	315428.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1239	3	U3 Neutral point potential shift alarm	Input Register	315428.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1240	3	U3 Carrier sync failure	Input Register	315428.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1241	3	U3 Fault State 3	Input Register	315430	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1242	3	U3 smoke sensing fault	Input Register	315430.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1243	3	U3 access control fault	Input Register	315430.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1244	3	U3 Emergency fault shutdown fault	Input Register	315430.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1245	3	U3 Node State 1	Input Register	315434	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1246	3	U3 AC circuit breaker status	Input Register	315434.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
1247	3	U3 DC switch 1 status	Input Register	315434.3	Boolean	3	\N	\N	None	Closed	Open	\N	\N	\N	\N
1248	3	U3 smoke node status	Input Register	315434.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1249	3	U3 access node status	Input Register	315434.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1250	3	U3 emergency shutdown status	Input Register	315434.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1251	3	U3 Temperature 1	Input Register	315438	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1252	3	U3 Temperature 3	Input Register	315440	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1253	3	U3 Temperature 5	Input Register	315442	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1254	3	U3 Positive Resistance to Ground	Input Register	315444	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
1255	3	U3 Negative Resistance to Ground	Input Register	315446	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
1256	3	U3 Work State	Input Register	315448	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1257	3	U3 Running	Input Register	315448.0	Boolean	0	\N	\N	None	Running	Not Running	\N	\N	\N	\N
1258	3	U3 Stopped	Input Register	315448.1	Boolean	1	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1259	3	U3 Initial Standby	Input Register	315448.2	Boolean	2	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
1260	3	U3 Press to shutdown	Input Register	315448.3	Boolean	3	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1261	3	U3 Standby	Input Register	315448.4	Boolean	4	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
1262	3	U3 Emergency Stop	Input Register	315448.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1263	3	U3 Starting	Input Register	315448.6	Boolean	6	\N	\N	None	Starting	Not Starting	\N	\N	\N	\N
1264	3	U3 Stopping	Input Register	315448.7	Boolean	7	\N	\N	None	Stopping	Not Stopping	\N	\N	\N	\N
1265	3	U3 Fault Stop	Input Register	315448.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1266	3	U3 Alarm running	Input Register	315448.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1267	3	U3 Derating running	Input Register	315448.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1268	3	U3 IO-DSP communication failure	Input Register	315448.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1269	3	U3 Inverter is running	Input Register	315448.17	Boolean	17	\N	\N	None	Running	Not Running	\N	\N	\N	\N
1270	3	U3 Inverter is stopped	Input Register	315448.18	Boolean	18	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1271	3	U3 Anti-PID active	Input Register	315448.19	Boolean	19	\N	\N	On (1)	Active	Not-Active	\N	\N	\N	\N
1272	3	U3 Alarm State	Input Register	315450	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1273	3	U3 Temperature alarm	Input Register	315450.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1274	3	U3 Low insulation resistance alarm	Input Register	315450.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1275	3	U3 GFRT operation alarm	Input Register	315450.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1276	3	U3 CT unbalance	Input Register	315450.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1277	3	U3 DC sensor fault	Input Register	315450.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1278	3	U3 DC SPD fault	Input Register	315450.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1279	3	U3 AC SPD fault	Input Register	315450.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1280	3	U3 DC switch fault	Input Register	315450.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1281	3	U3 Anti-PID power supply	Input Register	315450.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1282	3	U3 Fan fault	Input Register	315450.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1283	3	U3 DC bypass forward overcurrent alarm	Input Register	315450.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1284	3	U3 DC bypass reverse overcurrent alarm	Input Register	315450.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1285	3	U3 AC circuit breaker fault	Input Register	315450.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1286	3	U3 Meter communication failure	Input Register	315450.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1287	3	U3 Fan 2 fault	Input Register	315450.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1288	3	U3 Temperature and humidity sensor fault	Input Register	315450.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1289	3	U3 Frequency deviation active power regulation	Input Register	315450.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1290	3	U3 Voltage deviation reactive power regulation	Input Register	315450.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1291	3	U3 Busbar temperature alarm	Input Register	315450.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1292	3	U3 Abnormal derating of fan	Input Register	315450.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1293	3	U3 Frequency abnormal	Input Register	315450.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1294	3	U3 Negative Voltage to Ground	Input Register	315452	16-bit signed integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1295	3	U3 Annual Power Yield	Input Register	315453	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1296	3	U3 CO2 Emission Reduction	Input Register	315455	32-bit unsigned integer	\N	kg	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1297	3	U3 leakage current	Input Register	315485	16-bit unsigned integer	\N	A	100	\N	\N	\N	\N	\N	\N	\N
1298	3	U3 DC Input #1	Input Register	315490	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1299	3	U3 DC Input #2	Input Register	315491	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1300	3	U3 DC Input #3	Input Register	315492	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1301	3	U3 DC Input #4	Input Register	315493	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1302	3	U3 DC Input #5	Input Register	315494	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1303	3	U3 DC Input #6	Input Register	315495	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1304	3	U3 DC Input #7	Input Register	315496	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1305	3	U3 running status	Input Register	315502	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1306	3	U3 HVRT operation	Input Register	315502.1	Boolean	1	\N	\N	None	On	Off	\N	\N	\N	\N
1307	3	U3 LVRT operation	Input Register	315502.2	Boolean	2	\N	\N	None	On	Off	\N	\N	\N	\N
1308	3	U4 Daily power yield	Input Register	315510	32-bit unsigned integer	\N	kWh	10	\N	\N	\N	\N	\N	\N	\N
1309	3	U4 Monthly power yield	Input Register	315512	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1310	3	U4 Total power yield	Input Register	315514	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	\N
1311	3	U4 Daily grid connected minutes	Input Register	315516	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
1312	3	U4 Total running hours	Input Register	315517	32-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
1313	3	U4 Internal Module Temperature	Input Register	315519	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1314	3	U4 DC Voltage	Input Register	315520	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1315	3	U4 DC Current	Input Register	315521	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1316	3	U4 DC Power	Input Register	315522	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
1317	3	U4 Voltage A-B	Input Register	315524	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1318	3	U4 Voltage B-C	Input Register	315525	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1319	3	U4 Voltage C-A	Input Register	315526	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1320	3	U4 Phase A Current	Input Register	315527	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1321	3	U4 Phase B Current	Input Register	315528	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1322	3	U4 Phase C Current	Input Register	315529	16-bit unsigned integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1323	3	U4 Active Power	Input Register	315530	32-bit signed integer	\N	W	1	\N	\N	\N	\N	\N	\N	\N
1324	3	U4 Reactive Power	Input Register	315532	32-bit signed integer	\N	var	1	\N	\N	\N	\N	\N	\N	\N
1325	3	U4 Power Factor	Input Register	315534	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
1326	3	U4 Frequency	Input Register	315535	16-bit unsigned integer	\N	Hz	10	\N	\N	\N	\N	\N	\N	\N
1327	3	U4 Efficiency	Input Register	315536	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	\N
1328	3	U4 Clock Year	Input Register	315538	16-bit unsigned integer	\N	year	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1329	3	U4 Clock Month	Input Register	315539	16-bit unsigned integer	\N	month	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1330	3	U4 Clock Day	Input Register	315540	16-bit unsigned integer	\N	day	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1331	3	U4 Clock Hour	Input Register	315541	16-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1332	3	U4 Clock Minute	Input Register	315542	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1333	3	U4 Clock Second	Input Register	315543	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1334	3	U4 Fault State 1	Input Register	315546	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1335	3	U4 DC undervoltage alarm	Input Register	315546.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1336	3	U4 DC overvoltage alarm	Input Register	315546.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1337	3	U4 AC undervoltage alarm	Input Register	315546.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1338	3	U4 AC overvoltage alarm	Input Register	315546.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1339	3	U4 Anti islanding protection active	Input Register	315546.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1340	3	U4 PDP protection active	Input Register	315546.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1341	3	U4 Module overtemperature alarm	Input Register	315546.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1342	3	U4 Reactor overtemperature alarm	Input Register	315546.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1343	3	U4 AC leakage current protection alarm	Input Register	315546.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1344	3	U4 GFDI protection active	Input Register	315546.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1345	3	U4 Fan fault	Input Register	315546.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1346	3	U4 DC overcurrent	Input Register	315546.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1347	3	U4 AC overcurrent	Input Register	315546.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1348	3	U4 Frequency abnormal	Input Register	315546.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1349	3	U4 Temperature abnormal	Input Register	315546.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1350	3	U4 Hardware fault	Input Register	315546.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1351	3	U4 Grounding fault	Input Register	315546.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1352	3	U4 Bus overvoltage	Input Register	315546.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1353	3	U4 Bus undervoltage	Input Register	315546.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1354	3	U4 Inverter overvoltage	Input Register	315546.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1355	3	U4 Fault State 2	Input Register	315548	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1356	3	U4 Insulation impedance fault	Input Register	315548.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1357	3	U4 AC SPD fault	Input Register	315548.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1358	3	U4 Sampling fault	Input Register	315548.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1359	3	U4 DC polarity reversed alarm	Input Register	315548.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1360	3	U4 Control power supply fault	Input Register	315548.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1361	3	U4 Backup power supply fault	Input Register	315548.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1362	3	U4 AC current imballance	Input Register	315548.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1363	3	U4 AC fuse fault	Input Register	315548.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1364	3	U4 DC SPD fault	Input Register	315548.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1365	3	U4 Buffer contactor fault	Input Register	315548.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1366	3	U4 DC injection fault	Input Register	315548.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1367	3	U4 DC switch fault	Input Register	315548.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1368	3	U4 Device code repeat fault	Input Register	315548.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1369	3	U4 Parallel operation communication failure	Input Register	315548.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1370	3	U4 Control cabinet temperature alarm	Input Register	315548.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1371	3	U4 DC fuse grounding fault	Input Register	315548.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1372	3	U4 Reversed branch over current	Input Register	315548.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1373	3	U4 Grid voltage imballance	Input Register	315548.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1374	3	U4 inverter cabinet temperature alarm	Input Register	315548.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1375	3	U4 AC cabinet temperature alarm	Input Register	315548.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1376	3	U4 AC switch disconnection	Input Register	315548.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1377	3	U4 AC switch fault	Input Register	315548.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1378	3	U4 Soft start fault	Input Register	315548.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1379	3	U4 DC voltage sampling fault	Input Register	315548.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1380	3	U4 Fan 2 fault	Input Register	315548.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1381	3	U4 Current unbalance 2	Input Register	315548.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1382	3	U4 Current unbalance 3	Input Register	315548.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1383	3	U4 DC cabinet temperature alarm	Input Register	315548.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1384	3	U4 Neutral point potential shift alarm	Input Register	315548.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1385	3	U4 Carrier sync failure	Input Register	315548.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1386	3	U4 Fault State 3	Input Register	315550	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1387	3	U4 smoke sensing fault	Input Register	315550.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1388	3	U4 access control fault	Input Register	315550.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1389	3	U4 Emergency fault shutdown fault	Input Register	315550.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1390	3	U4 Node State 1	Input Register	315554	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1391	3	U4 AC circuit breaker status	Input Register	315554.0	Boolean	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
1392	3	U4 DC switch 1 status	Input Register	315554.3	Boolean	3	\N	\N	None	Closed	Open	\N	\N	\N	\N
1393	3	U4 smoke node status	Input Register	315554.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1394	3	U4 access node status	Input Register	315554.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1395	3	U4 emergency shutdown status	Input Register	315554.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1396	3	U4 Temperature 1	Input Register	315558	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1397	3	U4 Temperature 3	Input Register	315560	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1398	3	U4 Temperature 5	Input Register	315562	16-bit signed integer	\N	degC	10	\N	\N	\N	\N	\N	\N	\N
1399	3	U4 Positive Resistance to Ground	Input Register	315564	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
1400	3	U4 Negative Resistance to Ground	Input Register	315566	32-bit unsigned integer	\N	kOhm	100	\N	\N	\N	\N	\N	\N	\N
1401	3	U4 Work State	Input Register	315568	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1402	3	U4 Running	Input Register	315568.0	Boolean	0	\N	\N	None	Running	Not Running	\N	\N	\N	\N
1403	3	U4 Stopped	Input Register	315568.1	Boolean	1	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1404	3	U4 Initial Standby	Input Register	315568.2	Boolean	2	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
1405	3	U4 Press to shutdown	Input Register	315568.3	Boolean	3	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1406	3	U4 Standby	Input Register	315568.4	Boolean	4	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
1407	3	U4 Emergency Stop	Input Register	315568.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1408	3	U4 Starting	Input Register	315568.6	Boolean	6	\N	\N	None	Starting	Not Starting	\N	\N	\N	\N
1409	3	U4 Stopping	Input Register	315568.7	Boolean	7	\N	\N	None	Stopping	Not Stopping	\N	\N	\N	\N
1410	3	U4 Fault Stop	Input Register	315568.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1411	3	U4 Alarm running	Input Register	315568.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1412	3	U4 Derating running	Input Register	315568.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1413	3	U4 IO-DSP communication failure	Input Register	315568.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1414	3	U4 Inverter is running	Input Register	315568.17	Boolean	17	\N	\N	None	Running	Not Running	\N	\N	\N	\N
1415	3	U4 Inverter is stopped	Input Register	315568.18	Boolean	18	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
1416	3	U4 Anti-PID active	Input Register	315568.19	Boolean	19	\N	\N	On (1)	Active	Not-Active	\N	\N	\N	\N
1417	3	U4 Alarm State	Input Register	315570	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1418	3	U4 Temperature alarm	Input Register	315570.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1419	3	U4 Low insulation resistance alarm	Input Register	315570.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1420	3	U4 GFRT operation alarm	Input Register	315570.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1421	3	U4 CT unbalance	Input Register	315570.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1422	3	U4 DC sensor fault	Input Register	315570.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1423	3	U4 DC SPD fault	Input Register	315570.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1424	3	U4 AC SPD fault	Input Register	315570.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1425	3	U4 DC switch fault	Input Register	315570.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1426	3	U4 Anti-PID power supply	Input Register	315570.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1427	3	U4 Fan fault	Input Register	315570.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1428	3	U4 DC bypass forward overcurrent alarm	Input Register	315570.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1429	3	U4 DC bypass reverse overcurrent alarm	Input Register	315570.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1430	3	U4 AC circuit breaker fault	Input Register	315570.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1431	3	U4 Meter communication failure	Input Register	315570.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1432	3	U4 Fan 2 fault	Input Register	315570.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1433	3	U4 Temperature and humidity sensor fault	Input Register	315570.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1434	3	U4 Frequency deviation active power regulation	Input Register	315570.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1435	3	U4 Voltage deviation reactive power regulation	Input Register	315570.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1436	3	U4 Busbar temperature alarm	Input Register	315570.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1437	3	U4 Abnormal derating of fan	Input Register	315570.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1438	3	U4 Frequency abnormal	Input Register	315570.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1439	3	U4 Negative Voltage to Ground	Input Register	315572	16-bit signed integer	\N	V	10	\N	\N	\N	\N	\N	\N	\N
1440	3	U4 Annual Power Yield	Input Register	315573	32-bit unsigned integer	\N	kWh	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1441	3	U4 CO2 Emission Reduction	Input Register	315575	32-bit unsigned integer	\N	kg	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1442	3	U4 leakage current	Input Register	315605	16-bit unsigned integer	\N	A	100	\N	\N	\N	\N	\N	\N	\N
1443	3	U4 DC Input #1	Input Register	315610	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1444	3	U4 DC Input #2	Input Register	315611	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1445	3	U4 DC Input #3	Input Register	315612	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1446	3	U4 DC Input #4	Input Register	315613	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1447	3	U4 DC Input #5	Input Register	315614	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1448	3	U4 DC Input #6	Input Register	315615	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1449	3	U4 DC Input #7	Input Register	315616	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1450	3	U4 running status	Input Register	315622	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1451	3	U4 HVRT operation	Input Register	315622.1	Boolean	1	\N	\N	None	On	Off	\N	\N	\N	\N
1452	3	U4 LVRT operation	Input Register	315622.2	Boolean	2	\N	\N	None	On	Off	\N	\N	\N	\N
1453	3	ISO board fault status	Input Register	315630	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1454	3	ISO insulation detection abnormal	Input Register	315630.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1455	3	ISO hardware fault	Input Register	315630.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1456	3	ISO overtemperature fault	Input Register	315630.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1457	3	ISO overvoltage fault	Input Register	315630.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1458	3	ISO board alarm status	Input Register	315631	16-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1459	3	ISO insulation detection abnormal	Input Register	315631.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1460	3	ISO overtemperature alarm	Input Register	315631.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1461	3	ISO grid sampling abonormal	Input Register	315631.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1462	3	24h insulation resistance	Input Register	315632	16-bit unsigned integer	\N	k╬ô├ñ┬¬	1	\N	\N	\N	\N	\N	\N	\N
1463	3	Certified Software Version	Input Register	315634	String	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1464	3	Overexcitation Specified Active Power	Input Register	315699	32-bit signed integer	\N	kW	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1465	3	Underexcitation Specified Active Power	Input Register	315701	32-bit signed integer	\N	kW	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1466	3	Commercial Plant Running Status	Input Register	315703	16-bit unsigned integer	\N	boolean	\N	Off (0)	Running	Offline	\N	\N	\N	This point is not mapped to ignition
1467	3	Maximum Appearant Power	Input Register	315704	16-bit unsigned integer	\N	kVA	10	\N	\N	\N	\N	\N	\N	\N
1777	4	Batt current	Holding Register	40033	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
1468	3	Maximum Discharging Power	Input Register	315705	16-bit unsigned integer	\N	kW	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1469	3	Maximum inductive reactive power	Input Register	315706	16-bit signed integer	\N	kvar	10	\N	\N	\N	\N	\N	\N	\N
1470	3	Maximum capacitive reactive power	Input Register	315707	16-bit signed integer	\N	kvar	10	\N	\N	\N	\N	\N	\N	\N
1471	3	Grid connected status of commercial plant	Input Register	315708	16-bit unsigned integer	\N	boolean	\N	Off (0)	Connected	Disconnected	\N	\N	\N	This point is not mapped to ignition
1472	3	Nominal AC voltage	Input Register	315709	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1473	3	Max AC Voltage	Input Register	315710	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1474	3	Min AC Voltage	Input Register	315711	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1475	3	QU Reference Voltage Current Value	Input Register	315733	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1476	3	U1 Valid Recorder Quantity	Input Register	315734	16-bit unsigned integer	\N	count	\N	\N	\N	\N	\N	\N	\N	\N
1477	3	U2 Valid Recorder Quantity	Input Register	315735	16-bit unsigned integer	\N	count	\N	\N	\N	\N	\N	\N	\N	\N
1478	3	U3 Valid Recorder Quantity	Input Register	315736	16-bit unsigned integer	\N	count	\N	\N	\N	\N	\N	\N	\N	\N
1479	3	U4 Valid Recorder Quantity	Input Register	315737	16-bit unsigned integer	\N	count	\N	\N	\N	\N	\N	\N	\N	\N
1480	3	High side AB voltage	Input Register	315745	16-bit unsigned integer	\N	kV	100	\N	\N	\N	\N	\N	\N	\N
1481	3	High side BC voltage	Input Register	315746	16-bit unsigned integer	\N	kV	100	\N	\N	\N	\N	\N	\N	\N
1482	3	High side CA voltage	Input Register	315747	16-bit unsigned integer	\N	kV	100	\N	\N	\N	\N	\N	\N	\N
1483	3	High side active power	Input Register	315748	32-bit signed integer	\N	kW	100	\N	\N	\N	\N	\N	\N	\N
1484	3	High side phase A current	Input Register	315750	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1485	3	High side phase B current	Input Register	315751	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1486	3	High side phase C current	Input Register	315752	16-bit signed integer	\N	A	10	\N	\N	\N	\N	\N	\N	\N
1487	3	High side reactive power	Input Register	315754	32-bit signed integer	\N	kvar	100	\N	\N	\N	\N	\N	\N	\N
1488	3	Zone Monitor Work State	Input Register	316000	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Zone Monitor Work State:\n0: Disable\n1: Self-Study\n2: Fault Detection\n	\N
1489	3	Branch Open Circuit Alarm	Input Register	316001	32-bit bitfield	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1490	3	U1 open circuit fault branch 1	Input Register	316001.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1491	3	U1 open circuit fault branch 2	Input Register	316001.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1492	3	U1 open circuit fault branch 3	Input Register	316001.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1493	3	U1 open circuit fault branch 4	Input Register	316001.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1494	3	U1 open circuit fault branch 5	Input Register	316001.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1495	3	U1 open circuit fault branch 6	Input Register	316001.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1496	3	U1 open circuit fault branch 7	Input Register	316001.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1497	3	U1 open circuit fault branch 8	Input Register	316001.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1498	3	U2 open circuit fault branch 1	Input Register	316001.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1499	3	U2 open circuit fault branch 2	Input Register	316001.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1500	3	U2 open circuit fault branch 3	Input Register	316001.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1501	3	U2 open circuit fault branch 4	Input Register	316001.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1502	3	U2 open circuit fault branch 5	Input Register	316001.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1503	3	U2 open circuit fault branch 6	Input Register	316001.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1504	3	U2 open circuit fault branch 7	Input Register	316001.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1505	3	U2 open circuit fault branch 8	Input Register	316001.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1506	3	U3 open circuit fault branch 1	Input Register	316001.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1507	3	U3 open circuit fault branch 2	Input Register	316001.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1508	3	U3 open circuit fault branch 3	Input Register	316001.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1509	3	U3 open circuit fault branch 4	Input Register	316001.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1510	3	U3 open circuit fault branch 5	Input Register	316001.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1511	3	U3 open circuit fault branch 6	Input Register	316001.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1512	3	U3 open circuit fault branch 7	Input Register	316001.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1513	3	U3 open circuit fault branch 8	Input Register	316001.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1514	3	U4 open circuit fault branch 1	Input Register	316001.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1515	3	U4 open circuit fault branch 2	Input Register	316001.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1516	3	U4 open circuit fault branch 3	Input Register	316001.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1517	3	U4 open circuit fault branch 4	Input Register	316001.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1518	3	U4 open circuit fault branch 5	Input Register	316001.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1519	3	U4 open circuit fault branch 6	Input Register	316001.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1520	3	U4 open circuit fault branch 7	Input Register	316001.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1521	3	U4 open circuit fault branch 8	Input Register	316001.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1522	3	Branch String Alarm	Input Register	316003	32-bit bitfield	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1523	3	U1 string failure branch 1	Input Register	316003.0	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1524	3	U1 string failure branch 2	Input Register	316003.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1525	3	U1 string failure branch 3	Input Register	316003.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1526	3	U1 string failure branch 4	Input Register	316003.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1527	3	U1 string failure branch 5	Input Register	316003.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1778	4	Load current	Holding Register	40035	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
1528	3	U1 string failure branch 6	Input Register	316003.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1529	3	U1 string failure branch 7	Input Register	316003.6	Boolean	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1530	3	U1 string failure branch 8	Input Register	316003.7	Boolean	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1531	3	U2 string failure branch 1	Input Register	316003.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1532	3	U2 string failure branch 2	Input Register	316003.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1533	3	U2 string failure branch 3	Input Register	316003.10	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1534	3	U2 string failure branch 4	Input Register	316003.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1535	3	U2 string failure branch 5	Input Register	316003.12	Boolean	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1536	3	U2 string failure branch 6	Input Register	316003.13	Boolean	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1537	3	U2 string failure branch 7	Input Register	316003.14	Boolean	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1538	3	U2 string failure branch 8	Input Register	316003.15	Boolean	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1539	3	U3 string failure branch 1	Input Register	316003.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1540	3	U3 string failure branch 2	Input Register	316003.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1541	3	U3 string failure branch 3	Input Register	316003.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1542	3	U3 string failure branch 4	Input Register	316003.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1543	3	U3 string failure branch 5	Input Register	316003.20	Boolean	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1544	3	U3 string failure branch 6	Input Register	316003.21	Boolean	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1545	3	U3 string failure branch 7	Input Register	316003.22	Boolean	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1546	3	U3 string failure branch 8	Input Register	316003.23	Boolean	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1547	3	U4 string failure branch 1	Input Register	316003.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1548	3	U4 string failure branch 2	Input Register	316003.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1549	3	U4 string failure branch 3	Input Register	316003.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1550	3	U4 string failure branch 4	Input Register	316003.27	Boolean	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1551	3	U4 string failure branch 5	Input Register	316003.28	Boolean	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1552	3	U4 string failure branch 6	Input Register	316003.29	Boolean	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1553	3	U4 string failure branch 7	Input Register	316003.30	Boolean	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1554	3	U4 string failure branch 8	Input Register	316003.31	Boolean	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1555	3	U1 Warning Number of Strings Branch 1	Input Register	316005	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1556	3	U1 Warning Number of Strings Branch 2	Input Register	316006	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1557	3	U1 Warning Number of Strings Branch 3	Input Register	316007	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1558	3	U1 Warning Number of Strings Branch 4	Input Register	316008	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1559	3	U1 Warning Number of Strings Branch 5	Input Register	316009	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1560	3	U1 Warning Number of Strings Branch 6	Input Register	316010	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1561	3	U1 Warning Number of Strings Branch 7	Input Register	316011	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1562	3	U2 Warning Number of Strings Branch 1	Input Register	316021	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1563	3	U2 Warning Number of Strings Branch 2	Input Register	316022	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1564	3	U2 Warning Number of Strings Branch 3	Input Register	316023	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1565	3	U2 Warning Number of Strings Branch 4	Input Register	316024	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1566	3	U2 Warning Number of Strings Branch 5	Input Register	316025	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1567	3	U2 Warning Number of Strings Branch 6	Input Register	316026	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1568	3	U2 Warning Number of Strings Branch 7	Input Register	316027	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1569	3	U3 Warning Number of Strings Branch 1	Input Register	316037	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1570	3	U3 Warning Number of Strings Branch 2	Input Register	316038	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1571	3	U3 Warning Number of Strings Branch 3	Input Register	316039	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1572	3	U3 Warning Number of Strings Branch 4	Input Register	316040	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1573	3	U3 Warning Number of Strings Branch 5	Input Register	316041	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1574	3	U3 Warning Number of Strings Branch 6	Input Register	316042	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1575	3	U3 Warning Number of Strings Branch 7	Input Register	316043	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1576	3	U4 Warning Number of Strings Branch 1	Input Register	316053	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1577	3	U4 Warning Number of Strings Branch 2	Input Register	316054	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1578	3	U4 Warning Number of Strings Branch 3	Input Register	316055	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1579	3	U4 Warning Number of Strings Branch 4	Input Register	316056	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1580	3	U4 Warning Number of Strings Branch 5	Input Register	316057	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1581	3	U4 Warning Number of Strings Branch 6	Input Register	316058	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1582	3	U4 Warning Number of Strings Branch 7	Input Register	316059	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1583	3	Set system clock year	Holding Register	415000	16-bit unsigned integer	\N	year	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1584	3	Set system clock month	Holding Register	415001	16-bit unsigned integer	\N	month	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1585	3	Set system clock day	Holding Register	415002	16-bit unsigned integer	\N	day	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1586	3	Set system clock hour	Holding Register	415003	16-bit unsigned integer	\N	hr	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1587	3	Set system clock minute	Holding Register	415004	16-bit unsigned integer	\N	min	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1588	3	Set system clock second	Holding Register	415005	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1589	3	Start stop command	Holding Register	415006	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Start Stop Enumeration:\n16#CE - Start\n16#CF - Stop\nAll others no operation	\N
1590	3	Emergency stop command	Holding Register	415007	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Start Stop Enumeration:\n16#CE - Emergency Stop\nAll others no operation	\N
1591	3	Active power percent	Holding Register	415008	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1592	3	Local remote control	Holding Register	415010	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Local/Remote Control:\n0 - Remote control\n1 - Local control\n	This point is not mapped to ignition
1593	3	Reactive power mode	Holding Register	415011	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Reactive Power Mode:\n16#55 - OFF\n16#A1 - Power factor mode\n16#A2 - Reactive output mode\n16#A3 - QU mode\n16#A5 - QP mode\n	\N
1594	3	Reactive power percent setpoint	Holding Register	415012	16-bit signed integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1595	3	Power factor setpoint	Holding Register	415013	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	\N
1596	3	Power limit actual value setpoint	Holding Register	415014	16-bit unsigned integer	\N	kW	10	\N	\N	\N	\N	\N	\N	\N
1597	3	Reactive power actual limit setpoint	Holding Register	415015	16-bit signed integer	\N	kvar	10	\N	\N	\N	\N	\N	\N	\N
1598	3	Active power ramp up rate setpoint	Holding Register	415016	16-bit unsigned integer	\N	%/s	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1599	3	Active power ramp down rate setpoint	Holding Register	415017	16-bit unsigned integer	\N	%/s	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1600	3	Stop delay time	Holding Register	415020	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1601	3	Stop slope	Holding Register	415021	16-bit unsigned integer	\N	%/s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1602	3	U1 on off command	Holding Register	415022	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Start Stop Enumeration:\n16#CE - Off?\n16#CF - On?\nAll others no operation\nNeed to confirm	\N
1603	3	U2 on off command	Holding Register	415023	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Start Stop Enumeration:\n16#CE - Off?\n16#CF - On?\nAll others no operation\nNeed to confirm	\N
1604	3	U3 on off command	Holding Register	415024	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Start Stop Enumeration:\n16#CE - Off?\n16#CF - On?\nAll others no operation\nNeed to confirm	\N
1605	3	U4 on off command	Holding Register	415025	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Start Stop Enumeration:\n16#CE - Off?\n16#CF - On?\nAll others no operation\nNeed to confirm	\N
1606	3	High voltage load switch remote open	Holding Register	415026	16-bit unsigned integer	\N	boolean	\N	\N	Tripped	Normal	\N	\N	\N	This point is not mapped to ignition
1607	3	Reactive power ramp up rate setpoint	Holding Register	415027	16-bit unsigned integer	\N	%/s	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1608	3	Reactive power ramp down rate setpoint	Holding Register	415028	16-bit unsigned integer	\N	%/s	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1609	3	Qu activation power point	Holding Register	415029	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1610	3	Qu operation mode	Holding Register	415030	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	QU Operation Mode:\n16#A1 - Reactive power ratio mode\n16#A2 - Active power ratio mode\n16#A3 - Power factor mode	This point is not mapped to ignition
1611	3	Qu input voltage source	Holding Register	415031	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Voltage Source:\n16#B1 - real time voltage\n16#B2 - record voltage\n	This point is not mapped to ignition
1612	3	Qu reactive reactive power limit setpoint	Holding Register	415032	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1613	3	Qu reactive reactive power limit setpoint	Holding Register	415033	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1614	3	Qu power factor end point	Holding Register	415034	16-bit unsigned integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1615	3	Qu power factor start point	Holding Register	415035	16-bit unsigned integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1616	3	Qu voltage rise start point	Holding Register	415037	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1617	3	Qu voltage rise end point	Holding Register	415038	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1618	3	Qu voltage drop start point	Holding Register	415039	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1619	3	Qu voltage drop end point	Holding Register	415040	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1620	3	HV load switch remote close	Holding Register	415049	Enumeration	\N	\N	\N	\N	Closed	Open	\N	\N	Junior Metayer:\n0: Open\n1: Close	\N
1621	3	Qu reactive power rising start	Holding Register	415051	16-bit signed integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1622	3	Qu reactive power decline start	Holding Register	415052	16-bit signed integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1623	3	Enable pu	Holding Register	415055	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Enable Disable P(U):\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
1624	3	Pu active power rising gradiant	Holding Register	415056	16-bit unsigned integer	\N	%	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1625	3	Pu active power decline gradiant	Holding Register	415057	16-bit unsigned integer	\N	%	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1626	3	Dc switch open close	Holding Register	415060	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	DC Switch Open/Close:\n16#55 - Close\n16#AA - Open\n	\N
1627	3	Night svg enable disable	Holding Register	415061	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Night SVG Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
1628	3	Start waiting time	Holding Register	415062	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1629	3	Time for automatic recovery from fault	Holding Register	415063	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1630	3	Overfrequency recovery threshold	Holding Register	415064	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1631	3	Underfrequency recovery threshold	Holding Register	415065	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1632	3	Dc starting voltage	Holding Register	415066	16-bit unsigned integer	\N	V	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1633	3	Frequency modulation enable	Holding Register	415073	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Frequency modulation Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
1634	3	Overfrequency derating start point	Holding Register	415075	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1635	3	Overfrequency derating end point	Holding Register	415076	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1636	3	Overfrequency derating factor	Holding Register	415077	16-bit unsigned integer	\N	PU	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1637	3	Overfrequency derating limit	Holding Register	415078	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1638	3	Frequency regulation input source	Holding Register	415079	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Frequency Source:\n16#B1 - real time frequency\n16#B2 - record frequency\n	This point is not mapped to ignition
1639	3	Frequency regulation active power	Holding Register	415080	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1640	3	Underfrequency rising start point	Holding Register	415081	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1641	3	Underfrequency rising end point	Holding Register	415082	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1642	3	Underfrequency rise factor	Holding Register	415083	16-bit unsigned integer	\N	PU	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1643	3	Underfrequency rising limit	Holding Register	415084	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1644	3	Leakage current protection value	Holding Register	415088	16-bit unsigned integer	\N	A	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1645	3	Insulation monitoring protection threshold	Holding Register	415116	16-bit unsigned integer	\N	k╬ô├ñ┬¬	1	\N	\N	\N	\N	\N	\N	\N
1646	3	Ac overvoltage level 1 protection	Holding Register	415120	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1647	3	Ac overvoltage level 2 protection	Holding Register	415121	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1648	3	Ac overvoltage level 3 protection	Holding Register	415122	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1649	3	Ac overvoltage level 4 protection	Holding Register	415123	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1650	3	Ac overvoltage level 5 protection	Holding Register	415124	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1651	3	Vmax recover	Holding Register	415130	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1652	3	Ac undervoltage level 1 protection	Holding Register	415131	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1653	3	Ac undervoltage level 2 protection	Holding Register	415132	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1654	3	Ac undervoltage level 3 protection	Holding Register	415133	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1655	3	Ac undervoltage level 4 protection	Holding Register	415134	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1656	3	Ac undervoltage level 5 protection	Holding Register	415135	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1657	3	Vmin recover	Holding Register	415141	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1658	3	Grid over frequency level 1 protection	Holding Register	415142	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1659	3	Grid over frequency level 2 protection	Holding Register	415143	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1660	3	Grid over frequency level 3 protection	Holding Register	415144	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1661	3	Grid over frequency level 4 protection	Holding Register	415145	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1662	3	Grid over frequency level 5 protection	Holding Register	415146	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1663	3	Fmax recover	Holding Register	415152	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1664	3	AC under frequency level 1 protection	Holding Register	415153	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1665	3	AC under frequency level 2 protection	Holding Register	415154	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1666	3	AC under frequency level 3 protection	Holding Register	415155	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1667	3	AC under frequency level 4 protection	Holding Register	415156	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1668	3	AC under frequency level 5 protection	Holding Register	415157	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1669	3	Fmin recover	Holding Register	415163	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1670	3	Floating mode	Holding Register	415168	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1671	3	Over voltage level 1 trip time	Holding Register	415170	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1672	3	Over voltage level 2 trip time	Holding Register	415172	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1673	3	Over voltage level 3 trip time	Holding Register	415174	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1674	3	Over voltage level 4 trip time	Holding Register	415176	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1675	3	Over voltage level 5 trip time	Holding Register	415178	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1676	3	Under voltage level 1 trip time	Holding Register	415180	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1677	3	Under voltage level 2 trip time	Holding Register	415182	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1678	3	Under voltage level 3 trip time	Holding Register	415184	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1679	3	Under voltage level 4 trip time	Holding Register	415186	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1680	3	Under voltage level 5 trip time	Holding Register	415188	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1681	3	Over frequency level 1 trip time	Holding Register	415190	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1682	3	Over frequency level 2 trip time	Holding Register	415192	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1683	3	Over frequency level 3 trip time	Holding Register	415194	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1684	3	Over frequency level 4 trip time	Holding Register	415196	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1685	3	Over frequency level 5 trip time	Holding Register	415198	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1686	3	Under frequency level 1 trip time	Holding Register	415200	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1687	3	Under frequency level 2 trip time	Holding Register	415202	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1688	3	Under frequency level 3 trip time	Holding Register	415204	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1689	3	Under frequency level 4 trip time	Holding Register	415206	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1690	3	Under frequency level 5 trip time	Holding Register	415208	32-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1691	3	Active power control closed loop enable disable	Holding Register	415212	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Active Power Closed Loop Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
1692	3	Reactive power control closed loop enable disable	Holding Register	415213	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Reactive Power Closed Loop Enable/Disable:\n16#55 - Disable\n16#AA - Enable\n	This point is not mapped to ignition
1693	3	Overfrequency derating output variation baseline	Holding Register	415222	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Junior Metayer:\n16#A1: rated power\n16#A2: power before derating\n16#A3: maximum power\n16#A4: Pmax-Pm	\N
1694	3	Underfrequency rising output change base	Holding Register	415223	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Junior Metayer:\n16#A1: rated power\n16#A2: power before derating\n16#A3: maximum power\n16#A4: Pmax-Pm	\N
1695	3	Reactive power response time	Holding Register	415224	16-bit unsigned integer	\N	s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1696	3	QP_K1	Holding Register	415225	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1697	3	QP_K2	Holding Register	415226	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1698	3	QP_K3	Holding Register	415227	16-bit signed integer	\N	PU	1000	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1699	3	QP_P1	Holding Register	415228	16-bit unsigned integer	\N	PU	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1700	3	QP_P2	Holding Register	415229	16-bit unsigned integer	\N	PU	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1701	3	QP_P3	Holding Register	415230	16-bit unsigned integer	\N	PU	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1702	3	QP mode	Holding Register	415231	Enumeration	\N	\N	\N	\N	\N	\N	\N	\N	Frequency output change benchmark:\n16#A1 - function u nknown\n16#A2 - function unknown	This point is not mapped to ignition
1703	3	Heartbeat timeout period	Holding Register	415249	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1704	3	Grid connection maximum voltage	Holding Register	415257	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1705	3	Grid connection minimum voltage	Holding Register	415258	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1706	3	Grid connection maximum frequency	Holding Register	415259	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1707	3	Grid connection minimum frequency	Holding Register	415260	16-bit unsigned integer	\N	Hz	100	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1708	3	Grid detection before connection	Holding Register	415261	16-bit unsigned integer	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1709	3	Boot waiting time	Holding Register	415262	16-bit unsigned integer	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1710	3	Active power soft start	Holding Register	415263	16-bit unsigned integer	\N	\N	\N	\N	Enabled	Disabled	\N	\N	Junior Metayer:\n0: Disable\n1: Enable	\N
1711	3	Reactive power soft start	Holding Register	415264	16-bit unsigned integer	\N	\N	\N	\N	Enabled	Disabled	\N	\N	Junior Metayer:\n0: Disable\n1: Enable	\N
1712	3	Specified overexcitation PF	Holding Register	415265	16-bit signed integer	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1713	3	Specified underrexcitation PF	Holding Register	415266	16-bit signed integer	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1714	3	QU reference voltage automatic adjustment	Holding Register	415267	16-bit unsigned integer	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1715	3	QU reference voltage adjustment	Holding Register	415268	16-bit unsigned integer	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1716	3	QU reference voltage automatic adjustment time	Holding Register	415269	16-bit unsigned integer	\N	\N	\N	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1717	3	Overvoltage derating start point	Holding Register	415270	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1718	3	Overvoltage derating power start point	Holding Register	415271	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1719	3	Overvoltage derating end point	Holding Register	415272	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1720	3	Overvoltage derating power end point	Holding Register	415273	16-bit unsigned integer	\N	%	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1721	3	Voltage derating response time	Holding Register	415274	16-bit unsigned integer	\N	s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1722	3	Over frequency response time	Holding Register	415275	16-bit unsigned integer	\N	s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1723	3	Under frequency response time	Holding Register	415276	16-bit unsigned integer	\N	s	10	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1724	3	Over frequency response delay time	Holding Register	415281	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1725	3	Under frequency response delay time	Holding Register	415282	16-bit unsigned integer	\N	ms	0.05	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1726	3	Disconnection countdown time	Holding Register	415306	16-bit unsigned integer	\N	s	1	\N	\N	\N	\N	\N	\N	\N
1727	3	Number of disconnections	Holding Register	415307	16-bit unsigned integer	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
1728	3	Disconnection time	Holding Register	415308	16-bit unsigned integer	\N	ms	1	\N	\N	\N	\N	\N	\N	\N
1729	3	Shutdown slope at disconnections	Holding Register	415309	16-bit unsigned integer	\N	%/s	10	\N	\N	\N	\N	\N	\N	\N
1730	3	Zone monitoring	Holding Register	415800	16-bit unsigned integer	\N	boolean	\N	State change	Enable	Disable	\N	\N	\N	This point is not mapped to ignition
1731	3	Sensitivity	Holding Register	415802	16-bit unsigned integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1732	3	Clear zone monitor data	Holding Register	415803	16-bit unsigned integer	\N	boolean	\N	On (1)	Clear	No Action	\N	\N	\N	This point is not mapped to ignition
1733	3	Clear fault	Holding Register	415804	16-bit unsigned integer	\N	boolean	\N	On (1)	Clear	No Action	\N	\N	\N	This point is not mapped to ignition
1734	3	U1 number of strings on branch 1	Holding Register	415805	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1735	3	U1 number of strings on branch 2	Holding Register	415806	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1736	3	U1 number of strings on branch 3	Holding Register	415807	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1737	3	U1 number of strings on branch 4	Holding Register	415808	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1738	3	U1 number of strings on branch 5	Holding Register	415809	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1739	3	U1 number of strings on branch 6	Holding Register	415810	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1740	3	U1 number of strings on branch 7	Holding Register	415811	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1741	3	U2 number of strings on branch 1	Holding Register	415821	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1742	3	U2 number of strings on branch 2	Holding Register	415822	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1743	3	U2 number of strings on branch 3	Holding Register	415823	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1744	3	U2 number of strings on branch 4	Holding Register	415824	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1745	3	U2 number of strings on branch 5	Holding Register	415825	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1746	3	U2 number of strings on branch 6	Holding Register	415826	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1747	3	U2 number of strings on branch 7	Holding Register	415827	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1748	3	U3 number of strings on branch 1	Holding Register	415837	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1749	3	U3 number of strings on branch 2	Holding Register	415838	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1750	3	U3 number of strings on branch 3	Holding Register	415839	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1751	3	U3 number of strings on branch 4	Holding Register	415840	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1752	3	U3 number of strings on branch 5	Holding Register	415841	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1753	3	U3 number of strings on branch 6	Holding Register	415842	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1754	3	U3 number of strings on branch 7	Holding Register	415843	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1755	3	U4 number of strings on branch 1	Holding Register	415853	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1756	3	U4 number of strings on branch 2	Holding Register	415854	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1757	3	U4 number of strings on branch 3	Holding Register	415855	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1758	3	U4 number of strings on branch 4	Holding Register	415856	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1759	3	U4 number of strings on branch 5	Holding Register	415857	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1760	3	U4 number of strings on branch 6	Holding Register	415858	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1761	3	U4 number of strings on branch 7	Holding Register	415859	16-bit unsigned integer	\N	count	1	\N	\N	\N	\N	\N	\N	This point is not mapped to ignition
1762	4	Scan count	Holding Register	40001	32-bit float	\N	s	1	\N	\N	\N	\N	\N	\N	\N
1763	4	Skipped scans	Holding Register	40003	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1764	4	Logger voltage	Holding Register	40005	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
1765	4	Logger temp	Holding Register	40007	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1766	4	Skipped slow scans	Holding Register	40009	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1767	4	Logger lithium	Holding Register	40011	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
1768	4	Logger low volt 12	Holding Register	40013	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1769	4	Solar zenith	Holding Register	40017	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
1770	4	Solar elevation	Holding Register	40019	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
1771	4	Solar azimuth	Holding Register	40021	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
1772	4	Heat state	Holding Register	40023	32-bit float	\N	boolean	1	\N	On	Off	\N	\N	\N	\N
1773	4	Logger data map version	Holding Register	40025	32-bit float	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1774	4	Maint event	Holding Register	40027	32-bit float	\N	boolean	1	\N	On	Off	\N	\N	\N	\N
1775	4	Logger AC power available	Holding Register	40029	32-bit float	\N	boolean	1	\N	On	Off	\N	\N	0 to 1	\N
1776	4	Batt voltage	Holding Register	40031	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
1779	4	Input voltage 1	Holding Register	40037	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
1780	4	Chargesource	Holding Register	40041	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	\N	0 = None; 1 = Solar; 2 = AC Power
1781	4	Checkbattery	Holding Register	40043	32-bit float	\N	boolean	1	\N	Alarm	Alarm	\N	\N	\N	\N
1782	4	Input voltage 2	Holding Register	40045	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
1783	4	POA	Holding Register	40047	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1784	4	POA temperature compensated	Holding Register	40049	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1785	4	POA temp	Holding Register	40051	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1786	4	GHI	Holding Register	40053	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1787	4	GHI temperature compensated	Holding Register	40055	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1788	4	GHI temp	Holding Register	40057	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1789	4	Ambient temp	Holding Register	40075	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1790	4	Dew point	Holding Register	40077	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1791	4	RH	Holding Register	40079	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
1792	4	Wind speed	Holding Register	40081	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
1793	4	Wind speed max	Holding Register	40083	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
1794	4	Wind dir	Holding Register	40085	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
1795	4	Wsxxx wind quality	Holding Register	40087	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
1796	4	BP	Holding Register	40089	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
1797	4	BP sea level	Holding Register	40091	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
1798	4	Wsxxx compass	Holding Register	40093	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
1799	4	Wind chill	Holding Register	40095	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1800	4	Heat index	Holding Register	40097	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1801	4	Rain instantaneous	Holding Register	40105	32-bit float	\N	mm	1	\N	\N	\N	\N	\N	\N	\N
1802	4	Rain intensity	Holding Register	40107	32-bit float	\N	mm/hr	1	\N	\N	\N	\N	\N	\N	\N
1803	4	Rain today	Holding Register	40109	32-bit float	\N	mm/day	1	\N	\N	\N	\N	\N	\N	\N
1804	4	BOM temp 1	Holding Register	40125	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1805	4	BOM temp 2	Holding Register	40127	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1806	4	BOM temp 3	Holding Register	40129	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1807	4	POA insolation	Holding Register	40175	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
1808	4	GHI insolation	Holding Register	40177	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
1809	4	Hourly POA avg	Holding Register	40199	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1810	4	Hourly POA temperature compensated avg	Holding Register	40201	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1811	4	Hourly POA temp avg	Holding Register	40203	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1812	4	Hourly GHI avg	Holding Register	40205	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1813	4	Hourly GHI temperature compensated avg	Holding Register	40207	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1814	4	Hourly GHI temp avg	Holding Register	40209	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1815	4	Hourly ambient temp avg	Holding Register	40227	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1816	4	Hourly dew point avg	Holding Register	40229	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1817	4	Hourly RH	Holding Register	40231	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
1818	4	Hourly wind speed mean	Holding Register	40233	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
1819	4	Hourly wind speed max	Holding Register	40235	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
1820	4	Hourly wind dir mean	Holding Register	40237	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	\N
1821	4	Hourly BP avg	Holding Register	40239	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
1822	4	Hourly BP sea level avg	Holding Register	40241	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
1823	4	Hourly wsxxx compass	Holding Register	40243	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
1824	4	Hourly wind chill avg	Holding Register	40245	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1825	4	Hourly heat index avg	Holding Register	40247	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1826	4	Hourly rain instantaneous tot	Holding Register	40255	32-bit float	\N	mm	1	\N	\N	\N	\N	\N	\N	\N
1827	4	Hourly rain intensity avg	Holding Register	40257	32-bit float	\N	mm/hr	1	\N	\N	\N	\N	\N	\N	\N
1828	4	Hourly rain intensity max	Holding Register	40259	32-bit float	\N	mm/hr	1	\N	\N	\N	\N	\N	\N	\N
1829	4	Hourly BOM temp 1 avg	Holding Register	40275	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1830	4	Hourly BOM temp 2 avg	Holding Register	40277	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1831	4	Hourly BOM temp 3 avg	Holding Register	40279	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1832	4	Hourly POA insolation tot	Holding Register	40325	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
1833	4	Hourly GHI insolation tot	Holding Register	40327	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
1834	4	POA humidity	Holding Register	40351	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
1835	4	POA humidity temp	Holding Register	40353	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1836	4	POA tilt	Holding Register	40355	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	\N
1837	4	POA fan speed	Holding Register	40357	32-bit float	\N	RPM	1	\N	\N	\N	\N	\N	\N	\N
1838	4	POA heat current	Holding Register	40359	32-bit float	\N	mA	1	\N	\N	\N	\N	\N	\N	\N
1839	4	GHI humidity	Holding Register	40363	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
1840	4	GHI humidity temp	Holding Register	40365	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1841	4	GHI tilt	Holding Register	40367	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	\N
1842	4	GHI fan speed	Holding Register	40369	32-bit float	\N	RPM	1	\N	\N	\N	\N	\N	\N	\N
1843	4	GHI heat current	Holding Register	40371	32-bit float	\N	mA	1	\N	\N	\N	\N	\N	\N	\N
1844	4	Logger temp	Holding Register	40405	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
1845	4	Ambient temp f	Holding Register	40473	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
1846	4	Dew point	Holding Register	40475	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
1847	4	Wind speed	Holding Register	40479	32-bit float	\N	mph	1	\N	\N	\N	\N	\N	\N	\N
1848	4	Wind speed max	Holding Register	40481	32-bit float	\N	mph	1	\N	\N	\N	\N	\N	\N	\N
1849	4	BP hg	Holding Register	40487	32-bit float	\N	inHg	1	\N	\N	\N	\N	\N	\N	\N
1850	4	BP sea level hg	Holding Register	40489	32-bit float	\N	inHg	1	\N	\N	\N	\N	\N	\N	\N
1851	4	Rain instantaneous	Holding Register	40503	32-bit float	\N	in	1	\N	\N	\N	\N	\N	\N	\N
1852	4	Rain intensity	Holding Register	40505	32-bit float	\N	in/hr	1	\N	\N	\N	\N	\N	\N	\N
1853	4	Rain today	Holding Register	40507	32-bit float	\N	in/day	1	\N	\N	\N	\N	\N	\N	\N
1854	4	BOM temp 1	Holding Register	40523	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
1855	4	BOM temp 2	Holding Register	40525	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
1856	4	BOM temp 3	Holding Register	40527	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
1857	4	RPOA irradiance	Holding Register	40747	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1858	4	RPOA temperature corrected irradiance	Holding Register	40749	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1859	4	RPOA case temp	Holding Register	40751	32-bit float	\N	degC	1	\N	\N	\N	\N	\N	\N	\N
1860	4	RPOA isolation	Holding Register	40753	32-bit float	\N	Wh/m2	1	\N	\N	\N	\N	\N	\N	\N
1861	4	RPOA unit humidity 	Holding Register	40771	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
1862	4	RPOA unit temp 	Holding Register	40773	32-bit float	\N	degC	1	\N	\N	\N	\N	\N	\N	\N
1863	4	RPOA unit tilt	Holding Register	40775	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
1864	4	RPOA unit fan speed	Holding Register	40777	32-bit float	\N	rpm	1	\N	\N	\N	\N	\N	\N	\N
1865	4	Modeled GHI	Holding Register	40799	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1866	4	Modeled DHI	Holding Register	40801	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1867	4	Modeled DNI	Holding Register	40803	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1868	4	Modeled POA	Holding Register	40804	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1869	4	RPOA hourly irradiance	Holding Register	40839	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1870	4	RPOA hourly temperature corrected irradiance	Holding Register	40841	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
1871	4	RPOA hourly case temp	Holding Register	40843	32-bit float	\N	degC	1	\N	\N	\N	\N	\N	\N	\N
1872	4	RPOA hourly insolation	Holding Register	40845	32-bit float	\N	Wh/m2	1	\N	\N	\N	\N	\N	\N	\N
1873	4	Summary alarm	Holding Register	42001	32-bit unsigned int	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1874	4	Data logger alarms register	Holding Register	42003	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1875	4	Data logger watchdog error	Holding Register	42003	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1876	4	Data logger skipped main scan	Holding Register	42003.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1877	4	Data logger skipped slow scan	Holding Register	42003.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1878	4	Data logger program variable out of bounds	Holding Register	42003.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1879	4	Data logger low 12V	Holding Register	42003.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1880	4	Data logger low 5V	Holding Register	42003.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1881	4	Data logger lithium battery error	Holding Register	42003.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1882	4	Data logger lithium battery low	Holding Register	42003.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1883	4	Data logger lithium battery critical	Holding Register	42003.1	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1884	4	Data logger voltage error	Holding Register	42003.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1885	4	Data logger low voltage warning	Holding Register	42003.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1886	4	Data logger low voltage	Holding Register	42003.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1887	4	Data logger over voltage	Holding Register	42003.19	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1888	4	Data logger temperature error	Holding Register	42003.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1889	4	Data logger temperature below operating range	Holding Register	42003.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1890	4	Data logger temperature above operating range	Holding Register	42003.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1891	4	Battery alarms register	Holding Register	42005	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1892	4	Check battery	Holding Register	42005	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1893	4	Battery voltage error	Holding Register	42005.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1894	4	Low battery voltage warning	Holding Register	42005.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1895	4	Low battery voltage critical	Holding Register	42005.1	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1896	4	Low battery voltage deep discharge	Holding Register	42005.11	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1897	4	Battery current error	Holding Register	42005.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1898	4	Excessive battery current warning	Holding Register	42005.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1899	4	Excessive battery current critical	Holding Register	42005.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1900	4	Charging alarms register	Holding Register	42007	32-bit unsigned int	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1901	4	Input voltage error	Holding Register	42007	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1902	4	Rpu enabled	Holding Register	42007.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1903	4	Input current error	Holding Register	42007.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1904	4	Excessive input current	Holding Register	42007.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1905	4	Load current error	Holding Register	42007.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1906	4	Excessive load current warning	Holding Register	42007.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1907	4	Excessive load current	Holding Register	42007.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1908	4	GHI 1 alarms register	Holding Register	42019	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1909	4	GHI 1 irradiance error	Holding Register	42019	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1910	4	GHI 1 irradiance negative	Holding Register	42019.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1911	4	GHI 1 irradiance above solar constant	Holding Register	42019.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1912	4	GHI 1 temperature corrected irradiance error	Holding Register	42019.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1913	4	GHI 1 temperature corrected irradiance negative	Holding Register	42019.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1914	4	GHI 1 temperature corrected irradiance above solar constant	Holding Register	42019.1	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1915	4	GHI 1 case temperature error	Holding Register	42019.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1916	4	GHI 1 case temperature below operating range	Holding Register	42019.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1917	4	GHI 1 case temperature above operating range	Holding Register	42019.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1918	4	POA alarms register	Holding Register	42021	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1919	4	POA irradiance error	Holding Register	42021	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1920	4	POA irradiance negative	Holding Register	42021.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1921	4	POA irradiance above solar constant	Holding Register	42021.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1922	4	POA temperature corrected irradiance error	Holding Register	42021.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1923	4	POA temperature corrected irradiance negative	Holding Register	42021.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1924	4	POA temperature corrected irradiance above solar constant	Holding Register	42021.1	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1925	4	POA case temperature error	Holding Register	42021.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1926	4	POA case temperature below operating range	Holding Register	42021.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1927	4	POA case temperature above operating range	Holding Register	42021.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1928	4	Multifunction alarms register	Holding Register	42039	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1929	4	Ambient temperature error	Holding Register	42039	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1930	4	Ambient temperature below operating range	Holding Register	42039.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1931	4	Ambient temperature above operating range	Holding Register	42039.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1932	4	Dew point error	Holding Register	42039.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1933	4	Dew point above ambient temperature	Holding Register	42039.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1934	4	Condensation warning	Holding Register	42039.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1935	4	Relative humidity error	Holding Register	42039.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1936	4	Relative humidity below operating range	Holding Register	42039.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1937	4	Relative humidity above operating range	Holding Register	42039.1	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1938	4	Absolute barometric pressure error	Holding Register	42039.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1939	4	Absolute barometric pressure below operating range	Holding Register	42039.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1940	4	Absolute barometric pressure above operating range	Holding Register	42039.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1941	4	Sea level barometric pressure error	Holding Register	42039.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1942	4	Sea level barometric pressure below operating range	Holding Register	42039.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1943	4	Sea level barometric pressure above operating range	Holding Register	42039.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1944	4	Wind alarms register	Holding Register	42041	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1945	4	Wind speed error	Holding Register	42041	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1946	4	Wind speed below operating range	Holding Register	42041.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1947	4	Wind speed above operating range	Holding Register	42041.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1948	4	Wind speed unable to execute measurement due to ambient conditions	Holding Register	42041.3	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1949	4	Wind speed quality warning	Holding Register	42041.4	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1950	4	Wind speed quality error	Holding Register	42041.5	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1951	4	Wind speed max error	Holding Register	42041.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1952	4	Wind speed max below operating range	Holding Register	42041.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1953	4	Wind speed max above operating range	Holding Register	42041.1	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1954	4	Wind direction error	Holding Register	42041.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1955	4	Wind direction below operating range	Holding Register	42041.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1956	4	Wind direction above operating range	Holding Register	42041.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1957	4	Compass error	Holding Register	42041.24	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1958	4	Compass below operating range	Holding Register	42041.25	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1959	4	Compass above operating range	Holding Register	42041.26	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1960	4	Rain alarms regsiter	Holding Register	42043	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1961	4	Rain total error	Holding Register	42043	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1962	4	Rain total negative	Holding Register	42043.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1963	4	Rain total above operating range	Holding Register	42043.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1964	4	Rain intensity error	Holding Register	42043.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1965	4	Rain intensity negative	Holding Register	42043.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1966	4	Rain intensity above operating range	Holding Register	42043.1	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1967	4	Rain today error	Holding Register	42043.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1968	4	Rain today is negative	Holding Register	42043.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1969	4	Rain today above operating range	Holding Register	42043.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1970	4	GHI alarm register	Holding Register	42045	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1971	4	Global irradiance error	Holding Register	42045	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1972	4	Global irradiance below operating range	Holding Register	42045.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1973	4	Global irradiance above operating range	Holding Register	42045.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1974	4	Diffuse irradiance error	Holding Register	42045.8	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1975	4	Diffuse irradiance below operating range	Holding Register	42045.9	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1976	4	Diffuse irradiance above operating range	Holding Register	42045.1	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1977	4	Direct irradiance error	Holding Register	42045.16	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1978	4	Direct irradiance below operating range	Holding Register	42045.17	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1979	4	Direct irradiance above operating range	Holding Register	42045.18	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1980	4	BOM 1 alarm register	Holding Register	42059	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1981	4	BOM 1 temperature error	Holding Register	42059	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1982	4	BOM 1 temperature below operating range	Holding Register	42059.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1983	4	BOM 1 temperature above operating range	Holding Register	42059.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1984	4	BOM 2 alarm register	Holding Register	42061	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1985	4	BOM 2 temperature error	Holding Register	42061	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1986	4	BOM 2 temperature below operating range	Holding Register	42061.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1987	4	BOM 2 temperature above operating range	Holding Register	42061.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1988	4	BOM 3 alarm register	Holding Register	42063	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
1989	4	BOM 3 temperature error	Holding Register	42063	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1990	4	BOM 3 temperature below operating range	Holding Register	42063.1	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1991	4	BOM 3 temperature above operating range	Holding Register	42063.2	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
1992	5	Scan count	Holding Register	40001	32-bit float	\N	s	1	\N	\N	\N	\N	\N	\N	\N
1993	5	Skipped scans	Holding Register	40002	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1994	5	Logger voltage	Holding Register	40003	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
1995	5	Logger temp	Holding Register	40004	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
1996	5	Skipped slow scans	Holding Register	40005	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1997	5	Logger lithium	Holding Register	40006	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
1998	5	Logger low volt 12	Holding Register	40007	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
1999	5	Solar zenith	Holding Register	40008	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2000	5	Solar elevation	Holding Register	40009	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2001	5	Solar azimuth	Holding Register	40010	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2002	5	Heat state	Holding Register	40011	32-bit float	\N	boolean	1	\N	On	Off	\N	\N	\N	\N
2003	5	Logger data map version	Holding Register	40012	32-bit float	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2004	5	Maint event	Holding Register	40013	32-bit float	\N	boolean	1	\N	On	Off	\N	\N	\N	\N
2005	5	Logger AC power	Holding Register	40014	32-bit float	\N	boolean	1	\N	On	Off	\N	\N	\N	\N
2006	5	Batt voltage	Holding Register	40015	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2007	5	Batt current	Holding Register	40016	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2008	5	Load current	Holding Register	40017	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2009	5	Input voltage 1	Holding Register	40018	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2010	5	Input current	Holding Register	40019	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2011	5	Chargesource	Holding Register	40020	32-bit float	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2012	5	Checkbattery	Holding Register	40021	32-bit float	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2013	5	Input voltage 2	Holding Register	40022	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2014	5	POA	Holding Register	40023	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2015	5	POA temperature compensated	Holding Register	40024	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2016	5	POA temp	Holding Register	40025	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2017	5	GHI 1	Holding Register	40026	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2018	5	GHI 1 temperature compensated	Holding Register	40027	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2019	5	GHI 1 temp	Holding Register	40028	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2020	5	GHI 2	Holding Register	40029	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2021	5	GHI 2 temperature compensated	Holding Register	40030	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2022	5	GHI 2 temp	Holding Register	40031	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2023	5	Ambient temp	Holding Register	40032	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2024	5	Dew point	Holding Register	40033	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2025	5	Relative humidity	Holding Register	40034	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
2026	5	Wind speed	Holding Register	40035	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
2027	5	Wind speed max	Holding Register	40036	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
2028	5	Wind direction	Holding Register	40037	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2029	5	Wind measurement quality	Holding Register	40038	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
2030	5	Barometric pressure	Holding Register	40039	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
2031	5	Barometric pressure at sea level	Holding Register	40040	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
2032	5	Internal compass reading	Holding Register	40041	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2033	5	Wind chill	Holding Register	40042	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2034	5	Heat index	Holding Register	40043	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2035	5	Rain instantaneous	Holding Register	40044	32-bit float	\N	mm	1	\N	\N	\N	\N	\N	\N	\N
2036	5	Rain intensity	Holding Register	40045	32-bit float	\N	mm/hr	1	\N	\N	\N	\N	\N	\N	\N
2037	5	Rain today	Holding Register	40046	32-bit float	\N	mm/day	1	\N	\N	\N	\N	\N	\N	\N
2038	5	BOM temp 1	Holding Register	40047	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2039	5	BOM temp 2	Holding Register	40048	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2040	5	BOM temp 3	Holding Register	40049	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2041	5	POA insolation	Holding Register	40050	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2042	5	GHI insolation 1	Holding Register	40051	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2043	5	GHI insolation 2	Holding Register	40052	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2044	5	Hourly POA avg	Holding Register	40053	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2045	5	Hourly POA temperature compensated avg	Holding Register	40054	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2046	5	Hourly POA temp avg	Holding Register	40055	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2047	5	Hourly GHI 1 avg	Holding Register	40056	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2048	5	Hourly GHI 1 temperature compensated avg	Holding Register	40057	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2049	5	Hourly GHI 1 temp avg	Holding Register	40058	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2050	5	Hourly GHI 2 avg	Holding Register	40059	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2051	5	Hourly GHI 2 temperature compensated avg	Holding Register	40060	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2052	5	Hourly GHI 2 temp avg	Holding Register	40061	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2053	5	Hourly ambient temp avg	Holding Register	40062	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2054	5	Hourly dew point avg	Holding Register	40063	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2055	5	Hourly relative humidity	Holding Register	40064	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
2056	5	Hourly wind speed mean	Holding Register	40065	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
2057	5	Hourly wind speed max	Holding Register	40066	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
2058	5	Hourly wind direction mean	Holding Register	40067	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	\N
2059	5	Hourly barometric pressure avg	Holding Register	40068	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
2060	5	Hourly BP sea level avg	Holding Register	40069	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
2061	5	Hourly compass reading	Holding Register	40070	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2062	5	Hourly wind chill avg	Holding Register	40071	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2063	5	Hourly heat index avg	Holding Register	40072	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2064	5	Hourly rain instantaneous tot	Holding Register	40073	32-bit float	\N	mm	1	\N	\N	\N	\N	\N	\N	\N
2065	5	Hourly rain intensity avg	Holding Register	40074	32-bit float	\N	mm/hr	1	\N	\N	\N	\N	\N	\N	\N
2066	5	Hourly rain intensity max	Holding Register	40075	32-bit float	\N	mm/hr	1	\N	\N	\N	\N	\N	\N	\N
2067	5	Hourly BOM temp 1 avg	Holding Register	40076	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2068	5	Hourly BOM temp 2 avg	Holding Register	40077	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2069	5	Hourly BOM temp 3 avg	Holding Register	40078	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2070	5	Hourly POA insolation tot	Holding Register	40079	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2071	5	Hourly GHI insolation 1 tot	Holding Register	40080	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2072	5	Hourly GHI insolation 2 tot	Holding Register	40081	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2073	5	POA humidity	Holding Register	40082	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
2074	5	POA humidity temp	Holding Register	40083	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2075	5	POA tilt	Holding Register	40084	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	\N
2076	5	POA fan speed	Holding Register	40085	32-bit float	\N	RPM	1	\N	\N	\N	\N	\N	\N	\N
2077	5	POA heat current	Holding Register	40086	32-bit float	\N	A	0.001	\N	\N	\N	\N	\N	\N	\N
2078	5	GHI humidity 1	Holding Register	40087	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
2079	5	GHI humidity temp 1	Holding Register	40088	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2080	5	GHI tilt 1	Holding Register	40089	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	\N
2081	5	GHI fan speed 1	Holding Register	40090	32-bit float	\N	RPM	1	\N	\N	\N	\N	\N	\N	\N
2082	5	GHI heat current 1	Holding Register	40091	32-bit float	\N	A	0.001	\N	\N	\N	\N	\N	\N	\N
2083	5	GHI humidity 2	Holding Register	40092	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
2084	5	GHI humidity temp 2	Holding Register	40093	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2085	5	GHI tilt 2	Holding Register	40094	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	\N
2086	5	GHI fan speed 2	Holding Register	40095	32-bit float	\N	RPM	1	\N	\N	\N	\N	\N	\N	\N
2087	5	GHI heat current 2	Holding Register	40096	32-bit float	\N	A	0.001	\N	\N	\N	\N	\N	\N	\N
2088	5	Logger temp	Holding Register	40097	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2089	5	Ambient temp f	Holding Register	40098	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2090	5	Dew point	Holding Register	40099	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2091	5	Wind speed	Holding Register	40100	32-bit float	\N	mph	1	\N	\N	\N	\N	\N	\N	\N
2092	5	Wind speed max	Holding Register	40101	32-bit float	\N	mph	1	\N	\N	\N	\N	\N	\N	\N
2093	5	Barometric pressure hg	Holding Register	40102	32-bit float	\N	inHg	1	\N	\N	\N	\N	\N	\N	\N
2094	5	Barometric pressure sea level hg	Holding Register	40103	32-bit float	\N	inHg	1	\N	\N	\N	\N	\N	\N	\N
2095	5	Rain instantaneous	Holding Register	40104	32-bit float	\N	in	1	\N	\N	\N	\N	\N	\N	\N
2096	5	Rain intensity	Holding Register	40105	32-bit float	\N	in/hr	1	\N	\N	\N	\N	\N	\N	\N
2097	5	Rain today	Holding Register	40106	32-bit float	\N	in/day	1	\N	\N	\N	\N	\N	\N	\N
2098	5	BOM temp 1	Holding Register	40107	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2099	5	BOM temp 2	Holding Register	40108	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2100	5	BOM temp 3	Holding Register	40109	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2101	5	Modeled GHI	Holding Register	40110	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2102	5	Modeled DHI	Holding Register	40111	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2103	5	Modeled DNI	Holding Register	40112	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2104	5	Modeled POA	Holding Register	40113	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2105	5	Summary alarm	Holding Register	40114	32-bit unsigned int	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2106	5	Data logger alarms register	Holding Register	40115	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2107	5	Data logger watchdog error	Holding Register	40116	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2108	5	Data logger skipped main scan	Holding Register	40117	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2109	5	Data logger skipped slow scan	Holding Register	40118	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2110	5	Data logger program variable out of bounds	Holding Register	40119	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2111	5	Data logger low 12V	Holding Register	40120	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2112	5	Data logger low 5V	Holding Register	40121	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2113	5	Data logger lithium battery error	Holding Register	40122	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2114	5	Data logger lithium battery low	Holding Register	40123	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2115	5	Data logger lithium battery critical	Holding Register	40124	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2116	5	Data logger voltage error	Holding Register	40125	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2117	5	Data logger low voltage warning	Holding Register	40126	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2118	5	Data logger low voltage	Holding Register	40127	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2119	5	Data logger over voltage	Holding Register	40128	Boolean	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2120	5	Data logger temperature error	Holding Register	40129	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2121	5	Data logger temperature below operating range	Holding Register	40130	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2122	5	Data logger temperature above operating range	Holding Register	40131	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2123	5	Battery alarms register	Holding Register	40132	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2124	5	Check battery	Holding Register	40133	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2125	5	Battery voltage error	Holding Register	40134	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2126	5	Low battery voltage warning	Holding Register	40135	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2127	5	Low battery voltage critical	Holding Register	40136	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2128	5	Low battery voltage deep discharge	Holding Register	40137	Boolean	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2129	5	Battery current error	Holding Register	40138	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2130	5	Excessive battery current warning	Holding Register	40139	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2131	5	Excessive battery current critical	Holding Register	40140	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2132	5	Charging alarms register	Holding Register	40141	32-bit unsigned int	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2133	5	Input voltage error	Holding Register	40142	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2134	5	Rpu enabled	Holding Register	40143	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2135	5	Input current error	Holding Register	40144	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2136	5	Excessive input current	Holding Register	40145	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2137	5	Load current error	Holding Register	40146	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2138	5	Excessive load current warning	Holding Register	40147	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2139	5	Excessive load current	Holding Register	40148	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2140	5	GHI 1 alarms register	Holding Register	40149	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2141	5	GHI 1 irradiance error	Holding Register	40150	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2142	5	GHI 1 irradiance negative	Holding Register	40151	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2143	5	GHI 1 irradiance above solar constant	Holding Register	40152	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2144	5	GHI 1 temperature corrected irradiance error	Holding Register	40153	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2145	5	GHI 1 temperature corrected irradiance negative	Holding Register	40154	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2146	5	GHI 1 temperature corrected irradiance above solar constant	Holding Register	40155	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2147	5	GHI 1 case temperature error	Holding Register	40156	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2148	5	GHI 1 case temperature below operating range	Holding Register	40157	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2149	5	GHI 1 case temperature above operating range	Holding Register	40158	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2150	5	POA alarms register	Holding Register	40159	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2151	5	POA irradiance error	Holding Register	40160	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2152	5	POA irradiance negative	Holding Register	40161	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2153	5	POA irradiance above solar constant	Holding Register	40162	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2154	5	POA temperature corrected irradiance error	Holding Register	40163	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2155	5	POA temperature corrected irradiance negative	Holding Register	40164	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2156	5	POA temperature corrected irradiance above solar constant	Holding Register	40165	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2157	5	POA case temperature error	Holding Register	40166	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2158	5	POA case temperature below operating range	Holding Register	40167	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2159	5	POA case temperature above operating range	Holding Register	40168	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2160	5	GHI 2 alarms register	Holding Register	40169	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2161	5	GHI 2 irradiance error	Holding Register	40170	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2162	5	GHI 2 irradiance negative	Holding Register	40171	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2163	5	GHI 2 irradiance above solar constant	Holding Register	40172	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2164	5	GHI 2 temperature corrected irradiance error	Holding Register	40173	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2165	5	GHI 2 temperature corrected irradiance negative	Holding Register	40174	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2166	5	GHI 2 temperature corrected irradiance above solar constant	Holding Register	40175	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2167	5	GHI 2 case temperature error	Holding Register	40176	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2168	5	GHI 2 case temperature below operating range	Holding Register	40177	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2169	5	GHI 2 case temperature above operating range	Holding Register	40178	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2170	5	Multifunction alarms register	Holding Register	40179	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2171	5	Ambient temperature error	Holding Register	40180	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2172	5	Ambient temperature below operating range	Holding Register	40181	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2173	5	Ambient temperature above operating range	Holding Register	40182	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2174	5	Dew point error	Holding Register	40183	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2175	5	Dew point above ambient temperature	Holding Register	40184	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2176	5	Condensation warning	Holding Register	40185	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2177	5	Relative humidity error	Holding Register	40186	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2178	5	Relative humidity below operating range	Holding Register	40187	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2179	5	Relative humidity above operating range	Holding Register	40188	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2180	5	Absolute barometric pressure error	Holding Register	40189	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2181	5	Absolute barometric pressure below operating range	Holding Register	40190	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2182	5	Absolute barometric pressure above operating range	Holding Register	40191	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2183	5	Sea level barometric pressure error	Holding Register	40192	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2184	5	Sea level barometric pressure below operating range	Holding Register	40193	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2185	5	Sea level barometric pressure above operating range	Holding Register	40194	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2186	5	Wind alarms register	Holding Register	40195	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2187	5	Wind speed error	Holding Register	40196	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2188	5	Wind speed below operating range	Holding Register	40197	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2189	5	Wind speed above operating range	Holding Register	40198	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2190	5	Wind speed unable to execute measurement due to ambient conditions	Holding Register	40199	Boolean	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2191	5	Wind speed quality warning	Holding Register	40200	Boolean	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2192	5	Wind speed quality error	Holding Register	40201	Boolean	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2193	5	Wind speed max error	Holding Register	40202	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2194	5	Wind speed max below operating range	Holding Register	40203	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2195	5	Wind speed max above operating range	Holding Register	40204	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2196	5	Wind direction error	Holding Register	40205	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2197	5	Wind direction below operating range	Holding Register	40206	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2198	5	Wind direction above operating range	Holding Register	40207	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2199	5	Compass error	Holding Register	40208	Boolean	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2200	5	Compass below operating range	Holding Register	40209	Boolean	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2201	5	Compass above operating range	Holding Register	40210	Boolean	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2202	5	Rain alarms regsiter	Holding Register	40211	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2203	5	Rain total error	Holding Register	40212	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2204	5	Rain total negative	Holding Register	40213	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2205	5	Rain total above operating range	Holding Register	40214	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2206	5	Rain intensity error	Holding Register	40215	Boolean	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2207	5	Rain intensity negative	Holding Register	40216	Boolean	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2208	5	Rain intensity above operating range	Holding Register	40217	Boolean	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2209	5	Rain today error	Holding Register	40218	Boolean	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2210	5	Rain today is negative	Holding Register	40219	Boolean	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2211	5	Rain today above operating range	Holding Register	40220	Boolean	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2212	5	BOM 1 alarm register	Holding Register	40221	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2213	5	BOM 1 temperature error	Holding Register	40222	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2214	5	BOM 1 temperature below operating range	Holding Register	40223	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2215	5	BOM 1 temperature above operating range	Holding Register	40224	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2216	5	BOM 2 alarm register	Holding Register	40225	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2217	5	BOM 2 temperature error	Holding Register	40226	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2218	5	BOM 2 temperature below operating range	Holding Register	40227	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2219	5	BOM 2 temperature above operating range	Holding Register	40228	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2220	5	BOM 3 alarm register	Holding Register	40229	32-bit unsigned int	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2221	5	BOM 3 temperature error	Holding Register	40230	Boolean	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2222	5	BOM 3 temperature below operating range	Holding Register	40231	Boolean	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2223	5	BOM 3 temperature above operating range	Holding Register	40232	Boolean	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2224	6	Scan count	Holding Register	40001	32-bit float	\N	s	1	\N	\N	\N	\N	\N	\N	\N
2225	6	Skipped scans	Holding Register	40003	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2226	6	Logger voltage	Holding Register	40005	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2227	6	Logger temp	Holding Register	40007	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2228	6	Skipped slow scans	Holding Register	40009	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2229	6	Logger lithium	Holding Register	40011	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2230	6	Logger low volt 12	Holding Register	40013	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2231	6	Solar zenith	Holding Register	40017	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2232	6	Solar elevation	Holding Register	40019	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2233	6	Solar azimuth	Holding Register	40021	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
2234	6	Logger data map version	Holding Register	40025	32-bit float	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2235	6	Maint event	Holding Register	40027	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Soiling Status:\n0 - Normal\n1 - Maintenance in last 24 hours\n2 - Normalization in last 5 minutes	\N
2236	6	ISC clean	Holding Register	40139	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2237	6	ISC soiled	Holding Register	40141	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2238	6	Daily soiling loss factor	Holding Register	40143	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
2239	6	Daily soiling ISC ratio	Holding Register	40145	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
2240	6	BOM temp clean	Holding Register	40147	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2241	6	BOM temp soiled	Holding Register	40149	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2242	6	Soiling loss factor	Holding Register	40151	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
2243	6	Soiling ISC ratio	Holding Register	40153	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
2244	6	ISC normalized soiled	Holding Register	40155	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2245	6	G clean	Holding Register	40157	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2246	6	G soiled	Holding Register	40159	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2247	6	Soiling status	Holding Register	40161	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Soiling Status:\n0 - Normal\n1 - Maintenance in last 24 hours\n2 - Normalization in last 5 minutes	\N
2248	6	Voc clean	Holding Register	40163	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2249	6	Voc soiled	Holding Register	40165	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2250	6	Hourly ISC clean avg	Holding Register	40289	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2251	6	Hourly ISC soiled avg	Holding Register	40291	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2252	6	Hourly ISC normalized soiled	Holding Register	40293	32-bit float	\N	A	1	\N	\N	\N	\N	\N	\N	\N
2253	6	Hourly BOM temp clean avg	Holding Register	40297	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2254	6	Hourly BOM temp soiled avg	Holding Register	40299	32-bit float	\N	DegC	1	\N	\N	\N	\N	\N	\N	\N
2255	6	Hourly soiling loss factor avg	Holding Register	40301	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
2256	6	Hourly soiling ISC ratio avg	Holding Register	40303	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
2257	6	Hourly G clean avg	Holding Register	40305	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2258	6	Hourly G soiled avg	Holding Register	40307	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
2259	6	Hourly VOC clean avg	Holding Register	40309	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2260	6	Hourly VOC soiled avg	Holding Register	40311	32-bit float	\N	V	1	\N	\N	\N	\N	\N	\N	\N
2261	6	Logger temp	Holding Register	40405	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2262	6	BOM temp clean	Holding Register	40545	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2263	6	BOM temp soiled	Holding Register	40547	32-bit float	\N	DegF	1	\N	\N	\N	\N	\N	\N	\N
2264	6	Daily soiling quality	Holding Register	40617	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
2265	6	Daily soiling age	Holding Register	40619	32-bit float	\N	days	1	\N	\N	\N	\N	\N	\N	\N
2266	7	Soiling Ratio Sensor 1	Input Register	30021	16-bit Unsigned Integer	\N	%	0.1	\N	\N	\N	\N	\N	\N	In steps of  0.1%; 9999 when not valid
2267	7	Transmission Loss Sensor 1	Input Register	30022	16-bit Signed Integer	\N	%	0.1	\N	\N	\N	\N	\N	\N	In steps of  0.1%; 9999 when not valid
2268	7	Soiling Ratio Sensor 2	Input Register	30025	16-bit Unsigned Integer	\N	%	0.1	\N	\N	\N	\N	\N	\N	In steps of  0.1%; 9999 when not valid
2269	7	Transmission Loss Sensor 2	Input Register	30026	16-bit Signed Integer	\N	%	0.1	\N	\N	\N	\N	\N	\N	In steps of  0.1%; 9999 when not valid
2270	7	Tilt X Direction ( Long Axis)	Input Register	30029	16-bit Signed Integer	\N	Degrees	0.1	\N	\N	\N	\N	\N	\N	In steps of 0.1 degrees
2271	7	Tilt Y Direction (Short Axis)	Input Register	30030	16-bit Signed Integer	\N	Degrees	0.1	\N	\N	\N	\N	\N	\N	In steps of 0.1 degrees
2272	7	Back Panel Temperature 	Input Register	30032	16-bit Unsigned Integer	\N	Deg K	0.1	\N	\N	\N	\N	\N	\N	In steps 0.1 Kelvin
2273	7	Device Voltage	Input Register	30033	16-bit Unsigned Integer	\N	mV	1	\N	\N	\N	\N	\N	\N	Device voltage at the input connector
2274	7	Operational Mode	Input Register	30034	16-bit Unsigned Integer	\N	degrees	1	\N	\N	\N	\N	\N	Normal = 1; Service = 2; Calibration = 3	\N
2275	7	Device Status Flags	Input Register	30035	16-bit Unsigned Integer	\N	degrees	1	\N	\N	\N	\N	\N	0 = Status OK	\N
2276	8	Scan count	Holding Register	40001	32-bit float	\N	Sec	1	\N	\N	\N	\N	\N	\N	\N
2277	8	Skipped scans	Holding Register	40003	32-bit float	\N	Count	1	\N	\N	\N	\N	\N	\N	\N
2278	8	Logger voltage	Holding Register	40005	32-bit float	\N	Volts DC	1	\N	\N	\N	\N	\N	\N	\N
2279	8	Logger temp	Holding Register	40007	32-bit float	\N	Deg C	1	\N	\N	\N	\N	\N	\N	\N
2280	8	Skipped slow scans	Holding Register	40009	32-bit float	\N	Count	1	\N	\N	\N	\N	\N	\N	\N
2281	8	Logger lithium	Holding Register	40011	32-bit float	\N	Volts DC	1	\N	\N	\N	\N	\N	\N	\N
2282	8	Logger low volt 12	Holding Register	40013	32-bit float	\N	Count	1	\N	\N	\N	\N	\N	\N	\N
2283	8	Solar zenith	Holding Register	40017	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	Calculated using lat; lon; elevation; Temp; pressure
2284	8	Solar elevation	Holding Register	40019	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	Calculated using lat; lon; elevation; Temp; pressure
2285	8	Solar azimuth	Holding Register	40021	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	Calculated using lat; lon; elevation; Temp; pressure
2286	8	Pyranometer heaters on/off	Holding Register	40023	32-bit float	\N	Enumeration	1	\N	\N	\N	\N	\N	\N	 0 = Off; -1 = On.  Heat_State on only when vent fan is running
2287	8	Logger data map version	Holding Register	40025	32-bit float	\N	Unitless	1	\N	\N	\N	\N	\N	\N	\N
2288	8	Maint event	Holding Register	40027	32-bit float	\N	Boolean	1	\N	Maint ON	Maint OFF	\N	\N	\N	0 = nominal operation; 1 = maintenance button pushed in last five minutes
2289	8	Logger AC Power	Holding Register	40029	32-bit float	\N	Boolean	1	\N	Normal	Alarm	\N	\N	\N	0 = no AC power; 1 = AC power
2290	8	Battery Voltage	Holding Register	40031	32-bit float	\N	Volts DC	1	\N	\N	\N	\N	\N	\N	\N
2291	8	Battery Current	Holding Register	40033	32-bit float	\N	Amps	1	\N	\N	\N	\N	\N	\N	+ if battery charging; - if battery discharging
2292	8	Load Current	Holding Register	40035	32-bit float	\N	Amps	1	\N	\N	\N	\N	\N	\N	\N
2293	8	Solar Panel Voltage	Holding Register	40037	32-bit float	\N	Volts DC	1	\N	\N	\N	\N	\N	\N	When both inputs are utilized; the higher voltage power source will be selected
2294	8	Charge Source	Holding Register	40041	32-bit float	\N	Enumeration	1	\N	\N	\N	\N	\N	\N	0 = none; 1 = solar; 2 = AC/DC power supply
2295	8	Battery Status	Holding Register	40043	32-bit float	\N	Boolean	1	\N	Alarm	Normal	\N	\N	\N	0 = normal; 1 = check battery
2296	8	Power Supply Voltage	Holding Register	40045	32-bit float	\N	Volts DC	1	\N	\N	\N	\N	\N	\N	When both inputs are utilized; the higher voltage power source will be selected
2297	8	GHI	Holding Register	40053	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	Warning: not Temp-corrected
2298	8	GHI Temp Corr	Holding Register	40055	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	Most accurate irradiance value
2299	8	GHI Pyranometer Temp	Holding Register	40057	32-bit float	\N	Deg C	1	\N	\N	\N	\N	\N	\N	\N
2300	8	GHI Insolation	Holding Register	40177	32-bit float	\N	Wh/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	Previous 3-second scan total; divide by 1000 for kWh/mΓö¼Γûô
2301	8	GHI Humidity	Holding Register	40363	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	Used to detect desiccant failure
2302	8	Reserved reserved	Holding Register	40365	32-bit float	\N	Reserved	1	\N	\N	\N	\N	\N	\N	Reserved
2303	8	Pyranometer Single Axis Tilt	Holding Register	40367	32-bit float	\N	Degrees	1	\N	\N	\N	\N	\N	\N	Shows degrees from horizontal
2304	8	Pyranometer Fan Speed	Holding Register	40369	32-bit float	\N	RPM	1	\N	\N	\N	\N	\N	\N	\N
2305	8	Pyranometer Heater Current	Holding Register	40371	32-bit float	\N	mA	1	\N	\N	\N	\N	\N	\N	\N
2306	8	Logger temp	Holding Register	40405	32-bit float	\N	Deg F	1	\N	\N	\N	\N	\N	\N	\N
2307	8	Albedometer GHI	Holding Register	40597	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	Warning: not Temp-corrected.
2308	8	Albedometer GHI Temp Corr	Holding Register	40599	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	Most accurate irradiance value.
2309	8	Ablendometer GHI Temp	Holding Register	40601	32-bit float	\N	Deg C	1	\N	\N	\N	\N	\N	\N	\N
2310	8	Albedometer RHI	Holding Register	40603	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	Warning: not Temp-corrected.
2311	8	Albedometer RHI Temp Corr	Holding Register	40605	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	Most accurate irradiance value.
2312	8	Abledometer RHI Temp	Holding Register	40607	32-bit float	\N	Deg C	1	\N	\N	\N	\N	\N	\N	\N
2313	8	Albedo	Holding Register	40609	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	Calculated value: RHI_1 / GHI_1; See Daily_Albedo for filtered value
2314	8	Albedo Temp Corr	Holding Register	40611	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	Calculated value: RHI_TC_1 / GHI_TC_1; See Daily_Albedo for filtered value
2315	8	Daily Avg Albedo	Holding Register	40613	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	Avg of albedo values; solar noon Γö¼ΓûÆ30 minutes
2316	8	Daily Avg Albedo Temp Corr	Holding Register	40615	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	Avg of Temp-corrected albedo values; solar noon Γö¼ΓûÆ30 minutes
2317	8	Hourly Avg Abledometer GHI	Holding Register	40647	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2318	8	Hourly Avg Abledometer GHI Temp Corr	Holding Register	40649	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2319	8	Hourly Avg Albedometer GHI Temp	Holding Register	40651	32-bit float	\N	Deg C	1	\N	\N	\N	\N	\N	\N	\N
2320	8	Hourly Avg Albedometer RHI	Holding Register	40653	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2321	8	Hourly Avg Albedometer RHI Temp Corr	Holding Register	40655	32-bit float	\N	W/mΓö¼Γûô	1	\N	\N	\N	\N	\N	\N	\N
2322	8	Hourly Avg Albedometer RHI Temp	Holding Register	40657	32-bit float	\N	Deg C	1	\N	\N	\N	\N	\N	\N	\N
2323	8	Modeled GHI	Holding Register	40799	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	Ineichen Clear Sky Model**
2324	8	Modeled DHI	Holding Register	40801	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	Ineichen Clear Sky Model**
2325	8	Modeled DNI	Holding Register	40803	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	Ineichen Clear Sky Model**
2326	9	Irradiance temperature compensated	Holding Register	40003	32-bit signed integer	\N	w/m2	100	\N	\N	\N	\N	\N	\N	\N
2327	9	Irradiance	Holding Register	40005	32-bit signed integer	\N	w/m2	100	\N	\N	\N	\N	\N	\N	\N
2328	9	Case temperature	Holding Register	40007	16-bit signed integer	\N	DegC	100	\N	\N	\N	\N	\N	\N	\N
2329	9	Serial number	Holding Register	40041	16-bit unsigned integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2330	9	Calibration sensitivity	Holding Register	40042	32-bit float	\N	V / w/m2	1e-06	\N	\N	\N	\N	\N	\N	\N
2331	9	Calibration date	Holding Register	40047	32-bit float	\N	BCD	1	\N	\N	\N	\N	\N	\N	YYYYMMDD
2332	9	Humidity	Holding Register	40099	16-bit unsigned integer	\N	%	100	\N	\N	\N	\N	\N	\N	\N
2333	9	Tilt angle	Holding Register	40195	16-bit unsigned integer	\N	degrees	100	\N	\N	\N	\N	\N	\N	\N
2334	9	Fan speed	Holding Register	40197	16-bit unsigned integer	\N	RPM	1	\N	\N	\N	\N	\N	\N	\N
2335	9	Heater current	Holding Register	40200	16-bit unsigned integer	\N	A	0.001	\N	\N	\N	\N	\N	\N	\N
2336	10	Inv [n] status	Analog input	0	32-bit float	\N	enumeration	1	None	\N	\N	\N	\N	Inverter Status:\n0 - Not communicating\n1 - Fault\n2 - Stopped\n3 - Running\n	\N
2337	10	Inv [n] active power	Analog input	1	32-bit float	\N	kW	1	Analog	\N	\N	n/a;-10;3620;n/a	Out of Band	\N	\N
2338	10	Inv [n] reactive power	Analog input	2	32-bit float	\N	kvar	1	Analog	\N	\N	n/a;-2180;2180;n/a	Out of Band	\N	\N
2339	10	Inv [n] phase A current	Analog input	3	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2340	10	Inv [n] phase B current	Analog input	4	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2341	10	Inv [n] phase C current	Analog input	5	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2342	10	Inv [n] phase AB voltage	Analog input	6	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2343	10	Inv [n] phase BC voltage	Analog input	7	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2344	10	Inv [n] phase CA voltage	Analog input	8	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2345	10	Inv [n] power factor	Analog input	9	32-bit float	\N	PU	1	None	\N	\N	\N	\N	\N	\N
2346	10	Inv [n] frequency	Analog input	10	32-bit float	\N	Hz	1	None	\N	\N	\N	\N	\N	\N
2347	10	Inv [n] active power setpoint	Analog input	11	32-bit float	\N	kW	1	Analog	\N	\N	n/a;0;3600;n/a	Out of Band	\N	\N
2348	10	Inv [n] active power setpoint feedback	Analog input	12	32-bit float	\N	kW	1	Analog	\N	\N	AI_0010 +/- 1%	Not at Setpoint	\N	\N
2349	10	Inv [n] reactive power mode	Analog input	13	32-bit signed integer	\N	enumeration	1	State change	\N	\N	\N	\N	Reactive power mode:\n0 - OFF (unregulated unity PF)\n1 - Reactive output mode\n2 - Power factor mode\n3 - Voltage regulation\n98 - QU mode\n99 - QP mode	Q(U) and Q(P) modes are not used; but are defined
2350	10	Inv [n] reactive power mode feedback	Analog input	14	32-bit signed integer	\N	enumeration	1	Analog	\N	\N	AI_0012 +/- 1%	Not at Setpoint	Reactive power mode:\n0 - OFF (unregulated unity PF)\n1 - Reactive output mode\n2 - Power factor mode\n3 - Voltage regulation\n98 - QU mode\n99 - QP mode	Q(U) and Q(P) modes are not used; but are defined
2351	10	Inv [n] reactive power setpoint	Analog input	15	32-bit float	\N	kvar or PU 	1	Analog	\N	\N	-2160;-1;1;2160	5-State	\N	\N
2352	10	Inv [n] reactive power setpoint feedback	Analog input	16	32-bit float	\N	kvar or PU 	1	Analog	\N	\N	AI_0014 +/- 1%	Not at Setpoint	\N	\N
2353	10	Inv [n] total DC power	Analog input	17	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
2354	10	Inv [n] energy production today	Analog input	18	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2355	10	Inv [n] energy production yesterday	Analog input	19	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2356	10	Inv [n] total energy production	Analog input	20	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2357	10	Inv [n] total running hours	Analog input	21	32-bit float	\N	hr	1	None	\N	\N	\N	\N	\N	\N
2358	10	Inv [n] transformer oil temperature	Analog input	22	32-bit float	\N	degC	1	Analog	\N	\N	-40;-25;50;60	5-State	\N	\N
2424	10	Inv [n] unit 1 spare analog 04	Analog input	88	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2359	10	Inv [n] transformer winding temperature	Analog input	23	32-bit float	\N	degC	1	Analog	\N	\N	-40;-25;50;60	5-State	\N	\N
2360	10	Inv [n] maximum appearant power	Analog input	24	32-bit float	\N	kVA	1	Analog	\N	\N	n/a;3600;3600;n/a	Out of Band	\N	Real time derating
2361	10	Inv [n] maximum lagging reactive power	Analog input	25	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
2362	10	Inv [n] maximum leading reactive power	Analog input	26	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
2363	10	Inv [n] zone monitor status	Analog input	27	32-bit signed integer	\N	enumeration	1	None	\N	\N	\N	\N	Zone Monitor Work State:\n0: Disable\n1: Self-Study\n2: Fault Detection\n	\N
2364	10	Inv [n] spare analog 01	Analog input	28	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2365	10	Inv [n] spare analog 02	Analog input	29	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2366	10	Inv [n] spare analog 03	Analog input	30	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2367	10	Inv [n] spare analog 04	Analog input	31	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2368	10	Inv [n] spare analog 05	Analog input	32	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2369	10	Inv [n] spare analog 06	Analog input	33	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2370	10	Inv [n] spare analog 07	Analog input	34	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2371	10	Inv [n] spare analog 08	Analog input	35	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2372	10	Inv [n] spare analog 09	Analog input	36	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2373	10	Inv [n] spare analog 10	Analog input	37	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2374	10	Inv [n] unit 1 status	Analog input	38	32-bit float	\N	enumeration	1	None	\N	\N	\N	\N	Inverter Status:\n0 - Not communicating\n1 - Fault\n2 - Stopped\n3 - Running\n	\N
2375	10	Inv [n] unit 1 active power	Analog input	39	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
2376	10	Inv [n] unit 1 reactive power	Analog input	40	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
2377	10	Inv [n] unit 1 phase A current	Analog input	41	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2378	10	Inv [n] unit 1 phase B current	Analog input	42	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	True if any alarm is set for this inverter
2379	10	Inv [n] unit 1 phase C current	Analog input	43	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2380	10	Inv [n] unit 1 phase AB voltage	Analog input	44	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2381	10	Inv [n] unit 1 phase BC voltage	Analog input	45	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2382	10	Inv [n] unit 1 phase CA voltage	Analog input	46	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2383	10	Inv [n] unit 1 power factor	Analog input	47	32-bit float	\N	PU	1	None	\N	\N	\N	\N	\N	\N
2384	10	Inv [n] unit 1 frequency	Analog input	48	32-bit float	\N	Hz	1	None	\N	\N	\N	\N	\N	\N
2385	10	Inv [n] unit 1 DC power	Analog input	49	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
2386	10	Inv [n] unit 1 total DC current	Analog input	50	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2387	10	Inv [n] unit 1 DC voltage	Analog input	51	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2388	10	Inv [n] unit 1 energy production today	Analog input	52	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2389	10	Inv [n] unit 1 energy production yesterday	Analog input	53	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2390	10	Inv [n] unit 1 total energy production	Analog input	54	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2391	10	Inv [n] unit 1 total running hours	Analog input	55	32-bit float	\N	hr	1	None	\N	\N	\N	\N	\N	\N
2392	10	Inv [n] unit 1 internal module temperature	Analog input	56	32-bit float	\N	degC	1	Analog	\N	\N	-40;-25;50;60	5-State	\N	\N
2393	10	Inv [n] unit 1 yesterday grid connected minutes	Analog input	57	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
2394	10	Inv [n] unit 1 efficiency	Analog input	58	32-bit float	\N	%	1	None	\N	\N	\N	\N	\N	\N
2395	10	Inv [n] unit 1 positive resitance to ground	Analog input	59	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
2396	10	Inv [n] unit 1 negative resitance to ground	Analog input	60	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
2397	10	Inv [n] unit 1 negative voltage to ground	Analog input	61	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2398	10	Inv [n] unit 1 DC Input 1	Analog input	62	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2399	10	Inv [n] unit 1 DC Input 2	Analog input	63	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2400	10	Inv [n] unit 1 DC Input 3	Analog input	64	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2401	10	Inv [n] unit 1 DC Input 4	Analog input	65	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2402	10	Inv [n] unit 1 DC Input 5	Analog input	66	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2403	10	Inv [n] unit 1 DC Input 6	Analog input	67	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2404	10	Inv [n] unit 1 DC Input 7	Analog input	68	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2405	10	Inv [n] unit 1 DC Input 8	Analog input	69	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2406	10	Inv [n] unit 1 DC Input 9	Analog input	70	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2407	10	Inv [n] unit 1 DC Input 10	Analog input	71	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2408	10	Inv [n] unit 1 DC Input 11	Analog input	72	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2409	10	Inv [n] unit 1 DC Input 12	Analog input	73	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2410	10	Inv [n] unit 1 DC Input 13	Analog input	74	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2411	10	Inv [n] unit 1 DC Input 14	Analog input	75	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2412	10	Inv [n] unit 1 DC Input 15	Analog input	76	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2413	10	Inv [n] unit 1 DC Input 16	Analog input	77	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2414	10	Inv [n] unit 1 event recorder record count	Analog input	78	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
2415	10	Inv [n] unit 1 AC cabinet temperature	Analog input	79	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2416	10	Inv [n] unit 1 DC cabinet temperature	Analog input	80	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2417	10	Inv [n] unit 1 control cabinet temperature	Analog input	81	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2418	10	Inv [n] unit 1 busbar temperature	Analog input	82	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2419	10	Inv [n] unit 1 module cabinet temperature	Analog input	83	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2420	10	Inv [n] unit 1 reactor cabinet temperature	Analog input	84	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2421	10	Inv [n] unit 1 spare analog 01	Analog input	85	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2422	10	Inv [n] unit 1 spare analog 02	Analog input	86	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2423	10	Inv [n] unit 1 spare analog 03	Analog input	87	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2425	10	Inv [n] unit 1 spare analog 05	Analog input	89	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2426	10	Inv [n] unit 1 spare analog 06	Analog input	90	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2427	10	Inv [n] unit 1 spare analog 07	Analog input	91	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2428	10	Inv [n] unit 1 spare analog 08	Analog input	92	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2429	10	Inv [n] unit 1 spare analog 09	Analog input	93	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2430	10	Inv [n] unit 1 spare analog 10	Analog input	94	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2431	10	Inv [n] unit 2 status	Analog input	95	32-bit float	\N	enumeration	1	None	\N	\N	\N	\N	Inverter Status:\n0 - Not communicating\n1 - Fault\n2 - Stopped\n3 - Running\n	\N
2432	10	Inv [n] unit 2 active power	Analog input	96	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
2433	10	Inv [n] unit 2 reactive power	Analog input	97	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
2434	10	Inv [n] unit 2 phase A current	Analog input	98	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2435	10	Inv [n] unit 2 phase B current	Analog input	99	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2436	10	Inv [n] unit 2 phase C current	Analog input	100	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2437	10	Inv [n] unit 2 phase AB voltage	Analog input	101	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2438	10	Inv [n] unit 2 phase BC voltage	Analog input	102	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2439	10	Inv [n] unit 2 phase CA voltage	Analog input	103	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2440	10	Inv [n] unit 2 power factor	Analog input	104	32-bit float	\N	PU	1	None	\N	\N	\N	\N	\N	\N
2441	10	Inv [n] unit 2 frequency	Analog input	105	32-bit float	\N	Hz	1	None	\N	\N	\N	\N	\N	\N
2442	10	Inv [n] unit 2 DC power	Analog input	106	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
2443	10	Inv [n] unit 2 total DC current	Analog input	107	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2444	10	Inv [n] unit 2 DC voltage	Analog input	108	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2445	10	Inv [n] unit 2 energy production today	Analog input	109	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2446	10	Inv [n] unit 2 energy production yesterday	Analog input	110	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2447	10	Inv [n] unit 2 total energy production	Analog input	111	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2448	10	Inv [n] unit 2 total running hours	Analog input	112	32-bit float	\N	hr	1	None	\N	\N	\N	\N	\N	\N
2449	10	Inv [n] unit 2 internal module temperature	Analog input	113	32-bit float	\N	degC	1	Analog	\N	\N	-40;-25;50;60	5-State	\N	\N
2450	10	Inv [n] unit 2 yesterday grid connected minutes	Analog input	114	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
2451	10	Inv [n] unit 2 efficiency	Analog input	115	32-bit float	\N	%	1	None	\N	\N	\N	\N	\N	\N
2452	10	Inv [n] unit 2 positive resitance to ground	Analog input	116	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
2453	10	Inv [n] unit 2 negative resitance to ground	Analog input	117	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
2454	10	Inv [n] unit 2 negative voltage to ground	Analog input	118	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2455	10	Inv [n] unit 2 DC Input 1	Analog input	119	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2456	10	Inv [n] unit 2 DC Input 2	Analog input	120	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2457	10	Inv [n] unit 2 DC Input 3	Analog input	121	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2458	10	Inv [n] unit 2 DC Input 4	Analog input	122	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2459	10	Inv [n] unit 2 DC Input 5	Analog input	123	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2460	10	Inv [n] unit 2 DC Input 6	Analog input	124	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2461	10	Inv [n] unit 2 DC Input 7	Analog input	125	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2462	10	Inv [n] unit 2 DC Input 8	Analog input	126	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2463	10	Inv [n] unit 2 DC Input 9	Analog input	127	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2464	10	Inv [n] unit 2 DC Input 10	Analog input	128	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2465	10	Inv [n] unit 2 DC Input 11	Analog input	129	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2466	10	Inv [n] unit 2 DC Input 12	Analog input	130	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2467	10	Inv [n] unit 2 DC Input 13	Analog input	131	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2468	10	Inv [n] unit 2 DC Input 14	Analog input	132	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2469	10	Inv [n] unit 2 DC Input 15	Analog input	133	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2470	10	Inv [n] unit 2 DC Input 16	Analog input	134	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2471	10	Inv [n] unit 2 event recorder record count	Analog input	135	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
2472	10	Inv [n] unit 2 AC cabinet temperature	Analog input	136	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2473	10	Inv [n] unit 2 DC cabinet temperature	Analog input	137	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2474	10	Inv [n] unit 2 control cabinet temperature	Analog input	138	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2475	10	Inv [n] unit 2 busbar temperature	Analog input	139	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2476	10	Inv [n] unit 2 module cabinet temperature	Analog input	140	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2477	10	Inv [n] unit 2 reactor cabinet temperature	Analog input	141	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
2478	10	Inv [n] unit 2 spare analog 01	Analog input	142	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2479	10	Inv [n] unit 2 spare analog 02	Analog input	143	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2480	10	Inv [n] unit 2 spare analog 03	Analog input	144	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2481	10	Inv [n] unit 2 spare analog 04	Analog input	145	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2482	10	Inv [n] unit 2 spare analog 05	Analog input	146	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2483	10	Inv [n] unit 2 spare analog 06	Analog input	147	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2484	10	Inv [n] unit 2 spare analog 07	Analog input	148	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2485	10	Inv [n] unit 2 spare analog 08	Analog input	149	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2486	10	Inv [n] unit 2 spare analog 09	Analog input	150	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2487	10	Inv [n] unit 2 spare analog 10	Analog input	151	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2488	10	Inv [n] zone monitor unit 1 warning number of strings branch 1	Analog input	152	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2489	10	Inv [n] zone monitor unit 1 warning number of strings branch 2	Analog input	153	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2490	10	Inv [n] zone monitor unit 1 warning number of strings branch 3	Analog input	154	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2491	10	Inv [n] zone monitor unit 1 warning number of strings branch 4	Analog input	155	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2492	10	Inv [n] zone monitor unit 1 warning number of strings branch 5	Analog input	156	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2493	10	Inv [n] zone monitor unit 1 warning number of strings branch 6	Analog input	157	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2494	10	Inv [n] zone monitor unit 1 warning number of strings branch 7	Analog input	158	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2495	10	Inv [n] zone monitor unit 1 warning number of strings branch 8	Analog input	159	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2496	10	Inv [n] zone monitor unit 1 warning number of strings branch 9	Analog input	160	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2497	10	Inv [n] zone monitor unit 1 warning number of strings branch 10	Analog input	161	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2498	10	Inv [n] zone monitor unit 1 warning number of strings branch 11	Analog input	162	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2499	10	Inv [n] zone monitor unit 1 warning number of strings branch 12	Analog input	163	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2500	10	Inv [n] zone monitor unit 1 warning number of strings branch 13	Analog input	164	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2501	10	Inv [n] zone monitor unit 1 warning number of strings branch 14	Analog input	165	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2502	10	Inv [n] zone monitor unit 1 warning number of strings branch 15	Analog input	166	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2503	10	Inv [n] zone monitor unit 1 warning number of strings branch 16	Analog input	167	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2504	10	Inv [n] zone monitor unit 2 warning number of strings branch 1	Analog input	168	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2505	10	Inv [n] zone monitor unit 2 warning number of strings branch 2	Analog input	169	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2506	10	Inv [n] zone monitor unit 2 warning number of strings branch 3	Analog input	170	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2507	10	Inv [n] zone monitor unit 2 warning number of strings branch 4	Analog input	171	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2508	10	Inv [n] zone monitor unit 2 warning number of strings branch 5	Analog input	172	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2509	10	Inv [n] zone monitor unit 2 warning number of strings branch 6	Analog input	173	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2510	10	Inv [n] zone monitor unit 2 warning number of strings branch 7	Analog input	174	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2511	10	Inv [n] zone monitor unit 2 warning number of strings branch 8	Analog input	175	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2512	10	Inv [n] zone monitor unit 2 warning number of strings branch 9	Analog input	176	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2513	10	Inv [n] zone monitor unit 2 warning number of strings branch 10	Analog input	177	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2514	10	Inv [n] zone monitor unit 2 warning number of strings branch 11	Analog input	178	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2515	10	Inv [n] zone monitor unit 2 warning number of strings branch 12	Analog input	179	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2516	10	Inv [n] zone monitor unit 2 warning number of strings branch 13	Analog input	180	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2517	10	Inv [n] zone monitor unit 2 warning number of strings branch 14	Analog input	181	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2518	10	Inv [n] zone monitor unit 2 warning number of strings branch 15	Analog input	182	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2519	10	Inv [n] zone monitor unit 2 warning number of strings branch 16	Analog input	183	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2520	10	Inv [n] status	Counter	0	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2521	10	Inv [n] circuit breaker status	Counter	0	32-bit bitfield	0	\N	\N	None	Open	Closed	\N	\N	\N	\N
2522	10	Inv [n] disconnector status	Counter	0	32-bit bitfield	1	\N	\N	None	Open	Closed	\N	\N	\N	\N
2523	10	Inv [n] MV load switch status	Counter	0	32-bit bitfield	2	\N	\N	None	Closed	Open	\N	\N	\N	\N
2524	10	Inv [n] HV local remote switch status	Counter	0	32-bit bitfield	3	\N	\N	On (1)	Local	Remote	\N	\N	\N	\N
2525	10	Inv [n] running	Counter	0	32-bit bitfield	4	\N	\N	None	Running	Stopped	\N	\N	\N	\N
2526	10	Inv [n] stopped	Counter	0	32-bit bitfield	5	\N	\N	None	Stopped	Running	\N	\N	\N	\N
2527	10	Inv [n] unit 1 status	Counter	1	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2528	10	Inv [n] unit 1 load switch status	Counter	1	32-bit bitfield	0	\N	\N	None	Open	Closed	\N	\N	\N	\N
2529	10	Inv [n] unit 1 circuit breaker status	Counter	1	32-bit bitfield	1	\N	\N	None	Closed	Open	\N	\N	\N	\N
2530	10	Inv [n] unit 1 main contactor status	Counter	1	32-bit bitfield	2	\N	\N	None	Closed	Open	\N	\N	\N	\N
2531	10	Inv [n] unit 1 SPD status	Counter	1	32-bit bitfield	3	\N	\N	None	Closed	Open	\N	\N	\N	\N
2532	10	Inv [n] unit 1 DC switch 1 status	Counter	1	32-bit bitfield	4	\N	\N	None	Closed	Open	\N	\N	\N	\N
2533	10	Inv [n] unit 1 DC switch 2 status	Counter	1	32-bit bitfield	5	\N	\N	None	Closed	Open	\N	\N	\N	\N
2534	10	Inv [n] unit 1 DC switch 3 status	Counter	1	32-bit bitfield	6	\N	\N	None	Closed	Open	\N	\N	\N	\N
2535	10	Inv [n] unit 1 DC switch 4 status	Counter	1	32-bit bitfield	7	\N	\N	None	Closed	Open	\N	\N	\N	\N
2536	10	Inv [n] unit 1 running	Counter	1	32-bit bitfield	8	\N	\N	None	Running	Not Running	\N	\N	\N	\N
2537	10	Inv [n] unit 1 stopped	Counter	1	32-bit bitfield	9	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
2538	10	Inv [n] unit 1 initial standby	Counter	1	32-bit bitfield	10	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
2539	10	Inv [n] unit 1 key stop	Counter	1	32-bit bitfield	11	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
2540	10	Inv [n] unit 1 standby	Counter	1	32-bit bitfield	12	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
2541	10	Inv [n] unit 1 emergency stop	Counter	1	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2542	10	Inv [n] unit 1 starting	Counter	1	32-bit bitfield	14	\N	\N	None	Starting	Not Starting	\N	\N	\N	\N
2543	10	Inv [n] unit 1 stopping	Counter	1	32-bit bitfield	15	\N	\N	None	Stopping	Not Stopping	\N	\N	\N	\N
2544	10	Inv [n] unit 1 fault stop	Counter	1	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2545	10	Inv [n] unit 1 alarm running	Counter	1	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2546	10	Inv [n] unit 1 derating running	Counter	1	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2547	10	Inv [n] unit 1 inverter is running	Counter	1	32-bit bitfield	19	\N	\N	None	Running	Not Running	\N	\N	\N	\N
2548	10	Inv [n] unit 1 inverter is stopped	Counter	1	32-bit bitfield	20	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
2549	10	Inv [n] unit 1 anti PID active	Counter	1	32-bit bitfield	21	\N	\N	None	Active	Not-Active	\N	\N	\N	\N
2550	10	Inv [n] unit 1 ABC local remote status	Counter	1	32-bit bitfield	22	\N	\N	Off (0)	Remote	Local	\N	\N	\N	\N
2551	10	Inv [n] unit 2 status	Counter	2	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2552	10	Inv [n] unit 2 load switch status	Counter	2	32-bit bitfield	0	\N	\N	None	Open	Closed	\N	\N	\N	\N
2553	10	Inv [n] unit 2 circuit breaker status	Counter	2	32-bit bitfield	1	\N	\N	None	Closed	Open	\N	\N	\N	\N
2554	10	Inv [n] unit 2 main contactor status	Counter	2	32-bit bitfield	2	\N	\N	None	Closed	Open	\N	\N	\N	\N
2555	10	Inv [n] unit 2 SPD status	Counter	2	32-bit bitfield	3	\N	\N	None	Closed	Open	\N	\N	\N	\N
2556	10	Inv [n] unit 2 DC switch 1 status	Counter	2	32-bit bitfield	4	\N	\N	None	Closed	Open	\N	\N	\N	\N
2557	10	Inv [n] unit 2 DC switch 2 status	Counter	2	32-bit bitfield	5	\N	\N	None	Closed	Open	\N	\N	\N	\N
2558	10	Inv [n] unit 2 DC switch 3 status	Counter	2	32-bit bitfield	6	\N	\N	None	Closed	Open	\N	\N	\N	\N
2559	10	Inv [n] unit 2 DC switch 4 status	Counter	2	32-bit bitfield	7	\N	\N	None	Closed	Open	\N	\N	\N	\N
2560	10	Inv [n] unit 2 running	Counter	2	32-bit bitfield	8	\N	\N	None	Running	Not Running	\N	\N	\N	\N
2561	10	Inv [n] unit 2 stopped	Counter	2	32-bit bitfield	9	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
2562	10	Inv [n] unit 2 initial standby	Counter	2	32-bit bitfield	10	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
2563	10	Inv [n] unit 2 key stop	Counter	2	32-bit bitfield	11	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
2564	10	Inv [n] unit 2 standby	Counter	2	32-bit bitfield	12	\N	\N	None	Standby	Not Standby	\N	\N	\N	\N
2565	10	Inv [n] unit 2 emergency stop	Counter	2	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2566	10	Inv [n] unit 2 starting	Counter	2	32-bit bitfield	14	\N	\N	None	Starting	Not Starting	\N	\N	\N	\N
2567	10	Inv [n] unit 2 stopping	Counter	2	32-bit bitfield	15	\N	\N	None	Stopping	Not Stopping	\N	\N	\N	\N
2568	10	Inv [n] unit 2 fault stop	Counter	2	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2569	10	Inv [n] unit 2 alarm running	Counter	2	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2570	10	Inv [n] unit 2 derating running	Counter	2	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2571	10	Inv [n] unit 2 inverter is running	Counter	2	32-bit bitfield	19	\N	\N	None	Running	Not Running	\N	\N	\N	\N
2572	10	Inv [n] unit 2 inverter is stopped	Counter	2	32-bit bitfield	20	\N	\N	None	Stopped	Not Stopped	\N	\N	\N	\N
2573	10	Inv [n] unit 2 anti PID active	Counter	2	32-bit bitfield	21	\N	\N	None	Active	Not-Active	\N	\N	\N	\N
2574	10	Inv [n] unit 2 ABC local remote status	Counter	2	32-bit bitfield	22	\N	\N	Off (0)	Remote	Local	\N	\N	\N	\N
2575	10	Inv [n] alarms	Counter	3	32-bit bitfield	\N	\N	\N	None	\N	\N	\N	\N	\N	\N
2576	10	Inv [n] overcurrent protection trip	Counter	3	32-bit bitfield	0	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2577	10	Inv [n] external emergency stop overall	Counter	3	32-bit bitfield	1	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2578	10	Inv [n] remote emergency stop	Counter	3	32-bit bitfield	2	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2579	10	Inv [n] local emergency stop	Counter	3	32-bit bitfield	3	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2580	10	Inv [n] external emergency stop mv node	Counter	3	32-bit bitfield	4	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2581	10	Inv [n] door opening protection	Counter	3	32-bit bitfield	5	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2582	10	Inv [n] smoke alarm trip	Counter	3	32-bit bitfield	6	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2583	10	Inv [n] HV compartment door open	Counter	3	32-bit bitfield	7	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2584	10	Inv [n] SF6 low pressure	Counter	3	32-bit bitfield	8	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2585	10	Inv [n] MV fuse failure	Counter	3	32-bit bitfield	9	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2586	10	Inv [n] HV compartment smoke alarm	Counter	3	32-bit bitfield	10	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2587	10	Inv [n] smoke sensor abnormal	Counter	3	32-bit bitfield	11	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2588	10	Inv [n] temperature sensor abnormal	Counter	3	32-bit bitfield	12	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2589	10	Inv [n] HV remote trip	Counter	3	32-bit bitfield	13	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2590	10	Inv [n] UPS fault	Counter	3	32-bit bitfield	14	\N	\N	On (1)	Tripped	Normal	\N	\N	\N	\N
2591	10	Inv [n] transformer alarms	Counter	4	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2592	10	Inv [n] transformer gas buildup alarm	Counter	4	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2593	10	Inv [n] transformer gas buildup trip	Counter	4	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2594	10	Inv [n] transformer oil temperature alarm	Counter	4	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2595	10	Inv [n] transformer oil temperature trip	Counter	4	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2596	10	Inv [n] transformer low oil level alarm	Counter	4	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2597	10	Inv [n] transformer low oil level trip	Counter	4	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2598	10	Inv [n] transformer high oil level alarm	Counter	4	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2599	10	Inv [n] transformer pressure relief valve alarm	Counter	4	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2600	10	Inv [n] transformer pressure relief valve trip	Counter	4	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2601	10	Inv [n] transformer compartment door alarm	Counter	4	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2602	10	Inv [n] transformer compartment smoke alarm	Counter	4	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2603	10	Inv [n] unit 1 transformer over temperature alarm	Counter	4	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2604	10	Inv [n] unit 2 transformer over temperature alarm	Counter	4	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2605	10	Inv [n] unit 1 alarms 1	Counter	5	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2606	10	Inv [n] unit 1 AC current imballance	Counter	5	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2607	10	Inv [n] unit 1 AC fuse fault	Counter	5	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2608	10	Inv [n] unit 1 AC leakage current protection alarm	Counter	5	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2609	10	Inv [n] unit 1 AC overcurrent	Counter	5	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2610	10	Inv [n] unit 1 AC overvoltage alarm	Counter	5	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2611	10	Inv [n] unit 1 AC SPD fault	Counter	5	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2612	10	Inv [n] unit 1 AC SPD fault	Counter	5	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2613	10	Inv [n] unit 1 AC undervoltage alarm	Counter	5	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2614	10	Inv [n] unit 1 Anti islanding protection active	Counter	5	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2615	10	Inv [n] unit 1 Bus overvoltage	Counter	5	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2616	10	Inv [n] unit 1 Bus undervoltage	Counter	5	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2617	10	Inv [n] unit 1 CT unbalance	Counter	5	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2618	10	Inv [n] unit 1 Frequency abnormal	Counter	5	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2619	10	Inv [n] unit 1 Frequency abnormal	Counter	5	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2620	10	Inv [n] unit 1 Frequency deviation active power regulation	Counter	5	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2621	10	Inv [n] unit 1 Grid voltage imballance	Counter	5	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2622	10	Inv [n] unit 1 Overfrequency alarm	Counter	5	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2623	10	Inv [n] unit 1 Underfrequency alarm	Counter	5	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2624	10	Inv [n] unit 1 Sampling fault	Counter	5	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2625	10	Inv [n] unit 1 Voltage deviation reactive power regulation	Counter	5	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2626	10	Inv [n] unit 1 Current unbalance 2	Counter	5	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2627	10	Inv [n] unit 1 Current unbalance 3	Counter	5	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2628	10	Inv [n] unit 1 DC bypass forward overcurrent alarm	Counter	5	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2629	10	Inv [n] unit 1 DC bypass reverse overcurrent alarm	Counter	5	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2630	10	Inv [n] unit 1 DC fuse failure	Counter	5	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2631	10	Inv [n] unit 1 DC fuse failure	Counter	5	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2632	10	Inv [n] unit 1 DC fuse grounding fault	Counter	5	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2633	10	Inv [n] unit 1 DC injection fault	Counter	5	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2634	10	Inv [n] unit 1 DC leakage current protection alarm	Counter	5	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2635	10	Inv [n] unit 1 DC overcurrent	Counter	5	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2636	10	Inv [n] unit 1 DC overvoltage alarm	Counter	5	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2637	10	Inv [n] unit 1 DC polarity reversed alarm	Counter	5	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2638	10	Inv [n] unit 1 alarms 2	Counter	6	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2639	10	Inv [n] unit 1 DC sensor fault	Counter	6	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2640	10	Inv [n] unit 1 DC SPD fault	Counter	6	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2641	10	Inv [n] unit 1 DC SPD fault	Counter	6	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2642	10	Inv [n] unit 1 DC switch fault	Counter	6	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2643	10	Inv [n] unit 1 DC undervoltage alarm	Counter	6	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2644	10	Inv [n] unit 1 Detection fuse failure	Counter	6	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2645	10	Inv [n] unit 1 Insulation impedance fault	Counter	6	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2646	10	Inv [n] unit 1 Inverter overvoltage	Counter	6	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2647	10	Inv [n] unit 1 Low insulation resistance alarm	Counter	6	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2648	10	Inv [n] unit 1 Neutral point potential shift alarm	Counter	6	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2649	10	Inv [n] unit 1 Temperature abnormal	Counter	6	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2650	10	Inv [n] unit 1 Temperature alarm	Counter	6	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2651	10	Inv [n] unit 1 AC cabinet temperature alarm	Counter	6	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2652	10	Inv [n] unit 1 DC cabinet temperature alarm	Counter	6	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2653	10	Inv [n] unit 1 Control cabinet temperature alarm	Counter	6	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2654	10	Inv [n] unit 1 Busbar temperature alarm	Counter	6	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2655	10	Inv [n] unit 1 Module overtemperature alarm	Counter	6	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2656	10	Inv [n] unit 1 Reactor overtemperature alarm	Counter	6	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2657	10	Inv [n] unit 1 AC circuit breaker fault	Counter	6	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2658	10	Inv [n] unit 1 Bypass circuit breaker fault	Counter	6	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2659	10	Inv [n] unit 1 AC switch fault	Counter	6	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2660	10	Inv [n] unit 1 AC switch disconnection	Counter	6	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2661	10	Inv [n] unit 1 DC switch fault	Counter	6	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2662	10	Inv [n] unit 1 Buffer contactor fault	Counter	6	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2663	10	Inv [n] unit 1 Contactor fault	Counter	6	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2664	10	Inv [n] unit 1 Contactor contact fault	Counter	6	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2665	10	Inv [n] unit 1 Anti-PID power supply	Counter	6	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2666	10	Inv [n] unit 1 Backup power supply fault	Counter	6	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2667	10	Inv [n] unit 1 Control power supply fault	Counter	6	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2668	10	Inv [n] unit 1 Bypass fuse abnormal / branch fault	Counter	6	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2669	10	Inv [n] unit 1 Ground fuse fault	Counter	6	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2670	10	Inv [n] unit 1 Abnormal derating of fan	Counter	6	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2671	10	Inv [n] unit 1 alarms 3	Counter	7	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2672	10	Inv [n] unit 1 Fan fault	Counter	7	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2673	10	Inv [n] unit 1 Fan fault	Counter	7	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2674	10	Inv [n] unit 1 Fan 2 fault	Counter	7	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2675	10	Inv [n] unit 1 Fan 2 fault	Counter	7	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2676	10	Inv [n] unit 1 Grounding fault	Counter	7	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2677	10	Inv [n] unit 1 Drive board fault	Counter	7	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2678	10	Inv [n] unit 1 Hardware fault	Counter	7	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2679	10	Inv [n] unit 1 Insulation impedance sensor fault	Counter	7	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2680	10	Inv [n] unit 1 Sensor failure	Counter	7	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2681	10	Inv [n] unit 1 Temperature and humidity sensor fault	Counter	7	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2682	10	Inv [n] unit 1 DC voltage sampling fault	Counter	7	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2683	10	Inv [n] unit 1 Soft start fault	Counter	7	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2684	10	Inv [n] unit 1 DSP-MDC communication failure	Counter	7	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2685	10	Inv [n] unit 1 IO-DSP communication failure	Counter	7	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2686	10	Inv [n] unit 1 IO-MDC communication abnormal	Counter	7	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2687	10	Inv [n] unit 1 Meter communication failure	Counter	7	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2688	10	Inv [n] unit 1 Parallel operation communication failure	Counter	7	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2689	10	Inv [n] unit 1 Tributary board communication failure	Counter	7	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2690	10	Inv [n] unit 1 ABC fault	Counter	7	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2691	10	Inv [n] unit 1 Carrier sync failure	Counter	7	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2692	10	Inv [n] unit 1 Device code repeat fault	Counter	7	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2693	10	Inv [n] unit 1 External power supply fault	Counter	7	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2694	10	Inv [n] unit 1 GFDI protection active	Counter	7	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2695	10	Inv [n] unit 1 GFRT operation alarm	Counter	7	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2696	10	Inv [n] unit 1 Overload protection active	Counter	7	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2697	10	Inv [n] unit 1 PDP protection active	Counter	7	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2698	10	Inv [n] unit 1 Reversed branch over current	Counter	7	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2699	10	Inv [n] unit 2 alarms 1	Counter	8	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2700	10	Inv [n] unit 2 AC current imballance	Counter	8	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2701	10	Inv [n] unit 2 AC fuse fault	Counter	8	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2702	10	Inv [n] unit 2 AC leakage current protection alarm	Counter	8	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2703	10	Inv [n] unit 2 AC overcurrent	Counter	8	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2704	10	Inv [n] unit 2 AC overvoltage alarm	Counter	8	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2705	10	Inv [n] unit 2 AC SPD fault	Counter	8	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2706	10	Inv [n] unit 2 AC SPD fault	Counter	8	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2707	10	Inv [n] unit 2 AC undervoltage alarm	Counter	8	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2708	10	Inv [n] unit 2 Anti islanding protection active	Counter	8	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2709	10	Inv [n] unit 2 Bus overvoltage	Counter	8	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2710	10	Inv [n] unit 2 Bus undervoltage	Counter	8	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2711	10	Inv [n] unit 2 CT unbalance	Counter	8	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2712	10	Inv [n] unit 2 Frequency abnormal	Counter	8	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2713	10	Inv [n] unit 2 Frequency abnormal	Counter	8	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2714	10	Inv [n] unit 2 Frequency deviation active power regulation	Counter	8	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2715	10	Inv [n] unit 2 Grid voltage imballance	Counter	8	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2716	10	Inv [n] unit 2 Overfrequency alarm	Counter	8	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2717	10	Inv [n] unit 2 Underfrequency alarm	Counter	8	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2718	10	Inv [n] unit 2 Sampling fault	Counter	8	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2719	10	Inv [n] unit 2 Voltage deviation reactive power regulation	Counter	8	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2720	10	Inv [n] unit 2 Current unbalance 2	Counter	8	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2721	10	Inv [n] unit 2 Current unbalance 3	Counter	8	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2722	10	Inv [n] unit 2 DC bypass forward overcurrent alarm	Counter	8	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2723	10	Inv [n] unit 2 DC bypass reverse overcurrent alarm	Counter	8	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2724	10	Inv [n] unit 2 DC fuse failure	Counter	8	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2725	10	Inv [n] unit 2 DC fuse failure	Counter	8	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2726	10	Inv [n] unit 2 DC fuse grounding fault	Counter	8	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2727	10	Inv [n] unit 2 DC injection fault	Counter	8	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2728	10	Inv [n] unit 2 DC leakage current protection alarm	Counter	8	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2729	10	Inv [n] unit 2 DC overcurrent	Counter	8	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2730	10	Inv [n] unit 2 DC overvoltage alarm	Counter	8	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2731	10	Inv [n] unit 2 DC polarity reversed alarm	Counter	8	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2732	10	Inv [n] unit 2 alarms 2	Counter	9	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2733	10	Inv [n] unit 2 DC sensor fault	Counter	9	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2734	10	Inv [n] unit 2 DC SPD fault	Counter	9	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2735	10	Inv [n] unit 2 DC SPD fault	Counter	9	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2736	10	Inv [n] unit 2 DC switch fault	Counter	9	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2737	10	Inv [n] unit 2 DC undervoltage alarm	Counter	9	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2738	10	Inv [n] unit 2 Detection fuse failure	Counter	9	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2739	10	Inv [n] unit 2 Insulation impedance fault	Counter	9	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2740	10	Inv [n] unit 2 Inverter overvoltage	Counter	9	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2741	10	Inv [n] unit 2 Low insulation resistance alarm	Counter	9	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2742	10	Inv [n] unit 2 Neutral point potential shift alarm	Counter	9	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2743	10	Inv [n] unit 2 Temperature abnormal	Counter	9	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2744	10	Inv [n] unit 2 Temperature alarm	Counter	9	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2745	10	Inv [n] unit 2 AC cabinet temperature alarm	Counter	9	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2746	10	Inv [n] unit 2 DC cabinet temperature alarm	Counter	9	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2747	10	Inv [n] unit 2 Control cabinet temperature alarm	Counter	9	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2748	10	Inv [n] unit 2 Busbar temperature alarm	Counter	9	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2749	10	Inv [n] unit 2 Module overtemperature alarm	Counter	9	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2750	10	Inv [n] unit 2 Reactor overtemperature alarm	Counter	9	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2751	10	Inv [n] unit 2 AC circuit breaker fault	Counter	9	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2752	10	Inv [n] unit 2 Bypass circuit breaker fault	Counter	9	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2753	10	Inv [n] unit 2 AC switch fault	Counter	9	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2754	10	Inv [n] unit 2 AC switch disconnection	Counter	9	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2755	10	Inv [n] unit 2 DC switch fault	Counter	9	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2756	10	Inv [n] unit 2 Buffer contactor fault	Counter	9	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2757	10	Inv [n] unit 2 Contactor fault	Counter	9	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2758	10	Inv [n] unit 2 Contactor contact fault	Counter	9	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2759	10	Inv [n] unit 2 Anti-PID power supply	Counter	9	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2760	10	Inv [n] unit 2 Backup power supply fault	Counter	9	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2761	10	Inv [n] unit 2 Control power supply fault	Counter	9	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2762	10	Inv [n] unit 2 Bypass fuse abnormal / branch fault	Counter	9	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2763	10	Inv [n] unit 2 Ground fuse fault	Counter	9	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2764	10	Inv [n] unit 2 Abnormal derating of fan	Counter	9	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2765	10	Inv [n] unit 2 alarms 3	Counter	10	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2766	10	Inv [n] unit 2 Fan fault	Counter	10	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2767	10	Inv [n] unit 2 Fan fault	Counter	10	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2768	10	Inv [n] unit 2 Fan 2 fault	Counter	10	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2769	10	Inv [n] unit 2 Fan 2 fault	Counter	10	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2770	10	Inv [n] unit 2 Grounding fault	Counter	10	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2771	10	Inv [n] unit 2 Drive board fault	Counter	10	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2772	10	Inv [n] unit 2 Hardware fault	Counter	10	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2773	10	Inv [n] unit 2 Insulation impedance sensor fault	Counter	10	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2774	10	Inv [n] unit 2 Sensor failure	Counter	10	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2775	10	Inv [n] unit 2 Temperature and humidity sensor fault	Counter	10	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2776	10	Inv [n] unit 2 DC voltage sampling fault	Counter	10	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2777	10	Inv [n] unit 2 Soft start fault	Counter	10	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2778	10	Inv [n] unit 2 DSP-MDC communication failure	Counter	10	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2779	10	Inv [n] unit 2 IO-DSP communication failure	Counter	10	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2780	10	Inv [n] unit 2 IO-MDC communication abnormal	Counter	10	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2781	10	Inv [n] unit 2 Meter communication failure	Counter	10	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2782	10	Inv [n] unit 2 Parallel operation communication failure	Counter	10	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2783	10	Inv [n] unit 2 Tributary board communication failure	Counter	10	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2784	10	Inv [n] unit 2 ABC fault	Counter	10	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2785	10	Inv [n] unit 2 Carrier sync failure	Counter	10	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2786	10	Inv [n] unit 2 Device code repeat fault	Counter	10	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2787	10	Inv [n] unit 2 External power supply fault	Counter	10	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2788	10	Inv [n] unit 2 GFDI protection active	Counter	10	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2789	10	Inv [n] unit 2 GFRT operation alarm	Counter	10	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2790	10	Inv [n] unit 2 Overload protection active	Counter	10	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2791	10	Inv [n] unit 2 PDP protection active	Counter	10	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2792	10	Inv [n] unit 2 Reversed branch over current	Counter	10	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2793	10	Inv [n] zone monitor branch open circuit	Counter	11	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2794	10	Inv [n] unit 1 open circuit fault branch 1	Counter	11	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2795	10	Inv [n] unit 1 open circuit fault branch 2	Counter	11	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2796	10	Inv [n] unit 1 open circuit fault branch 3	Counter	11	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2797	10	Inv [n] unit 1 open circuit fault branch 4	Counter	11	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2798	10	Inv [n] unit 1 open circuit fault branch 5	Counter	11	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2799	10	Inv [n] unit 1 open circuit fault branch 6	Counter	11	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2800	10	Inv [n] unit 1 open circuit fault branch 7	Counter	11	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2801	10	Inv [n] unit 1 open circuit fault branch 8	Counter	11	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2802	10	Inv [n] unit 1 open circuit fault branch 9	Counter	11	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2803	10	Inv [n] unit 1 open circuit fault branch 10	Counter	11	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2804	10	Inv [n] unit 1 open circuit fault branch 11	Counter	11	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2805	10	Inv [n] unit 1 open circuit fault branch 12	Counter	11	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2806	10	Inv [n] unit 1 open circuit fault branch 13	Counter	11	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2807	10	Inv [n] unit 1 open circuit fault branch 14	Counter	11	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2808	10	Inv [n] unit 1 open circuit fault branch 15	Counter	11	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2809	10	Inv [n] unit 1 open circuit fault branch 16	Counter	11	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2810	10	Inv [n] unit 2 open circuit fault branch 1	Counter	11	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2811	10	Inv [n] unit 2 open circuit fault branch 2	Counter	11	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2812	10	Inv [n] unit 2 open circuit fault branch 3	Counter	11	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2813	10	Inv [n] unit 2 open circuit fault branch 4	Counter	11	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2814	10	Inv [n] unit 2 open circuit fault branch 5	Counter	11	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2815	10	Inv [n] unit 2 open circuit fault branch 6	Counter	11	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2816	10	Inv [n] unit 2 open circuit fault branch 7	Counter	11	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2817	10	Inv [n] unit 2 open circuit fault branch 8	Counter	11	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2818	10	Inv [n] unit 2 open circuit fault branch 9	Counter	11	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2819	10	Inv [n] unit 2 open circuit fault branch 10	Counter	11	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2820	10	Inv [n] unit 2 open circuit fault branch 11	Counter	11	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2821	10	Inv [n] unit 2 open circuit fault branch 12	Counter	11	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2822	10	Inv [n] unit 2 open circuit fault branch 13	Counter	11	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2823	10	Inv [n] unit 2 open circuit fault branch 14	Counter	11	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2824	10	Inv [n] unit 2 open circuit fault branch 15	Counter	11	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2825	10	Inv [n] unit 2 open circuit fault branch 16	Counter	11	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2826	10	Inv [n] zone monitor string failure	Counter	12	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
2827	10	Inv [n] unit 1 string failure branch 1	Counter	12	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2828	10	Inv [n] unit 1 string failure branch 2	Counter	12	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2829	10	Inv [n] unit 1 string failure branch 3	Counter	12	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2830	10	Inv [n] unit 1 string failure branch 4	Counter	12	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2831	10	Inv [n] unit 1 string failure branch 5	Counter	12	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2832	10	Inv [n] unit 1 string failure branch 6	Counter	12	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2833	10	Inv [n] unit 1 string failure branch 7	Counter	12	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2834	10	Inv [n] unit 1 string failure branch 8	Counter	12	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2835	10	Inv [n] unit 1 string failure branch 9	Counter	12	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2836	10	Inv [n] unit 1 string failure branch 10	Counter	12	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2837	10	Inv [n] unit 1 string failure branch 11	Counter	12	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2838	10	Inv [n] unit 1 string failure branch 12	Counter	12	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2839	10	Inv [n] unit 1 string failure branch 13	Counter	12	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2840	10	Inv [n] unit 1 string failure branch 14	Counter	12	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2841	10	Inv [n] unit 1 string failure branch 15	Counter	12	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2842	10	Inv [n] unit 1 string failure branch 16	Counter	12	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2843	10	Inv [n] unit 2 string failure branch 1	Counter	12	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2844	10	Inv [n] unit 2 string failure branch 2	Counter	12	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2845	10	Inv [n] unit 2 string failure branch 3	Counter	12	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2846	10	Inv [n] unit 2 string failure branch 4	Counter	12	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2847	10	Inv [n] unit 2 string failure branch 5	Counter	12	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2848	10	Inv [n] unit 2 string failure branch 6	Counter	12	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2906	10	Inv [n] manual start stop	Binary output	1	Boolean	LOn:LOff	\N	\N	None	Start	Stop	\N	\N	\N	\N
2849	10	Inv [n] unit 2 string failure branch 7	Counter	12	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2850	10	Inv [n] unit 2 string failure branch 8	Counter	12	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2851	10	Inv [n] unit 2 string failure branch 9	Counter	12	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2852	10	Inv [n] unit 2 string failure branch 10	Counter	12	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2853	10	Inv [n] unit 2 string failure branch 11	Counter	12	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2854	10	Inv [n] unit 2 string failure branch 12	Counter	12	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2855	10	Inv [n] unit 2 string failure branch 13	Counter	12	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2856	10	Inv [n] unit 2 string failure branch 14	Counter	12	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2857	10	Inv [n] unit 2 string failure branch 15	Counter	12	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2858	10	Inv [n] unit 2 string failure branch 16	Counter	12	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2859	10	Inv [n] unit 1 fault state 1 register	Counter	13	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2860	10	Inv [n] unit 1 fault state 2 register	Counter	14	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2861	10	Inv [n] unit 1 node state 1 register	Counter	15	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2862	10	Inv [n] unit 1 node state 2 register	Counter	16	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2863	10	Inv [n] unit 1 work state register	Counter	17	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2864	10	Inv [n] unit 1 alarm state register	Counter	18	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2865	10	Inv [n] unit 2 fault state 1 register	Counter	19	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2866	10	Inv [n] unit 2 fault state 2 register	Counter	20	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2867	10	Inv [n] unit 2 node state 1 register	Counter	21	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2868	10	Inv [n] unit 2 node state 2 register	Counter	22	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2869	10	Inv [n] unit 2 work state register	Counter	23	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2870	10	Inv [n] unit 2 alarm state register	Counter	24	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2871	10	Inv [n] transformer node state register	Counter	25	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2872	10	Inv [n] overall work state register	Counter	26	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2873	10	Inv [n] mv node 1 state register	Counter	27	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2874	10	Inv [n] mv node 2 state register	Counter	28	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2875	10	Inv [n] overall alarm state register	Counter	29	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2876	10	Inv [n] digital input state register	Counter	30	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
2877	10	Inv [n] any alarm	Binary input	0	Boolean	\N	\N	\N	None	Alarm	Normal	\N	\N	\N	\N
2878	10	Inv [n] any fault	Binary input	1	Boolean	\N	\N	\N	None	Alarm	Normal	\N	\N	\N	\N
2879	10	Inv [n] communication failure alarm	Binary input	2	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
2880	10	Inv [n] manual control status	Binary input	3	Boolean	\N	\N	\N	On (1)	Manual	Auto	\N	\N	\N	\N
2881	10	Inv [n] DI01 status	Binary input	4	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2882	10	Inv [n] DI02 status	Binary input	5	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2883	10	Inv [n] DI03 status	Binary input	6	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2884	10	Inv [n] DI04 status	Binary input	7	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2885	10	Inv [n] DI05 status	Binary input	8	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2886	10	Inv [n] DI06 status	Binary input	9	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2887	10	Inv [n] DI07 status	Binary input	10	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2888	10	Inv [n] DI08 status	Binary input	11	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2889	10	Inv [n] DI09 status	Binary input	12	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2890	10	Inv [n] DI10 status	Binary input	13	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2891	10	Inv [n] DI11 status	Binary input	14	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2892	10	Inv [n] DI12 status	Binary input	15	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2893	10	Inv [n] DI13 status	Binary input	16	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2894	10	Inv [n] DI14 status	Binary input	17	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2895	10	Inv [n] DI15 status	Binary input	18	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2896	10	Inv [n] DI16 status	Binary input	19	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2897	10	Inv [n] DI17 status	Binary input	20	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2898	10	Inv [n] DI18 status	Binary input	21	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2899	10	Inv [n] DI19 status	Binary input	22	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2900	10	Inv [n] DI20 status	Binary input	23	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2901	10	Inv [n] DI21 status	Binary input	24	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
2902	10	Inv [n] manual active power setpoint	Analog output	0	32-bit float	\N	kW	1	\N	\N	\N	\N	\N	\N	\N
2903	10	Inv [n] manual reactive power setpoint	Analog output	1	32-bit float	\N	kvar or PU 	1	\N	\N	\N	\N	\N	\N	\N
2904	10	Inv [n] manual reactive power mode	Analog output	2	32-bit signed integer	\N	enumeration	1	\N	\N	\N	\N	\N	Reactive power mode:\n0 - OFF (unregulated unity PF)\n1 - Reactive output mode\n2 - Power factor mode\n3 - Voltage regulation\n98 - QU mode\n99 - QP mode	Voltage; Q(U) and Q(P) modes are not selectable through the HMI
2905	10	Inv [n] manual control	Binary output	0	Boolean	LOn:LOff	\N	\N	None	Manual	Auto	\N	\N	\N	\N
2907	10	Inv [n] remote emergency stop	Binary output	2	Boolean	LOn:LOff	\N	\N	None	E-stop	Normal	\N	\N	\N	\N
2908	10	Inv [n] manual DC switch open close	Binary output	3	Boolean	LOn:LOff	\N	\N	None	Close	Open	\N	\N	\N	\N
2909	11	Inv [n] status	Analog input	0	32-bit float	\N	enumeration	1	None	\N	\N	\N	\N	0 to 4	\N
2910	11	Inv [n] active power	Analog input	1	32-bit float	\N	kW	1	Analog	\N	\N	n/a;-10;3620;n/a	Out of Band	\N	\N
2911	11	Inv [n] reactive power	Analog input	2	32-bit float	\N	kvar	1	Analog	\N	\N	n/a;-2180;2180;n/a	Out of Band	\N	\N
2912	11	Inv [n] phase A current	Analog input	3	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2913	11	Inv [n] phase B current	Analog input	4	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2914	11	Inv [n] phase C current	Analog input	5	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2915	11	Inv [n] phase AB voltage	Analog input	6	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2916	11	Inv [n] phase BC voltage	Analog input	7	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2917	11	Inv [n] phase CA voltage	Analog input	8	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2918	11	Inv [n] power factor	Analog input	9	32-bit float	\N	PU	1	None	\N	\N	\N	\N	\N	\N
2919	11	Inv [n] frequency	Analog input	10	32-bit float	\N	Hz	1	None	\N	\N	\N	\N	\N	\N
2920	11	Inv [n] active power setpoint	Analog input	11	32-bit float	\N	kW	1	Analog	\N	\N	n/a;0;3600;n/a	Out of Band	\N	\N
2921	11	Inv [n] active power setpoint feedback	Analog input	12	32-bit float	\N	kW	1	Analog	\N	\N	AI_0010 +/- 1%	Not at Setpoint	\N	\N
2922	11	Inv [n] reactive power mode	Analog input	13	32-bit signed integer	\N	enumeration	1	State change	\N	\N	\N	\N	0 to 3; 98;99	Q(U) and Q(P) modes are not used; but are defined
2923	11	Inv [n] reactive power mode feedback	Analog input	14	32-bit signed integer	\N	enumeration	1	Analog	\N	\N	AI_0012 +/- 1%	Not at Setpoint	0 to 3; 98;99	Q(U) and Q(P) modes are not used; but are defined
2924	11	Inv [n] reactive power setpoint	Analog input	15	32-bit float	\N	kvar or PU 	1	Analog	\N	\N	-2160;-1;1;2160	5-State	\N	\N
2925	11	Inv [n] reactive power setpoint feedback	Analog input	16	32-bit float	\N	kvar or PU 	1	Analog	\N	\N	AI_0014 +/- 1%	Not at Setpoint	\N	\N
2926	11	Inv [n] total DC power	Analog input	17	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
2927	11	Inv [n] energy production today	Analog input	18	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2928	11	Inv [n] energy production yesterday	Analog input	19	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2929	11	Inv [n] total energy production	Analog input	20	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2930	11	Inv [n] total running hours	Analog input	21	32-bit float	\N	hr	1	None	\N	\N	\N	\N	\N	\N
2931	11	Inv [n] transformer oil temperature	Analog input	22	32-bit float	\N	degC	1	Analog	\N	\N	-40;-25;50;60	5-State	\N	\N
2932	11	Inv [n] transformer winding temperature	Analog input	23	32-bit float	\N	degC	1	Analog	\N	\N	-40;-25;50;60	5-State	\N	\N
2933	11	Inv [n] maximum appearant power	Analog input	24	32-bit float	\N	kVA	1	Analog	\N	\N	n/a;3600;3600;n/a	Out of Band	\N	Real time derating
2934	11	Inv [n] maximum lagging reactive power	Analog input	25	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
2935	11	Inv [n] maximum leading reactive power	Analog input	26	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
2936	11	Inv [n] zone monitor status	Analog input	27	32-bit signed integer	\N	enumeration	1	None	\N	\N	\N	\N	0 to 2	\N
2937	11	Inv [n] appearant power	Analog input	28	32-bit float	\N	\N	1	\N	\N	\N	\N	\N	\N	\N
2938	11	Inv [n] zone monitor unit 1 warning number of strings branch 1	Analog input	29	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2939	11	Inv [n] zone monitor unit 1 warning number of strings branch 2	Analog input	30	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2940	11	Inv [n] zone monitor unit 1 warning number of strings branch 3	Analog input	31	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2941	11	Inv [n] zone monitor unit 1 warning number of strings branch 4	Analog input	32	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2942	11	Inv [n] zone monitor unit 1 warning number of strings branch 5	Analog input	33	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2943	11	Inv [n] zone monitor unit 1 warning number of strings branch 6	Analog input	34	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2944	11	Inv [n] zone monitor unit 1 warning number of strings branch 7	Analog input	35	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2945	11	Inv [n] zone monitor unit 2 warning number of strings branch 1	Analog input	36	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2946	11	Inv [n] zone monitor unit 2 warning number of strings branch 2	Analog input	37	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2947	11	Inv [n] zone monitor unit 2 warning number of strings branch 3	Analog input	38	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2948	11	Inv [n] zone monitor unit 2 warning number of strings branch 4	Analog input	39	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2949	11	Inv [n] zone monitor unit 2 warning number of strings branch 5	Analog input	40	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2950	11	Inv [n] zone monitor unit 2 warning number of strings branch 6	Analog input	41	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2951	11	Inv [n] zone monitor unit 2 warning number of strings branch 7	Analog input	42	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2952	11	Inv [n] zone monitor unit 3 warning number of strings branch 1	Analog input	43	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2953	11	Inv [n] zone monitor unit 3 warning number of strings branch 2	Analog input	44	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2954	11	Inv [n] zone monitor unit 3 warning number of strings branch 3	Analog input	45	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2955	11	Inv [n] zone monitor unit 3 warning number of strings branch 4	Analog input	46	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2956	11	Inv [n] zone monitor unit 3 warning number of strings branch 5	Analog input	47	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2957	11	Inv [n] zone monitor unit 3 warning number of strings branch 6	Analog input	48	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2958	11	Inv [n] zone monitor unit 3 warning number of strings branch 7	Analog input	49	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2959	11	Inv [n] zone monitor unit 4 warning number of strings branch 1	Analog input	50	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2960	11	Inv [n] zone monitor unit 4 warning number of strings branch 2	Analog input	51	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2961	11	Inv [n] zone monitor unit 4 warning number of strings branch 3	Analog input	52	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
3026	11	Inv [n] unit 2 total energy production	Analog input	236	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2962	11	Inv [n] zone monitor unit 4 warning number of strings branch 4	Analog input	53	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2963	11	Inv [n] zone monitor unit 4 warning number of strings branch 5	Analog input	54	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2964	11	Inv [n] zone monitor unit 4 warning number of strings branch 6	Analog input	55	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2965	11	Inv [n] zone monitor unit 4 warning number of strings branch 7	Analog input	56	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
2966	11	Inv [n] unit 1 status	Analog input	100	32-bit float	\N	enumeration	1	None	\N	\N	\N	\N	0 to 4	\N
2967	11	Inv [n] unit 1 active power	Analog input	101	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
2968	11	Inv [n] unit 1 reactive power	Analog input	102	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
2969	11	Inv [n] unit 1 phase A current	Analog input	103	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2970	11	Inv [n] unit 1 phase B current	Analog input	104	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	True if any alarm is set for this inverter
2971	11	Inv [n] unit 1 phase C current	Analog input	105	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2972	11	Inv [n] unit 1 phase AB voltage	Analog input	106	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2973	11	Inv [n] unit 1 phase BC voltage	Analog input	107	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2974	11	Inv [n] unit 1 phase CA voltage	Analog input	108	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2975	11	Inv [n] unit 1 power factor	Analog input	109	32-bit float	\N	PU	1	None	\N	\N	\N	\N	\N	\N
2976	11	Inv [n] unit 1 frequency	Analog input	110	32-bit float	\N	Hz	1	None	\N	\N	\N	\N	\N	\N
2977	11	Inv [n] unit 1 DC power	Analog input	111	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
2978	11	Inv [n] unit 1 total DC current	Analog input	112	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2979	11	Inv [n] unit 1 DC voltage	Analog input	113	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2980	11	Inv [n] unit 1 DC Input 1	Analog input	114	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2981	11	Inv [n] unit 1 DC Input 2	Analog input	115	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2982	11	Inv [n] unit 1 DC Input 3	Analog input	116	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2983	11	Inv [n] unit 1 DC Input 4	Analog input	117	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2984	11	Inv [n] unit 1 DC Input 5	Analog input	118	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2985	11	Inv [n] unit 1 DC Input 6	Analog input	119	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2986	11	Inv [n] unit 1 DC Input 7	Analog input	120	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
2987	11	Inv [n] unit 1 energy production today	Analog input	134	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2988	11	Inv [n] unit 1 energy production yesterday	Analog input	135	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2989	11	Inv [n] unit 1 total energy production	Analog input	136	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
2990	11	Inv [n] unit 1 total running hours	Analog input	137	32-bit float	\N	hr	1	None	\N	\N	\N	\N	\N	\N
2991	11	Inv [n] unit 1 internal module temperature	Analog input	138	32-bit float	\N	degC	1	Analog	\N	\N	\N	5-State	\N	\N
2992	11	Inv [n] unit 1 daily grid connected minutes	Analog input	139	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
2993	11	Inv [n] unit 1 yesterday grid connected minutes	Analog input	140	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
2994	11	Inv [n] unit 1 efficiency	Analog input	141	32-bit float	\N	%	1	None	\N	\N	\N	\N	\N	\N
2995	11	Inv [n] unit 1 positive resitance to ground	Analog input	142	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
2996	11	Inv [n] unit 1 negative resitance to ground	Analog input	143	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
2997	11	Inv [n] unit 1 negative voltage to ground	Analog input	144	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
2998	11	Inv [n] unit 1 leakage current	Analog input	145	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
2999	11	Inv [n] unit 1 temperature 1	Analog input	146	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3000	11	Inv [n] unit 1 temperature 3	Analog input	147	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3001	11	Inv [n] unit 1 temperature 5	Analog input	148	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3002	11	Inv [n] unit 1 event recorder count	Analog input	149	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
3003	11	Inv [n] unit 2 status	Analog input	200	32-bit float	\N	enumeration	1	None	\N	\N	\N	\N	\N	\N
3004	11	Inv [n] unit 2 active power	Analog input	201	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
3005	11	Inv [n] unit 2 reactive power	Analog input	202	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
3006	11	Inv [n] unit 2 phase A current	Analog input	203	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3007	11	Inv [n] unit 2 phase B current	Analog input	204	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3008	11	Inv [n] unit 2 phase C current	Analog input	205	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3009	11	Inv [n] unit 2 phase AB voltage	Analog input	206	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3010	11	Inv [n] unit 2 phase BC voltage	Analog input	207	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3011	11	Inv [n] unit 2 phase CA voltage	Analog input	208	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3012	11	Inv [n] unit 2 power factor	Analog input	209	32-bit float	\N	PU	1	None	\N	\N	\N	\N	\N	\N
3013	11	Inv [n] unit 2 frequency	Analog input	210	32-bit float	\N	Hz	1	None	\N	\N	\N	\N	\N	\N
3014	11	Inv [n] unit 2 DC power	Analog input	211	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
3015	11	Inv [n] unit 2 total DC current	Analog input	212	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3016	11	Inv [n] unit 2 DC voltage	Analog input	213	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3017	11	Inv [n] unit 2 DC Input 1	Analog input	214	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3018	11	Inv [n] unit 2 DC Input 2	Analog input	215	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3019	11	Inv [n] unit 2 DC Input 3	Analog input	216	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3020	11	Inv [n] unit 2 DC Input 4	Analog input	217	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3021	11	Inv [n] unit 2 DC Input 5	Analog input	218	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3022	11	Inv [n] unit 2 DC Input 6	Analog input	219	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3023	11	Inv [n] unit 2 DC Input 7	Analog input	220	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3024	11	Inv [n] unit 2 energy production today	Analog input	234	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
3025	11	Inv [n] unit 2 energy production yesterday	Analog input	235	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
3027	11	Inv [n] unit 2 total running hours	Analog input	237	32-bit float	\N	hr	1	None	\N	\N	\N	\N	\N	\N
3028	11	Inv [n] unit 2 internal module temperature	Analog input	238	32-bit float	\N	degC	1	Analog	\N	\N	\N	5-State	\N	\N
3029	11	Inv [n] unit 2 daily grid connected minutes	Analog input	239	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
3030	11	Inv [n] unit 2 yesterday grid connected minutes	Analog input	240	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
3031	11	Inv [n] unit 2 efficiency	Analog input	241	32-bit float	\N	%	1	None	\N	\N	\N	\N	\N	\N
3032	11	Inv [n] unit 2 positive resitance to ground	Analog input	242	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
3033	11	Inv [n] unit 2 negative resitance to ground	Analog input	243	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
3034	11	Inv [n] unit 2 negative voltage to ground	Analog input	244	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3035	11	Inv [n] unit 2 leakage current	Analog input	245	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
3036	11	Inv [n] unit 2 temperature 1	Analog input	246	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3037	11	Inv [n] unit 2 temperature 3	Analog input	247	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3038	11	Inv [n] unit 2 temperature 5	Analog input	248	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3039	11	Inv [n] unit 2 event recorder count	Analog input	149	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
3040	11	Inv [n] unit 3 status	Analog input	300	32-bit float	\N	enumeration	1	None	\N	\N	\N	\N	\N	\N
3041	11	Inv [n] unit 3 active power	Analog input	301	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
3042	11	Inv [n] unit 3 reactive power	Analog input	302	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
3043	11	Inv [n] unit 3 phase A current	Analog input	303	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3044	11	Inv [n] unit 3 phase B current	Analog input	304	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3045	11	Inv [n] unit 3 phase C current	Analog input	305	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3046	11	Inv [n] unit 3 phase AB voltage	Analog input	306	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3047	11	Inv [n] unit 3 phase BC voltage	Analog input	307	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3048	11	Inv [n] unit 3 phase CA voltage	Analog input	308	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3049	11	Inv [n] unit 3 power factor	Analog input	309	32-bit float	\N	PU	1	None	\N	\N	\N	\N	\N	\N
3050	11	Inv [n] unit 3 frequency	Analog input	310	32-bit float	\N	Hz	1	None	\N	\N	\N	\N	\N	\N
3051	11	Inv [n] unit 3 DC power	Analog input	311	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
3052	11	Inv [n] unit 3 total DC current	Analog input	312	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3053	11	Inv [n] unit 3 DC voltage	Analog input	313	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3054	11	Inv [n] unit 3 DC Input 1	Analog input	314	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3055	11	Inv [n] unit 3 DC Input 2	Analog input	315	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3056	11	Inv [n] unit 3 DC Input 3	Analog input	316	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3057	11	Inv [n] unit 3 DC Input 4	Analog input	317	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3058	11	Inv [n] unit 3 DC Input 5	Analog input	318	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3059	11	Inv [n] unit 3 DC Input 6	Analog input	319	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3060	11	Inv [n] unit 3 DC Input 7	Analog input	320	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3061	11	Inv [n] unit 3 energy production today	Analog input	334	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
3062	11	Inv [n] unit 3 energy production yesterday	Analog input	335	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
3063	11	Inv [n] unit 3 total energy production	Analog input	336	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
3064	11	Inv [n] unit 3 total running hours	Analog input	337	32-bit float	\N	hr	1	None	\N	\N	\N	\N	\N	\N
3065	11	Inv [n] unit 3 internal module temperature	Analog input	338	32-bit float	\N	degC	1	Analog	\N	\N	\N	5-State	\N	\N
3066	11	Inv [n] unit 3 daily grid connected minutes	Analog input	339	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
3067	11	Inv [n] unit 3 yesterday grid connected minutes	Analog input	340	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
3068	11	Inv [n] unit 3 efficiency	Analog input	341	32-bit float	\N	%	1	None	\N	\N	\N	\N	\N	\N
3069	11	Inv [n] unit 3 positive resitance to ground	Analog input	342	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
3070	11	Inv [n] unit 3 negative resitance to ground	Analog input	343	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
3071	11	Inv [n] unit 3 negative voltage to ground	Analog input	344	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3072	11	Inv [n] unit 3 leakage current	Analog input	345	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
3073	11	Inv [n] unit 3 temperature 1	Analog input	346	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3074	11	Inv [n] unit 3 temperature 3	Analog input	347	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3075	11	Inv [n] unit 3 temperature 5	Analog input	348	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3076	11	Inv [n] unit 3 event recorder count	Analog input	149	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
3077	11	Inv [n] unit 4 status	Analog input	400	32-bit float	\N	enumeration	1	None	\N	\N	\N	\N	\N	\N
3078	11	Inv [n] unit 4 active power	Analog input	401	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
3079	11	Inv [n] unit 4 reactive power	Analog input	402	32-bit float	\N	kvar	1	None	\N	\N	\N	\N	\N	\N
3080	11	Inv [n] unit 4 phase A current	Analog input	403	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3081	11	Inv [n] unit 4 phase B current	Analog input	404	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3082	11	Inv [n] unit 4 phase C current	Analog input	405	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3083	11	Inv [n] unit 4 phase AB voltage	Analog input	406	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3084	11	Inv [n] unit 4 phase BC voltage	Analog input	407	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3085	11	Inv [n] unit 4 phase CA voltage	Analog input	408	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3086	11	Inv [n] unit 4 power factor	Analog input	409	32-bit float	\N	PU	1	None	\N	\N	\N	\N	\N	\N
3087	11	Inv [n] unit 4 frequency	Analog input	410	32-bit float	\N	Hz	1	None	\N	\N	\N	\N	\N	\N
3088	11	Inv [n] unit 4 DC power	Analog input	411	32-bit float	\N	kW	1	None	\N	\N	\N	\N	\N	\N
3089	11	Inv [n] unit 4 total DC current	Analog input	412	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3090	11	Inv [n] unit 4 DC voltage	Analog input	413	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3091	11	Inv [n] unit 4 DC Input 1	Analog input	414	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3092	11	Inv [n] unit 4 DC Input 2	Analog input	415	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3093	11	Inv [n] unit 4 DC Input 3	Analog input	416	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3094	11	Inv [n] unit 4 DC Input 4	Analog input	417	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3095	11	Inv [n] unit 4 DC Input 5	Analog input	418	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3096	11	Inv [n] unit 4 DC Input 6	Analog input	419	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3097	11	Inv [n] unit 4 DC Input 7	Analog input	420	32-bit float	\N	A	1	None	\N	\N	\N	\N	\N	\N
3098	11	Inv [n] unit 4 energy production today	Analog input	434	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
3099	11	Inv [n] unit 4 energy production yesterday	Analog input	435	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
3100	11	Inv [n] unit 4 total energy production	Analog input	436	32-bit float	\N	kWh	1	None	\N	\N	\N	\N	\N	\N
3101	11	Inv [n] unit 4 total running hours	Analog input	437	32-bit float	\N	hr	1	None	\N	\N	\N	\N	\N	\N
3102	11	Inv [n] unit 4 internal module temperature	Analog input	438	32-bit float	\N	degC	1	Analog	\N	\N	\N	5-State	\N	\N
3103	11	Inv [n] unit 4 daily grid connected minutes	Analog input	439	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
3104	11	Inv [n] unit 4 yesterday grid connected minutes	Analog input	440	32-bit float	\N	min	1	None	\N	\N	\N	\N	\N	\N
3105	11	Inv [n] unit 4 efficiency	Analog input	441	32-bit float	\N	%	1	None	\N	\N	\N	\N	\N	\N
3106	11	Inv [n] unit 4 positive resitance to ground	Analog input	442	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
3107	11	Inv [n] unit 4 negative resitance to ground	Analog input	443	32-bit float	\N	kOhm	1	None	\N	\N	\N	\N	\N	\N
3108	11	Inv [n] unit 4 negative voltage to ground	Analog input	444	32-bit float	\N	V	1	None	\N	\N	\N	\N	\N	\N
3109	11	Inv [n] unit 4 leakage current	Analog input	445	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
3110	11	Inv [n] unit 4 temperature 1	Analog input	446	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3111	11	Inv [n] unit 4 temperature 3	Analog input	447	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3112	11	Inv [n] unit 4 temperature 5	Analog input	448	32-bit float	\N	degC	1	None	\N	\N	\N	\N	\N	\N
3113	11	Inv [n] unit 4 event recorder count	Analog input	149	32-bit float	\N	count	1	None	\N	\N	\N	\N	\N	\N
3114	11	Inv [n] skid level status register	Counter	0	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3115	11	Inv [n] MV load switch status	Counter	0	32-bit bitfield	0	\N	\N	None	Closed	Open	\N	\N	\N	\N
3116	11	Inv [n] HV remote control	Counter	0	32-bit bitfield	1	\N	\N	None	Local	Remote	\N	\N	\N	\N
3117	11	Inv [n] Inverter is Running	Counter	0	32-bit bitfield	2	\N	\N	None	Running	Stopped	\N	\N	\N	\N
3118	11	Inv [n] Inverter is Stopped	Counter	0	32-bit bitfield	3	\N	\N	None	Stopped	Running	\N	\N	\N	\N
3119	11	Inv [n] Remote E-stop	Counter	0	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3120	11	Inv [n] Local E-stop	Counter	0	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3121	11	Inv [n] Running	Counter	0	32-bit bitfield	6	\N	\N	None	On	Off	\N	\N	\N	\N
3122	11	Inv [n] Warn Run	Counter	0	32-bit bitfield	7	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3123	11	Inv [n] Fault	Counter	0	32-bit bitfield	8	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3124	11	Inv [n] Stop	Counter	0	32-bit bitfield	9	\N	\N	None	On	Off	\N	\N	\N	\N
3125	11	Inv [n] HV room door	Counter	0	32-bit bitfield	10	\N	\N	On (1)	Open	Closed	\N	\N	\N	\N
3126	11	Inv [n] External E-stop	Counter	0	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3127	11	Inv [n] HV remote control trip	Counter	0	32-bit bitfield	12	\N	\N	None	Active	Normal	\N	\N	\N	\N
3128	11	Inv [n] HV remote control close	Counter	0	32-bit bitfield	13	\N	\N	None	Active	Normal	\N	\N	\N	\N
3129	11	Inv [n] Transformer room door	Counter	0	32-bit bitfield	14	\N	\N	On (1)	Open	Closed	\N	\N	\N	\N
3130	11	Inv [n] MV earthing switch	Counter	0	32-bit bitfield	15	\N	\N	On (1)	Closed	Open	\N	\N	\N	\N
3131	11	Inv [n] MV earthing switch 1	Counter	0	32-bit bitfield	16	\N	\N	On (1)	Closed	Open	\N	\N	\N	\N
3132	11	Inv [n] MV earthing switch 2	Counter	0	32-bit bitfield	17	\N	\N	On (1)	Closed	Open	\N	\N	\N	\N
3133	11	Inv [n] MV earthing switch 3	Counter	0	32-bit bitfield	18	\N	\N	On (1)	Closed	Open	\N	\N	\N	\N
3134	11	Inv [n] Load switch T-A status	Counter	0	32-bit bitfield	19	\N	\N	None	Closed	Open	\N	\N	\N	\N
3135	11	Inv [n] Load switch T-B status	Counter	0	32-bit bitfield	20	\N	\N	None	Closed	Open	\N	\N	\N	\N
3136	11	Inv [n] Load switch T-AB status	Counter	0	32-bit bitfield	21	\N	\N	None	Closed	Open	\N	\N	\N	\N
3137	11	Inv [n] Load switch A-B status	Counter	0	32-bit bitfield	22	\N	\N	None	Closed	Open	\N	\N	\N	\N
3138	11	Inv [n] Skid level faults register	Counter	1	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3139	11	Inv [n] SCU master fault	Counter	1	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3140	11	Inv [n] AC insulation fault	Counter	1	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3141	11	Inv [n] SCU slave fault	Counter	1	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3142	11	Inv [n] 24hr insulation fault	Counter	1	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3143	11	Inv [n] 24hr DC insulation fault	Counter	1	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3144	11	Inv [n] 24hr AC insulation fault	Counter	1	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3145	11	Inv [n] ISO insulation detection abnormal fault	Counter	1	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3146	11	Inv [n] ISO hardware fault	Counter	1	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3147	11	Inv [n] ISO overtemperature fault	Counter	1	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3148	11	Inv [n] ISO overvoltage fault	Counter	1	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3149	11	Inv [n] Skid level alarms register	Counter	2	32-bit bitfield	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3150	11	Inv [n] ISO insulation detection abnormal alarm	Counter	2	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3151	11	Inv [n] ISO overtemperature alarm	Counter	2	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3152	11	Inv [n] ISO grid sampling abnormal alarm	Counter	2	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3153	11	Inv [n] MV fuse	Counter	2	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3154	11	Inv [n] HV room smoke	Counter	2	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3155	11	Inv [n] Transformer room smoke	Counter	2	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3156	11	Inv [n] UPS alarm	Counter	2	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3157	11	Inv [n] High level trip	Counter	2	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3158	11	Inv [n] MV fan alarm	Counter	2	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3159	11	Inv [n] AC insulation detection comm failure	Counter	2	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3160	11	Inv [n] 24hr insulation alarm	Counter	2	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3161	11	Inv [n] SCU master-slave comm failure	Counter	2	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3162	11	Inv [n] Heartbeat abnormal	Counter	2	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3163	11	Inv [n] PMD IO board comm failure	Counter	2	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3164	11	Inv [n] Inverter IO board comm failure	Counter	2	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3165	11	Inv [n] ISO board comm failure	Counter	2	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3166	11	Inv [n] UPS fault alarm	Counter	2	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3167	11	Inv [n] UPS bypass alarm	Counter	2	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3168	11	Inv [n] UPS battery undervoltage alarm	Counter	2	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3169	11	Inv [n] UPS mains disconnection alarm	Counter	2	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3170	11	Inv [n] UPS conversion	Counter	2	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3171	11	Inv [n] Skid transformer alarms register	Counter	3	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3172	11	Inv [n] Gas relay trip	Counter	3	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3173	11	Inv [n] Gas relay alarm	Counter	3	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3174	11	Inv [n] Oil temperature alarm	Counter	3	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3175	11	Inv [n] Oil temperature trip	Counter	3	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3176	11	Inv [n] Low oil level trip	Counter	3	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3177	11	Inv [n] Low oil level alarm	Counter	3	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3178	11	Inv [n] Pressure relief trip	Counter	3	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3179	11	Inv [n] MV load switch 1	Counter	3	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3180	11	Inv [n] MV load switch 2 status	Counter	3	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3181	11	Inv [n] MV disconnector switch status	Counter	3	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3182	11	Inv [n] High level alarm	Counter	3	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3183	11	Inv [n] Winding temperature trip	Counter	3	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3184	11	Inv [n] Winding temperature alarm	Counter	3	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	Need schematic to tell us what function each DI has
3185	11	Inv [n] Skid digital inputs register	Counter	4	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3186	11	Inv [n] DI01 status	Counter	4	32-bit bitfield	0	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
3187	11	Inv [n] DI02 status	Counter	4	32-bit bitfield	1	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
3188	11	Inv [n] DI03 status	Counter	4	32-bit bitfield	2	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
3189	11	Inv [n] DI04 status	Counter	4	32-bit bitfield	3	\N	\N	None	On	Off	\N	\N	\N	Need schematic to tell us what function each DI has
3190	11	Inv [n] DI05 status	Counter	4	32-bit bitfield	4	\N	\N	None	On	Off	\N	\N	\N	\N
3191	11	Inv [n] DI06 status	Counter	4	32-bit bitfield	5	\N	\N	None	On	Off	\N	\N	\N	\N
3192	11	Inv [n] DI07 status	Counter	4	32-bit bitfield	6	\N	\N	None	On	Off	\N	\N	\N	\N
3193	11	Inv [n] DI08 status	Counter	4	32-bit bitfield	7	\N	\N	None	On	Off	\N	\N	\N	\N
3194	11	Inv [n] DI09 status	Counter	4	32-bit bitfield	8	\N	\N	None	On	Off	\N	\N	\N	\N
3195	11	Inv [n] DI10 status	Counter	4	32-bit bitfield	9	\N	\N	None	On	Off	\N	\N	\N	\N
3196	11	Inv [n] DI11 status	Counter	4	32-bit bitfield	10	\N	\N	None	On	Off	\N	\N	\N	\N
3197	11	Inv [n] DI12 status	Counter	4	32-bit bitfield	11	\N	\N	None	On	Off	\N	\N	\N	\N
3198	11	Inv [n] DI13 status	Counter	4	32-bit bitfield	12	\N	\N	None	On	Off	\N	\N	\N	\N
3199	11	Inv [n] DI14 status	Counter	4	32-bit bitfield	13	\N	\N	None	On	Off	\N	\N	\N	\N
3200	11	Inv [n] DI15 status	Counter	4	32-bit bitfield	14	\N	\N	None	On	Off	\N	\N	\N	\N
3201	11	Inv [n] DI16 status	Counter	4	32-bit bitfield	15	\N	\N	None	On	Off	\N	\N	\N	\N
3202	11	Inv [n] DI17 status	Counter	4	32-bit bitfield	16	\N	\N	None	On	Off	\N	\N	\N	\N
3203	11	Inv [n] DI18 status	Counter	4	32-bit bitfield	17	\N	\N	None	On	Off	\N	\N	\N	\N
3204	11	Inv [n] DI19 status	Counter	4	32-bit bitfield	18	\N	\N	None	On	Off	\N	\N	\N	\N
3205	11	Inv [n] DI20 status	Counter	4	32-bit bitfield	19	\N	\N	None	On	Off	\N	\N	\N	\N
3206	11	Inv [n] DI21 status	Counter	4	32-bit bitfield	20	\N	\N	None	On	Off	\N	\N	\N	\N
3207	11	Inv [n] DI22 status	Counter	4	32-bit bitfield	21	\N	\N	None	On	Off	\N	\N	\N	\N
3208	11	Inv [n] DI23 status	Counter	4	32-bit bitfield	22	\N	\N	None	On	Off	\N	\N	\N	\N
3209	11	Inv [n] DI24 status	Counter	4	32-bit bitfield	23	\N	\N	None	On	Off	\N	\N	\N	\N
3210	11	Inv [n] PMD IO register	Counter	5	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3211	11	Inv [n] PMD DI01 status	Counter	5	32-bit bitfield	0	\N	\N	None	On	Off	\N	\N	\N	\N
3212	11	Inv [n] PMD DI02 status	Counter	5	32-bit bitfield	1	\N	\N	None	On	Off	\N	\N	\N	\N
3213	11	Inv [n] PMD DI03 status	Counter	5	32-bit bitfield	2	\N	\N	None	On	Off	\N	\N	\N	\N
3214	11	Inv [n] PMD DI04 status	Counter	5	32-bit bitfield	3	\N	\N	None	On	Off	\N	\N	\N	\N
3215	11	Inv [n] PMD DI05 status	Counter	5	32-bit bitfield	4	\N	\N	None	On	Off	\N	\N	\N	\N
3216	11	Inv [n] PMD DI06 status	Counter	5	32-bit bitfield	5	\N	\N	None	On	Off	\N	\N	\N	\N
3217	11	Inv [n] PMD DI07 status	Counter	5	32-bit bitfield	6	\N	\N	None	On	Off	\N	\N	\N	\N
3218	11	Inv [n] PMD DI08 status	Counter	5	32-bit bitfield	7	\N	\N	None	On	Off	\N	\N	\N	\N
3219	11	Inv [n] PMD DI09 status	Counter	5	32-bit bitfield	8	\N	\N	None	On	Off	\N	\N	\N	\N
3220	11	Inv [n] PMD DI10 status	Counter	5	32-bit bitfield	9	\N	\N	None	On	Off	\N	\N	\N	\N
3221	11	Inv [n] PMD DI11 status	Counter	5	32-bit bitfield	10	\N	\N	None	On	Off	\N	\N	\N	\N
3222	11	Inv [n] PMD DI12 status	Counter	5	32-bit bitfield	11	\N	\N	None	On	Off	\N	\N	\N	\N
3223	11	Inv [n] unit 1 status register	Counter	10	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3224	11	Inv [n] unit 1 Unit is running	Counter	10	32-bit bitfield	0	\N	\N	None	Running	Stopped	\N	\N	\N	\N
3225	11	Inv [n] unit 1 Unit is stopped	Counter	10	32-bit bitfield	1	\N	\N	None	Stopped	Running	\N	\N	\N	\N
3226	11	Inv [n] unit 1 Run	Counter	10	32-bit bitfield	2	\N	\N	None	On	Off	\N	\N	\N	\N
3227	11	Inv [n] unit 1 Stop	Counter	10	32-bit bitfield	3	\N	\N	None	On	Off	\N	\N	\N	\N
3228	11	Inv [n] unit 1 Initial standby	Counter	10	32-bit bitfield	4	\N	\N	None	On	Off	\N	\N	\N	\N
3229	11	Inv [n] unit 1 Press to shutdown	Counter	10	32-bit bitfield	5	\N	\N	None	On	Off	\N	\N	\N	\N
3230	11	Inv [n] unit 1 Standby	Counter	10	32-bit bitfield	6	\N	\N	None	On	Off	\N	\N	\N	\N
3231	11	Inv [n] unit 1 Emergency stop	Counter	10	32-bit bitfield	7	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3232	11	Inv [n] unit 1 Starting up	Counter	10	32-bit bitfield	8	\N	\N	None	On	Off	\N	\N	\N	\N
3233	11	Inv [n] unit 1 Shutting down	Counter	10	32-bit bitfield	9	\N	\N	None	On	Off	\N	\N	\N	\N
3234	11	Inv [n] unit 1 Shut down	Counter	10	32-bit bitfield	10	\N	\N	None	On	Off	\N	\N	\N	\N
3235	11	Inv [n] unit 1 Warning run	Counter	10	32-bit bitfield	11	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3236	11	Inv [n] unit 1 Derating run	Counter	10	32-bit bitfield	12	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3237	11	Inv [n] unit 1 IO and DSP communication error	Counter	10	32-bit bitfield	13	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3238	11	Inv [n] unit 1 Anti-PID run	Counter	10	32-bit bitfield	14	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3239	11	Inv [n] unit 1 AC breaker status	Counter	10	32-bit bitfield	15	\N	\N	None	Closed	Open	\N	\N	\N	\N
3240	11	Inv [n] unit 1 DC switch 1 status	Counter	10	32-bit bitfield	16	\N	\N	None	Closed	Open	\N	\N	\N	\N
3241	11	Inv [n] unit 1 Emergency shutdown node	Counter	10	32-bit bitfield	17	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3242	11	Inv [n] unit 1 faults register 1	Counter	11	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3243	11	Inv [n] unit 1 Smoke node	Counter	11	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3244	11	Inv [n] unit 1 Access node	Counter	11	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3245	11	Inv [n] unit 1 DC undervoltage fault	Counter	11	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3246	11	Inv [n] unit 1 DC overvoltage fault	Counter	11	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3247	11	Inv [n] unit 1 AC undervoltage fault	Counter	11	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3248	11	Inv [n] unit 1 AC overvoltage fault	Counter	11	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3249	11	Inv [n] unit 1 Anti islanding protection active	Counter	11	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3250	11	Inv [n] unit 1 PDP protection active	Counter	11	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3251	11	Inv [n] unit 1 Module overtemperature fault	Counter	11	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3252	11	Inv [n] unit 1 Reactor overtemperature fault	Counter	11	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3253	11	Inv [n] unit 1 AC leakage current protection fault	Counter	11	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3254	11	Inv [n] unit 1 GFDI protection active	Counter	11	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3255	11	Inv [n] unit 1 Fan 1 fault	Counter	11	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3256	11	Inv [n] unit 1 DC overcurrent	Counter	11	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3257	11	Inv [n] unit 1 AC overcurrent	Counter	11	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3258	11	Inv [n] unit 1 Frequency abnormal	Counter	11	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3259	11	Inv [n] unit 1 Temperature abnormal	Counter	11	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3260	11	Inv [n] unit 1 Hardware fault	Counter	11	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3261	11	Inv [n] unit 1 Grounding fault	Counter	11	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3262	11	Inv [n] unit 1 Bus overvoltage	Counter	11	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3263	11	Inv [n] unit 1 Bus undervoltage	Counter	11	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3264	11	Inv [n] unit 1 Inverter overvoltage	Counter	11	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3265	11	Inv [n] unit 1 Low insulation resistance fault	Counter	11	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3266	11	Inv [n] unit 1 AC SPD fault	Counter	11	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3267	11	Inv [n] unit 1 Sampling fault	Counter	11	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3268	11	Inv [n] unit 1 DC polarity reversed fault	Counter	11	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3269	11	Inv [n] unit 1 Control power supply fault	Counter	11	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3270	11	Inv [n] unit 1 AC current imballance	Counter	11	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3271	11	Inv [n] unit 1 DC SPD fault	Counter	11	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3272	11	Inv [n] unit 1 DC component fault	Counter	11	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3273	11	Inv [n] unit 1 DC switch fault	Counter	11	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3274	11	Inv [n] unit 1 Repeated fault	Counter	11	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3275	11	Inv [n] unit 1 faults register 2	Counter	12	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3276	11	Inv [n] unit 1 Parallel operation communication failure	Counter	12	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3277	11	Inv [n] unit 1 Control cabinet temperature fault	Counter	12	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3278	11	Inv [n] unit 1 DC fuse ground fault	Counter	12	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3279	11	Inv [n] unit 1 Excessive DC reverse current fault	Counter	12	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3340	11	Inv [n] unit 2 Initial standby	Counter	20	32-bit bitfield	4	\N	\N	None	On	Off	\N	\N	\N	\N
3280	11	Inv [n] unit 1 Grid voltage imballance fault	Counter	12	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3281	11	Inv [n] unit 1 Inverter cabinet temperature fault	Counter	12	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3282	11	Inv [n] unit 1 AC cabinet temperature fault	Counter	12	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3283	11	Inv [n] unit 1 AC switch off	Counter	12	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3284	11	Inv [n] unit 1 AC switch fault	Counter	12	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3285	11	Inv [n] unit 1 Soft start fault	Counter	12	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3286	11	Inv [n] unit 1 DC voltage sampling fault	Counter	12	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3287	11	Inv [n] unit 1 Fan 2 fault	Counter	12	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3288	11	Inv [n] unit 1 Current unbalance 2	Counter	12	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3289	11	Inv [n] unit 1 Current unbalance 3	Counter	12	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3290	11	Inv [n] unit 1 DC cabinet temperature alarm	Counter	12	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3291	11	Inv [n] unit 1 Neutral point potential shift alarm	Counter	12	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3292	11	Inv [n] unit 1 Carrier sync failure	Counter	12	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3293	11	Inv [n] unit 1 Smoke alarm	Counter	12	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3294	11	Inv [n] unit 1 Access control protection alarm	Counter	12	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3295	11	Inv [n] unit 1 Emergency shutdown alarm	Counter	12	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3296	11	Inv [n] unit 1 alarms register	Counter	13	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3297	11	Inv [n] unit 1 Temperature abnormal alarm	Counter	13	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3298	11	Inv [n] unit 1 Low insulation resistance alarm	Counter	13	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3299	11	Inv [n] unit 1 GFRT operation alarm	Counter	13	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3300	11	Inv [n] unit 1 CT unbalance alarm	Counter	13	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3301	11	Inv [n] unit 1 DC sensor alarm	Counter	13	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3302	11	Inv [n] unit 1 DC SPD alarm	Counter	13	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3303	11	Inv [n] unit 1 AC SPD alarm	Counter	13	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3304	11	Inv [n] unit 1 DC switch alarm	Counter	13	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3305	11	Inv [n] unit 1 Anti-PID power alarm	Counter	13	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3306	11	Inv [n] unit 1 Cooling fan 1 alarm	Counter	13	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3307	11	Inv [n] unit 1 DC branch forward alarm	Counter	13	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3308	11	Inv [n] unit 1 DC branch reverse alarm	Counter	13	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3309	11	Inv [n] unit 1 AC switch alarm	Counter	13	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3310	11	Inv [n] unit 1 Meter communication failure alarm	Counter	13	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3311	11	Inv [n] unit 1 Cooling fan 2 alarm	Counter	13	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3312	11	Inv [n] unit 1 Temperature and humidity sensor alarm	Counter	13	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3313	11	Inv [n] unit 1 Frequency deviation active power regulation	Counter	13	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3314	11	Inv [n] unit 1 Voltage deviation reactive power regulation	Counter	13	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3315	11	Inv [n] unit 1 Busbar temperature alarm	Counter	13	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3316	11	Inv [n] unit 1 Cooling fan derating alarm	Counter	13	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3317	11	Inv [n] unit 1 Frequency abnormal	Counter	13	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3318	11	Inv [n] unit 1 HVRT operation	Counter	13	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3319	11	Inv [n] unit 1 LVRT operation	Counter	13	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3320	11	Inv [n] unit 1 array monitoring register	Counter	14	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3321	11	Inv [n] unit 1 DC input 1 open circuit fault	Counter	14	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3322	11	Inv [n] unit 1 DC input 2 open circuit fault	Counter	14	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3323	11	Inv [n] unit 1 DC input 3 open circuit fault	Counter	14	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3324	11	Inv [n] unit 1 DC input 4 open circuit fault	Counter	14	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3325	11	Inv [n] unit 1 DC input 5 open circuit fault	Counter	14	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3326	11	Inv [n] unit 1 DC input 6 open circuit fault	Counter	14	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3327	11	Inv [n] unit 1 DC input 7 open circuit fault	Counter	14	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3328	11	Inv [n] unit 1 DC input 1 string failure alarm	Counter	14	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3329	11	Inv [n] unit 1 DC input 2 string failure alarm	Counter	14	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3330	11	Inv [n] unit 1 DC input 3 string failure alarm	Counter	14	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3331	11	Inv [n] unit 1 DC input 4 string failure alarm	Counter	14	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3332	11	Inv [n] unit 1 DC input 5 string failure alarm	Counter	14	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3333	11	Inv [n] unit 1 DC input 6 string failure alarm	Counter	14	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3334	11	Inv [n] unit 1 DC input 7 string failure alarm	Counter	14	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3335	11	Inv [n] unit 2 status register	Counter	20	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3336	11	Inv [n] unit 2 Unit is running	Counter	20	32-bit bitfield	0	\N	\N	None	Running	Stopped	\N	\N	\N	\N
3337	11	Inv [n] unit 2 Unit is stopped	Counter	20	32-bit bitfield	1	\N	\N	None	Stopped	Running	\N	\N	\N	\N
3338	11	Inv [n] unit 2 Run	Counter	20	32-bit bitfield	2	\N	\N	None	On	Off	\N	\N	\N	\N
3339	11	Inv [n] unit 2 Stop	Counter	20	32-bit bitfield	3	\N	\N	None	On	Off	\N	\N	\N	\N
3341	11	Inv [n] unit 2 Press to shutdown	Counter	20	32-bit bitfield	5	\N	\N	None	On	Off	\N	\N	\N	\N
3342	11	Inv [n] unit 2 Standby	Counter	20	32-bit bitfield	6	\N	\N	None	On	Off	\N	\N	\N	\N
3343	11	Inv [n] unit 2 Emergency stop	Counter	20	32-bit bitfield	7	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3344	11	Inv [n] unit 2 Starting up	Counter	20	32-bit bitfield	8	\N	\N	None	On	Off	\N	\N	\N	\N
3345	11	Inv [n] unit 2 Shutting down	Counter	20	32-bit bitfield	9	\N	\N	None	On	Off	\N	\N	\N	\N
3346	11	Inv [n] unit 2 Shut down	Counter	20	32-bit bitfield	10	\N	\N	None	On	Off	\N	\N	\N	\N
3347	11	Inv [n] unit 2 Warning run	Counter	20	32-bit bitfield	11	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3348	11	Inv [n] unit 2 Derating run	Counter	20	32-bit bitfield	12	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3349	11	Inv [n] unit 2 IO and DSP communication error	Counter	20	32-bit bitfield	13	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3350	11	Inv [n] unit 2 Anti-PID run	Counter	20	32-bit bitfield	14	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3351	11	Inv [n] unit 2 AC breaker status	Counter	20	32-bit bitfield	15	\N	\N	None	Closed	Open	\N	\N	\N	\N
3352	11	Inv [n] unit 2 DC switch 1 status	Counter	20	32-bit bitfield	16	\N	\N	None	Closed	Open	\N	\N	\N	\N
3353	11	Inv [n] unit 2 Emergency shutdown node	Counter	20	32-bit bitfield	17	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3354	11	Inv [n] unit 2 faults register 1	Counter	21	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3355	11	Inv [n] unit 2 Smoke node	Counter	21	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3356	11	Inv [n] unit 2 Access node	Counter	21	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3357	11	Inv [n] unit 2 DC undervoltage fault	Counter	21	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3358	11	Inv [n] unit 2 DC overvoltage fault	Counter	21	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3359	11	Inv [n] unit 2 AC undervoltage fault	Counter	21	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3360	11	Inv [n] unit 2 AC overvoltage fault	Counter	21	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3361	11	Inv [n] unit 2 Anti islanding protection active	Counter	21	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3362	11	Inv [n] unit 2 PDP protection active	Counter	21	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3363	11	Inv [n] unit 2 Module overtemperature fault	Counter	21	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3364	11	Inv [n] unit 2 Reactor overtemperature fault	Counter	21	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3365	11	Inv [n] unit 2 AC leakage current protection fault	Counter	21	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3366	11	Inv [n] unit 2 GFDI protection active	Counter	21	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3367	11	Inv [n] unit 2 Fan 1 fault	Counter	21	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3368	11	Inv [n] unit 2 DC overcurrent	Counter	21	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3369	11	Inv [n] unit 2 AC overcurrent	Counter	21	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3370	11	Inv [n] unit 2 Frequency abnormal	Counter	21	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3371	11	Inv [n] unit 2 Temperature abnormal	Counter	21	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3372	11	Inv [n] unit 2 Hardware fault	Counter	21	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3373	11	Inv [n] unit 2 Grounding fault	Counter	21	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3374	11	Inv [n] unit 2 Bus overvoltage	Counter	21	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3375	11	Inv [n] unit 2 Bus undervoltage	Counter	21	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3376	11	Inv [n] unit 2 Inverter overvoltage	Counter	21	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3377	11	Inv [n] unit 2 Low insulation resistance fault	Counter	21	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3378	11	Inv [n] unit 2 AC SPD fault	Counter	21	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3379	11	Inv [n] unit 2 Sampling fault	Counter	21	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3380	11	Inv [n] unit 2 DC polarity reversed fault	Counter	21	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3381	11	Inv [n] unit 2 Control power supply fault	Counter	21	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3382	11	Inv [n] unit 2 AC current imballance	Counter	21	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3383	11	Inv [n] unit 2 DC SPD fault	Counter	21	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3384	11	Inv [n] unit 2 DC component fault	Counter	21	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3385	11	Inv [n] unit 2 DC switch fault	Counter	21	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3386	11	Inv [n] unit 2 Repeated fault	Counter	21	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3387	11	Inv [n] unit 2 faults register 2	Counter	22	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3388	11	Inv [n] unit 2 Parallel operation communication failure	Counter	22	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3389	11	Inv [n] unit 2 Control cabinet temperature fault	Counter	22	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3390	11	Inv [n] unit 2 DC fuse ground fault	Counter	22	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3391	11	Inv [n] unit 2 Excessive DC reverse current fault	Counter	22	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3392	11	Inv [n] unit 2 Grid voltage imballance fault	Counter	22	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3393	11	Inv [n] unit 2 Inverter cabinet temperature fault	Counter	22	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3394	11	Inv [n] unit 2 AC cabinet temperature fault	Counter	22	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3395	11	Inv [n] unit 2 AC switch off	Counter	22	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3396	11	Inv [n] unit 2 AC switch fault	Counter	22	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3397	11	Inv [n] unit 2 Soft start fault	Counter	22	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3398	11	Inv [n] unit 2 DC voltage sampling fault	Counter	22	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3399	11	Inv [n] unit 2 Fan 2 fault	Counter	22	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3400	11	Inv [n] unit 2 Current unbalance 2	Counter	22	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3401	11	Inv [n] unit 2 Current unbalance 3	Counter	22	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3402	11	Inv [n] unit 2 DC cabinet temperature alarm	Counter	22	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3403	11	Inv [n] unit 2 Neutral point potential shift alarm	Counter	22	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3404	11	Inv [n] unit 2 Carrier sync failure	Counter	22	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3405	11	Inv [n] unit 2 Smoke alarm	Counter	22	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3406	11	Inv [n] unit 2 Access control protection alarm	Counter	22	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3407	11	Inv [n] unit 2 Emergency shutdown alarm	Counter	22	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3408	11	Inv [n] unit 2 alarms register	Counter	23	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3409	11	Inv [n] unit 2 Temperature abnormal alarm	Counter	23	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3410	11	Inv [n] unit 2 Low insulation resistance alarm	Counter	23	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3411	11	Inv [n] unit 2 GFRT operation alarm	Counter	23	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3412	11	Inv [n] unit 2 CT unbalance alarm	Counter	23	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3413	11	Inv [n] unit 2 DC sensor alarm	Counter	23	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3414	11	Inv [n] unit 2 DC SPD alarm	Counter	23	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3415	11	Inv [n] unit 2 AC SPD alarm	Counter	23	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3416	11	Inv [n] unit 2 DC switch alarm	Counter	23	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3417	11	Inv [n] unit 2 Anti-PID power alarm	Counter	23	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3418	11	Inv [n] unit 2 Cooling fan 1 alarm	Counter	23	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3419	11	Inv [n] unit 2 DC branch forward alarm	Counter	23	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3420	11	Inv [n] unit 2 DC branch reverse alarm	Counter	23	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3421	11	Inv [n] unit 2 AC switch alarm	Counter	23	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3422	11	Inv [n] unit 2 Meter communication failure alarm	Counter	23	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3423	11	Inv [n] unit 2 Cooling fan 2 alarm	Counter	23	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3424	11	Inv [n] unit 2 Temperature and humidity sensor alarm	Counter	23	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3425	11	Inv [n] unit 2 Frequency deviation active power regulation	Counter	23	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3426	11	Inv [n] unit 2 Voltage deviation reactive power regulation	Counter	23	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3427	11	Inv [n] unit 2 Busbar temperature alarm	Counter	23	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3428	11	Inv [n] unit 2 Cooling fan derating alarm	Counter	23	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3429	11	Inv [n] unit 2 Frequency abnormal	Counter	23	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3430	11	Inv [n] unit 2 HVRT operation	Counter	23	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3431	11	Inv [n] unit 2 LVRT operation	Counter	23	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3432	11	Inv [n] unit 2 array monitoring register	Counter	24	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3433	11	Inv [n] unit 2 DC input 1 open circuit fault	Counter	24	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3434	11	Inv [n] unit 2 DC input 2 open circuit fault	Counter	24	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3435	11	Inv [n] unit 2 DC input 3 open circuit fault	Counter	24	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3436	11	Inv [n] unit 2 DC input 4 open circuit fault	Counter	24	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3437	11	Inv [n] unit 2 DC input 5 open circuit fault	Counter	24	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3438	11	Inv [n] unit 2 DC input 6 open circuit fault	Counter	24	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3439	11	Inv [n] unit 2 DC input 7 open circuit fault	Counter	24	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3440	11	Inv [n] unit 2 DC input 1 string failure alarm	Counter	24	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3441	11	Inv [n] unit 2 DC input 2 string failure alarm	Counter	24	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3442	11	Inv [n] unit 2 DC input 3 string failure alarm	Counter	24	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3443	11	Inv [n] unit 2 DC input 4 string failure alarm	Counter	24	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3444	11	Inv [n] unit 2 DC input 5 string failure alarm	Counter	24	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3445	11	Inv [n] unit 2 DC input 6 string failure alarm	Counter	24	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3446	11	Inv [n] unit 2 DC input 7 string failure alarm	Counter	24	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3447	11	Inv [n] unit 3 status register	Counter	30	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3448	11	Inv [n] unit 3 Unit is running	Counter	30	32-bit bitfield	0	\N	\N	None	Running	Stopped	\N	\N	\N	\N
3449	11	Inv [n] unit 3 Unit is stopped	Counter	30	32-bit bitfield	1	\N	\N	None	Stopped	Running	\N	\N	\N	\N
3450	11	Inv [n] unit 3 Run	Counter	30	32-bit bitfield	2	\N	\N	None	On	Off	\N	\N	\N	\N
3451	11	Inv [n] unit 3 Stop	Counter	30	32-bit bitfield	3	\N	\N	None	On	Off	\N	\N	\N	\N
3452	11	Inv [n] unit 3 Initial standby	Counter	30	32-bit bitfield	4	\N	\N	None	On	Off	\N	\N	\N	\N
3453	11	Inv [n] unit 3 Press to shutdown	Counter	30	32-bit bitfield	5	\N	\N	None	On	Off	\N	\N	\N	\N
3454	11	Inv [n] unit 3 Standby	Counter	30	32-bit bitfield	6	\N	\N	None	On	Off	\N	\N	\N	\N
3455	11	Inv [n] unit 3 Emergency stop	Counter	30	32-bit bitfield	7	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3456	11	Inv [n] unit 3 Starting up	Counter	30	32-bit bitfield	8	\N	\N	None	On	Off	\N	\N	\N	\N
3457	11	Inv [n] unit 3 Shutting down	Counter	30	32-bit bitfield	9	\N	\N	None	On	Off	\N	\N	\N	\N
3458	11	Inv [n] unit 3 Shut down	Counter	30	32-bit bitfield	10	\N	\N	None	On	Off	\N	\N	\N	\N
3459	11	Inv [n] unit 3 Warning run	Counter	30	32-bit bitfield	11	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3460	11	Inv [n] unit 3 Derating run	Counter	30	32-bit bitfield	12	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3461	11	Inv [n] unit 3 IO and DSP communication error	Counter	30	32-bit bitfield	13	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3462	11	Inv [n] unit 3 Anti-PID run	Counter	30	32-bit bitfield	14	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3463	11	Inv [n] unit 3 AC breaker status	Counter	30	32-bit bitfield	15	\N	\N	None	Closed	Open	\N	\N	\N	\N
3464	11	Inv [n] unit 3 DC switch 1 status	Counter	30	32-bit bitfield	16	\N	\N	None	Closed	Open	\N	\N	\N	\N
3465	11	Inv [n] unit 3 Emergency shutdown node	Counter	30	32-bit bitfield	17	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3466	11	Inv [n] unit 3 faults register 1	Counter	31	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3467	11	Inv [n] unit 3 Smoke node	Counter	31	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3468	11	Inv [n] unit 3 Access node	Counter	31	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3469	11	Inv [n] unit 3 DC undervoltage fault	Counter	31	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3470	11	Inv [n] unit 3 DC overvoltage fault	Counter	31	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3471	11	Inv [n] unit 3 AC undervoltage fault	Counter	31	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3472	11	Inv [n] unit 3 AC overvoltage fault	Counter	31	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3473	11	Inv [n] unit 3 Anti islanding protection active	Counter	31	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3474	11	Inv [n] unit 3 PDP protection active	Counter	31	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3475	11	Inv [n] unit 3 Module overtemperature fault	Counter	31	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3476	11	Inv [n] unit 3 Reactor overtemperature fault	Counter	31	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3477	11	Inv [n] unit 3 AC leakage current protection fault	Counter	31	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3478	11	Inv [n] unit 3 GFDI protection active	Counter	31	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3479	11	Inv [n] unit 3 Fan 1 fault	Counter	31	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3480	11	Inv [n] unit 3 DC overcurrent	Counter	31	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3481	11	Inv [n] unit 3 AC overcurrent	Counter	31	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3482	11	Inv [n] unit 3 Frequency abnormal	Counter	31	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3483	11	Inv [n] unit 3 Temperature abnormal	Counter	31	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3484	11	Inv [n] unit 3 Hardware fault	Counter	31	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3485	11	Inv [n] unit 3 Grounding fault	Counter	31	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3486	11	Inv [n] unit 3 Bus overvoltage	Counter	31	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3487	11	Inv [n] unit 3 Bus undervoltage	Counter	31	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3488	11	Inv [n] unit 3 Inverter overvoltage	Counter	31	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3489	11	Inv [n] unit 3 Low insulation resistance fault	Counter	31	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3490	11	Inv [n] unit 3 AC SPD fault	Counter	31	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3491	11	Inv [n] unit 3 Sampling fault	Counter	31	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3492	11	Inv [n] unit 3 DC polarity reversed fault	Counter	31	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3493	11	Inv [n] unit 3 Control power supply fault	Counter	31	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3494	11	Inv [n] unit 3 AC current imballance	Counter	31	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3495	11	Inv [n] unit 3 DC SPD fault	Counter	31	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3496	11	Inv [n] unit 3 DC component fault	Counter	31	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3497	11	Inv [n] unit 3 DC switch fault	Counter	31	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3498	11	Inv [n] unit 3 Repeated fault	Counter	31	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3499	11	Inv [n] unit 3 faults register 2	Counter	32	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3500	11	Inv [n] unit 3 Parallel operation communication failure	Counter	32	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3501	11	Inv [n] unit 3 Control cabinet temperature fault	Counter	32	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3502	11	Inv [n] unit 3 DC fuse ground fault	Counter	32	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3503	11	Inv [n] unit 3 Excessive DC reverse current fault	Counter	32	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3504	11	Inv [n] unit 3 Grid voltage imballance fault	Counter	32	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3505	11	Inv [n] unit 3 Inverter cabinet temperature fault	Counter	32	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3506	11	Inv [n] unit 3 AC cabinet temperature fault	Counter	32	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3507	11	Inv [n] unit 3 AC switch off	Counter	32	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3508	11	Inv [n] unit 3 AC switch fault	Counter	32	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3509	11	Inv [n] unit 3 Soft start fault	Counter	32	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3510	11	Inv [n] unit 3 DC voltage sampling fault	Counter	32	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3511	11	Inv [n] unit 3 Fan 2 fault	Counter	32	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3512	11	Inv [n] unit 3 Current unbalance 2	Counter	32	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3513	11	Inv [n] unit 3 Current unbalance 3	Counter	32	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3514	11	Inv [n] unit 3 DC cabinet temperature alarm	Counter	32	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3515	11	Inv [n] unit 3 Neutral point potential shift alarm	Counter	32	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3516	11	Inv [n] unit 3 Carrier sync failure	Counter	32	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3517	11	Inv [n] unit 3 Smoke alarm	Counter	32	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3518	11	Inv [n] unit 3 Access control protection alarm	Counter	32	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3519	11	Inv [n] unit 3 Emergency shutdown alarm	Counter	32	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3520	11	Inv [n] unit 3 alarms register	Counter	33	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3521	11	Inv [n] unit 3 Temperature abnormal alarm	Counter	33	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3522	11	Inv [n] unit 3 Low insulation resistance alarm	Counter	33	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3523	11	Inv [n] unit 3 GFRT operation alarm	Counter	33	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3524	11	Inv [n] unit 3 CT unbalance alarm	Counter	33	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3525	11	Inv [n] unit 3 DC sensor alarm	Counter	33	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3526	11	Inv [n] unit 3 DC SPD alarm	Counter	33	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3527	11	Inv [n] unit 3 AC SPD alarm	Counter	33	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3528	11	Inv [n] unit 3 DC switch alarm	Counter	33	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3529	11	Inv [n] unit 3 Anti-PID power alarm	Counter	33	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3530	11	Inv [n] unit 3 Cooling fan 1 alarm	Counter	33	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3531	11	Inv [n] unit 3 DC branch forward alarm	Counter	33	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3532	11	Inv [n] unit 3 DC branch reverse alarm	Counter	33	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3533	11	Inv [n] unit 3 AC switch alarm	Counter	33	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3534	11	Inv [n] unit 3 Meter communication failure alarm	Counter	33	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3535	11	Inv [n] unit 3 Cooling fan 2 alarm	Counter	33	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3536	11	Inv [n] unit 3 Temperature and humidity sensor alarm	Counter	33	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3537	11	Inv [n] unit 3 Frequency deviation active power regulation	Counter	33	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3538	11	Inv [n] unit 3 Voltage deviation reactive power regulation	Counter	33	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3539	11	Inv [n] unit 3 Busbar temperature alarm	Counter	33	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3540	11	Inv [n] unit 3 Cooling fan derating alarm	Counter	33	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3541	11	Inv [n] unit 3 Frequency abnormal	Counter	33	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3542	11	Inv [n] unit 3 HVRT operation	Counter	33	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3543	11	Inv [n] unit 3 LVRT operation	Counter	33	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3544	11	Inv [n] unit 3 array monitoring register	Counter	34	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3545	11	Inv [n] unit 3 DC input 1 open circuit fault	Counter	34	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3546	11	Inv [n] unit 3 DC input 2 open circuit fault	Counter	34	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3547	11	Inv [n] unit 3 DC input 3 open circuit fault	Counter	34	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3548	11	Inv [n] unit 3 DC input 4 open circuit fault	Counter	34	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3549	11	Inv [n] unit 3 DC input 5 open circuit fault	Counter	34	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3550	11	Inv [n] unit 3 DC input 6 open circuit fault	Counter	34	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3551	11	Inv [n] unit 3 DC input 7 open circuit fault	Counter	34	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3552	11	Inv [n] unit 3 DC input 1 string failure alarm	Counter	34	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3553	11	Inv [n] unit 3 DC input 2 string failure alarm	Counter	34	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3554	11	Inv [n] unit 3 DC input 3 string failure alarm	Counter	34	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3555	11	Inv [n] unit 3 DC input 4 string failure alarm	Counter	34	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3556	11	Inv [n] unit 3 DC input 5 string failure alarm	Counter	34	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3557	11	Inv [n] unit 3 DC input 6 string failure alarm	Counter	34	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3558	11	Inv [n] unit 3 DC input 7 string failure alarm	Counter	34	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3559	11	Inv [n] unit 4 status register	Counter	40	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3560	11	Inv [n] unit 4 Unit is running	Counter	40	32-bit bitfield	0	\N	\N	None	Running	Stopped	\N	\N	\N	\N
3561	11	Inv [n] unit 4 Unit is stopped	Counter	40	32-bit bitfield	1	\N	\N	None	Stopped	Running	\N	\N	\N	\N
3562	11	Inv [n] unit 4 Run	Counter	40	32-bit bitfield	2	\N	\N	None	On	Off	\N	\N	\N	\N
3563	11	Inv [n] unit 4 Stop	Counter	40	32-bit bitfield	3	\N	\N	None	On	Off	\N	\N	\N	\N
3564	11	Inv [n] unit 4 Initial standby	Counter	40	32-bit bitfield	4	\N	\N	None	On	Off	\N	\N	\N	\N
3565	11	Inv [n] unit 4 Press to shutdown	Counter	40	32-bit bitfield	5	\N	\N	None	On	Off	\N	\N	\N	\N
3566	11	Inv [n] unit 4 Standby	Counter	40	32-bit bitfield	6	\N	\N	None	On	Off	\N	\N	\N	\N
3567	11	Inv [n] unit 4 Emergency stop	Counter	40	32-bit bitfield	7	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3568	11	Inv [n] unit 4 Starting up	Counter	40	32-bit bitfield	8	\N	\N	None	On	Off	\N	\N	\N	\N
3569	11	Inv [n] unit 4 Shutting down	Counter	40	32-bit bitfield	9	\N	\N	None	On	Off	\N	\N	\N	\N
3570	11	Inv [n] unit 4 Shut down	Counter	40	32-bit bitfield	10	\N	\N	None	On	Off	\N	\N	\N	\N
3571	11	Inv [n] unit 4 Warning run	Counter	40	32-bit bitfield	11	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3572	11	Inv [n] unit 4 Derating run	Counter	40	32-bit bitfield	12	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3573	11	Inv [n] unit 4 IO and DSP communication error	Counter	40	32-bit bitfield	13	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3574	11	Inv [n] unit 4 Anti-PID run	Counter	40	32-bit bitfield	14	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3575	11	Inv [n] unit 4 AC breaker status	Counter	40	32-bit bitfield	15	\N	\N	None	Closed	Open	\N	\N	\N	\N
3576	11	Inv [n] unit 4 DC switch 1 status	Counter	40	32-bit bitfield	16	\N	\N	None	Closed	Open	\N	\N	\N	\N
3577	11	Inv [n] unit 4 Emergency shutdown node	Counter	40	32-bit bitfield	17	\N	\N	On (1)	On	Off	\N	\N	\N	\N
3578	11	Inv [n] unit 4 faults register 1	Counter	41	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3579	11	Inv [n] unit 4 Smoke node	Counter	41	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3580	11	Inv [n] unit 4 Access node	Counter	41	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3581	11	Inv [n] unit 4 DC undervoltage fault	Counter	41	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3582	11	Inv [n] unit 4 DC overvoltage fault	Counter	41	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3583	11	Inv [n] unit 4 AC undervoltage fault	Counter	41	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3584	11	Inv [n] unit 4 AC overvoltage fault	Counter	41	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3585	11	Inv [n] unit 4 Anti islanding protection active	Counter	41	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3586	11	Inv [n] unit 4 PDP protection active	Counter	41	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3587	11	Inv [n] unit 4 Module overtemperature fault	Counter	41	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3588	11	Inv [n] unit 4 Reactor overtemperature fault	Counter	41	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3589	11	Inv [n] unit 4 AC leakage current protection fault	Counter	41	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3590	11	Inv [n] unit 4 GFDI protection active	Counter	41	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3591	11	Inv [n] unit 4 Fan 1 fault	Counter	41	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3592	11	Inv [n] unit 4 DC overcurrent	Counter	41	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3593	11	Inv [n] unit 4 AC overcurrent	Counter	41	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3594	11	Inv [n] unit 4 Frequency abnormal	Counter	41	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3595	11	Inv [n] unit 4 Temperature abnormal	Counter	41	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3596	11	Inv [n] unit 4 Hardware fault	Counter	41	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3597	11	Inv [n] unit 4 Grounding fault	Counter	41	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3598	11	Inv [n] unit 4 Bus overvoltage	Counter	41	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3599	11	Inv [n] unit 4 Bus undervoltage	Counter	41	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3600	11	Inv [n] unit 4 Inverter overvoltage	Counter	41	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3601	11	Inv [n] unit 4 Low insulation resistance fault	Counter	41	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3602	11	Inv [n] unit 4 AC SPD fault	Counter	41	32-bit bitfield	23	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3603	11	Inv [n] unit 4 Sampling fault	Counter	41	32-bit bitfield	24	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3604	11	Inv [n] unit 4 DC polarity reversed fault	Counter	41	32-bit bitfield	25	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3605	11	Inv [n] unit 4 Control power supply fault	Counter	41	32-bit bitfield	26	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3606	11	Inv [n] unit 4 AC current imballance	Counter	41	32-bit bitfield	27	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3607	11	Inv [n] unit 4 DC SPD fault	Counter	41	32-bit bitfield	28	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3608	11	Inv [n] unit 4 DC component fault	Counter	41	32-bit bitfield	29	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3609	11	Inv [n] unit 4 DC switch fault	Counter	41	32-bit bitfield	30	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3610	11	Inv [n] unit 4 Repeated fault	Counter	41	32-bit bitfield	31	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3611	11	Inv [n] unit 4 faults register 2	Counter	42	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3612	11	Inv [n] unit 4 Parallel operation communication failure	Counter	42	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3613	11	Inv [n] unit 4 Control cabinet temperature fault	Counter	42	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3614	11	Inv [n] unit 4 DC fuse ground fault	Counter	42	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3615	11	Inv [n] unit 4 Excessive DC reverse current fault	Counter	42	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3616	11	Inv [n] unit 4 Grid voltage imballance fault	Counter	42	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3617	11	Inv [n] unit 4 Inverter cabinet temperature fault	Counter	42	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3618	11	Inv [n] unit 4 AC cabinet temperature fault	Counter	42	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3619	11	Inv [n] unit 4 AC switch off	Counter	42	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3620	11	Inv [n] unit 4 AC switch fault	Counter	42	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3621	11	Inv [n] unit 4 Soft start fault	Counter	42	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3622	11	Inv [n] unit 4 DC voltage sampling fault	Counter	42	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3623	11	Inv [n] unit 4 Fan 2 fault	Counter	42	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3624	11	Inv [n] unit 4 Current unbalance 2	Counter	42	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3625	11	Inv [n] unit 4 Current unbalance 3	Counter	42	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3626	11	Inv [n] unit 4 DC cabinet temperature alarm	Counter	42	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3627	11	Inv [n] unit 4 Neutral point potential shift alarm	Counter	42	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3628	11	Inv [n] unit 4 Carrier sync failure	Counter	42	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3629	11	Inv [n] unit 4 Smoke alarm	Counter	42	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3630	11	Inv [n] unit 4 Access control protection alarm	Counter	42	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3631	11	Inv [n] unit 4 Emergency shutdown alarm	Counter	42	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3632	11	Inv [n] unit 4 alarms register	Counter	43	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3633	11	Inv [n] unit 4 Temperature abnormal alarm	Counter	43	32-bit bitfield	0	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3634	11	Inv [n] unit 4 Low insulation resistance alarm	Counter	43	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3635	11	Inv [n] unit 4 GFRT operation alarm	Counter	43	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3636	11	Inv [n] unit 4 CT unbalance alarm	Counter	43	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3637	11	Inv [n] unit 4 DC sensor alarm	Counter	43	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3638	11	Inv [n] unit 4 DC SPD alarm	Counter	43	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3639	11	Inv [n] unit 4 AC SPD alarm	Counter	43	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3640	11	Inv [n] unit 4 DC switch alarm	Counter	43	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3641	11	Inv [n] unit 4 Anti-PID power alarm	Counter	43	32-bit bitfield	8	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3642	11	Inv [n] unit 4 Cooling fan 1 alarm	Counter	43	32-bit bitfield	9	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3643	11	Inv [n] unit 4 DC branch forward alarm	Counter	43	32-bit bitfield	10	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3644	11	Inv [n] unit 4 DC branch reverse alarm	Counter	43	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3645	11	Inv [n] unit 4 AC switch alarm	Counter	43	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3646	11	Inv [n] unit 4 Meter communication failure alarm	Counter	43	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3647	11	Inv [n] unit 4 Cooling fan 2 alarm	Counter	43	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3648	11	Inv [n] unit 4 Temperature and humidity sensor alarm	Counter	43	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3649	11	Inv [n] unit 4 Frequency deviation active power regulation	Counter	43	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3650	11	Inv [n] unit 4 Voltage deviation reactive power regulation	Counter	43	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3651	11	Inv [n] unit 4 Busbar temperature alarm	Counter	43	32-bit bitfield	18	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3652	11	Inv [n] unit 4 Cooling fan derating alarm	Counter	43	32-bit bitfield	19	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3653	11	Inv [n] unit 4 Frequency abnormal	Counter	43	32-bit bitfield	20	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3654	11	Inv [n] unit 4 HVRT operation	Counter	43	32-bit bitfield	21	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3655	11	Inv [n] unit 4 LVRT operation	Counter	43	32-bit bitfield	22	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3656	11	Inv [n] unit 4 array monitoring register	Counter	44	32-bit bitfield	\N	unitless	1	None	\N	\N	\N	\N	\N	\N
3657	11	Inv [n] unit 4 DC input 1 open circuit fault	Counter	44	32-bit bitfield	1	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3658	11	Inv [n] unit 4 DC input 2 open circuit fault	Counter	44	32-bit bitfield	2	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3659	11	Inv [n] unit 4 DC input 3 open circuit fault	Counter	44	32-bit bitfield	3	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3660	11	Inv [n] unit 4 DC input 4 open circuit fault	Counter	44	32-bit bitfield	4	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3661	11	Inv [n] unit 4 DC input 5 open circuit fault	Counter	44	32-bit bitfield	5	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3662	11	Inv [n] unit 4 DC input 6 open circuit fault	Counter	44	32-bit bitfield	6	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3663	11	Inv [n] unit 4 DC input 7 open circuit fault	Counter	44	32-bit bitfield	7	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3664	11	Inv [n] unit 4 DC input 1 string failure alarm	Counter	44	32-bit bitfield	11	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3665	11	Inv [n] unit 4 DC input 2 string failure alarm	Counter	44	32-bit bitfield	12	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3666	11	Inv [n] unit 4 DC input 3 string failure alarm	Counter	44	32-bit bitfield	13	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3667	11	Inv [n] unit 4 DC input 4 string failure alarm	Counter	44	32-bit bitfield	14	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3668	11	Inv [n] unit 4 DC input 5 string failure alarm	Counter	44	32-bit bitfield	15	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3669	11	Inv [n] unit 4 DC input 6 string failure alarm	Counter	44	32-bit bitfield	16	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3670	11	Inv [n] unit 4 DC input 7 string failure alarm	Counter	44	32-bit bitfield	17	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3671	11	Inv [n] MV node status register (transformer)	Counter	100	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3672	11	Inv [n] Entire system working state register	Counter	101	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3673	11	Inv [n] MV node status 1 register	Counter	102	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3674	11	Inv [n] MV node status 2 register	Counter	103	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3675	11	Inv [n] Overall alarm status register	Counter	104	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3676	11	Inv [n] DI node status register	Counter	105	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3677	11	Inv [n] PMD_IODI input status register	Counter	106	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3678	11	Inv [n] UPS conversion status register	Counter	107	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3679	11	Inv [n] UPS alarm status regsiter	Counter	108	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3680	11	Inv [n] ISO board fault status register	Counter	109	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3681	11	Inv [n] ISO board alarm status register	Counter	110	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3682	11	Inv [n] Branch open circuit alarm register	Counter	111	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3683	11	Inv [n] Branch string fault alarm register	Counter	112	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3684	11	Inv [n] unit 1 fault status 1 register	Counter	113	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3685	11	Inv [n] unit 1 fault status 2 register	Counter	114	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3686	11	Inv [n] unit 1 fault status 3 register	Counter	115	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3687	11	Inv [n] unit 1 node status register	Counter	116	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3688	11	Inv [n] unit 1 working status register	Counter	117	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3689	11	Inv [n] unit 1 alarm status register	Counter	118	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3690	11	Inv [n] unit 1 running status register	Counter	119	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3691	11	Inv [n] unit 2 fault status 1 register	Counter	120	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3692	11	Inv [n] unit 2 fault status 2 register	Counter	121	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3693	11	Inv [n] unit 2 fault status 3 register	Counter	122	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3694	11	Inv [n] unit 2 node status register	Counter	123	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3695	11	Inv [n] unit 2 working status register	Counter	124	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3696	11	Inv [n] unit 2 alarm status register	Counter	125	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3697	11	Inv [n] unit 2 running status register	Counter	126	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3698	11	Inv [n] unit 3 fault status 1 register	Counter	127	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3699	11	Inv [n] unit 3 fault status 2 register	Counter	128	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3700	11	Inv [n] unit 3 fault status 3 register	Counter	129	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3701	11	Inv [n] unit 3 node status register	Counter	130	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3702	11	Inv [n] unit 3 working status register	Counter	131	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3703	11	Inv [n] unit 3 alarm status register	Counter	132	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3704	11	Inv [n] unit 3 running status register	Counter	133	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3705	11	Inv [n] unit 4 fault status 1 register	Counter	134	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3706	11	Inv [n] unit 4 fault status 2 register	Counter	135	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3707	11	Inv [n] unit 4 fault status 3 register	Counter	136	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3708	11	Inv [n] unit 4 node status register	Counter	137	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3709	11	Inv [n] unit 4 working status register	Counter	138	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3710	11	Inv [n] unit 4 alarm status register	Counter	139	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3711	11	Inv [n] unit 4 running status register	Counter	140	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
3712	11	Inv [n] any alarm	Binary input	0	Boolean	\N	\N	\N	None	Alarm	Normal	\N	\N	\N	\N
3713	11	Inv [n] any fault	Binary input	1	Boolean	\N	\N	\N	None	Alarm	Normal	\N	\N	\N	\N
3714	11	Inv [n] communication failure alarm	Binary input	2	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
3715	11	Inv [n] manual control status	Binary input	3	Boolean	\N	\N	\N	On (1)	Manual	Auto	\N	\N	\N	\N
3716	11	Inv [n] manual active power setpoint	Analog output	0	32-bit float	\N	kW	1	\N	\N	\N	\N	\N	\N	\N
3717	11	Inv [n] manual reactive power setpoint	Analog output	1	32-bit float	\N	kvar or PU 	1	\N	\N	\N	\N	\N	\N	\N
3718	11	Inv [n] manual reactive power mode	Analog output	2	32-bit signed integer	\N	enumeration	1	\N	\N	\N	\N	\N	0 to 2	Voltage; Q(U) and Q(P) modes are not selectable through the HMI
3719	11	Inv [n] manual control	Binary output	0	Boolean	\N	\N	\N	None	Manual	Auto	\N	\N	\N	\N
3720	11	Inv [n] manual start stop	Binary output	1	Boolean	\N	\N	\N	None	Start	Stop	\N	\N	\N	\N
3721	11	Inv [n] remote emergency stop	Binary output	2	Boolean	\N	\N	\N	None	E-stop	Normal	\N	\N	\N	\N
3722	11	Inv [n] manual DC switch open close	Binary output	3	Boolean	\N	\N	\N	None	Close	Open	\N	\N	\N	\N
4067	13	Cap bank manual close open command	Binary output	3	Boolean	LOn:LOff	\N	\N	\N	Close	Open	\N	\N	\N	\N
4068	13	Cap bank automatic control enable disable	Binary output	4	Boolean	LOn:LOff	\N	\N	\N	Auto	Manual	\N	\N	\N	\N
4006	13	Plant status	Analog input	0	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Plant Operation Status:\n ESTOP  0;\n STOPPED  1;\n STANDBY  2;\n WARMUP  3;\n RUN_NIGHT_SVC  4;\n RUN_OPEN_LOOP  5;\n RUN_OL_RAMP  6;\n RUN_CLOSED_LOOP  7;\n RUN_CL_RAMP  8;\n SHUTTING_DOWN  9	\N
4007	13	Active power mode feedback	Analog input	1	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Active power modes:\nUnlimited   0\nCurtailment  1\nDispatch  2	\N
4008	13	Active power setpoint feedback	Analog input	2	32-bit float	\N	MW	1	\N	\N	\N	\N	\N	\N	\N
4009	13	Reactive power mode feedback	Analog input	3	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Reactive power modes:\n\n0 - Off\n1 - Var output regulation\n2 - PF regulation\n3 - AVR (voltage regulation)\n	\N
4010	13	Voltage regulation setpoint feedback	Analog input	4	32-bit float	\N	kV	1	\N	\N	\N	\N	\N	\N	\N
4011	13	Power factor regulation setpoint feedback	Analog input	5	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
4012	13	Var output regulation setpoint feedback	Analog input	6	32-bit float	\N	Mvar	1	\N	\N	\N	\N	\N	\N	\N
4013	13	Control command source feedback	Analog input	7	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Command/Setpoint Source:\n0 - HMI only\n1 - Interface only\n2 - HMI and interface	\N
4014	13	Setpoint source feedback	Analog input	8	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Command/Setpoint Source:\n0 - HMI only\n1 - Interface only\n2 - HMI and interface	\N
4015	13	Generation output	Analog input	9	32-bit float	\N	MW	1	\N	\N	\N	\N	\N	\N	\N
4016	13	Reactive output	Analog input	10	32-bit float	\N	Mvar	1	\N	\N	\N	\N	\N	\N	\N
4017	13	Median Line-Line Voltage	Analog input	11	32-bit float	\N	kV	1	\N	\N	\N	\N	\N	\N	 3ph median ph-ph
4018	13	Power factor	Analog input	12	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
4019	13	Frequency	Analog input	13	32-bit float	\N	Hz	1	\N	\N	\N	\N	\N	\N	\N
4020	13	Maximum available generation output	Analog input	14	32-bit float	\N	MW	1	\N	\N	\N	\N	\N	\N	\N
4021	13	Maximum available reactive source	Analog input	15	32-bit float	\N	Mvar	1	\N	\N	\N	\N	\N	\N	\N
4022	13	Maximum available reactive sink	Analog input	16	32-bit float	\N	Mvar	1	\N	\N	\N	\N	\N	\N	\N
4023	13	Site average insolation	Analog input	17	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
4024	13	Net energy generation today	Analog input	18	32-bit float	\N	MWh	1	\N	\N	\N	\N	\N	\N	\N
4025	13	Net energy generation yesterday	Analog input	19	32-bit float	\N	MWh	1	\N	\N	\N	\N	\N	\N	\N
4026	13	Number of inverters online	Analog input	20	32-bit float	\N	count	1	\N	\N	\N	\N	\N	\N	\N
4027	13	Number of inverters available	Analog input	21	32-bit float	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4028	13	Average BOM temperature	Analog input	22	32-bit float	\N	degC	1	\N	\N	\N	\N	\N	\N	\N
4029	13	Average ambient temperature	Analog input	23	32-bit float	\N	degC	1	\N	\N	\N	\N	\N	\N	\N
4030	13	Average wind speed	Analog input	24	32-bit float	\N	m/s	1	\N	\N	\N	\N	\N	\N	\N
4031	13	Prevailing wind direction	Analog input	25	32-bit float	\N	degrees	1	\N	\N	\N	\N	\N	\N	\N
4032	13	Average GHI irradiance	Analog input	26	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
4033	13	Average POA irradiance	Analog input	27	32-bit float	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
4034	13	Average relative humidity	Analog input	28	32-bit float	\N	%	1	\N	\N	\N	\N	\N	\N	\N
4035	13	Average barometric pressure	Analog input	29	32-bit float	\N	mbar	1	\N	\N	\N	\N	\N	\N	\N
4036	13	Average rain intensity	Analog input	30	32-bit float	\N	mm/hr	1	\N	\N	\N	\N	\N	\N	\N
4037	13	Active power ramp rate feedback	Analog input	31	32-bit float	\N	kW/s	1	\N	\N	\N	\N	\N	\N	\N
4038	13	Reactive power ramp rate feedback	Analog input	32	32-bit float	\N	kvar/s	1	\N	\N	\N	\N	\N	\N	\N
4039	13	Grid curtailment setpoint (SPARE)	Analog input	33	32-bit float	\N	MW	1	\N	\N	\N	\N	\N	\N	\N
4040	13	Active power mode	Analog output	0	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Active power modes:\nUnlimited   0\nCurtailment  1\nDispatch  2	\N
4041	13	Active power setpoint	Analog output	1	32-bit float	\N	MW	1	\N	\N	\N	\N	\N	\N	\N
4042	13	Reactive power mode	Analog output	2	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Reactive power modes:\n\n0 - Off\n1 - Var output regulation\n2 - PF regulation\n3 - AVR (voltage regulation)\n	\N
4043	13	Voltage regulation setpoint	Analog output	3	32-bit float	\N	kV	1	\N	\N	\N	\N	\N	\N	\N
4044	13	Power factor regulation setpoint	Analog output	4	32-bit float	\N	PU	1	\N	\N	\N	\N	\N	\N	\N
4045	13	Var output regulation setpoint	Analog output	5	32-bit float	\N	Mvar	1	\N	\N	\N	\N	\N	\N	\N
4046	13	Control command source	Analog output	6	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Command/Setpoint Source:\n0 - HMI only\n1 - Interface only\n2 - HMI and interface	\N
4047	13	Setpoint source	Analog output	7	32-bit float	\N	enumeration	1	\N	\N	\N	\N	\N	Command/Setpoint Source:\n0 - HMI only\n1 - Interface only\n2 - HMI and interface	\N
4048	13	Active power ramp rate	Analog output	8	32-bit float	\N	kW/s	1	\N	\N	\N	\N	\N	\N	\N
4049	13	Reactive power ramp rate	Analog output	9	32-bit float	\N	kvar/s	1	\N	\N	\N	\N	\N	\N	\N
4050	13	Primary meter communication alarm	Binary input	0	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4051	13	Backup meter communication alarm	Binary input	1	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4052	13	Backup meter in use for generation control	Binary input	2	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4053	13	Primary - backup meter disagreement alarm	Binary input	3	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4054	13	Open loop operation alarm	Binary input	4	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4055	13	Night SVC enable feedback	Binary input	5	Boolean	\N	\N	\N	None	Enable	Disable	\N	\N	\N	\N
4056	13	Cap bank PPC control enable feedback	Binary input	6	Boolean	\N	\N	\N	None	Enable	Disable	\N	\N	\N	\N
4057	13	Cap bank in manual control	Binary input	7	Boolean	\N	\N	\N	None	Manual	Auto	\N	\N	\N	\N
4058	13	Cap bank position error	Binary input	8	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4059	13	Command source alarm	Binary input	9	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4060	13	Invalid command value alarm	Binary input	10	Boolean	\N	\N	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4061	13	Last setpoint source	Binary input	11	Boolean	\N	\N	\N	None	Interface	HMI	\N	\N	\N	\N
4062	13	Grid curtailment flag	Binary input	12	Boolean	\N	\N	\N	None	On	Off	\N	\N	\N	\N
4063	13	RTU permit to operate cap bank	Binary input	13	Boolean	\N	\N	\N	Off (0)	Enable	Disable	\N	\N	\N	\N
4064	13	Plant start stop command	Binary output	0	Boolean	LOn:LOff	\N	\N	\N	Start	Stop	\N	\N	\N	\N
4065	13	Night SVC enable disable command	Binary output	1	Boolean	LOn:LOff	\N	\N	\N	Enable	Disable	\N	\N	\N	\N
4066	13	Cap bank PPC control enable disable command	Binary output	2	Boolean	LOn:LOff	\N	\N	\N	Enable	Disable	\N	\N	\N	\N
4069	13	Emergency stop command	Binary output	5	Boolean	LOn	\N	\N	\N	Stop	\N	\N	\N	\N	\N
4070	13	Curtailment enable disable from grid control	Binary output	6	Boolean	LOn:LOff	\N	\N	\N	Enable	Disable	\N	\N	\N	\N
4071	14	TRK-[n] Firmware version	Holding Register	450000	32-bit signed integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4072	14	TRK-[n] NCU serial number	Holding Register	450002	String	\N	ASCII	16	\N	\N	\N	\N	\N	\N	\N
4073	14	TRK-[n] Time zone	Holding Register	450010	16-bit signed integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
4074	14	TRK-[n] Longitude	Holding Register	450011	64-bit signed integer	\N	degrees	1e+06	\N	\N	\N	\N	\N	\N	\N
4075	14	TRK-[n] Latitude	Holding Register	450015	64-bit signed integer	\N	degrees	1e+06	\N	\N	\N	\N	\N	\N	\N
4076	14	TRK-[n] Elevation	Holding Register	450019	32-bit signed integer	\N	m	1	\N	\N	\N	\N	\N	\N	\N
4077	14	TRK-[n] Zigbee ID	Holding Register	450020	32-bit signed integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4078	14	TRK-[n] IP address	Holding Register	450021	32-bit unsigned integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4079	14	TRK-[n] NCU UTC time second	Holding Register	450023	32-bit signed integer	\N	s	1	\N	\N	\N	\N	\N	\N	\N
4080	14	TRK-[n] NCU UTC time minute	Holding Register	450024	32-bit signed integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
4081	14	TRK-[n] NCU UTC time hour	Holding Register	450025	32-bit signed integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
4082	14	TRK-[n] NCU UTC time day	Holding Register	450026	32-bit signed integer	\N	day	1	\N	\N	\N	\N	\N	\N	\N
4083	14	TRK-[n] NCU UTC time month	Holding Register	450027	32-bit signed integer	\N	month	1	\N	\N	\N	\N	\N	\N	\N
4084	14	TRK-[n] NCU UTC time year	Holding Register	450028	32-bit signed integer	\N	year	1	\N	\N	\N	\N	\N	\N	\N
4085	14	TRK-[n] AC Power Fault	Holding Register	450029	32-bit signed integer	\N	enumeration	1	\N	\N	\N	\N	\N	\N	Faults can be cleared by writing a 0 to this point.
4086	14	TRK-[n] Global tracker state	Holding Register	450031	32-bit signed integer	\N	enumeration	1	\N	\N	\N	\N	\N	0-5: R/W; 6-10: R/O	\N
4087	14	TRK-[n] SPCs and WS connected	Holding Register	450032	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
4088	14	TRK-[n] Wind speed	Holding Register	450033	32-bit signed integer	\N	mph	1	\N	\N	\N	\N	\N	\N	\N
4089	14	TRK-[n] Water level	Holding Register	450034	32-bit signed integer	\N	in	100	\N	\N	\N	\N	\N	\N	\N
4090	14	TRK-[n] SPCs online	Holding Register	450035	32-bit signed integer	\N	count	1	\N	\N	\N	\N	\N	\N	\N
4091	14	TRK-[n] GHI sensor	Holding Register	450036	32-bit signed integer	\N	W/m2	1	\N	\N	\N	\N	\N	\N	\N
4092	14	TRK-[n] Snow Level	Holding Register	450038	32-bit signed integer	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4093	14	TRK-[n] Row [r] SPC firmware version	Input Register	4[r]50	32-bit signed integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4094	14	TRK-[n] Row [r] SPC serial number	Input Register	4[r]52	String	\N	ASCII	16	\N	\N	\N	\N	\N	\N	\N
4095	14	TRK-[n] Row [r] SPC fault register	Holding Register	4[r]60	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4096	14	TRK-[n] battery over current	Holding Register	4[r]60	Boolean	0	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4097	14	TRK-[n] battery over voltage	Holding Register	4[r]60	Boolean	1	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4098	14	TRK-[n] Row [r] boost over current	Holding Register	4[r]60	Boolean	2	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4099	14	TRK-[n] Row [r] boost over voltage	Holding Register	4[r]60	Boolean	3	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4100	14	TRK-[n] Row [r] panel over coltage	Holding Register	4[r]60	Boolean	4	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4101	14	TRK-[n] Row [r] panel over current	Holding Register	4[r]60	Boolean	5	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4102	14	TRK-[n] Row [r] motor over current	Holding Register	4[r]60	Boolean	6	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4103	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	7	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4104	14	TRK-[n] Row [r] motor inrush over current	Holding Register	4[r]60	Boolean	8	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4105	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	9	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4106	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	10	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4107	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	11	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4108	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	12	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4109	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	13	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4110	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	14	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4111	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	15	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4112	14	TRK-[n] Row [r] spc over temperature	Holding Register	4[r]60	Boolean	16	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4113	14	TRK-[n] Row [r] battery over temperature	Holding Register	4[r]60	Boolean	17	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4114	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	18	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4115	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	19	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4116	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	20	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4117	14	TRK-[n] Row [r] tracker stall	Holding Register	4[r]60	Boolean	21	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4118	14	TRK-[n] Row [r] boost start timeout	Holding Register	4[r]60	Boolean	22	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4119	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	23	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4120	14	TRK-[n] Row [r] software system error	Holding Register	4[r]60	Boolean	24	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4121	14	TRK-[n] Row [r] firmware loading error	Holding Register	4[r]60	Boolean	25	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4122	14	TRK-[n] Row [r] user setting loading error	Holding Register	4[r]60	Boolean	26	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4123	14	TRK-[n] Row [r] tilt sensor error	Holding Register	4[r]60	Boolean	27	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4124	14	TRK-[n] Row [r] motor stall	Holding Register	4[r]60	Boolean	28	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4125	14	TRK-[n] Row [r] actuator fail	Holding Register	4[r]60	Boolean	29	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4126	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	30	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4127	14	TRK-[n] Row [r] reserved	Holding Register	4[r]60	Boolean	31	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4128	14	TRK-[n] Row [r] SPC alert	Input Register	4[r]62	16-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4129	14	TRK-[n] Row [r] reserved	Input Register	4[r]62	Boolean	0	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4130	14	TRK-[n] Row [r] reserved	Input Register	4[r]62	Boolean	1	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4131	14	TRK-[n] Row [r] snow shed	Input Register	4[r]62	Boolean	2	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4132	14	TRK-[n] Row [r] snow shed blackout	Input Register	4[r]62	Boolean	3	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4133	14	TRK-[n] Row [r] low battery stow	Input Register	4[r]62	Boolean	4	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4134	14	TRK-[n] Row [r] reserved	Input Register	4[r]62	Boolean	5	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4135	14	TRK-[n] Row [r] reserved	Input Register	4[r]62	Boolean	6	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4136	14	TRK-[n] Row [r] real time clock failed	Input Register	4[r]62	Boolean	7	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4137	14	TRK-[n] Row [r] factory firmware	Input Register	4[r]62	Boolean	8	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4138	14	TRK-[n] Row [r] invalid serial number	Input Register	4[r]62	Boolean	9	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4139	14	TRK-[n] Row [r] night stow enabled	Input Register	4[r]62	Boolean	10	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4140	14	TRK-[n] Row [r] wind stow enabled	Input Register	4[r]62	Boolean	11	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4141	14	TRK-[n] Row [r] reserved	Input Register	4[r]62	Boolean	12	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4142	14	TRK-[n] Row [r] flood stow enabled	Input Register	4[r]62	Boolean	13	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4143	14	TRK-[n] Row [r] snow stow enabled	Input Register	4[r]62	Boolean	14	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4144	14	TRK-[n] Row [r] reserved	Input Register	4[r]62	Boolean	15	boolean	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4145	14	TRK-[n] Row [r] SPC status	Input Register	4[r]63	16-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4146	14	TRK-[n] Row [r] Battery charger status	Input Register	4[r]63	8-bit unsigned integer	0-7	enumeration	\N	\N	\N	\N	\N	\N	0-6	Status register & 255 gives bits 0-7 as an int
4147	14	TRK-[n] Row [r] Tracker status	Input Register	4[r]63	8-bit unsigned integer	8-15	enumeration	\N	\N	\N	\N	\N	\N	0-1	Status register >> 8 gives bit 8-15 as an int
4148	14	TRK-[n] Row [r] target angle	Input Register	4[r]64	16-bit signed integer	\N	degrees	100	\N	\N	\N	\N	\N	\N	\N
4149	14	TRK-[n] Row [r] tracker position	Input Register	4[r]65	16-bit signed integer	\N	degrees	100	\N	\N	\N	\N	\N	\N	\N
4150	14	TRK-[n] Row [r] automatic tracking	Holding Register	4[r]66	16-bit signed integer	\N	boolean	1	None	Enabled	Disabled	\N	\N	\N	\N
4151	14	TRK-[n] Row [r] SPC time second	Input Register	4[r]67	16-bit signed integer	\N	s	1	\N	\N	\N	\N	\N	\N	\N
4152	14	TRK-[n] Row [r] SPC time minute	Input Register	4[r]68	16-bit signed integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
4153	14	TRK-[n] Row [r] SPC time hour	Input Register	4[r]69	16-bit signed integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
4154	14	TRK-[n] Row [r] SPC time day	Input Register	4[r]70	16-bit signed integer	\N	day	1	\N	\N	\N	\N	\N	\N	\N
4155	14	TRK-[n] Row [r] SPC time month	Input Register	4[r]71	16-bit signed integer	\N	month	1	\N	\N	\N	\N	\N	\N	\N
4156	14	TRK-[n] Row [r] SPC time year	Input Register	4[r]72	16-bit signed integer	\N	year	1	\N	\N	\N	\N	\N	\N	\N
4157	14	TRK-[n] Row [r] device online	Input Register	4[r]73	16-bit signed integer	\N	enumeration	1	\N	\N	\N	\N	\N	\N	\N
4158	14	TRK-[n] Row [r] name	Input Register	4[r]74	16-bit signed integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4159	14	TRK-[n] weather station firmware version	Holding Register	4[w]50	32-bit signed integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4160	14	TRK-[n] weather station serial number	Holding Register	4[w]52	String	\N	ASCII	16	\N	\N	\N	\N	\N	\N	\N
4161	14	TRK-[n] weather station fault register	Holding Register	4[w]60	32-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	Faults can be cleared by writing a 0 to this point.
4162	14	TRK-[n] WS [w] battery over current	Holding Register	4[w]60	Boolean	0	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4163	14	TRK-[n] WS [w] battery over voltage	Holding Register	4[w]60	Boolean	1	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4164	14	TRK-[n] WS [w] boost over current	Holding Register	4[w]60	Boolean	2	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4165	14	TRK-[n] WS [w] boost over voltage	Holding Register	4[w]60	Boolean	3	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4166	14	TRK-[n] WS [w] panel over coltage	Holding Register	4[w]60	Boolean	4	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4167	14	TRK-[n] WS [w] panel over current	Holding Register	4[w]60	Boolean	5	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4168	14	TRK-[n] WS [w] motor over current	Holding Register	4[w]60	Boolean	6	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4169	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	7	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4170	14	TRK-[n] WS [w] motor inrush over current	Holding Register	4[w]60	Boolean	8	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4171	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	9	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4172	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	10	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4173	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	11	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4174	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	12	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4175	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	13	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4176	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	14	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4177	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	15	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4178	14	TRK-[n] WS [w] spc over temperature	Holding Register	4[w]60	Boolean	16	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4179	14	TRK-[n] WS [w] battery over temperature	Holding Register	4[w]60	Boolean	17	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4180	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	18	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4181	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	19	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4182	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	20	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4183	14	TRK-[n] WS [w] tracker stall	Holding Register	4[w]60	Boolean	21	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4184	14	TRK-[n] WS [w] boost start timeout	Holding Register	4[w]60	Boolean	22	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4185	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	23	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4186	14	TRK-[n] WS [w] software system error	Holding Register	4[w]60	Boolean	24	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4187	14	TRK-[n] WS [w] firmware loading error	Holding Register	4[w]60	Boolean	25	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4188	14	TRK-[n] WS [w] user setting loading error	Holding Register	4[w]60	Boolean	26	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4189	14	TRK-[n] WS [w] tilt sensor error	Holding Register	4[w]60	Boolean	27	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4190	14	TRK-[n] WS [w] motor stall	Holding Register	4[w]60	Boolean	28	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4191	14	TRK-[n] WS [w] actuator fail	Holding Register	4[w]60	Boolean	29	unitless	\N	On (1)	Alarm	Normal	\N	\N	\N	\N
4192	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	30	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4193	14	TRK-[n] WS [w] reserved	Holding Register	4[w]60	Boolean	31	unitless	\N	\N	\N	\N	\N	\N	\N	\N
4194	14	TRK-[n] weather station alert	Holding Register	4[w]62	16-bit signed integer	\N	boolean	1	On (1)	Alarm	Normal	\N	\N	\N	\N
4195	14	TRK-[n] weather station status	Holding Register	4[w]63	16-bit bitfield	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4196	14	TRK-[n] weather station time second	Input Register	4[w]67	16-bit signed integer	\N	s	1	\N	\N	\N	\N	\N	\N	\N
4197	14	TRK-[n] weather station time minute	Input Register	4[w]68	16-bit signed integer	\N	min	1	\N	\N	\N	\N	\N	\N	\N
4198	14	TRK-[n] weather station time hour	Input Register	4[w]69	16-bit signed integer	\N	hr	1	\N	\N	\N	\N	\N	\N	\N
4199	14	TRK-[n] weather station time day	Input Register	4[w]70	16-bit signed integer	\N	day	1	\N	\N	\N	\N	\N	\N	\N
4200	14	TRK-[n] weather station time month	Input Register	4[w]71	16-bit signed integer	\N	month	1	\N	\N	\N	\N	\N	\N	\N
4201	14	TRK-[n] weather station time year	Input Register	4[w]72	16-bit signed integer	\N	year	1	\N	\N	\N	\N	\N	\N	\N
4202	14	TRK-[n] weather station device online	Input Register	4[w]73	16-bit signed integer	\N	enumeration	1	\N	\N	\N	\N	\N	\N	\N
4203	14	TRK-[n] weather station name	Input Register	4[w]74	16-bit signed integer	\N	unitless	1	\N	\N	\N	\N	\N	\N	\N
4204	14	TRK-[n] weather station water level	Input Register	4[w]75	16-bit signed integer	\N	in	0.01	\N	\N	\N	\N	\N	\N	\N
4205	14	TRK-[n] weather station snow height	Input Register	4[w]76	16-bit signed integer	\N	in	0.01	\N	\N	\N	\N	\N	\N	\N
4206	14	TRK-[n] weather station wind speed	Input Register	4[w]77	16-bit signed integer	\N	mph	0.01	\N	\N	\N	\N	\N	\N	\N
4207	15	30BAT-[n] Battery voltage	Holding Register	400772	16-bit unsigned integer	\N	V	\N	\N	Analog	\N	655.35	22.5;23;28.4;29.4	\N	\N
4208	15	30BAT-[n] Battery current	Holding Register	400773	16-bit signed integer	\N	A	\N	\N	\N	\N	3276.7	\N	\N	\N
4209	15	30BAT-[n] Charger on/off	Holding Register	400775	16-bit unsigned integer	\N	enumeration	\N	\N	\N	\N	65535	\N	Charger Mode:\n1 - On\n4 - Off\n	\N
4210	15	30BAT-[n] Charge state	Holding Register	400776	16-bit unsigned integer	\N	enumeration	\N	\N	Analog	\N	65535	2	Charge State:\n0 - OFF\n2 - Fault\n3 - Bulk\n4 - Absorbtion\n5 - Float\n6 - Storage\n7 - Equalize\n11 - Other\n252 - External control	\N
4211	15	90BAT-[n] PV voltage	Holding Register	400777	16-bit unsigned integer	\N	V	\N	\N	\N	\N	655.35	\N	\N	\N
4212	15	30BAT-[n] PV current	Holding Register	400778	16-bit signed integer	\N	A	\N	\N	\N	\N	3276.7	\N	\N	\N
4213	15	30BAT-[n] Yield today	Holding Register	400785	16-bit unsigned integer	\N	kWh	\N	\N	\N	\N	6553.5	\N	\N	\N
4214	15	30BAT-[n] Maximum charge power today	Holding Register	400786	16-bit unsigned integer	\N	W	\N	\N	\N	\N	65535	\N	\N	\N
4215	15	30BAT-[n] Yield yesterday	Holding Register	400787	16-bit unsigned integer	\N	kWh	\N	\N	\N	\N	6553.5	\N	\N	\N
4216	15	30BAT-[n] Maximum charge power yesterday	Holding Register	400788	16-bit unsigned integer	\N	W	\N	\N	\N	\N	65535	\N	\N	\N
4217	15	30BAT-[n] Error code	Holding Register	400789	16-bit unsigned integer	\N	enumeration	\N	\N	Analog	\N	65535	n/a;0;0;n/a	\N	\N
4218	15	30BAT-[n] PV power	Holding Register	400790	16-bit unsigned integer	\N	W	\N	\N	\N	\N	6553.5	\N	Error Codes:\n0=No error;\n1=Battery temperature too high;\n2=Battery voltage too high;\n3=Battery temperature sensor miswired (+);\n4=Battery temperature sensor miswired (-);\n5=Battery temperature sensor disconnected;\n6=Battery voltage sense miswired (+);\n7=Battery voltage sense miswired (-);\n8=Battery voltage sense disconnected;\n9=Battery voltage wire losses too high;\n17=Charger temperature too high;\n18=Charger over-current;\n19=Charger current polarity reversed;\n20=Bulk time limit reached;\n22=Charger temperature sensor miswired;\n23=Charger temperature sensor disconnected;\n34=Input current too high\n	\N
4219	15	30BAT-[n] User yield	Holding Register	400791	16-bit unsigned integer	\N	kWh	\N	\N	\N	\N	6553.5	\N	\N	\N
4220	15	30BAT-[n] MPP operation mode	Holding Register	400792	16-bit unsigned integer	\N	enumeration	\N	\N	\N	\N	65535	\N	MPPT Mode:\n0 - OFF\n1 - Voltage/Current Limited\n2 - MPPT\n255 - Not Available	\N
5112	12	Env [n] solar zenith angle	Analog input	0	32-bit float		degrees	69							
5113	12	Env [n] solar elevation angle	Analog input	1	32-bit float		degrees	1							
5114	12	Env [n] solar azimuth angle	Analog input	2	32-bit float		degrees	1							
5115	12	Env [n] POA irradiance raw	Analog input	3	32-bit float		W/m2	1							
5116	12	Env [n] POA irradiance temperature compensated	Analog input	4	32-bit float		W/m2	1							
5117	12	Env [n] POA temperature	Analog input	5	32-bit float		degC	1							
5118	12	Env [n] POA tilt angle	Analog input	6	32-bit float		degrees	1							
5119	12	Env [n] GHI irradiance raw	Analog input	7	32-bit float		W/m2	1							
5120	12	Env [n] GHI irradiance temperature compensated	Analog input	8	32-bit float		W/m2	1							
5121	12	Env [n] GHI temperature	Analog input	9	32-bit float		degC	1							
5122	12	Env [n] ambient temp	Analog input	10	32-bit float		degC	1							
5123	12	Env [n] dew point	Analog input	11	32-bit float		degC	1							
5124	12	Env [n] relative humidity	Analog input	12	32-bit float		%	1							
5125	12	Env [n] wind speed	Analog input	13	32-bit float		m/s	1							
5126	12	Env [n] wind speed max	Analog input	14	32-bit float		m/s	1							
5127	12	Env [n] wind direction	Analog input	15	32-bit float		degrees	1							
5128	12	Env [n] wind quality	Analog input	16	32-bit float		%	1							
5129	12	Env [n] barometric pressure local	Analog input	17	32-bit float		mbar	1							
5130	12	Env [n] barometric pressure sea level	Analog input	18	32-bit float		mbar	1							
5131	12	Env [n] wind sensor compass	Analog input	19	32-bit float		degrees	1							
5132	12	Env [n] wind chill	Analog input	20	32-bit float		degC	1							
5133	12	Env [n] heat index	Analog input	21	32-bit float		degC	1							
5134	12	Env [n] rainfall total monthly	Analog input	22	32-bit float		mm	1							
5135	12	Env [n] rainfall instantaneous	Analog input	23	32-bit float		mm	1							
5136	12	Env [n] rainfall intensity instantaneous	Analog input	24	32-bit float		mm/hr	1							
5137	12	Env [n] rainfall total today	Analog input	25	32-bit float		mm	1							
5138	12	Env [n] BOM temperature 1	Analog input	26	32-bit float		degC	1							
5139	12	Env [n] BOM temperature 2	Analog input	27	32-bit float		degC	1							
5140	12	Env [n] BOM temperature 3	Analog input	28	32-bit float		degC	1							
5141	12	Env [n] data logger scan count	Analog input	29	32-bit float		count	1							
5142	12	Env [n] data logger skipped scans	Analog input	30	32-bit float		count	1							
5143	12	Env [n] data logger power supply voltage	Analog input	31	32-bit float		V	1							
5144	12	Env [n] data logger cabinet temperature	Analog input	32	32-bit float		degC	1							
5145	12	Env [n] data logger battery backup voltage	Analog input	33	32-bit float		V	1							
5146	12	Env [n] data logger battery backup charging source	Analog input	34	32-bit float		enumeration	1						0 thru 2	0 = None; 1 = Solar; 2 = AC Power
5147	12	Env [n] reflected POA irradiance raw	Analog input	35	32-bit float		W/m2	1							
5148	12	Env [n] reflected POA irradiance temperature compensated	Analog input	36	32-bit float		W/m2	1							
5149	12	Env [n] reflected POA temperature	Analog input	37	32-bit float		degC	1							
5150	12	Env [n] reflected insolation	Analog input	38	32-bit float		Wh/m2	1							
5151	12	Env [n] reflected POA tilt angle	Analog input	39	32-bit float		degrees	1							
5152	12	Env [n] spare analog 01	Analog input	40	32-bit float			\N							
5153	12	Env [n] spare analog 02	Analog input	41	32-bit float			\N							
5154	12	Env [n] spare analog 03	Analog input	42	32-bit float			\N							
5155	12	Env [n] spare analog 04	Analog input	43	32-bit float			\N							
5156	12	Env [n] spare analog 05	Analog input	44	32-bit float			\N							
5157	12	Env [p] POA irradiance raw	Analog input	45	32-bit float		W/m2	1							
5158	12	Env [p] POA irradiance temperature compensated	Analog input	46	32-bit float		W/m2	1							
5159	12	Env [p] POA temperature	Analog input	47	32-bit float		degC	1							
5160	12	Env [p] POA tilt angle	Analog input	48	32-bit float		degrees	1							
5161	12	Env [p] spare analog 01	Analog input	49	32-bit float			\N							
5162	12	Env [p] spare analog 02	Analog input	50	32-bit float			\N							
5163	12	Env [s] soiling ratio raw	Analog input	51	32-bit float		unitless	1							
5164	12	Env [s] soiling ratio irradiance weighted	Analog input	52	32-bit float		unitless	1							
5165	12	Env [s] soiling loss factor raw	Analog input	53	32-bit float		unitless	1							
5166	12	Env [s] soiling loss factor irradiance weighted	Analog input	54	32-bit float		unitless	1							
5167	12	Env [s] clean panel short circuit current	Analog input	55	32-bit float		A	1							
5168	12	Env [s] soiled panel short circuit current	Analog input	56	32-bit float		A	1							
5169	12	Env [s] short circuit current normalization ratio	Analog input	57	32-bit float		unitless	1							ISC clean / ISC soiled at time of normalization
5170	12	Env [s] clean panel effective irradiance	Analog input	58	32-bit float		W/m2	1							
5171	12	Env [s] soiled panel effective irradiance	Analog input	59	32-bit float		W/m2	1							
5172	12	Env [s] clean panel BOM temperature	Analog input	60	32-bit float		degC	1							
5173	12	Env [s] soiled panel BOM temperature	Analog input	61	32-bit float		degC	1							
5174	12	Env [s] soiling quality	Analog input	62	32-bit float		%	1							Percent of possible samples that were actually sampled
5175	12	Env [s] number of days since last clear sky	Analog input	63	32-bit float		days	1							
5176	12	Env [s] data logger scan count	Analog input	64	32-bit float		count	1							
5177	12	Env [s] data logger skipped scans	Analog input	65	32-bit float		count	1							
5178	12	Env [s] data logger power supply voltage	Analog input	66	32-bit float		V	1							
5179	12	Env [s] data logger cabinet temperature	Analog input	67	32-bit float		degC	1							
5180	12	Env [s] data logger battery backup voltage	Analog input	68	32-bit float		V	1							
5181	12	Env [s] spare analog 01	Analog input	69	32-bit float			\N							
5182	12	Env [s] spare analog 02	Analog input	70	32-bit float			\N							
5183	12	Env [s] spare analog 03	Analog input	71	32-bit float			\N							
5184	12	Env [s] spare analog 04	Analog input	72	32-bit float			\N							
5185	12	Env [s] spare analog 05	Analog input	73	32-bit float			\N							
5186	12	Env [s] spare analog 06	Analog input	74	32-bit float			\N							
5187	12	Env [a] instantaneous albedo raw	Analog input	75	32-bit float		unitless	1							
5188	12	Env [a] instantaneous albedo temperature compensated	Analog input	76	32-bit float		unitless	1							
5189	12	Env [a] daily average albedo raw	Analog input	77	32-bit float		unitless	1							
5190	12	Env [a] daily average albedo temperature compensated	Analog input	78	32-bit float		unitless	1							
5191	12	Env [a] GHI irradiance raw	Analog input	79	32-bit float		W/m2	1							
5192	12	Env [a] GHI irradiance temperature compensated	Analog input	80	32-bit float		W/m2	1							
5193	12	Env [a] GHI temperature	Analog input	81	32-bit float		degC	1							
5194	12	Env [a] RHI irradiance raw	Analog input	82	32-bit float		W/m2	1							
5195	12	Env [a] RHI irradiance temperature compensated	Analog input	83	32-bit float		W/m2	1							
5196	12	Env [a] RHI temperature	Analog input	84	32-bit float		degC	1							
5197	12	Env [a] data logger scan count	Analog input	85	32-bit float		count	1							
5198	12	Env [a] data logger skipped scans	Analog input	86	32-bit float		count	1							
5199	12	Env [a] data logger power supply voltage	Analog input	87	32-bit float		V	1							
5200	12	Env [a] data logger cabinet temperature	Analog input	88	32-bit float		degC	1							
5201	12	Env [a] data logger battery backup voltage	Analog input	89	32-bit float		V	1							
5202	12	Env [a] spare analog 01	Analog input	90	32-bit float			\N							
5203	12	Env [a] spare analog 02	Analog input	91	32-bit float			\N							
5204	12	Env [a] spare analog 03	Analog input	92	32-bit float			\N							
5205	12	Env [a] spare analog 04	Analog input	93	32-bit float			\N							
5206	12	Env [a] spare analog 05	Analog input	94	32-bit float			\N							
5207	12	Env [a] spare analog 06	Analog input	95	32-bit float			\N							
5208	12	Env [n] data logger alarms register	Counter	0	32-bit bitfield		unitless	1							
5209	12	Env [n] data logger watchdog error	Counter	0	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5210	12	Env [n] data logger skipped main scan	Counter	0	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5211	12	Env [n] data logger skipped slow scan	Counter	0	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5212	12	Env [n] data logger program variable out of bounds	Counter	0	32-bit bitfield	3		\N	On (1)	Alarm	Normal				
5213	12	Env [n] data logger low 12V	Counter	0	32-bit bitfield	4		\N	On (1)	Alarm	Normal				
5214	12	Env [n] data logger low 5V	Counter	0	32-bit bitfield	5		\N	On (1)	Alarm	Normal				
5215	12	Env [n] data logger lithium battery error	Counter	0	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5216	12	Env [n] data logger lithium battery low	Counter	0	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5217	12	Env [n] data logger lithium battery critical	Counter	0	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5218	12	Env [n] data logger voltage error	Counter	0	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5219	12	Env [n] data logger low voltage warning	Counter	0	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5220	12	Env [n] data logger low voltage	Counter	0	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5221	12	Env [n] data logger over voltage	Counter	0	32-bit bitfield	19		\N	On (1)	Alarm	Normal				
5222	12	Env [n] data logger temperature error	Counter	0	32-bit bitfield	24		\N	On (1)	Alarm	Normal				
5223	12	Env [n] data logger temperature below operating range	Counter	0	32-bit bitfield	25		\N	On (1)	Alarm	Normal				
5224	12	Env [n] data logger temperature above operating range	Counter	0	32-bit bitfield	26		\N	On (1)	Alarm	Normal				
5225	12	Env [n] battery alarms register	Counter	1	32-bit bitfield		unitless	1							
5226	12	Env [n] check battery	Counter	1	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5227	12	Env [n] battery voltage error	Counter	1	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5228	12	Env [n] low battery voltage warning	Counter	1	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5229	12	Env [n] low battery voltage critical	Counter	1	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5230	12	Env [n] low battery voltage deep discharge	Counter	1	32-bit bitfield	11		\N	On (1)	Alarm	Normal				
5231	12	Env [n] battery current error	Counter	1	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5232	12	Env [n] excessive battery current warning	Counter	1	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5233	12	Env [n] excessive battery current critical	Counter	1	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5234	12	Env [n] charging alarms register	Counter	2	32-bit bitfield		unitless	1							
5235	12	Env [n] input voltage error	Counter	2	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5236	12	Env [n] rpu enabled	Counter	2	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5237	12	Env [n] input current error	Counter	2	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5238	12	Env [n] excessive input current	Counter	2	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5239	12	Env [n] load current error	Counter	2	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5240	12	Env [n] excessive load current warning	Counter	2	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5241	12	Env [n] excessive load current	Counter	2	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5242	12	Env [n] GHI alarms register	Counter	3	32-bit bitfield		unitless	1							
5243	12	Env [n] GHI irradiance error	Counter	3	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5244	12	Env [n] GHI irradiance negative	Counter	3	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5245	12	Env [n] GHI irradiance above solar constant	Counter	3	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5246	12	Env [n] GHI temperature corrected irradiance error	Counter	3	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5247	12	Env [n] GHI temperature corrected irradiance negative	Counter	3	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5248	12	Env [n] GHI temperature corrected irradiance above solar constant	Counter	3	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5249	12	Env [n] GHI case temperature error	Counter	3	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5250	12	Env [n] GHI case temperature below operating range	Counter	3	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5251	12	Env [n] GHI case temperature above operating range	Counter	3	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5252	12	Env [n] GHI irradiance insufficient activity	Counter	3	32-bit bitfield	31		\N	On (1)	Alarm	Normal				
5253	12	Env [n] POA alarms register	Counter	4	32-bit bitfield		unitless	1							
5254	12	Env [n] POA irradiance error	Counter	3	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5255	12	Env [n] POA irradiance negative	Counter	3	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5256	12	Env [n] POA irradiance above solar constant	Counter	3	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5257	12	Env [n] POA temperature corrected irradiance error	Counter	3	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5258	12	Env [n] POA temperature corrected irradiance negative	Counter	3	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5259	12	Env [n] POA temperature corrected irradiance above solar constant	Counter	3	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5260	12	Env [n] POA case temperature error	Counter	3	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5261	12	Env [n] POA case temperature below operating range	Counter	3	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5262	12	Env [n] POA case temperature above operating range	Counter	3	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5263	12	Env [n] POA irradiance insufficient activity	Counter	3	32-bit bitfield	31		\N	On (1)	Alarm	Normal				
5264	12	Env [n] multifunction alarms register	Counter	5	32-bit bitfield		unitless	1							
5265	12	Env [n] ambient temperature error	Counter	4	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5266	12	Env [n] ambient temperature below operating range	Counter	4	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5267	12	Env [n] ambient temperature above operating range	Counter	4	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5268	12	Env [n] dew point error	Counter	4	32-bit bitfield	3		\N	On (1)	Alarm	Normal				
5269	12	Env [n] dew point above ambient temperature	Counter	4	32-bit bitfield	4		\N	On (1)	Alarm	Normal				
5270	12	Env [n] condensation warning	Counter	4	32-bit bitfield	5		\N	On (1)	Alarm	Normal				
5271	12	Env [n] relative humidity error	Counter	4	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5272	12	Env [n] relative humidity below operating range	Counter	4	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5273	12	Env [n] relative humidity above operating range	Counter	4	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5274	12	Env [n] absolute barometric pressure error	Counter	4	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5275	12	Env [n] absolute barometric pressure below operating range	Counter	4	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5276	12	Env [n] absolute barometric pressure above operating range	Counter	4	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5277	12	Env [a] communication failure alarm	Binary input	77	Boolean			\N	On (1)	Alarm	Normal				
5278	12	Env [n] sea level barometric pressure error	Counter	4	32-bit bitfield	24		\N	On (1)	Alarm	Normal				
5279	12	Env [n] sea level barometric pressure below operating range	Counter	4	32-bit bitfield	25		\N	On (1)	Alarm	Normal				
5280	12	Env [n] sea level barometric pressure above operating range	Counter	4	32-bit bitfield	26		\N	On (1)	Alarm	Normal				
5281	12	Env [n] wind alarms register	Counter	6	32-bit bitfield		unitless	1							
5282	12	Env [n] wind speed error	Counter	5	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5283	12	Env [n] wind speed below operating range	Counter	5	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5284	12	Env [n] wind speed above operating range	Counter	5	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5285	12	Env [n] wind speed unable to execute measurement due to ambient conditions	Counter	5	32-bit bitfield	3		\N	On (1)	Alarm	Normal				
5286	12	Env [n] wind speed quality warning	Counter	5	32-bit bitfield	4		\N	On (1)	Alarm	Normal				
5287	12	Env [n] wind speed quality error	Counter	5	32-bit bitfield	5		\N	On (1)	Alarm	Normal				
5288	12	Env [n] wind speed max error	Counter	5	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5289	12	Env [n] wind speed max below operating range	Counter	5	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5290	12	Env [n] wind speed max above operating range	Counter	5	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5291	12	Env [n] wind direction error	Counter	5	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5292	12	Env [n] wind direction below operating range	Counter	5	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5293	12	Env [n] wind direction above operating range	Counter	5	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5294	12	Env [n] compass error	Counter	5	32-bit bitfield	24		\N	On (1)	Alarm	Normal				
5295	12	Env [n] compass below operating range	Counter	5	32-bit bitfield	25		\N	On (1)	Alarm	Normal				
5296	12	Env [n] compass above operating range	Counter	5	32-bit bitfield	26		\N	On (1)	Alarm	Normal				
5297	12	Env [n] wind speed insufficient activity	Counter	5	32-bit bitfield	31		\N	On (1)	Alarm	Normal				
5298	12	Env [n] rain alarms regsiter	Counter	7	32-bit bitfield		unitless	1							
5299	12	Env [n] rain total error	Counter	6	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5300	12	Env [n] rain total negative	Counter	6	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5301	12	Env [n] rain total above operating range	Counter	6	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5302	12	Env [n] rain intensity error	Counter	6	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5303	12	Env [n] rain intensity negative	Counter	6	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5304	12	Env [n] rain intensity above operating range	Counter	6	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5305	12	Env [n] rain today error	Counter	6	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5306	12	Env [n] rain today is negative	Counter	6	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5307	12	Env [n] rain today above operating range	Counter	6	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5308	12	Env [n] BOM alarm register	Counter	8	32-bit bitfield		unitless	1							
5309	12	Env [n] BOM 1 temperature error	Counter	7	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5310	12	Env [n] BOM 1 temperature below operating range	Counter	7	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5311	12	Env [n] BOM 1 temperature above operating range	Counter	7	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5312	12	Env [n] BOM 2 temperature error	Counter	7	32-bit bitfield	3		\N	On (1)	Alarm	Normal				
5313	12	Env [n] BOM 2 temperature below operating range	Counter	7	32-bit bitfield	4		\N	On (1)	Alarm	Normal				
5314	12	Env [n] BOM 2 temperature above operating range	Counter	7	32-bit bitfield	5		\N	On (1)	Alarm	Normal				
5315	12	Env [n] BOM 3 temperature error	Counter	7	32-bit bitfield	6		\N	On (1)	Alarm	Normal				
5316	12	Env [n] BOM 3 temperature below operating range	Counter	7	32-bit bitfield	7		\N	On (1)	Alarm	Normal				
5317	12	Env [n] BOM 3 temperature above operating range	Counter	7	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5318	12	Env [n] summary alarm	Binary input	0	Boolean			\N	On (1)	Alarm	Normal				
5319	12	Env [n] maintenance button pressed	Binary input	1	Boolean			\N	On (1)	Alarm	Normal				
5320	12	Env [n] pyranometer heat status	Binary input	2	Boolean			\N	None	On	Off				
5321	12	Env [n] communication failure alarm	Binary input	3	Boolean			\N	On (1)	Alarm	Normal				
5322	12	Env [p] POA irradiance error	Binary input	4	Boolean			\N	On (1)	Alarm	Normal				
5323	12	Env [p] POA irradiance negative	Binary input	5	Boolean			\N	On (1)	Alarm	Normal				
5324	12	Env [p] POA irradiance above solar constant	Binary input	6	Boolean			\N	On (1)	Alarm	Normal				
5325	12	Env [p] POA temperature corrected irradiance error	Binary input	7	Boolean			\N	On (1)	Alarm	Normal				
5326	12	Env [p] POA temperature corrected irradiance negative	Binary input	8	Boolean			\N	On (1)	Alarm	Normal				
5327	12	Env [p] POA temperature corrected irradiance above solar constant	Binary input	9	Boolean			\N	On (1)	Alarm	Normal				
5328	12	Env [p] POA case temperature error	Binary input	10	Boolean			\N	On (1)	Alarm	Normal				
5329	12	Env [p] POA case temperature below operating range	Binary input	11	Boolean			\N	On (1)	Alarm	Normal				
5330	12	Env [p] POA case temperature above operating range	Binary input	12	Boolean			\N	On (1)	Alarm	Normal				
5331	12	Env [p] POA irradiance insufficient activity	Binary input	13	Boolean			\N	On (1)	Alarm	Normal				
5332	12	Env [p] communication failure alarm	Binary input	14	Boolean			\N	On (1)	Alarm	Normal				
5333	12	Env [s] soiling ratio out of range	Binary input	15	Boolean			\N	On (1)	Alarm	Normal				
5334	12	Env [s] heavy soiling alarm	Binary input	16	Boolean			\N	On (1)	Alarm	Normal				Soiling ratio below 0.93
5335	12	Env [s] extremely heavy soiling alarm	Binary input	17	Boolean			\N	On (1)	Alarm	Normal				Soiling ratio below 0.87
5336	12	Env [s] soiling ratio insufficient activity	Binary input	18	Boolean			\N	On (1)	Alarm	Normal				
5337	12	Env [s] clean panel BOM temperature error	Binary input	19	Boolean			\N	On (1)	Alarm	Normal				
5338	12	Env [s] clean panel BOM temperature below operating range	Binary input	20	Boolean			\N	On (1)	Alarm	Normal				
5339	12	Env [s] clean panel BOM temperature above operating range	Binary input	21	Boolean			\N	On (1)	Alarm	Normal				
5340	12	Env [s] soiled panel BOM temperature error	Binary input	22	Boolean			\N	On (1)	Alarm	Normal				
5341	12	Env [s] soiled panel BOM temperature below operating range	Binary input	23	Boolean			\N	On (1)	Alarm	Normal				
5342	12	Env [s] soiled panel BOM temperature above operating range	Binary input	24	Boolean			\N	On (1)	Alarm	Normal				
5343	12	Env [s] BOM temperature difference too great	Binary input	25	Boolean			\N	On (1)	Alarm	Normal				
5344	12	Env [s] clean panel ISC out of range	Binary input	26	Boolean			\N	On (1)	Alarm	Normal				
5345	12	Env [s] soiled panel ISC out of range	Binary input	27	Boolean			\N	On (1)	Alarm	Normal				
5346	12	Env [s] ISC difference too great	Binary input	28	Boolean			\N	On (1)	Alarm	Normal				
5347	12	Env [s] data logger watchdog error	Binary input	29	Boolean			\N	On (1)	Alarm	Normal				
5348	12	Env [s] data logger skipped main scan	Binary input	30	Boolean			\N	On (1)	Alarm	Normal				
5349	12	Env [s] data logger skipped slow scan	Binary input	31	Boolean			\N	On (1)	Alarm	Normal				
5350	12	Env [s] data logger program variable out of bounds	Binary input	32	Boolean			\N	On (1)	Alarm	Normal				
5351	12	Env [s] data logger low 12V	Binary input	33	Boolean			\N	On (1)	Alarm	Normal				
5352	12	Env [s] data logger low 5V	Binary input	34	Boolean			\N	On (1)	Alarm	Normal				
5353	12	Env [s] data logger lithium battery error	Binary input	35	Boolean			\N	On (1)	Alarm	Normal				
5354	12	Env [s] data logger lithium battery low	Binary input	36	Boolean			\N	On (1)	Alarm	Normal				
5355	12	Env [s] data logger lithium battery critical	Binary input	37	Boolean			\N	On (1)	Alarm	Normal				
5356	12	Env [s] data logger voltage error	Binary input	38	Boolean			\N	On (1)	Alarm	Normal				
5357	12	Env [s] data logger low voltage warning	Binary input	39	Boolean			\N	On (1)	Alarm	Normal				
5358	12	Env [s] data logger low voltage	Binary input	40	Boolean			\N	On (1)	Alarm	Normal				
5359	12	Env [s] data logger over voltage	Binary input	41	Boolean			\N	On (1)	Alarm	Normal				
5360	12	Env [s] data logger temperature error	Binary input	42	Boolean			\N	On (1)	Alarm	Normal				
5361	12	Env [s] data logger temperature below operating range	Binary input	43	Boolean			\N	On (1)	Alarm	Normal				
5362	12	Env [s] data logger temperature above operating range	Binary input	44	Boolean			\N	On (1)	Alarm	Normal				
5363	12	Env [s] communication failure alarm	Binary input	45	Boolean			\N	On (1)	Alarm	Normal				
5364	12	Env [a] GHI irradiance error	Binary input	46	Boolean			\N	On (1)	Alarm	Normal				
5365	12	Env [a] GHI irradiance negative	Binary input	47	Boolean			\N	On (1)	Alarm	Normal				
5366	12	Env [a] GHI irradiance above solar constant	Binary input	48	Boolean			\N	On (1)	Alarm	Normal				
5367	12	Env [a] GHI irradiance insufficient activity	Binary input	49	Boolean			\N	On (1)	Alarm	Normal				
5368	12	Env [a] RHI irradiance error	Binary input	50	Boolean			\N	On (1)	Alarm	Normal				
5369	12	Env [a] RHI irradiance negative	Binary input	51	Boolean			\N	On (1)	Alarm	Normal				
5370	12	Env [a] RHI irradiance above solar constant	Binary input	52	Boolean			\N	On (1)	Alarm	Normal				
5371	12	Env [a] RHI irradiance insufficient activity	Binary input	53	Boolean			\N	On (1)	Alarm	Normal				
5372	12	Env [a] GHI case temperature error	Binary input	54	Boolean			\N	On (1)	Alarm	Normal				
5373	12	Env [a] GHI case temperature below operating range	Binary input	55	Boolean			\N	On (1)	Alarm	Normal				
5374	12	Env [a] GHI case temperature above operating range	Binary input	56	Boolean			\N	On (1)	Alarm	Normal				
5375	12	Env [a] RHI case temperature error	Binary input	57	Boolean			\N	On (1)	Alarm	Normal				
5376	12	Env [a] RHI case temperature below operating range	Binary input	58	Boolean			\N	On (1)	Alarm	Normal				
5377	12	Env [a] RHI case temperature above operating range	Binary input	59	Boolean			\N	On (1)	Alarm	Normal				
5378	12	Env [a] albedo out of range	Binary input	60	Boolean			\N	On (1)	Alarm	Normal				
5379	12	Env [a] data logger watchdog error	Binary input	61	Boolean			\N	On (1)	Alarm	Normal				
5380	12	Env [a] data logger skipped main scan	Binary input	62	Boolean			\N	On (1)	Alarm	Normal				
5381	12	Env [a] data logger skipped slow scan	Binary input	63	Boolean			\N	On (1)	Alarm	Normal				
5382	12	Env [a] data logger program variable out of bounds	Binary input	64	Boolean			\N	On (1)	Alarm	Normal				
5383	12	Env [a] data logger low 12V	Binary input	65	Boolean			\N	On (1)	Alarm	Normal				
5384	12	Env [a] data logger low 5V	Binary input	66	Boolean			\N	On (1)	Alarm	Normal				
5385	12	Env [a] data logger lithium battery error	Binary input	67	Boolean			\N	On (1)	Alarm	Normal				
5386	12	Env [a] data logger lithium battery low	Binary input	68	Boolean			\N	On (1)	Alarm	Normal				
5387	12	Env [a] data logger lithium battery critical	Binary input	69	Boolean			\N	On (1)	Alarm	Normal				
5388	12	Env [a] data logger voltage error	Binary input	70	Boolean			\N	On (1)	Alarm	Normal				
5389	12	Env [a] data logger low voltage warning	Binary input	71	Boolean			\N	On (1)	Alarm	Normal				
5390	12	Env [a] data logger low voltage	Binary input	72	Boolean			\N	On (1)	Alarm	Normal				
5391	12	Env [a] data logger over voltage	Binary input	73	Boolean			\N	On (1)	Alarm	Normal				
5392	12	Env [a] data logger temperature error	Binary input	74	Boolean			\N	On (1)	Alarm	Normal				
5393	12	Env [a] data logger temperature below operating range	Binary input	75	Boolean			\N	On (1)	Alarm	Normal				
5394	12	Env [a] data logger temperature above operating range	Binary input	76	Boolean			\N	On (1)	Alarm	Normal				
5395	21	Env [n] solar zenith angle	Analog input	0	32-bit float		degrees	1							
5396	21	Env [n] solar elevation angle	Analog input	1	32-bit float		degrees	1							
5397	21	Env [n] solar azimuth angle	Analog input	2	32-bit float		degrees	1							
5398	21	Env [n] POA 1 irradiance raw	Analog input	3	32-bit float		W/m2	1							
5399	21	Env [n] POA 1 irradiance temperature compensated	Analog input	4	32-bit float		W/m2	1							
5400	21	Env [n] POA 1 temperature	Analog input	5	32-bit float		degC	1							
5401	21	Env [n] POA 1 tilt angle	Analog input	6	32-bit float		degrees	1							
5402	21	Env [n] GHI irradiance raw	Analog input	7	32-bit float		W/m2	1							
5403	21	Env [n] GHI irradiance temperature compensated	Analog input	8	32-bit float		W/m2	1							
5404	21	Env [n] GHI temperature	Analog input	9	32-bit float		degC	1							
5405	21	Env [n] ambient temp	Analog input	10	32-bit float		degC	1							
5406	21	Env [n] dew point	Analog input	11	32-bit float		degC	1							
5407	21	Env [n] relative humidity	Analog input	12	32-bit float		%	1							
5408	21	Env [n] wind speed	Analog input	13	32-bit float		m/s	1							
5409	21	Env [n] wind speed max	Analog input	14	32-bit float		m/s	1							
5410	21	Env [n] wind direction	Analog input	15	32-bit float		degrees	1							
5411	21	Env [n] wind quality	Analog input	16	32-bit float		%	1							
5412	21	Env [n] barometric pressure local	Analog input	17	32-bit float		mbar	1							
5413	21	Env [n] barometric pressure sea level	Analog input	18	32-bit float		mbar	1							
5414	21	Env [n] wind sensor compass	Analog input	19	32-bit float		degrees	1							
5415	21	Env [n] wind chill	Analog input	20	32-bit float		degC	1							
5416	21	Env [n] heat index	Analog input	21	32-bit float		degC	1							
5417	21	Env [n] rainfall total monthly	Analog input	22	32-bit float		mm	1							
5418	21	Env [n] rainfall instantaneous	Analog input	23	32-bit float		mm	1							
5419	21	Env [n] rainfall intensity instantaneous	Analog input	24	32-bit float		mm/hr	1							
5420	21	Env [n] rainfall total today	Analog input	25	32-bit float		mm	1							
5421	21	Env [n] BOM temperature 1	Analog input	26	32-bit float		degC	1							
5422	21	Env [n] BOM temperature 2	Analog input	27	32-bit float		degC	1							
5423	21	Env [n] BOM temperature 3	Analog input	28	32-bit float		degC	1							
5424	21	Env [n] data logger scan count	Analog input	29	32-bit float		count	1							
5425	21	Env [n] data logger skipped scans	Analog input	30	32-bit float		count	1							
5426	21	Env [n] data logger power supply voltage	Analog input	31	32-bit float		V	1							
5427	21	Env [n] data logger cabinet temperature	Analog input	32	32-bit float		degC	1							
5428	21	Env [n] data logger battery backup voltage	Analog input	33	32-bit float		V	1							
5429	21	Env [n] data logger battery backup charging source	Analog input	34	32-bit float		enumeration	1						0 thru 2	0 = None, 1 = Solar, 2 = AC Power
5430	21	Env [n] reflected POA irradiance raw	Analog input	35	32-bit float		W/m2	1							
5431	21	Env [n] reflected POA irradiance temperature compensated	Analog input	36	32-bit float		W/m2	1							
5432	21	Env [n] reflected POA temperature	Analog input	37	32-bit float		degC	1							
5433	21	Env [n] reflected insolation	Analog input	38	32-bit float		Wh/m2	1							
5434	21	Env [n] reflected POA tilt angle	Analog input	39	32-bit float		degrees	1							
5435	21	Env [n] POA 2 irradiance raw	Analog input	40	32-bit float		W/m2	1							
5436	21	Env [n] POA 2 irradiance temperature compensated	Analog input	41	32-bit float		W/m2	1							
5437	21	Env [n] POA 2 temperature	Analog input	42	32-bit float		degC	1							
5438	21	Env [n] POA 2 tilt angle	Analog input	43	32-bit float		degrees	1							
5439	21	Env [n] spare analog 01	Analog input	44	32-bit float			\N							
5440	21	Env [p] POA irradiance raw	Analog input	45	32-bit float		W/m2	1							
5441	21	Env [p] POA irradiance temperature compensated	Analog input	46	32-bit float		W/m2	1							
5442	21	Env [p] POA temperature	Analog input	47	32-bit float		degC	1							
5443	21	Env [p] POA tilt angle	Analog input	48	32-bit float		degrees	1							
5444	21	Env [p] spare analog 01	Analog input	49	32-bit float			\N							
5445	21	Env [p] spare analog 02	Analog input	50	32-bit float			\N							
5446	21	Env [s] soiling ratio raw	Analog input	51	16-bit unsigned int		unitless	0.1							Corresponds to IREG_024_soiling_ratio_2
5447	21	Env [s] soiling ratio irradiance weighted	Analog input	52	16-bit unsigned int		unitless	0.1							IREG_020_soiling_raio_1
5448	21	Env [s] soiling loss factor raw	Analog input	53	16-bit signed int		unitless	0.1							IREG_025_transmission_loss_2
5449	21	Env [s] soiling loss factor irradiance weighted	Analog input	54	16-bit signed int		unitless	0.1							IREG_021_transmission_loss_1
5450	21	Env [s] clean panel short circuit current	Analog input	55	32-bit float		A	1							
5451	21	Env [s] soiled panel short circuit current	Analog input	56	32-bit float		A	1							
5452	21	Env [s] short circuit current normalization ratio	Analog input	57	32-bit float		unitless	1							ISC clean / ISC soiled at time of normalization
5453	21	Env [s] clean panel effective irradiance	Analog input	58	32-bit float		W/m2	1							
5454	21	Env [s] soiled panel effective irradiance	Analog input	59	32-bit float		W/m2	1							
5455	21	Env [s] clean panel BOM temperature	Analog input	60	16-bit unsigned int		degK	0.1							IREG_031_back_panel_temperature_K
5456	21	Env [s] soiled panel BOM temperature	Analog input	61	32-bit float		degC	1							
5457	21	Env [s] soiling quality	Analog input	62	32-bit float		%	1							Percent of possible samples that were actually sampled
5458	21	Env [s] number of days since last clear sky	Analog input	63	32-bit float		days	1							
5459	21	Env [s] data logger scan count	Analog input	64	32-bit float		count	1							
5460	21	Env [s] data logger skipped scans	Analog input	65	32-bit float		count	1							
5461	21	Env [s] data logger power supply voltage	Analog input	66	16-bit unsigned int		mV	1							IREG_032_device_voltage_mV
5462	21	Env [s] data logger cabinet temperature	Analog input	67	32-bit float		degC	1							
5463	21	Env [s] data logger battery backup voltage	Analog input	68	32-bit float		V	1							
5464	21	Env [s] operational mode	Analog input	69	16-bit unsigned int		unitless	1							IREG_033_operational_mode
5465	21	Env [s] device status	Analog input	70	16-bit unsigned int		unitless	1							IREG_034_device_status
5466	21	Env [s] spare analog 01	Analog input	71	32-bit float			\N							
5467	21	Env [s] spare analog 02	Analog input	72	32-bit float			\N							
5468	21	Env [s] spare analog 03	Analog input	73	32-bit float			\N							
5469	21	Env [s] spare analog 04	Analog input	74	32-bit float			\N							
5470	21	Env [a] instantaneous albedo raw	Analog input	75	32-bit float		unitless	1							
5471	21	Env [a] instantaneous albedo temperature compensated	Analog input	76	32-bit float		unitless	1							
5472	21	Env [a] daily average albedo raw	Analog input	77	32-bit float		unitless	1							
5473	21	Env [a] daily average albedo temperature compensated	Analog input	78	32-bit float		unitless	1							
5474	21	Env [a] GHI irradiance raw	Analog input	79	32-bit float		W/m2	1							
5475	21	Env [a] GHI irradiance temperature compensated	Analog input	80	32-bit float		W/m2	1							
5476	21	Env [a] GHI temperature	Analog input	81	32-bit float		degC	1							
5477	21	Env [a] RHI irradiance raw	Analog input	82	32-bit float		W/m2	1							
5478	21	Env [a] RHI irradiance temperature compensated	Analog input	83	32-bit float		W/m2	1							
5479	21	Env [a] RHI temperature	Analog input	84	32-bit float		degC	1							
5480	21	Env [a] data logger scan count	Analog input	85	32-bit float		count	1							
5481	21	Env [a] data logger skipped scans	Analog input	86	32-bit float		count	1							
5482	21	Env [a] data logger power supply voltage	Analog input	87	32-bit float		V	1							
5483	21	Env [a] data logger cabinet temperature	Analog input	88	32-bit float		degC	1							
5484	21	Env [a] data logger battery backup voltage	Analog input	89	32-bit float		V	1							
5485	21	Env [a] spare analog 01	Analog input	90	32-bit float			\N							
5486	21	Env [a] spare analog 02	Analog input	91	32-bit float			\N							
5487	21	Env [a] spare analog 03	Analog input	92	32-bit float			\N							
5488	21	Env [a] spare analog 04	Analog input	93	32-bit float			\N							
5489	21	Env [a] spare analog 05	Analog input	94	32-bit float			\N							
5490	21	Env [a] spare analog 06	Analog input	95	32-bit float			\N							
5491	21	Env [n] data logger alarms register	Counter	0	32-bit bitfield		unitless	1							
5492	21	Env [n] data logger watchdog error	Counter	0	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5493	21	Env [n] data logger skipped main scan	Counter	0	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5494	21	Env [n] data logger skipped slow scan	Counter	0	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5495	21	Env [n] data logger program variable out of bounds	Counter	0	32-bit bitfield	3		\N	On (1)	Alarm	Normal				
5496	21	Env [n] data logger low 12V	Counter	0	32-bit bitfield	4		\N	On (1)	Alarm	Normal				
5497	21	Env [n] data logger low 5V	Counter	0	32-bit bitfield	5		\N	On (1)	Alarm	Normal				
5498	21	Env [n] data logger lithium battery error	Counter	0	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5499	21	Env [n] data logger lithium battery low	Counter	0	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5500	21	Env [n] data logger lithium battery critical	Counter	0	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5501	21	Env [n] data logger voltage error	Counter	0	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5502	21	Env [n] data logger low voltage warning	Counter	0	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5503	21	Env [n] data logger low voltage	Counter	0	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5504	21	Env [n] data logger over voltage	Counter	0	32-bit bitfield	19		\N	On (1)	Alarm	Normal				
5505	21	Env [n] data logger temperature error	Counter	0	32-bit bitfield	24		\N	On (1)	Alarm	Normal				
5506	21	Env [n] data logger temperature below operating range	Counter	0	32-bit bitfield	25		\N	On (1)	Alarm	Normal				
5507	21	Env [n] data logger temperature above operating range	Counter	0	32-bit bitfield	26		\N	On (1)	Alarm	Normal				
5508	21	Env [n] battery alarms register	Counter	1	32-bit bitfield		unitless	1							
5509	21	Env [n] check battery	Counter	1	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5510	21	Env [n] battery voltage error	Counter	1	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5511	21	Env [n] low battery voltage warning	Counter	1	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5512	21	Env [n] low battery voltage critical	Counter	1	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5513	21	Env [n] low battery voltage deep discharge	Counter	1	32-bit bitfield	11		\N	On (1)	Alarm	Normal				
5514	21	Env [n] battery current error	Counter	1	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5515	21	Env [n] excessive battery current warning	Counter	1	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5516	21	Env [n] excessive battery current critical	Counter	1	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5517	21	Env [n] charging alarms register	Counter	2	32-bit bitfield		unitless	1							
5518	21	Env [n] input voltage error	Counter	2	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5519	21	Env [n] rpu enabled	Counter	2	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5520	21	Env [n] input current error	Counter	2	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5521	21	Env [n] excessive input current	Counter	2	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5522	21	Env [n] load current error	Counter	2	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5523	21	Env [n] excessive load current warning	Counter	2	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5524	21	Env [n] excessive load current	Counter	2	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5525	21	Env [n] GHI alarms register	Counter	3	32-bit bitfield		unitless	1							
5526	21	Env [n] GHI irradiance error	Counter	3	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5527	21	Env [n] GHI irradiance negative	Counter	3	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5528	21	Env [n] GHI irradiance above solar constant	Counter	3	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5529	21	Env [n] GHI temperature corrected irradiance error	Counter	3	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5530	21	Env [n] GHI temperature corrected irradiance negative	Counter	3	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5531	21	Env [n] GHI temperature corrected irradiance above solar constant	Counter	3	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5532	21	Env [n] GHI case temperature error	Counter	3	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5533	21	Env [n] GHI case temperature below operating range	Counter	3	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5534	21	Env [n] GHI case temperature above operating range	Counter	3	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5535	21	Env [n] GHI irradiance insufficient activity	Counter	3	32-bit bitfield	31		\N	On (1)	Alarm	Normal				
5536	21	Env [n] POA 1 alarms register	Counter	4	32-bit bitfield		unitless	1							
5537	21	Env [n] POA 1 irradiance error	Counter	4	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5538	21	Env [n] POA 1 irradiance negative	Counter	4	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5539	21	Env [n] POA 1 irradiance above solar constant	Counter	4	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5540	21	Env [n] POA 1 temperature corrected irradiance error	Counter	4	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5541	21	Env [n] POA 1 temperature corrected irradiance negative	Counter	4	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5542	21	Env [n] POA 1 temperature corrected irradiance above solar constant	Counter	4	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5543	21	Env [n] POA 1 case temperature error	Counter	4	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5544	21	Env [n] POA 1 case temperature below operating range	Counter	4	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5545	21	Env [n] POA 1 case temperature above operating range	Counter	4	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5546	21	Env [n] POA 1 irradiance insufficient activity	Counter	4	32-bit bitfield	31		\N	On (1)	Alarm	Normal				
5547	21	Env [n] multifunction alarms register	Counter	5	32-bit bitfield		unitless	1							
5548	21	Env [n] ambient temperature error	Counter	5	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5549	21	Env [n] ambient temperature below operating range	Counter	5	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5550	21	Env [n] ambient temperature above operating range	Counter	5	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5551	21	Env [n] dew point error	Counter	5	32-bit bitfield	3		\N	On (1)	Alarm	Normal				
5552	21	Env [n] dew point above ambient temperature	Counter	5	32-bit bitfield	4		\N	On (1)	Alarm	Normal				
5553	21	Env [n] condensation warning	Counter	5	32-bit bitfield	5		\N	On (1)	Alarm	Normal				
5554	21	Env [n] relative humidity error	Counter	5	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5555	21	Env [n] relative humidity below operating range	Counter	5	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5556	21	Env [n] relative humidity above operating range	Counter	5	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5557	21	Env [n] absolute barometric pressure error	Counter	5	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5558	21	Env [n] absolute barometric pressure below operating range	Counter	5	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5559	21	Env [n] absolute barometric pressure above operating range	Counter	5	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5560	21	Env [n] sea level barometric pressure error	Counter	5	32-bit bitfield	24		\N	On (1)	Alarm	Normal				
5561	21	Env [n] sea level barometric pressure below operating range	Counter	5	32-bit bitfield	25		\N	On (1)	Alarm	Normal				
5562	21	Env [n] sea level barometric pressure above operating range	Counter	5	32-bit bitfield	26		\N	On (1)	Alarm	Normal				
5563	21	Env [n] wind alarms register	Counter	6	32-bit bitfield		unitless	1							
5564	21	Env [n] wind speed error	Counter	6	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5565	21	Env [n] wind speed below operating range	Counter	6	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5566	21	Env [n] wind speed above operating range	Counter	6	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5567	21	Env [n] wind speed unable to execute measurement due to ambient conditions	Counter	6	32-bit bitfield	3		\N	On (1)	Alarm	Normal				
5568	21	Env [n] wind speed quality warning	Counter	6	32-bit bitfield	4		\N	On (1)	Alarm	Normal				
5569	21	Env [n] wind speed quality error	Counter	6	32-bit bitfield	5		\N	On (1)	Alarm	Normal				
5570	21	Env [n] wind speed max error	Counter	6	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5571	21	Env [n] wind speed max below operating range	Counter	6	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5572	21	Env [n] wind speed max above operating range	Counter	6	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5573	21	Env [n] wind direction error	Counter	6	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5574	21	Env [n] wind direction below operating range	Counter	6	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5575	21	Env [n] wind direction above operating range	Counter	6	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5576	21	Env [n] compass error	Counter	6	32-bit bitfield	24		\N	On (1)	Alarm	Normal				
5577	21	Env [n] compass below operating range	Counter	6	32-bit bitfield	25		\N	On (1)	Alarm	Normal				
5578	21	Env [n] compass above operating range	Counter	6	32-bit bitfield	26		\N	On (1)	Alarm	Normal				
5579	21	Env [n] wind speed insufficient activity	Counter	6	32-bit bitfield	31		\N	On (1)	Alarm	Normal				
5580	21	Env [n] rain alarms regsiter	Counter	7	32-bit bitfield		unitless	1							
5581	21	Env [n] rain total error	Counter	7	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5582	21	Env [n] rain total negative	Counter	7	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5583	21	Env [n] rain total above operating range	Counter	7	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5584	21	Env [n] rain intensity error	Counter	7	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5585	21	Env [n] rain intensity negative	Counter	7	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5586	21	Env [n] rain intensity above operating range	Counter	7	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5587	21	Env [n] rain today error	Counter	7	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5588	21	Env [n] rain today is negative	Counter	7	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5589	21	Env [n] rain today above operating range	Counter	7	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5590	21	Env [n] BOM alarm register	Counter	8	32-bit bitfield		unitless	1							
5591	21	Env [n] BOM 1 temperature error	Counter	8	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5592	21	Env [n] BOM 1 temperature below operating range	Counter	8	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5593	21	Env [n] BOM 1 temperature above operating range	Counter	8	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5594	21	Env [n] BOM 2 temperature error	Counter	8	32-bit bitfield	3		\N	On (1)	Alarm	Normal				
5595	21	Env [n] BOM 2 temperature below operating range	Counter	8	32-bit bitfield	4		\N	On (1)	Alarm	Normal				
5596	21	Env [n] BOM 2 temperature above operating range	Counter	8	32-bit bitfield	5		\N	On (1)	Alarm	Normal				
5597	21	Env [n] BOM 3 temperature error	Counter	8	32-bit bitfield	6		\N	On (1)	Alarm	Normal				
5598	21	Env [n] BOM 3 temperature below operating range	Counter	8	32-bit bitfield	7		\N	On (1)	Alarm	Normal				
5599	21	Env [n] BOM 3 temperature above operating range	Counter	8	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5600	21	Env [n] POA 2 alarms register	Counter	9	32-bit bitfield		unitless	1							
5601	21	Env [n] POA 2 irradiance error	Counter	9	32-bit bitfield	0		\N	On (1)	Alarm	Normal				
5602	21	Env [n] POA 2 irradiance negative	Counter	9	32-bit bitfield	1		\N	On (1)	Alarm	Normal				
5603	21	Env [n] POA 2 irradiance above solar constant	Counter	9	32-bit bitfield	2		\N	On (1)	Alarm	Normal				
5604	21	Env [n] POA 2 temperature corrected irradiance error	Counter	9	32-bit bitfield	8		\N	On (1)	Alarm	Normal				
5605	21	Env [n] POA 2 temperature corrected irradiance negative	Counter	9	32-bit bitfield	9		\N	On (1)	Alarm	Normal				
5606	21	Env [n] POA 2 temperature corrected irradiance above solar constant	Counter	9	32-bit bitfield	10		\N	On (1)	Alarm	Normal				
5607	21	Env [n] POA 2 case temperature error	Counter	9	32-bit bitfield	16		\N	On (1)	Alarm	Normal				
5608	21	Env [n] POA 2 case temperature below operating range	Counter	9	32-bit bitfield	17		\N	On (1)	Alarm	Normal				
5609	21	Env [n] POA 2 case temperature above operating range	Counter	9	32-bit bitfield	18		\N	On (1)	Alarm	Normal				
5610	21	Env [n] POA 2 irradiance insufficient activity	Counter	9	32-bit bitfield	31		\N	On (1)	Alarm	Normal				
5611	21	Env [n] summary alarm	Binary input	0	Boolean			\N	On (1)	Alarm	Normal				
5612	21	Env [n] maintenance button pressed	Binary input	1	Boolean			\N	On (1)	Alarm	Normal				
5613	21	Env [n] pyranometer heat status	Binary input	2	Boolean			\N	None	On	Off				
5614	21	Env [n] communication failure alarm	Binary input	3	Boolean			\N	On (1)	Alarm	Normal				
5615	21	Env [n] POA 1 irradiance error	Binary input	4	Boolean			\N	On (1)	Alarm	Normal				
5616	21	Env [n] POA 1 irradiance negative	Binary input	5	Boolean			\N	On (1)	Alarm	Normal				
5617	21	Env [n] POA 1 irradiance above solar constant	Binary input	6	Boolean			\N	On (1)	Alarm	Normal				
5618	21	Env [n] POA 1 temperature corrected irradiance error	Binary input	7	Boolean			\N	On (1)	Alarm	Normal				
5619	21	Env [n] POA 1 temperature corrected irradiance negative	Binary input	8	Boolean			\N	On (1)	Alarm	Normal				
5620	21	Env [n] POA 1 temperature corrected irradiance above solar constant	Binary input	9	Boolean			\N	On (1)	Alarm	Normal				
5621	21	Env [n] POA 1 case temperature error	Binary input	10	Boolean			\N	On (1)	Alarm	Normal				
5622	21	Env [n] POA 1 case temperature below operating range	Binary input	11	Boolean			\N	On (1)	Alarm	Normal				
5623	21	Env [n] POA 1 case temperature above operating range	Binary input	12	Boolean			\N	On (1)	Alarm	Normal				
5624	21	Env [n] POA 1 irradiance insufficient activity	Binary input	13	Boolean			\N	On (1)	Alarm	Normal				
5625	21	Env [n] communication failure alarm	Binary input	14	Boolean			\N	On (1)	Alarm	Normal				
5626	21	Env [s] soiling ratio out of range	Binary input	15	Boolean			\N	On (1)	Alarm	Normal				
5627	21	Env [s] heavy soiling alarm	Binary input	16	Boolean			\N	On (1)	Alarm	Normal				Soiling ratio below 0.93
5628	21	Env [s] extremely heavy soiling alarm	Binary input	17	Boolean			\N	On (1)	Alarm	Normal				Soiling ratio below 0.87
5629	21	Env [s] soiling ratio insufficient activity	Binary input	18	Boolean			\N	On (1)	Alarm	Normal				
5630	21	Env [s] clean panel BOM temperature error	Binary input	19	Boolean			\N	On (1)	Alarm	Normal				
5631	21	Env [s] clean panel BOM temperature below operating range	Binary input	20	Boolean			\N	On (1)	Alarm	Normal				
5632	21	Env [s] clean panel BOM temperature above operating range	Binary input	21	Boolean			\N	On (1)	Alarm	Normal				
5633	21	Env [s] soiled panel BOM temperature error	Binary input	22	Boolean			\N	On (1)	Alarm	Normal				
5634	21	Env [s] soiled panel BOM temperature below operating range	Binary input	23	Boolean			\N	On (1)	Alarm	Normal				
5635	21	Env [s] soiled panel BOM temperature above operating range	Binary input	24	Boolean			\N	On (1)	Alarm	Normal				
5636	21	Env [s] BOM temperature difference too great	Binary input	25	Boolean			\N	On (1)	Alarm	Normal				
5637	21	Env [s] clean panel ISC out of range	Binary input	26	Boolean			\N	On (1)	Alarm	Normal				
5638	21	Env [s] soiled panel ISC out of range	Binary input	27	Boolean			\N	On (1)	Alarm	Normal				
5639	21	Env [s] ISC difference too great	Binary input	28	Boolean			\N	On (1)	Alarm	Normal				
5640	21	Env [s] data logger watchdog error	Binary input	29	Boolean			\N	On (1)	Alarm	Normal				
5641	21	Env [s] data logger skipped main scan	Binary input	30	Boolean			\N	On (1)	Alarm	Normal				
5642	21	Env [s] data logger skipped slow scan	Binary input	31	Boolean			\N	On (1)	Alarm	Normal				
5643	21	Env [s] data logger program variable out of bounds	Binary input	32	Boolean			\N	On (1)	Alarm	Normal				
5644	21	Env [s] data logger low 12V	Binary input	33	Boolean			\N	On (1)	Alarm	Normal				
5645	21	Env [s] data logger low 5V	Binary input	34	Boolean			\N	On (1)	Alarm	Normal				
5646	21	Env [s] data logger lithium battery error	Binary input	35	Boolean			\N	On (1)	Alarm	Normal				
5647	21	Env [s] data logger lithium battery low	Binary input	36	Boolean			\N	On (1)	Alarm	Normal				
5648	21	Env [s] data logger lithium battery critical	Binary input	37	Boolean			\N	On (1)	Alarm	Normal				
5649	21	Env [s] data logger voltage error	Binary input	38	Boolean			\N	On (1)	Alarm	Normal				
5650	21	Env [s] data logger low voltage warning	Binary input	39	Boolean			\N	On (1)	Alarm	Normal				
5651	21	Env [s] data logger low voltage	Binary input	40	Boolean			\N	On (1)	Alarm	Normal				
5652	21	Env [s] data logger over voltage	Binary input	41	Boolean			\N	On (1)	Alarm	Normal				
5653	21	Env [s] data logger temperature error	Binary input	42	Boolean			\N	On (1)	Alarm	Normal				
5654	21	Env [s] data logger temperature below operating range	Binary input	43	Boolean			\N	On (1)	Alarm	Normal				
5655	21	Env [s] data logger temperature above operating range	Binary input	44	Boolean			\N	On (1)	Alarm	Normal				
5656	21	Env [s] communication failure alarm	Binary input	45	Boolean			\N	On (1)	Alarm	Normal				
5657	21	Env [a] GHI irradiance error	Binary input	46	Boolean			\N	On (1)	Alarm	Normal				
5658	21	Env [a] GHI irradiance negative	Binary input	47	Boolean			\N	On (1)	Alarm	Normal				
5659	21	Env [a] GHI irradiance above solar constant	Binary input	48	Boolean			\N	On (1)	Alarm	Normal				
5660	21	Env [a] GHI irradiance insufficient activity	Binary input	49	Boolean			\N	On (1)	Alarm	Normal				
5661	21	Env [a] RHI irradiance error	Binary input	50	Boolean			\N	On (1)	Alarm	Normal				
5662	21	Env [a] RHI irradiance negative	Binary input	51	Boolean			\N	On (1)	Alarm	Normal				
5663	21	Env [a] RHI irradiance above solar constant	Binary input	52	Boolean			\N	On (1)	Alarm	Normal				
5664	21	Env [a] RHI irradiance insufficient activity	Binary input	53	Boolean			\N	On (1)	Alarm	Normal				
5665	21	Env [a] GHI case temperature error	Binary input	54	Boolean			\N	On (1)	Alarm	Normal				
5666	21	Env [a] GHI case temperature below operating range	Binary input	55	Boolean			\N	On (1)	Alarm	Normal				
5667	21	Env [a] GHI case temperature above operating range	Binary input	56	Boolean			\N	On (1)	Alarm	Normal				
5668	21	Env [a] RHI case temperature error	Binary input	57	Boolean			\N	On (1)	Alarm	Normal				
5669	21	Env [a] RHI case temperature below operating range	Binary input	58	Boolean			\N	On (1)	Alarm	Normal				
5670	21	Env [a] RHI case temperature above operating range	Binary input	59	Boolean			\N	On (1)	Alarm	Normal				
5671	21	Env [a] albedo out of range	Binary input	60	Boolean			\N	On (1)	Alarm	Normal				
5672	21	Env [a] data logger watchdog error	Binary input	61	Boolean			\N	On (1)	Alarm	Normal				
5673	21	Env [a] data logger skipped main scan	Binary input	62	Boolean			\N	On (1)	Alarm	Normal				
5674	21	Env [a] data logger skipped slow scan	Binary input	63	Boolean			\N	On (1)	Alarm	Normal				
5675	21	Env [a] data logger program variable out of bounds	Binary input	64	Boolean			\N	On (1)	Alarm	Normal				
5676	21	Env [a] data logger low 12V	Binary input	65	Boolean			\N	On (1)	Alarm	Normal				
5677	21	Env [a] data logger low 5V	Binary input	66	Boolean			\N	On (1)	Alarm	Normal				
5678	21	Env [a] data logger lithium battery error	Binary input	67	Boolean			\N	On (1)	Alarm	Normal				
5679	21	Env [a] data logger lithium battery low	Binary input	68	Boolean			\N	On (1)	Alarm	Normal				
5680	21	Env [a] data logger lithium battery critical	Binary input	69	Boolean			\N	On (1)	Alarm	Normal				
5681	21	Env [a] data logger voltage error	Binary input	70	Boolean			\N	On (1)	Alarm	Normal				
5682	21	Env [a] data logger low voltage warning	Binary input	71	Boolean			\N	On (1)	Alarm	Normal				
5683	21	Env [a] data logger low voltage	Binary input	72	Boolean			\N	On (1)	Alarm	Normal				
5684	21	Env [a] data logger over voltage	Binary input	73	Boolean			\N	On (1)	Alarm	Normal				
5685	21	Env [a] data logger temperature error	Binary input	74	Boolean			\N	On (1)	Alarm	Normal				
5686	21	Env [a] data logger temperature below operating range	Binary input	75	Boolean			\N	On (1)	Alarm	Normal				
5687	21	Env [a] data logger temperature above operating range	Binary input	76	Boolean			\N	On (1)	Alarm	Normal				
5688	21	Env [a] communication failure alarm	Binary input	77	Boolean			\N	On (1)	Alarm	Normal				
5689	21	Env [n] POA 2 irradiance error	Binary input	78	Boolean			\N	On (1)	Alarm	Normal				
5690	21	Env [n] POA 2 irradiance negative	Binary input	79	Boolean			\N	On (1)	Alarm	Normal				
5691	21	Env [n] POA 2 irradiance above solar constant	Binary input	80	Boolean			\N	On (1)	Alarm	Normal				
5692	21	Env [n] POA 2 temperature corrected irradiance error	Binary input	81	Boolean			\N	On (1)	Alarm	Normal				
5693	21	Env [n] POA 2 temperature corrected irradiance negative	Binary input	82	Boolean			\N	On (1)	Alarm	Normal				
5694	21	Env [n] POA 2 temperature corrected irradiance above solar constant	Binary input	83	Boolean			\N	On (1)	Alarm	Normal				
5695	21	Env [n] POA 2 case temperature error	Binary input	84	Boolean			\N	On (1)	Alarm	Normal				
5696	21	Env [n] POA 2 case temperature below operating range	Binary input	85	Boolean			\N	On (1)	Alarm	Normal				
5697	21	Env [n] POA 2 case temperature above operating range	Binary input	86	Boolean			\N	On (1)	Alarm	Normal				
5698	21	Env [n] POA 2 irradiance insufficient activity	Binary input	87	Boolean			\N	On (1)	Alarm	Normal				
\.


--
-- Data for Name: map_version; Type: TABLE DATA; Schema: public; Owner: mmunin
--

COPY public.map_version (id, interface_id, version, release_date, changelog) FROM stdin;
1	1	1.0	\N	\N
2	2	1.0	\N	\N
3	3	1.0	\N	\N
4	4	1.0	\N	\N
5	5	1.0	\N	\N
6	6	1.0	\N	\N
7	7	1.0	\N	\N
8	8	1.0	\N	\N
9	9	1.0	\N	\N
10	10	1.0	\N	\N
11	11	1.0	\N	\N
12	12	1.0	\N	\N
13	13	1.0	\N	\N
14	14	1.0	\N	\N
15	15	1.0	\N	\N
21	12	1.1	2025-05-02	Added points for 2nd POA on Met Towers.\nAdded points for DustIQ\n Existing points left alone.\n
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: mmunin
--

COPY public.project (id, name, location, notes) FROM stdin;
1	Hornshadow Points List	Castle Dale, UT	Generated 5/2/25
\.


--
-- Data for Name: project_map_usage; Type: TABLE DATA; Schema: public; Owner: mmunin
--

COPY public.project_map_usage (id, project_id, interface_id, version_id, notes) FROM stdin;
1	1	4	4	5 met towers.
2	1	7	7	3 dustiqs
3	1	12	21	first time used
\.


--
-- Name: api_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mmunin
--

SELECT pg_catalog.setval('public.api_provider_id_seq', 18, true);


--
-- Name: data_interface_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mmunin
--

SELECT pg_catalog.setval('public.data_interface_id_seq', 16, true);


--
-- Name: map_point_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mmunin
--

SELECT pg_catalog.setval('public.map_point_id_seq', 5698, true);


--
-- Name: map_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mmunin
--

SELECT pg_catalog.setval('public.map_version_id_seq', 22, true);


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mmunin
--

SELECT pg_catalog.setval('public.project_id_seq', 1, true);


--
-- Name: project_map_usage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mmunin
--

SELECT pg_catalog.setval('public.project_map_usage_id_seq', 3, true);


--
-- Name: api_provider api_provider_name_key; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.api_provider
    ADD CONSTRAINT api_provider_name_key UNIQUE (name);


--
-- Name: api_provider api_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.api_provider
    ADD CONSTRAINT api_provider_pkey PRIMARY KEY (id);


--
-- Name: data_interface data_interface_name_key; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.data_interface
    ADD CONSTRAINT data_interface_name_key UNIQUE (name);


--
-- Name: data_interface data_interface_pkey; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.data_interface
    ADD CONSTRAINT data_interface_pkey PRIMARY KEY (id);


--
-- Name: map_point map_point_pkey; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.map_point
    ADD CONSTRAINT map_point_pkey PRIMARY KEY (id);


--
-- Name: map_version map_version_interface_id_version_key; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.map_version
    ADD CONSTRAINT map_version_interface_id_version_key UNIQUE (interface_id, version);


--
-- Name: map_version map_version_pkey; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.map_version
    ADD CONSTRAINT map_version_pkey PRIMARY KEY (id);


--
-- Name: project_map_usage project_map_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.project_map_usage
    ADD CONSTRAINT project_map_usage_pkey PRIMARY KEY (id);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: data_interface data_interface_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.data_interface
    ADD CONSTRAINT data_interface_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.api_provider(id);


--
-- Name: map_point map_point_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.map_point
    ADD CONSTRAINT map_point_version_id_fkey FOREIGN KEY (version_id) REFERENCES public.map_version(id) ON DELETE CASCADE;


--
-- Name: map_version map_version_interface_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.map_version
    ADD CONSTRAINT map_version_interface_id_fkey FOREIGN KEY (interface_id) REFERENCES public.data_interface(id) ON DELETE CASCADE;


--
-- Name: project_map_usage project_map_usage_interface_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.project_map_usage
    ADD CONSTRAINT project_map_usage_interface_id_fkey FOREIGN KEY (interface_id) REFERENCES public.data_interface(id);


--
-- Name: project_map_usage project_map_usage_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.project_map_usage
    ADD CONSTRAINT project_map_usage_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project_map_usage project_map_usage_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mmunin
--

ALTER TABLE ONLY public.project_map_usage
    ADD CONSTRAINT project_map_usage_version_id_fkey FOREIGN KEY (version_id) REFERENCES public.map_version(id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

