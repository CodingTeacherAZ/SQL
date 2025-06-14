--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: blackhole; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.blackhole (
    blackhole_id integer NOT NULL,
    name character varying(25) NOT NULL,
    galaxy_id integer NOT NULL,
    mass integer,
    event_horizon_radius numeric,
    is_active boolean
);


ALTER TABLE public.blackhole OWNER TO freecodecamp;

--
-- Name: blackhole_blackhole_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.blackhole_blackhole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blackhole_blackhole_id_seq OWNER TO freecodecamp;

--
-- Name: blackhole_blackhole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.blackhole_blackhole_id_seq OWNED BY public.blackhole.blackhole_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    type character varying(30) NOT NULL,
    size numeric,
    is_active boolean NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_id integer NOT NULL,
    diameter numeric,
    has_water boolean NOT NULL,
    has_atmosphere boolean NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    radius numeric,
    star_id integer NOT NULL,
    planet_type character varying(15),
    has_moons boolean NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_moon (
    planet_moon_id integer NOT NULL,
    name character varying(30),
    planet_id integer NOT NULL,
    moon_id integer NOT NULL,
    moon_name text
);


ALTER TABLE public.planet_moon OWNER TO freecodecamp;

--
-- Name: planet_moon_planet_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_moon_planet_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_moon_planet_moon_id_seq OWNER TO freecodecamp;

--
-- Name: planet_moon_planet_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_moon_planet_moon_id_seq OWNED BY public.planet_moon.planet_moon_id;


--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_id integer NOT NULL,
    luminosity numeric,
    is_visited boolean NOT NULL,
    distance_from_earth integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: blackhole blackhole_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.blackhole ALTER COLUMN blackhole_id SET DEFAULT nextval('public.blackhole_blackhole_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: planet_moon planet_moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_moon ALTER COLUMN planet_moon_id SET DEFAULT nextval('public.planet_moon_planet_moon_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: blackhole; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.blackhole VALUES (1, 'Sagittarius A*', 1, 4000000, 12000000, true);
INSERT INTO public.blackhole VALUES (2, 'Cygnus X-1', 1, 15000000, 45000000000, true);
INSERT INTO public.blackhole VALUES (3, 'GRO J1655-40', 1, 7000000, 21000000000, true);
INSERT INTO public.blackhole VALUES (4, 'LMC X-3', 6, 10000000, 30000000000, true);
INSERT INTO public.blackhole VALUES (5, 'M87*', 2, 1000000000, 3000000000, true);
INSERT INTO public.blackhole VALUES (6, 'M51*', 5, 30000000, 90000000, true);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Barred Spiral', 150000, false);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Spiral', 220000, false);
INSERT INTO public.galaxy VALUES (3, 'Sombrero', 'Spiral', 50000, false);
INSERT INTO public.galaxy VALUES (4, 'Triangulum', 'Spiral', 60000, false);
INSERT INTO public.galaxy VALUES (5, 'Whirlpool', 'Spiral', 76000, true);
INSERT INTO public.galaxy VALUES (6, 'Large Magellanic Cloud', 'Dwarf Irregular', 14000, true);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 1, 3475, true, false);
INSERT INTO public.moon VALUES (2, 'Europa', 8, 3122, true, false);
INSERT INTO public.moon VALUES (3, 'Io', 9, 3643, false, true);
INSERT INTO public.moon VALUES (4, 'Ganymede', 7, 5268, true, true);
INSERT INTO public.moon VALUES (5, 'Callisto', 7, 4822, true, false);
INSERT INTO public.moon VALUES (6, 'Titan', 11, 5152, true, true);
INSERT INTO public.moon VALUES (7, 'Rhea', 5, 1528, true, false);
INSERT INTO public.moon VALUES (8, 'Enceladus', 3, 504, true, false);
INSERT INTO public.moon VALUES (9, 'Mimas', 12, 396, true, false);
INSERT INTO public.moon VALUES (10, 'Triton', 5, 2710, true, true);
INSERT INTO public.moon VALUES (11, 'Charon', 11, 1212, true, false);
INSERT INTO public.moon VALUES (12, 'Phobos', 9, 22, false, false);
INSERT INTO public.moon VALUES (13, 'Deimos', 2, 12, false, false);
INSERT INTO public.moon VALUES (14, 'Miranda', 12, 472, true, false);
INSERT INTO public.moon VALUES (15, 'Ariel', 5, 1159, true, false);
INSERT INTO public.moon VALUES (16, 'Umbriel', 7, 1169, true, false);
INSERT INTO public.moon VALUES (17, 'Titania', 12, 1579, true, false);
INSERT INTO public.moon VALUES (18, 'Oberon', 2, 1523, true, false);
INSERT INTO public.moon VALUES (19, 'Iepetus', 11, 1472, true, false);
INSERT INTO public.moon VALUES (20, 'Ceres', 7, 940, true, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 6378, 1, 'Greenbelt', true);
INSERT INTO public.planet VALUES (2, 'Arrakis', 5000, 3, 'Sand', true);
INSERT INTO public.planet VALUES (3, 'Caladan', 6500, 5, 'Oceanic', true);
INSERT INTO public.planet VALUES (4, 'Giedi Prime', 4500, 6, 'Rocky', false);
INSERT INTO public.planet VALUES (5, 'Lankiveil', 6000, 4, 'Gaseous', true);
INSERT INTO public.planet VALUES (6, 'Salusa Secundus', 5500, 3, 'Rocky', false);
INSERT INTO public.planet VALUES (7, 'Bela Tegeuse', 7200, 2, 'Gaseous', true);
INSERT INTO public.planet VALUES (8, 'Richese', 5200, 3, 'Rocky', true);
INSERT INTO public.planet VALUES (9, 'Ix', 6800, 6, 'Greenbelt', true);
INSERT INTO public.planet VALUES (10, 'Tleilax', 5500, 4, 'Rocky', false);
INSERT INTO public.planet VALUES (11, 'Chusuk', 5900, 5, 'Rocky', true);
INSERT INTO public.planet VALUES (12, 'Corrin', 6000, 3, 'Oceanic', true);
INSERT INTO public.planet VALUES (13, 'Poritrin', 6400, 2, 'Gaseous', false);


