--
-- PostgreSQL database dump
--

-- Dumped from database version 14.23
-- Dumped by pg_dump version 17.0

-- Started on 2026-06-24 18:22:03

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
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 16455)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 213 (class 1259 OID 16399)
-- Name: facturas; Type: TABLE; Schema: public; Owner: terceros01
--

CREATE TABLE public.facturas (
    id_factura bigint NOT NULL,
    fecha_factura date NOT NULL,
    id_tercero bigint NOT NULL,
    numero integer
);


ALTER TABLE public.facturas OWNER TO terceros01;

--
-- TOC entry 212 (class 1259 OID 16398)
-- Name: facturas_id_factura_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

CREATE SEQUENCE public.facturas_id_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facturas_id_factura_seq OWNER TO terceros01;

--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 212
-- Name: facturas_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terceros01
--

ALTER SEQUENCE public.facturas_id_factura_seq OWNED BY public.facturas.id_factura;


--
-- TOC entry 215 (class 1259 OID 16411)
-- Name: facturas_items; Type: TABLE; Schema: public; Owner: terceros01
--

CREATE TABLE public.facturas_items (
    id_items bigint NOT NULL,
    monto numeric(38,2) NOT NULL,
    cantidad numeric(38,2) NOT NULL,
    id_factura bigint NOT NULL,
    detalle character varying(255)
);


ALTER TABLE public.facturas_items OWNER TO terceros01;

--
-- TOC entry 214 (class 1259 OID 16410)
-- Name: facturas_items_id_items_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

CREATE SEQUENCE public.facturas_items_id_items_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facturas_items_id_items_seq OWNER TO terceros01;

--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 214
-- Name: facturas_items_id_items_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terceros01
--

ALTER SEQUENCE public.facturas_items_id_items_seq OWNED BY public.facturas_items.id_items;


--
-- TOC entry 217 (class 1259 OID 16423)
-- Name: facultad; Type: TABLE; Schema: public; Owner: terceros01
--

CREATE TABLE public.facultad (
    id_facultad bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    direccion character varying(255) NOT NULL,
    cuit character varying(255) NOT NULL,
    sucursal integer NOT NULL,
    telefonos character varying(255),
    email character varying(255),
    defecto boolean DEFAULT false
);


ALTER TABLE public.facultad OWNER TO terceros01;

--
-- TOC entry 216 (class 1259 OID 16422)
-- Name: facultad_id_facultad_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

CREATE SEQUENCE public.facultad_id_facultad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facultad_id_facultad_seq OWNER TO terceros01;

--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 216
-- Name: facultad_id_facultad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terceros01
--

ALTER SEQUENCE public.facultad_id_facultad_seq OWNED BY public.facultad.id_facultad;


--
-- TOC entry 219 (class 1259 OID 16431)
-- Name: pagos; Type: TABLE; Schema: public; Owner: terceros01
--

CREATE TABLE public.pagos (
    id_pagos bigint NOT NULL,
    id_tercero bigint NOT NULL,
    fecha_pago date NOT NULL,
    monto_pago numeric(38,2),
    modo_pago character varying(255) NOT NULL
);


ALTER TABLE public.pagos OWNER TO terceros01;

--
-- TOC entry 221 (class 1259 OID 16443)
-- Name: pagos_detalle; Type: TABLE; Schema: public; Owner: terceros01
--

CREATE TABLE public.pagos_detalle (
    id_pagosdetalle bigint NOT NULL,
    instrumentnumber character varying(255) NOT NULL,
    instrumentdate date NOT NULL,
    banco character varying(255),
    pagorealizado boolean DEFAULT false,
    id_pagos bigint NOT NULL
);


ALTER TABLE public.pagos_detalle OWNER TO terceros01;

--
-- TOC entry 220 (class 1259 OID 16442)
-- Name: pagos_detalle_id_pagosdetalle_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

CREATE SEQUENCE public.pagos_detalle_id_pagosdetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_detalle_id_pagosdetalle_seq OWNER TO terceros01;

--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 220
-- Name: pagos_detalle_id_pagosdetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terceros01
--

ALTER SEQUENCE public.pagos_detalle_id_pagosdetalle_seq OWNED BY public.pagos_detalle.id_pagosdetalle;


--
-- TOC entry 218 (class 1259 OID 16430)
-- Name: pagos_id_pagos_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

CREATE SEQUENCE public.pagos_id_pagos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_id_pagos_seq OWNER TO terceros01;

--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 218
-- Name: pagos_id_pagos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terceros01
--

ALTER SEQUENCE public.pagos_id_pagos_seq OWNED BY public.pagos.id_pagos;


--
-- TOC entry 224 (class 1259 OID 24576)
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    task_id bigint NOT NULL,
    creation_date timestamp(6) with time zone NOT NULL,
    description character varying(300) NOT NULL,
    due_date date
);


ALTER TABLE public.task OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24581)
-- Name: task_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_seq OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16392)
-- Name: terceros; Type: TABLE; Schema: public; Owner: terceros01
--

CREATE TABLE public.terceros (
    id_tercero bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    cuitl character varying(255) NOT NULL,
    sitiva character varying(255) NOT NULL,
    direccion character varying(255) NOT NULL,
    localidad character varying(255),
    provincia character varying(255),
    telefonos character varying(255),
    saldo_apertura numeric(38,2),
    tipo_saldo character varying(255)
);


ALTER TABLE public.terceros OWNER TO terceros01;

--
-- TOC entry 210 (class 1259 OID 16391)
-- Name: terceros_id_tercero_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

CREATE SEQUENCE public.terceros_id_tercero_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.terceros_id_tercero_seq OWNER TO terceros01;

--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 210
-- Name: terceros_id_tercero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terceros01
--

ALTER SEQUENCE public.terceros_id_tercero_seq OWNED BY public.terceros.id_tercero;


--
-- TOC entry 223 (class 1259 OID 16587)
-- Name: users; Type: TABLE; Schema: public; Owner: terceros01
--

CREATE TABLE public.users (
    id_user bigint NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    id bigint NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.users OWNER TO terceros01;

--
-- TOC entry 226 (class 1259 OID 24582)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16586)
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

ALTER TABLE public.users ALTER COLUMN id_user ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 24592)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: terceros01
--

CREATE TABLE public.usuarios (
    id bigint NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);


ALTER TABLE public.usuarios OWNER TO terceros01;

--
-- TOC entry 227 (class 1259 OID 24591)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: terceros01
--

ALTER TABLE public.usuarios ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3343 (class 2604 OID 16466)
-- Name: facturas id_factura; Type: DEFAULT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.facturas ALTER COLUMN id_factura SET DEFAULT nextval('public.facturas_id_factura_seq'::regclass);


--
-- TOC entry 3344 (class 2604 OID 16487)
-- Name: facturas_items id_items; Type: DEFAULT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.facturas_items ALTER COLUMN id_items SET DEFAULT nextval('public.facturas_items_id_items_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 16511)
-- Name: facultad id_facultad; Type: DEFAULT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.facultad ALTER COLUMN id_facultad SET DEFAULT nextval('public.facultad_id_facultad_seq'::regclass);


--
-- TOC entry 3347 (class 2604 OID 16526)
-- Name: pagos id_pagos; Type: DEFAULT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.pagos ALTER COLUMN id_pagos SET DEFAULT nextval('public.pagos_id_pagos_seq'::regclass);


--
-- TOC entry 3348 (class 2604 OID 16547)
-- Name: pagos_detalle id_pagosdetalle; Type: DEFAULT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.pagos_detalle ALTER COLUMN id_pagosdetalle SET DEFAULT nextval('public.pagos_detalle_id_pagosdetalle_seq'::regclass);


--
-- TOC entry 3342 (class 2604 OID 16567)
-- Name: terceros id_tercero; Type: DEFAULT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.terceros ALTER COLUMN id_tercero SET DEFAULT nextval('public.terceros_id_tercero_seq'::regclass);


--
-- TOC entry 3520 (class 0 OID 16399)
-- Dependencies: 213
-- Data for Name: facturas; Type: TABLE DATA; Schema: public; Owner: terceros01
--

COPY public.facturas (id_factura, fecha_factura, id_tercero, numero) FROM stdin;
2	2024-06-01	4	1002
3	2024-06-08	37	1003
4	2024-09-04	4	1004
5	2025-11-18	33	1005
6	2024-10-21	36	1006
7	2024-06-30	35	1007
8	2025-01-16	13	1008
9	2025-08-16	13	1009
10	2024-04-04	26	1010
11	2025-11-21	25	1011
12	2025-09-13	2	1012
13	2025-02-14	14	1013
14	2025-03-06	15	1014
15	2024-07-07	31	1015
16	2025-10-05	23	1016
17	2024-10-13	25	1017
18	2025-08-08	16	1018
19	2024-11-03	17	1019
20	2024-01-05	17	1020
21	2024-11-06	5	1021
22	2024-01-12	22	1022
23	2025-06-23	34	1023
24	2025-02-01	1	1024
25	2025-11-27	8	1025
26	2025-01-31	25	1026
27	2024-10-07	26	1027
28	2024-04-22	12	1028
29	2024-05-19	7	1029
30	2024-05-02	26	1030
31	2024-09-10	35	1031
32	2025-02-23	30	1032
33	2025-08-17	30	1033
34	2025-10-08	27	1034
35	2025-06-16	15	1035
36	2024-06-27	19	1036
37	2024-06-22	35	1037
38	2024-11-04	17	1038
39	2025-11-04	38	1039
40	2024-10-10	28	1040
41	2025-08-08	24	1041
42	2025-05-16	28	1042
43	2025-07-24	15	1043
44	2025-07-11	11	1044
45	2024-07-06	14	1045
46	2025-12-14	26	1046
47	2025-09-18	22	1047
48	2024-09-17	9	1048
49	2025-08-16	14	1049
50	2025-03-30	30	1050
51	2025-09-11	11	1051
52	2025-12-24	10	1052
53	2025-05-26	14	1053
54	2024-10-26	25	1054
55	2025-11-23	24	1055
56	2025-12-12	8	1056
57	2025-05-03	7	1057
58	2024-03-03	24	1058
59	2024-12-17	30	1059
60	2025-04-02	12	1060
61	2024-03-09	9	1061
62	2025-12-15	34	1062
63	2024-06-08	15	1063
64	2025-07-21	9	1064
65	2024-10-24	21	1065
66	2025-06-20	23	1066
67	2024-03-02	28	1067
68	2024-03-17	23	1068
69	2024-09-30	37	1069
70	2024-02-04	29	1070
71	2025-01-31	19	1071
72	2024-11-27	8	1072
73	2024-08-22	12	1073
74	2024-05-26	34	1074
75	2025-08-03	3	1075
76	2024-05-10	5	1076
77	2025-08-09	6	1077
78	2024-07-06	19	1078
79	2024-03-01	33	1079
80	2025-09-07	36	1080
81	2024-10-08	31	1081
82	2025-05-19	28	1082
83	2025-08-04	34	1083
84	2025-02-21	14	1084
85	2024-03-12	9	1085
86	2024-08-28	6	1086
87	2025-08-19	1	1087
88	2025-07-07	6	1088
89	2025-10-03	7	1089
90	2025-01-22	36	1090
91	2024-12-01	26	1091
92	2025-07-14	7	1092
93	2025-08-24	19	1093
95	2025-06-08	12	1095
96	2025-08-29	23	1096
97	2024-08-20	7	1097
98	2025-09-11	37	1098
99	2025-12-23	35	1099
100	2024-07-12	10	1100
\.


--
-- TOC entry 3522 (class 0 OID 16411)
-- Dependencies: 215
-- Data for Name: facturas_items; Type: TABLE DATA; Schema: public; Owner: terceros01
--

COPY public.facturas_items (id_items, monto, cantidad, id_factura, detalle) FROM stdin;
4	4746.11	57.25	2	Mantenimiento
5	4982.11	85.80	2	Ecografía
6	4723.01	67.21	2	Capacitación
7	4918.95	89.37	2	Cuota social
8	116.18	26.77	2	Ecografía
9	477.32	85.17	3	Servicio de limpieza
10	2985.14	72.79	3	Honorarios
11	2520.97	27.42	3	Material de oficina
12	276.13	98.28	3	Mantenimiento
13	1896.55	20.67	4	Consultoría
14	3714.13	53.04	4	Cuota social
15	3295.06	50.09	4	Radiografía
16	1264.74	59.39	4	Terapia
17	1290.40	74.30	4	Ecografía
18	1353.58	73.90	5	Libros
19	2176.71	65.56	5	Software
20	4468.43	47.10	5	Medicamentos
21	1349.23	2.47	5	Material didáctico
22	1505.88	93.60	5	Telecomunicaciones
23	2102.41	66.95	6	Servicios públicos
24	4495.74	44.88	6	Servicio de limpieza
25	1380.12	64.07	6	Honorarios
26	2693.92	92.31	6	Material de oficina
27	931.74	80.57	7	Alquiler
28	415.52	26.87	7	Equipo informático
29	374.67	62.63	7	Servicios públicos
30	382.53	36.26	7	Análisis clínicos
31	843.25	11.78	7	Terapia
32	3038.59	58.31	8	Servicio de limpieza
33	2306.81	97.56	8	Servicios públicos
34	476.41	55.65	8	Libros
35	2398.38	65.30	8	Mantenimiento
36	3120.94	68.91	8	Radiografía
37	1583.85	51.45	9	Software
38	537.54	32.69	9	Terapia
39	2304.03	92.82	9	Servicio de limpieza
40	3732.34	49.47	9	Análisis clínicos
41	951.70	29.03	9	Medicamentos
42	3402.16	30.87	10	Consulta médica
43	3318.23	32.46	10	Análisis clínicos
44	4270.15	84.29	11	Ecografía
45	3458.77	62.33	11	Ecografía
46	2628.19	6.27	11	Cuota social
47	1432.30	57.38	11	Libros
48	1522.73	84.00	11	Inscripción
49	3015.25	69.04	12	Telecomunicaciones
50	554.49	95.03	12	Material de oficina
51	866.41	43.98	12	Tratamiento dental
52	4702.52	35.51	12	Material de oficina
53	4491.14	69.89	13	Cuota social
54	1708.90	1.52	13	Cuota social
55	1656.06	42.65	13	Cirugía menor
56	3941.37	46.22	14	Tratamiento dental
57	774.39	89.81	14	Servicios públicos
58	1205.09	55.16	15	Consultoría
59	3534.16	20.56	15	Análisis clínicos
60	4554.55	55.18	15	Radiografía
61	1627.53	27.96	15	Equipo informático
62	193.09	85.34	15	Inscripción
63	3271.44	23.05	16	Mantenimiento
64	2867.93	73.19	16	Telecomunicaciones
65	409.62	82.90	16	Equipo informático
66	1349.52	63.05	17	Consultoría
67	2255.00	50.55	17	Seguridad
68	3654.27	38.24	17	Software
69	1290.72	56.80	17	Material de oficina
70	877.35	21.05	18	Servicio de limpieza
71	270.55	0.71	19	Material didáctico
72	4922.37	5.06	20	Servicio de limpieza
73	2922.82	20.73	21	Servicio de limpieza
74	2255.58	49.63	21	Material didáctico
75	2219.91	15.13	21	Cuota social
76	2772.11	42.99	22	Material didáctico
77	570.01	50.35	23	Servicios públicos
78	2172.92	8.10	23	Inscripción
79	2662.57	71.94	24	Ecografía
80	767.97	7.21	24	Consultoría
81	2485.11	2.80	24	Consulta médica
82	496.78	83.98	24	Material didáctico
83	3551.21	90.27	24	Cirugía menor
84	1637.01	46.14	25	Capacitación
85	3643.56	59.14	25	Servicios públicos
86	4387.16	63.22	26	Ecografía
87	2553.11	59.13	26	Equipo informático
88	2684.13	50.31	26	Cuota social
89	1600.27	61.53	26	Radiografía
90	4434.91	27.75	26	Terapia
91	3467.19	29.81	27	Ecografía
92	2590.38	88.67	27	Servicio de limpieza
93	4266.80	37.18	27	Alquiler
94	4345.42	77.71	27	Servicio de limpieza
95	212.64	20.93	27	Equipo informático
96	183.55	3.10	28	Inscripción
97	1863.92	54.65	28	Cirugía menor
98	4308.20	8.92	28	Libros
99	1159.11	3.52	29	Seguridad
100	2975.74	3.81	29	Inscripción
101	1853.21	82.21	30	Material didáctico
102	2980.67	84.77	30	Software
103	4797.64	53.92	31	Honorarios
104	314.79	40.74	31	Servicios públicos
105	4862.10	69.57	31	Equipo informático
106	1254.20	10.70	31	Alquiler
107	4239.36	61.88	32	Material didáctico
108	4030.48	29.13	32	Capacitación
109	2820.47	51.75	32	Cuota social
110	4185.60	37.98	32	Material de oficina
111	4505.90	90.20	33	Libros
112	2253.12	84.39	33	Radiografía
113	3202.14	83.81	33	Material de oficina
114	4760.58	70.40	34	Alquiler
115	4682.87	32.30	34	Libros
116	4540.82	53.37	34	Honorarios
117	1879.31	97.81	34	Seguridad
118	2692.48	65.52	34	Telecomunicaciones
119	481.22	17.08	35	Cuota social
120	4922.97	11.32	35	Material de oficina
121	4426.01	82.76	35	Análisis clínicos
122	4956.77	14.83	35	Servicios públicos
123	66.72	41.86	35	Equipo informático
124	1128.09	72.91	36	Radiografía
125	3612.33	49.05	36	Telecomunicaciones
126	4137.03	35.20	36	Telecomunicaciones
127	4560.63	93.74	36	Honorarios
128	736.95	70.69	37	Alquiler
129	3366.08	93.07	37	Material de oficina
130	786.86	86.25	37	Seguridad
131	3300.72	52.51	37	Equipo informático
132	450.25	72.83	38	Material de oficina
133	2615.83	33.41	38	Material de oficina
134	508.36	35.81	38	Cirugía menor
135	1550.79	54.35	38	Alquiler
136	3556.59	43.83	38	Seguridad
137	241.25	69.95	39	Radiografía
138	3057.05	45.20	39	Libros
139	3425.14	98.01	39	Radiografía
140	4486.10	63.58	40	Mantenimiento
141	650.00	37.95	40	Cirugía menor
142	4208.80	24.58	40	Libros
143	1333.11	67.70	41	Tratamiento dental
144	3591.80	92.04	41	Cirugía menor
145	4921.91	23.65	41	Material de oficina
146	4489.88	14.04	42	Medicamentos
147	860.23	17.30	42	Consulta médica
148	345.71	77.24	42	Servicio de limpieza
149	481.92	95.25	43	Servicio de limpieza
150	1327.89	55.75	43	Cirugía menor
151	3343.99	96.39	44	Alquiler
152	4285.27	28.38	44	Ecografía
153	437.45	48.83	44	Honorarios
154	3440.95	78.20	44	Cirugía menor
155	4311.40	17.72	44	Capacitación
156	1773.45	95.44	45	Mantenimiento
157	3444.85	43.06	45	Telecomunicaciones
158	464.34	72.80	45	Equipo informático
159	2727.22	60.10	45	Terapia
160	3212.71	9.87	45	Libros
161	2958.53	17.17	46	Mantenimiento
162	4347.87	5.34	46	Cirugía menor
163	3446.54	89.68	46	Inscripción
164	3276.28	18.03	46	Mantenimiento
165	627.21	48.26	46	Consultoría
166	4591.40	81.61	47	Radiografía
167	3058.85	21.99	47	Telecomunicaciones
168	741.11	73.73	47	Software
169	3510.10	53.93	47	Cirugía menor
170	233.34	77.95	47	Alquiler
171	581.99	40.16	48	Cirugía menor
172	2846.39	78.56	48	Inscripción
173	4883.36	60.55	48	Honorarios
174	803.28	94.65	49	Tratamiento dental
175	133.71	13.50	50	Ecografía
176	1014.46	13.72	50	Tratamiento dental
177	1422.02	33.75	50	Consulta médica
178	3638.20	51.28	51	Tratamiento dental
179	4250.80	64.73	52	Servicio de limpieza
180	2705.38	17.77	52	Capacitación
181	3937.49	94.47	53	Ecografía
182	1957.05	32.69	53	Material de oficina
183	1164.86	58.90	54	Equipo informático
184	1681.05	25.12	54	Terapia
185	4966.16	32.72	54	Material didáctico
186	407.90	53.72	54	Terapia
187	4523.07	63.93	54	Inscripción
188	2675.91	12.91	55	Servicio de limpieza
189	3326.66	16.00	55	Software
190	140.40	49.04	56	Cuota social
191	882.98	3.26	56	Cirugía menor
192	3974.78	17.18	56	Libros
193	4224.63	24.05	56	Equipo informático
194	688.11	100.16	57	Consulta médica
195	1714.80	94.79	58	Cirugía menor
196	3869.40	13.69	58	Servicios públicos
197	1596.29	42.37	58	Consultoría
198	2204.01	4.44	58	Servicio de limpieza
199	4585.43	66.64	59	Cuota social
200	4808.30	17.04	59	Análisis clínicos
201	4745.07	67.97	59	Libros
202	2701.49	22.09	59	Libros
203	2677.62	63.55	59	Análisis clínicos
204	3576.52	20.27	60	Cirugía menor
205	2942.72	65.30	60	Honorarios
206	3198.38	46.48	60	Honorarios
207	1903.57	32.04	61	Libros
208	2527.14	3.97	61	Medicamentos
209	2577.08	39.91	61	Mantenimiento
210	2579.85	48.18	62	Medicamentos
211	4167.08	30.37	63	Cuota social
212	125.83	90.04	63	Mantenimiento
213	2332.64	96.53	63	Medicamentos
214	1646.69	26.03	63	Consultoría
215	2617.99	9.31	64	Alquiler
216	2637.89	77.35	64	Servicio de limpieza
217	2912.40	24.08	64	Servicios públicos
218	302.46	98.48	64	Material de oficina
219	1160.92	83.58	64	Tratamiento dental
220	198.40	85.18	65	Material de oficina
221	871.40	93.85	65	Cirugía menor
222	2023.76	5.94	65	Consultoría
223	4824.56	79.03	65	Material didáctico
224	1375.47	85.47	66	Material de oficina
225	254.53	62.42	66	Inscripción
226	439.86	61.13	66	Ecografía
227	1961.25	37.05	67	Inscripción
228	2990.57	44.07	68	Análisis clínicos
229	1364.15	22.26	69	Cuota social
230	3773.94	11.76	70	Equipo informático
231	898.97	66.78	70	Ecografía
232	3987.68	82.42	70	Telecomunicaciones
233	2507.98	91.64	71	Servicio de limpieza
234	488.89	32.14	72	Consulta médica
235	2543.24	76.53	72	Mantenimiento
236	3302.38	12.70	72	Equipo informático
237	1682.65	40.55	72	Análisis clínicos
238	331.58	18.15	72	Mantenimiento
239	627.93	10.30	73	Software
240	712.83	45.30	73	Equipo informático
241	2315.02	100.43	73	Seguridad
242	1330.68	13.31	74	Ecografía
243	1583.22	27.33	74	Alquiler
244	2726.62	1.74	75	Material didáctico
245	388.43	75.11	75	Medicamentos
246	1936.05	59.77	75	Inscripción
247	1961.67	50.88	76	Material de oficina
248	2059.89	34.14	76	Telecomunicaciones
249	3280.11	95.19	76	Cuota social
250	1301.36	80.67	76	Servicio de limpieza
251	911.35	56.34	77	Servicios públicos
252	2706.70	57.33	78	Telecomunicaciones
253	677.86	29.62	78	Capacitación
254	2832.76	6.20	79	Medicamentos
255	179.44	17.04	80	Consulta médica
256	2496.40	95.47	80	Radiografía
257	4372.65	70.64	80	Inscripción
258	1887.39	51.17	80	Material de oficina
259	207.03	80.65	81	Consulta médica
260	1944.02	32.15	81	Tratamiento dental
261	1585.40	52.88	82	Análisis clínicos
262	98.16	57.38	82	Seguridad
263	3446.74	69.96	82	Consultoría
264	3385.19	34.13	83	Seguridad
265	1277.98	26.47	83	Libros
266	4869.13	6.96	83	Tratamiento dental
267	2532.85	33.30	83	Software
268	3058.52	49.85	83	Cirugía menor
269	1949.20	13.88	84	Software
270	3813.75	98.90	84	Consultoría
271	2979.21	99.59	84	Equipo informático
272	2386.46	70.95	84	Inscripción
273	2932.04	62.22	85	Capacitación
274	1665.29	77.61	85	Software
275	4948.14	2.65	85	Alquiler
276	2110.03	7.42	85	Consulta médica
277	1981.85	1.73	86	Consultoría
278	624.71	3.19	86	Ecografía
279	419.79	50.45	86	Terapia
280	1489.61	59.31	86	Material de oficina
281	4107.06	75.52	86	Cirugía menor
282	815.82	5.79	87	Análisis clínicos
283	202.53	23.60	87	Cirugía menor
284	51.51	57.77	88	Inscripción
285	4362.19	33.41	88	Libros
286	4792.19	5.56	88	Análisis clínicos
287	1899.12	17.94	89	Libros
288	1262.73	76.80	89	Capacitación
289	3261.24	83.76	89	Servicio de limpieza
290	2744.53	72.23	89	Inscripción
291	406.42	74.99	90	Medicamentos
292	2139.28	77.72	90	Alquiler
293	1347.89	87.88	90	Servicios públicos
294	3427.17	4.28	90	Material didáctico
295	1940.96	86.27	90	Libros
296	3148.27	29.05	91	Terapia
297	4964.54	41.68	91	Tratamiento dental
298	1734.27	1.30	91	Análisis clínicos
299	648.02	78.36	91	Medicamentos
300	513.20	45.41	91	Análisis clínicos
301	260.92	73.51	92	Servicio de limpieza
302	2506.43	37.32	92	Seguridad
303	343.13	63.92	92	Consulta médica
304	421.97	5.23	92	Telecomunicaciones
305	2160.41	76.81	93	Honorarios
306	1439.24	44.45	93	Terapia
307	1492.05	42.61	93	Medicamentos
308	2169.87	41.06	93	Análisis clínicos
309	3035.98	9.42	93	Mantenimiento
312	4087.93	18.79	95	Seguridad
313	4993.69	24.48	95	Mantenimiento
314	862.22	39.06	96	Análisis clínicos
315	2373.55	18.07	96	Alquiler
316	806.20	80.59	97	Servicios públicos
317	1008.11	34.69	98	Telecomunicaciones
318	4502.65	66.54	99	Mantenimiento
319	354.74	28.30	99	Terapia
320	4460.41	18.07	99	Terapia
321	2481.64	52.09	100	Capacitación
322	1085.18	27.16	100	Equipo informático
323	118.98	50.91	100	Software
324	3345.81	99.98	100	Honorarios
325	136.22	10.69	100	Honorarios
\.


--
-- TOC entry 3524 (class 0 OID 16423)
-- Dependencies: 217
-- Data for Name: facultad; Type: TABLE DATA; Schema: public; Owner: terceros01
--

COPY public.facultad (id_facultad, nombre, direccion, cuit, sucursal, telefonos, email, defecto) FROM stdin;
1	Facultad de Ingeniería	Av. Libertador 1234, Buenos Aires	30-12345678-9	1	011-4123-4567;011-4123-4568	ingenieria@universidad.edu	t
2	Facultad de Medicina	Calle Corrientes 567, Buenos Aires	30-23456789-0	2	011-5234-5678;011-5234-5679	medicina@universidad.edu	f
3	Facultad de Derecho	Av. Callao 890, Buenos Aires	30-34567890-1	3	011-6345-6789	derecho@universidad.edu	f
4	Facultad de Economía	Calle Florida 123, Buenos Aires	30-45678901-2	4	011-7456-7890;011-7456-7891	economia@universidad.edu	f
5	Facultad de Ciencias Exactas	Av. Del Libertador 4567, Córdoba	30-56789012-3	5	0351-456-7890	exactas@universidad.edu	f
6	Facultad de Psicología	Calle San Martín 789, Rosario	30-67890123-4	6	0341-567-8901	psicologia@universidad.edu	f
\.


--
-- TOC entry 3526 (class 0 OID 16431)
-- Dependencies: 219
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: terceros01
--

COPY public.pagos (id_pagos, id_tercero, fecha_pago, monto_pago, modo_pago) FROM stdin;
2	14	2024-11-07	9354.57	CHEQUE
3	37	2025-12-08	39213.91	CHEQUE
4	12	2024-07-05	8723.38	CHEQUE
5	16	2025-08-01	13491.14	MERCADO PAGO
6	20	2025-02-04	45269.78	TRANSFERENCIA
7	9	2024-02-10	15024.61	EFECTIVO
8	7	2025-02-22	5386.40	CHEQUE
9	27	2024-06-28	41456.25	MERCADO PAGO
10	10	2025-09-12	21658.78	MERCADO PAGO
11	27	2024-05-08	2924.85	EFECTIVO
12	29	2024-02-23	46350.45	TRANSFERENCIA
13	1	2025-09-15	48329.23	MERCADO PAGO
14	14	2025-05-27	6479.07	CHEQUE
15	27	2025-04-08	11244.74	TRANSFERENCIA
16	14	2025-10-11	409.53	TARJETA
17	3	2024-08-29	40716.85	MERCADO PAGO
18	32	2024-03-14	35001.14	CHEQUE
19	16	2025-03-25	34548.08	EFECTIVO
20	10	2025-01-03	30519.87	TARJETA
21	18	2025-12-17	9149.60	CHEQUE
22	19	2025-06-27	37763.05	EFECTIVO
23	32	2025-11-11	20546.45	EFECTIVO
24	37	2024-05-08	18142.64	TARJETA
25	8	2025-10-29	45705.34	TRANSFERENCIA
26	7	2024-02-13	32834.57	MERCADO PAGO
27	21	2025-04-14	41996.74	TARJETA
28	24	2024-12-01	21525.39	TRANSFERENCIA
29	6	2024-05-01	25307.72	TARJETA
30	2	2025-07-31	24774.00	TARJETA
31	2	2025-11-28	44090.02	EFECTIVO
32	26	2024-03-04	16554.79	TRANSFERENCIA
33	15	2025-08-08	27457.44	TRANSFERENCIA
34	29	2024-01-15	15160.13	CHEQUE
35	4	2024-03-07	339.62	TARJETA
36	27	2025-04-23	31313.67	EFECTIVO
37	6	2024-07-25	37654.07	TARJETA
38	12	2025-06-11	42082.50	CHEQUE
39	24	2024-02-10	22476.08	CHEQUE
40	33	2025-10-16	47975.03	TRANSFERENCIA
41	31	2025-04-29	30266.12	TARJETA
42	3	2024-06-29	28472.45	TRANSFERENCIA
43	25	2024-11-27	32356.92	TRANSFERENCIA
44	28	2025-01-03	8165.98	TRANSFERENCIA
45	25	2024-10-25	47107.47	CHEQUE
46	30	2024-07-31	31658.01	MERCADO PAGO
47	27	2025-08-20	16399.00	TRANSFERENCIA
48	16	2025-06-26	20434.25	TARJETA
49	2	2025-10-03	48477.59	TRANSFERENCIA
50	3	2024-07-20	49025.37	MERCADO PAGO
51	17	2024-03-06	45541.23	TRANSFERENCIA
52	26	2024-09-12	30950.25	EFECTIVO
53	24	2025-08-10	25923.71	EFECTIVO
54	25	2024-05-29	47169.65	TRANSFERENCIA
55	19	2024-05-31	6245.57	TRANSFERENCIA
56	11	2024-11-29	31077.36	EFECTIVO
57	37	2024-07-15	28482.54	EFECTIVO
58	3	2024-10-12	44417.95	TRANSFERENCIA
59	35	2025-11-23	543.94	MERCADO PAGO
60	15	2025-01-09	37943.36	TRANSFERENCIA
61	38	2024-01-23	16659.42	MERCADO PAGO
62	26	2025-04-19	39107.38	MERCADO PAGO
63	13	2024-12-22	35639.06	EFECTIVO
64	17	2024-12-09	46645.74	EFECTIVO
65	17	2024-06-09	20902.75	TRANSFERENCIA
66	17	2025-08-27	38500.82	EFECTIVO
67	9	2024-08-12	36066.86	CHEQUE
68	10	2025-05-16	15223.78	TRANSFERENCIA
69	1	2025-05-31	43831.39	EFECTIVO
70	22	2025-07-25	5723.48	EFECTIVO
71	26	2024-10-30	23928.45	MERCADO PAGO
72	21	2024-08-19	6030.09	EFECTIVO
73	15	2025-06-02	7973.00	TRANSFERENCIA
74	1	2024-05-07	4602.74	TARJETA
75	9	2024-01-26	25199.21	TARJETA
76	2	2024-04-25	19634.56	EFECTIVO
77	11	2024-11-05	13271.04	EFECTIVO
78	24	2025-05-09	34794.34	TRANSFERENCIA
79	8	2024-05-19	22623.13	MERCADO PAGO
80	34	2024-05-24	19893.47	TARJETA
81	26	2025-06-16	31118.23	TRANSFERENCIA
82	1	2024-12-19	12077.59	MERCADO PAGO
83	16	2025-09-30	38199.91	CHEQUE
84	6	2024-09-16	11316.54	MERCADO PAGO
85	20	2024-07-31	24174.36	TRANSFERENCIA
86	9	2026-07-01	35253.00	transferencia
\.


--
-- TOC entry 3528 (class 0 OID 16443)
-- Dependencies: 221
-- Data for Name: pagos_detalle; Type: TABLE DATA; Schema: public; Owner: terceros01
--

COPY public.pagos_detalle (id_pagosdetalle, instrumentnumber, instrumentdate, banco, pagorealizado, id_pagos) FROM stdin;
1	02220499-2	2025-08-29	Banco Supervielle	t	2
2	01410801-7	2025-07-10	Banco Macro	t	4
3	05911164-0	2025-11-02	Banco Santander	t	7
4	09810383-2	2024-10-29	Banco Santander	t	9
5	03749405-4	2025-12-24	Banco Macro	t	10
6	05547281-4	2024-07-26	HSBC	t	11
7	07940499-7	2024-03-16	Banco Patagonia	t	12
8	06604443-1	2024-06-11	Banco Galicia	f	13
9	04880285-4	2025-06-26	Banco Nación	t	14
10	03391431-8	2024-06-23	Banco Francés	f	16
11	00603806-7	2025-11-27	Banco Patagonia	t	19
12	05540866-8	2025-06-18	Banco Nación	t	20
13	04708827-0	2025-03-04	Banco Nación	t	24
14	04565080-5	2024-08-29	Banco Provincia	f	26
15	05565399-5	2025-01-21	Banco Nación	f	27
16	09695083-7	2025-04-10	Banco Ciudad	t	28
17	05651598-8	2024-09-05	Banco Santander	t	29
18	06215192-1	2025-09-06	Banco Francés	t	31
19	07002841-6	2025-01-02	HSBC	t	34
20	07995808-2	2024-05-02	Banco Supervielle	t	35
21	07496837-7	2025-11-19	Banco Nación	t	37
22	00390806-1	2025-04-01	Banco Patagonia	t	39
23	07230694-8	2025-05-15	Banco Itaú	t	40
24	04913971-0	2025-09-08	Banco Francés	t	41
25	09826849-7	2025-07-18	Banco Supervielle	f	42
26	07072393-7	2025-08-08	Banco Comafi	t	44
27	04848066-4	2024-11-23	Banco Galicia	t	46
28	08818321-2	2025-02-09	HSBC	f	47
29	04312699-1	2025-03-27	HSBC	f	48
30	03455089-4	2025-06-10	Banco Santander	t	50
31	03878466-5	2025-05-17	Banco Comafi	t	51
32	05562436-7	2025-11-02	Banco Supervielle	t	52
33	03137965-7	2025-10-14	Banco Nación	t	54
34	00827055-4	2025-11-30	Banco Galicia	t	55
35	04425481-1	2024-08-31	Banco Supervielle	f	57
36	08898324-5	2024-12-16	Banco Provincia	t	58
37	03782763-0	2025-05-22	Banco Santander	t	60
38	08603806-1	2025-01-05	Banco Patagonia	t	62
39	09291385-5	2024-10-13	Banco Itaú	t	64
40	00568125-3	2024-11-11	Banco Macro	t	65
41	04990696-5	2025-12-11	Banco Nación	t	66
42	01884927-3	2025-08-12	Banco Santander	f	68
43	05900082-5	2024-05-22	Banco Provincia	t	69
44	06096922-5	2025-02-05	Banco Supervielle	t	70
45	03430708-2	2025-06-23	Banco Itaú	t	72
46	01715137-8	2025-07-08	Banco Francés	t	74
47	06632508-7	2025-11-16	Banco Francés	t	76
48	06761577-8	2025-11-30	Banco Santander	t	77
49	08672795-0	2025-09-10	Banco Itaú	t	79
50	07532746-7	2025-07-13	Banco Francés	t	82
51	00004942-7	2025-04-14	Banco Francés	t	83
52	09641189-4	2024-05-14	Banco Santander	t	84
53	142	2026-06-09	BERSA	t	86
\.


--
-- TOC entry 3531 (class 0 OID 24576)
-- Dependencies: 224
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task (task_id, creation_date, description, due_date) FROM stdin;
\.


--
-- TOC entry 3518 (class 0 OID 16392)
-- Dependencies: 211
-- Data for Name: terceros; Type: TABLE DATA; Schema: public; Owner: terceros01
--

COPY public.terceros (id_tercero, nombre, cuitl, sitiva, direccion, localidad, provincia, telefonos, saldo_apertura, tipo_saldo) FROM stdin;
10	Patricia Ramírez	27-01234567-8	MONOTRIBUTO	Calle Lavalle 7890	Neuquén	Neuquén	0299-123-4567	3500.00	DEVEDOR
14	Claudia Méndez	27-44556677-8	MONOTRIBUTO	Calle Sarmiento 3456	Corrientes	Corrientes	0379-567-8901	2100.00	DEVEDOR
18	Andrea Paz	27-88990011-2	MONOTRIBUTO	Calle Uruguay 9012	Santiago del Estero	Santiago del Estero	0385-901-2345	1850.00	DEVEDOR
22	Roxana Vega	27-22233344-5	MONOTRIBUTO	Calle Güemes 5678	Jujuy	Jujuy	0388-345-6789	2950.00	DEVEDOR
26	Miriam Luna	27-66677788-9	MONOTRIBUTO	Calle Rivadavia 1234	Comodoro Rivadavia	Chubut	0297-789-0123	4100.00	DEVEDOR
30	Marina Juárez	27-00011122-3	MONOTRIBUTO	Calle Olivos 7890	Olivos	Buenos Aires	011-456-7890	2750.00	DEVEDOR
34	Mónica Giménez	27-44455566-7	MONOTRIBUTO	Calle Las Heras 3456	Palermo	Buenos Aires	011-890-1234	3300.00	DEVEDOR
38	Carolina Pereyra	27-88899900-1	MONOTRIBUTO	Calle Boedo 9012	San Cristóbal	Buenos Aires	011-234-5678	1980.00	DEVEDOR
1	Juan Pérez	20-12345678-9	RESPONSABLE_INSCRIPTO	Av. Rivadavia 1234	Capital Federal	Buenos Aires	011-4123-1234	15000.00	ACREEDOR
3	Carlos Rodríguez	20-34567890-1	RESPONSABLE_INSCRIPTO	Av. Santa Fe 9012	Rosario	Santa Fe	0341-456-7890	25000.50	ACREEDOR
5	Roberto Sánchez	30-56789012-3	RESPONSABLE_INSCRIPTO	Av. Alem 7890	Mendoza	Mendoza	0261-678-9012	32000.75	ACREEDOR
7	Diego López	20-78901234-5	RESPONSABLE_INSCRIPTO	Av. Pueyrredón 5678	Mar del Plata	Buenos Aires	0223-890-1234	18750.00	ACREEDOR
9	Javier Torres	30-90123456-7	RESPONSABLE_INSCRIPTO	Av. 9 de Julio 3456	Tucumán	Tucumán	0381-012-3456	42900.00	ACREEDOR
11	Gabriel Morales	20-11223344-5	RESPONSABLE_INSCRIPTO	Av. Libertador 1234	San Juan	San Juan	0264-234-5678	22500.00	ACREEDOR
13	Ricardo Aguirre	30-33445566-7	RESPONSABLE_INSCRIPTO	Av. Illia 9012	Paraná	Entre Ríos	0343-456-7890	31000.00	ACREEDOR
15	Fernando Herrera	20-55667788-9	RESPONSABLE_INSCRIPTO	Av. Costanera 7890	Posadas	Misiones	0376-678-9012	19800.00	ACREEDOR
17	Martín Silva	30-77889900-1	RESPONSABLE_INSCRIPTO	Av. San Martín 5678	Resistencia	Chaco	0362-890-1234	26750.00	ACREEDOR
19	Hugo Medina	20-99001122-3	RESPONSABLE_INSCRIPTO	Av. Roca 3456	La Rioja	La Rioja	0380-012-3456	15200.00	ACREEDOR
21	Oscar Navarro	30-11122233-4	RESPONSABLE_INSCRIPTO	Av. Perón 1234	Catamarca	Catamarca	0383-234-5678	34100.00	ACREEDOR
23	Luis Páez	20-33344455-6	RESPONSABLE_INSCRIPTO	Av. Belgrano 9012	San Miguel	Tucumán	0381-456-7890	27300.00	ACREEDOR
25	Sergio Godoy	30-55566677-8	RESPONSABLE_INSCRIPTO	Av. España 7890	Bariloche	Río Negro	0294-678-9012	45600.00	ACREEDOR
27	Emilio Fuentes	20-77788899-0	RESPONSABLE_INSCRIPTO	Av. del Trabajo 5678	Río Gallegos	Santa Cruz	0296-890-1234	18900.00	ACREEDOR
29	Adrián Ponce	30-99900011-2	RESPONSABLE_INSCRIPTO	Av. Maipú 3456	Vicente López	Buenos Aires	011-345-6789	52300.00	ACREEDOR
31	Esteban Vera	20-11122233-4	RESPONSABLE_INSCRIPTO	Av. del Libertador 1234	Belgrano	Buenos Aires	011-567-8901	34800.00	ACREEDOR
33	Guillermo Benítez	30-33344455-6	RESPONSABLE_INSCRIPTO	Av. Santa Fe 9012	Recoleta	Buenos Aires	011-789-0123	29500.00	ACREEDOR
35	Raúl Villalba	20-55566677-8	RESPONSABLE_INSCRIPTO	Av. Corrientes 7890	Balvanera	Buenos Aires	011-901-2345	41200.00	ACREEDOR
37	Leonardo Farías	30-77788899-0	RESPONSABLE_INSCRIPTO	Av. La Plata 5678	Boedo	Buenos Aires	011-123-4567	36700.00	ACREEDOR
4	Ana Martínez	27-45678901-2	CONSUMIDOR_FINAL	Calle San Martín 3456	Córdoba	Córdoba	0351-567-8901	5000.00	DEVEDOR
8	Silvia Díaz	27-89012345-6	CONSUMIDOR_FINAL	Calle Moreno 9012	Salta	Salta	0387-901-2345	750.00	DEVEDOR
12	Veronica Castro	27-22334455-6	CONSUMIDOR_FINAL	Calle Mitre 5678	Santa Fe	Santa Fe	0342-345-6789	800.00	DEVEDOR
16	Liliana Ríos	27-66778899-0	CONSUMIDOR_FINAL	Calle Alvear 1234	Formosa	Formosa	0370-789-0123	450.00	DEVEDOR
20	Natalia Blanco	27-00112233-4	CONSUMIDOR_FINAL	Calle Pellegrini 7890	San Luis	San Luis	0266-123-4567	620.00	DEVEDOR
24	Graciela Ortiz	27-44455566-7	CONSUMIDOR_FINAL	Calle Independencia 3456	Godoy Cruz	Mendoza	0261-567-8901	980.00	DEVEDOR
28	Cecilia Domínguez	27-88899900-1	CONSUMIDOR_FINAL	Calle San Lorenzo 9012	Ushuaia	Tierra del Fuego	02901-234-567	350.00	DEVEDOR
32	Florencia Acosta	27-22233344-5	CONSUMIDOR_FINAL	Calle Cabildo 5678	Nuñez	Buenos Aires	011-678-9012	1250.00	DEVEDOR
36	Bárbara Toledo	27-66677788-9	CONSUMIDOR_FINAL	Calle Jujuy 1234	Almagro	Buenos Aires	011-012-3456	890.00	DEVEDOR
2	María Gonzalez	27-23456789-0	MONOTRIBUTO	Calle Corrientes 5678	Capital Federal	Buenos Aires	011-5234-5678	0.00	DEVEDOR
6	Laura Fernandez	27-67890123-4	MONOTRIBUTO	Calle Belgrano 1234	La Plata	Buenos Aires	0221-789-0123	1200.00	DEVEDOR
\.


--
-- TOC entry 3530 (class 0 OID 16587)
-- Dependencies: 223
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: terceros01
--

COPY public.users (id_user, password, username, id, enabled) FROM stdin;
1	$2a$10$ZtU3sedq5iOxlS3yjaN9eespMChmNGouDl4jq8/U0hX4iFNb1Y7SG	admin	1	t
2	$2a$10$xGRhRnn5X9FZOrjIThDq2e0pcA0/KrhFv8VEfBRobTLfaQmqycFlK	admin2	2	t
\.


--
-- TOC entry 3535 (class 0 OID 24592)
-- Dependencies: 228
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: terceros01
--

COPY public.usuarios (id, activo, password, username) FROM stdin;
1	t	$2a$10$ZXHUrQTMoPptALJdD.ZhJe.Hzc8l/eSpENE2RpXKj3gEWx03qiSX.	admin
\.


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 212
-- Name: facturas_id_factura_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.facturas_id_factura_seq', 100, true);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 214
-- Name: facturas_items_id_items_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.facturas_items_id_items_seq', 325, true);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 216
-- Name: facultad_id_facultad_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.facultad_id_facultad_seq', 9, true);


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 220
-- Name: pagos_detalle_id_pagosdetalle_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.pagos_detalle_id_pagosdetalle_seq', 53, true);


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 218
-- Name: pagos_id_pagos_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.pagos_id_pagos_seq', 86, true);


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 225
-- Name: task_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_seq', 1, false);


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 210
-- Name: terceros_id_tercero_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.terceros_id_tercero_seq', 38, true);


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 226
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 222
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.users_id_user_seq', 34, true);


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 227
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: terceros01
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 1, true);