--
-- Data for Name: planet_moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_moon VALUES (21, 'Earth', 1, 1, 'Eluna');
INSERT INTO public.planet_moon VALUES (22, 'Arrakis', 2, 14, 'Aphobos');
INSERT INTO public.planet_moon VALUES (23, 'Arrakis', 2, 19, 'Atitania');
INSERT INTO public.planet_moon VALUES (24, 'Caladan', 3, 8, 'Cenceladus');
INSERT INTO public.planet_moon VALUES (25, 'Lankiveil', 5, 7, 'Larhea');
INSERT INTO public.planet_moon VALUES (26, 'Lankiveil', 5, 12, 'Latriton');
INSERT INTO public.planet_moon VALUES (27, 'Lankiveil', 5, 16, 'Lamiranda');
INSERT INTO public.planet_moon VALUES (28, 'Bela Tegeuse', 7, 4, 'Beteganymede');
INSERT INTO public.planet_moon VALUES (29, 'Bela Tegeuse', 7, 5, 'Betecallisto');
INSERT INTO public.planet_moon VALUES (30, 'Bela Tegeuse', 7, 18, 'Betumbriel');
INSERT INTO public.planet_moon VALUES (31, 'Bela Tegeuse', 7, 19, 'Betiepetus');
INSERT INTO public.planet_moon VALUES (32, 'Richese', 8, 2, 'Reuropa');
INSERT INTO public.planet_moon VALUES (33, 'Richese', 9, 3, 'Rio');
INSERT INTO public.planet_moon VALUES (34, 'Richese', 9, 13, 'Richaron');
INSERT INTO public.planet_moon VALUES (35, 'Chusuk', 11, 6, 'Chutitan');
INSERT INTO public.planet_moon VALUES (36, 'Chusuk', 11, 11, 'Chuceres');
INSERT INTO public.planet_moon VALUES (37, 'Chusuk', 11, 20, 'Choberon');
INSERT INTO public.planet_moon VALUES (38, 'Corrin', 12, 9, 'Comimas');
INSERT INTO public.planet_moon VALUES (39, 'Corrin', 12, 15, 'Codeimos');
INSERT INTO public.planet_moon VALUES (40, 'Corrin', 12, 17, 'Cariel');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 1.0, true, 0);
INSERT INTO public.star VALUES (2, 'Alpha Centauri', 1, 1.519, false, 4);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 1, 120000, false, 643);
INSERT INTO public.star VALUES (4, 'Cygnus Nova', 2, 2500, false, 2500000);
INSERT INTO public.star VALUES (5, 'Andromeda Prime', 3, 5000, false, 2550000);
INSERT INTO public.star VALUES (6, 'Triangulum Alpha', 3, 8000, true, 3000000);


--
-- Name: blackhole_blackhole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.blackhole_blackhole_id_seq', 6, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_moon_planet_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_moon_planet_moon_id_seq', 40, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 13, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: blackhole blackhole_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.blackhole
    ADD CONSTRAINT blackhole_name_key UNIQUE (name);


--
-- Name: blackhole blackhole_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.blackhole
    ADD CONSTRAINT blackhole_pkey PRIMARY KEY (blackhole_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet_moon planet_moon_moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_moon
    ADD CONSTRAINT planet_moon_moon_name_key UNIQUE (moon_name);


--
-- Name: planet_moon planet_moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_moon
    ADD CONSTRAINT planet_moon_pkey PRIMARY KEY (planet_moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet_moon planet_moon_moon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_moon
    ADD CONSTRAINT planet_moon_moon_id_fkey FOREIGN KEY (moon_id) REFERENCES public.moon(moon_id);


--
-- Name: planet_moon planet_moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_moon
    ADD CONSTRAINT planet_moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