--
-- TOC entry 3357 (class 2606 OID 16489)
-- Name: facturas_items facturas_items_pk; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.facturas_items
    ADD CONSTRAINT facturas_items_pk PRIMARY KEY (id_items);


--
-- TOC entry 3355 (class 2606 OID 16468)
-- Name: facturas facturas_pk; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_pk PRIMARY KEY (id_factura);


--
-- TOC entry 3359 (class 2606 OID 16513)
-- Name: facultad facultad_pk; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.facultad
    ADD CONSTRAINT facultad_pk PRIMARY KEY (id_facultad);


--
-- TOC entry 3363 (class 2606 OID 16549)
-- Name: pagos_detalle pagos_detalle_pk; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.pagos_detalle
    ADD CONSTRAINT pagos_detalle_pk PRIMARY KEY (id_pagosdetalle);


--
-- TOC entry 3361 (class 2606 OID 16528)
-- Name: pagos pagos_pk; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pk PRIMARY KEY (id_pagos);


--
-- TOC entry 3369 (class 2606 OID 24580)
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 3353 (class 2606 OID 16569)
-- Name: terceros terceros_pk; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.terceros
    ADD CONSTRAINT terceros_pk PRIMARY KEY (id_tercero);


--
-- TOC entry 3371 (class 2606 OID 24601)
-- Name: usuarios ukm2dvbwfge291euvmk6vkkocao; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT ukm2dvbwfge291euvmk6vkkocao UNIQUE (username);


--
-- TOC entry 3365 (class 2606 OID 16595)
-- Name: users ukr43af9ap4edm43mmtq01oddj6; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT ukr43af9ap4edm43mmtq01oddj6 UNIQUE (username);


--
-- TOC entry 3367 (class 2606 OID 16593)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- TOC entry 3373 (class 2606 OID 24599)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 3375 (class 2606 OID 16502)
-- Name: facturas_items facturas_items_facturas_fk; Type: FK CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.facturas_items
    ADD CONSTRAINT facturas_items_facturas_fk FOREIGN KEY (id_factura) REFERENCES public.facturas(id_factura) ON DELETE CASCADE;


--
-- TOC entry 3374 (class 2606 OID 16570)
-- Name: facturas facturas_terceros_fk; Type: FK CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_terceros_fk FOREIGN KEY (id_tercero) REFERENCES public.terceros(id_tercero) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3377 (class 2606 OID 16556)
-- Name: pagos_detalle pagos_detalle_pagos_fk; Type: FK CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.pagos_detalle
    ADD CONSTRAINT pagos_detalle_pagos_fk FOREIGN KEY (id_pagos) REFERENCES public.pagos(id_pagos) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3376 (class 2606 OID 16575)
-- Name: pagos pagos_terceros_fk; Type: FK CONSTRAINT; Schema: public; Owner: terceros01
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_terceros_fk FOREIGN KEY (id_tercero) REFERENCES public.terceros(id_tercero) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO terceros01;
GRANT USAGE ON SCHEMA public TO "terceros-app";


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE facturas; Type: ACL; Schema: public; Owner: terceros01
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.facturas TO "terceros-app";


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE facturas_items; Type: ACL; Schema: public; Owner: terceros01
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.facturas_items TO "terceros-app";


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE facultad; Type: ACL; Schema: public; Owner: terceros01
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.facultad TO "terceros-app";


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE pagos; Type: ACL; Schema: public; Owner: terceros01
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.pagos TO "terceros-app";


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE pagos_detalle; Type: ACL; Schema: public; Owner: terceros01
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.pagos_detalle TO "terceros-app";


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE task; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.task TO terceros01;


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 225
-- Name: SEQUENCE task_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.task_seq TO terceros01;


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE terceros; Type: ACL; Schema: public; Owner: terceros01
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.terceros TO "terceros-app";


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE users; Type: ACL; Schema: public; Owner: terceros01
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.users TO "terceros-app";


--
-- TOC entry 2078 (class 826 OID 16390)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO terceros01;


--
-- TOC entry 2077 (class 826 OID 16389)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO terceros01;


-- Completed on 2026-06-24 18:22:03

--
-- PostgreSQL database dump complete
--

