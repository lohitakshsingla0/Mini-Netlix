--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5 (Debian 13.5-1.pgdg100+1)
-- Dumped by pg_dump version 13.5

-- Started on 2022-02-10 17:56:05

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

--
-- TOC entry 3065 (class 1262 OID 388731)
-- Name: lohitaksh; Type: DATABASE; Schema: -; Owner: dbservice
--

CREATE DATABASE lohitaksh WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'de_DE.UTF-8';


ALTER DATABASE lohitaksh OWNER TO dbservice;

\connect lohitaksh

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

--
-- TOC entry 4 (class 2615 OID 412040)
-- Name: film; Type: SCHEMA; Schema: -; Owner: lohitaksh_rw
--

CREATE SCHEMA film;


ALTER SCHEMA film OWNER TO lohitaksh_rw;

--
-- TOC entry 233 (class 1255 OID 446055)
-- Name: add_genres_to_movies(integer, integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.add_genres_to_movies(movie_id integer, genre_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
status varchar;
begin
status='False';
INSERT INTO "film"."genre_movies"("movie_id","genre_id") VALUES (movie_id, genre_id);
status= 'True';
return status;
EXCEPTION WHEN OTHERS THEN
status='False';
return status;

end;

$$;


ALTER FUNCTION public.add_genres_to_movies(movie_id integer, genre_id integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 232 (class 1255 OID 446051)
-- Name: add_movie(integer, character varying, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.add_movie(pid integer, title character varying, release_year integer, min_age integer, prod_country character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$DECLARE
m_id integer;
begin

INSERT INTO "film"."movie"("parent_id","title","release_year","min_age","prod_country") VALUES(pid, title, release_year, min_age, prod_country) RETURNING id INTO m_id;
return m_id;
end;

$$;


ALTER FUNCTION public.add_movie(pid integer, title character varying, release_year integer, min_age integer, prod_country character varying) OWNER TO lohitaksh_rw;

--
-- TOC entry 234 (class 1255 OID 446060)
-- Name: add_movie_person(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.add_movie_person(movie_id integer, role_id integer, person_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$declare
status varchar;
begin
status='False';
INSERT INTO "film"."movie_person"("movie_id","role_id","person_id") VALUES(movie_id,role_id,person_id);
status= 'True';
return status;
EXCEPTION WHEN OTHERS THEN
status='False';
return status;

end;

$$;


ALTER FUNCTION public.add_movie_person(movie_id integer, role_id integer, person_id integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 238 (class 1255 OID 447609)
-- Name: add_movie_rating(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.add_movie_rating(movie_id_number integer, user_id_number integer, rate_v integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE
m_id integer;
begin

INSERT INTO "film"."rating"("movie_id", "user_id", "rate") VALUES (movie_id_number , user_id_number , rate_v);

return m_id ;

end;

$$;


ALTER FUNCTION public.add_movie_rating(movie_id_number integer, user_id_number integer, rate_v integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 235 (class 1255 OID 446066)
-- Name: add_person(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.add_person(person_name character varying, dob character varying, sex character varying, cv character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
status varchar;
begin
status='False';
INSERT INTO "film"."person"("person_name", "dob", "sex","cv") VALUES(person_name, dob, sex, cv);
status= 'True';
return status;
EXCEPTION WHEN OTHERS THEN
status='False';
return status;

end;

$$;


ALTER FUNCTION public.add_person(person_name character varying, dob character varying, sex character varying, cv character varying) OWNER TO lohitaksh_rw;

--
-- TOC entry 219 (class 1255 OID 441618)
-- Name: add_user(integer, character varying); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.add_user(id integer, fn character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$declare
status varchar;
begin
status='False';
INSERT INTO "film"."users" ("id","name")
VALUES(id,fn);
status= 'True';
return status;
EXCEPTION WHEN OTHERS THEN
status='False';
return status ;

end;
$$;


ALTER FUNCTION public.add_user(id integer, fn character varying) OWNER TO lohitaksh_rw;

--
-- TOC entry 236 (class 1255 OID 446073)
-- Name: delete_person(integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.delete_person(delete_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$declare
status varchar;
begin
status='False';


DELETE FROM "film"."movie" WHERE id in (select "film"."movie"."id" from
"film"."movie"
join "film"."movie_person" on "movie"."id" = "movie_person"."movie_id"
join "film"."person" on movie_person.person_id = person.id
where "person"."id" = delete_id);


delete from "film"."person" where person.id = delete_id;

status= 'True';
return status;
EXCEPTION WHEN OTHERS THEN
status='False';
return status;

end;

$$;


ALTER FUNCTION public.delete_person(delete_id integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 231 (class 1255 OID 446033)
-- Name: delete_rating(integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.delete_rating(idn integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
status varchar;
begin
status='False';
DELETE FROM "film"."rating" WHERE "rating"."id" = idn;
status= 'True';
return status;
EXCEPTION WHEN OTHERS THEN
status='False';
return status;

end;

$$;


ALTER FUNCTION public.delete_rating(idn integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 239 (class 1255 OID 454964)
-- Name: get_all_films_rating_sort(); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.get_all_films_rating_sort() RETURNS TABLE(id integer, title character varying, release_year integer, min_age integer, prod_country character varying, avg_rating numeric)
    LANGUAGE plpgsql
    AS $$

BEGIN

return query
select 
m.id, m.title, m.release_year, m.min_age, m.prod_country, round(ab.avvg,2)
from "film"."movie" m JOIN
(SELECT r.movie_id mvie, avg(r.rate) as avvg
FROM  "film"."rating" r 
group by r.movie_id) ab on ab.mvie = m.id where m.parent_id is null
order by ab.avvg desc;


END

$$;


ALTER FUNCTION public.get_all_films_rating_sort() OWNER TO lohitaksh_rw;

--
-- TOC entry 240 (class 1255 OID 455958)
-- Name: get_all_rating_for_single_movie(integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.get_all_rating_for_single_movie(movie_id_number integer) RETURNS TABLE(id integer, name character varying, title character varying, rate integer)
    LANGUAGE plpgsql
    AS $$


begin
return query SELECT 
"film"."rating"."id",
"film"."users"."name",
 "film"."movie"."title",
 "film"."rating"."rate"
from
"film"."users"  
JOIN 
"film"."rating" ON users.id=rating.user_id
JOIN 
"film"."movie" 
ON movie.id=rating.movie_id
 where 
movie.id= movie_id_number;


END

$$;


ALTER FUNCTION public.get_all_rating_for_single_movie(movie_id_number integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 243 (class 1255 OID 492567)
-- Name: get_all_users(); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.get_all_users() RETURNS TABLE(id integer, name character varying)
    LANGUAGE plpgsql
    AS $$

BEGIN

return query

select 
"film"."users"."id",
"film"."users"."name"
from 
"film"."users";
                  
END

$$;


ALTER FUNCTION public.get_all_users() OWNER TO lohitaksh_rw;

--
-- TOC entry 241 (class 1255 OID 457113)
-- Name: get_movie_related_person(integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.get_movie_related_person(movie_id_number integer) RETURNS TABLE(id integer, person_name character varying, dob character varying, sex character varying, cv character varying, role_name character varying)
    LANGUAGE plpgsql
    AS $$

begin

return query select   
"film"."person"."id",
"film"."person"."person_name",
 "film"."person"."dob",
 "film"."person"."sex",
 "film"."person"."cv",
 "film"."role"."role_name"
 from "film"."person"
JOIN 
"film"."movie_person" 
ON person.id=movie_person.person_id 
JOIN "film"."role" 
ON role.id=movie_person.role_id where movie_person.movie_id= movie_id_number;

end;

$$;


ALTER FUNCTION public.get_movie_related_person(movie_id_number integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 242 (class 1255 OID 457126)
-- Name: get_subordinate_movies(integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.get_subordinate_movies(movie_id integer) RETURNS TABLE(id integer, title character varying, release_year integer, min_age integer, prod_country character varying)
    LANGUAGE plpgsql
    AS $$

BEGIN
   RETURN QUERY
   SELECT "film"."movie"."id", "film"."movie"."title", "film"."movie"."release_year", "film"."movie"."min_age", "film"."movie"."prod_country"
   from "film"."movie"
   where "film"."movie"."id" = movie_id OR "film"."movie"."parent_id" = movie_id;                   
END

$$;


ALTER FUNCTION public.get_subordinate_movies(movie_id integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 244 (class 1255 OID 494108)
-- Name: suggestion_movies(integer); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.suggestion_movies(user_id_number integer) RETURNS TABLE(title character varying, release_year integer, min_age integer, prod_country character varying)
    LANGUAGE plpgsql
    AS $$
 
BEGIN
   RETURN QUERY
   SELECT DISTINCT m.title,
                m.release_year,
                m.min_age,
                m.prod_country
FROM   "film"."movie" m
       JOIN "film"."rating" r
         ON m.id = r.movie_id
       JOIN "film"."genre_movies" gm
         ON m.id = gm.movie_id
WHERE  m.id NOT IN (SELECT movie_id
                    FROM   "film"."rating"
                    WHERE  user_id = user_id_number)
       AND gm.genre_id IN (SELECT DISTINCT genre_id
                           FROM   "film"."genre_movies"
                                  JOIN "film"."rating"
                                    ON "film"."genre_movies".movie_id =
                                       "film"."rating".movie_id
                           WHERE  "film"."rating".user_id = user_id_number);                   
END
$$;


ALTER FUNCTION public.suggestion_movies(user_id_number integer) OWNER TO lohitaksh_rw;

--
-- TOC entry 237 (class 1255 OID 447595)
-- Name: update_person_details(integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: lohitaksh_rw
--

CREATE FUNCTION public.update_person_details(person_id_number integer, dob_v character varying, sex_v character varying, cv_v character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$

declare
status varchar;
begin
status='False';

update "film"."person" set dob=dob_v, sex=sex_v, cv=cv_v where id=person_id_number ;

status= 'True';
return status;
EXCEPTION WHEN OTHERS THEN
status='False';
return status;

end;

$$;


ALTER FUNCTION public.update_person_details(person_id_number integer, dob_v character varying, sex_v character varying, cv_v character varying) OWNER TO lohitaksh_rw;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 206 (class 1259 OID 412803)
-- Name: genre_movies; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.genre_movies (
    id integer NOT NULL,
    movie_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE film.genre_movies OWNER TO lohitaksh_rw;

--
-- TOC entry 205 (class 1259 OID 412801)
-- Name: genre_movies_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.genre_movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.genre_movies_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 205
-- Name: genre_movies_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.genre_movies_id_seq OWNED BY film.genre_movies.id;


--
-- TOC entry 204 (class 1259 OID 412792)
-- Name: genres; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.genres (
    id integer NOT NULL,
    genre_name text NOT NULL
);


ALTER TABLE film.genres OWNER TO lohitaksh_rw;

--
-- TOC entry 203 (class 1259 OID 412790)
-- Name: genres_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.genres_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 203
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.genres_id_seq OWNED BY film.genres.id;


--
-- TOC entry 202 (class 1259 OID 412780)
-- Name: movie; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.movie (
    id integer NOT NULL,
    title character varying NOT NULL,
    release_year integer NOT NULL,
    parent_id integer,
    min_age integer NOT NULL,
    prod_country character varying NOT NULL
);


ALTER TABLE film.movie OWNER TO lohitaksh_rw;

--
-- TOC entry 201 (class 1259 OID 412778)
-- Name: movie_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.movie_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 201
-- Name: movie_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.movie_id_seq OWNED BY film.movie.id;


--
-- TOC entry 212 (class 1259 OID 412837)
-- Name: movie_person; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.movie_person (
    id integer NOT NULL,
    movie_id integer NOT NULL,
    person_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE film.movie_person OWNER TO lohitaksh_rw;

--
-- TOC entry 211 (class 1259 OID 412835)
-- Name: movie_person_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.movie_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.movie_person_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 211
-- Name: movie_person_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.movie_person_id_seq OWNED BY film.movie_person.id;


--
-- TOC entry 208 (class 1259 OID 412812)
-- Name: person; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.person (
    id integer NOT NULL,
    person_name character varying NOT NULL,
    dob character varying,
    sex character varying,
    cv character varying
);


ALTER TABLE film.person OWNER TO lohitaksh_rw;

--
-- TOC entry 207 (class 1259 OID 412810)
-- Name: person_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.person_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 207
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.person_id_seq OWNED BY film.person.id;


--
-- TOC entry 214 (class 1259 OID 412845)
-- Name: rating; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.rating (
    id integer NOT NULL,
    movie_id integer NOT NULL,
    user_id integer NOT NULL,
    rate integer NOT NULL
);


ALTER TABLE film.rating OWNER TO lohitaksh_rw;

--
-- TOC entry 213 (class 1259 OID 412843)
-- Name: rating_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.rating_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 213
-- Name: rating_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.rating_id_seq OWNED BY film.rating.id;


--
-- TOC entry 210 (class 1259 OID 412825)
-- Name: role; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.role (
    id integer NOT NULL,
    role_name character varying NOT NULL
);


ALTER TABLE film.role OWNER TO lohitaksh_rw;

--
-- TOC entry 209 (class 1259 OID 412823)
-- Name: role_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.role_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 209
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.role_id_seq OWNED BY film.role.id;


--
-- TOC entry 216 (class 1259 OID 412854)
-- Name: users; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.users (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE film.users OWNER TO lohitaksh_rw;

--
-- TOC entry 215 (class 1259 OID 412852)
-- Name: users_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.users_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.users_id_seq OWNED BY film.users.id;


--
-- TOC entry 218 (class 1259 OID 454524)
-- Name: watched_movies; Type: TABLE; Schema: film; Owner: lohitaksh_rw
--

CREATE TABLE film.watched_movies (
    id integer NOT NULL,
    movie_id integer,
    user_id integer
);


ALTER TABLE film.watched_movies OWNER TO lohitaksh_rw;

--
-- TOC entry 217 (class 1259 OID 454522)
-- Name: watched_movies_id_seq; Type: SEQUENCE; Schema: film; Owner: lohitaksh_rw
--

CREATE SEQUENCE film.watched_movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE film.watched_movies_id_seq OWNER TO lohitaksh_rw;

--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 217
-- Name: watched_movies_id_seq; Type: SEQUENCE OWNED BY; Schema: film; Owner: lohitaksh_rw
--

ALTER SEQUENCE film.watched_movies_id_seq OWNED BY film.watched_movies.id;


--
-- TOC entry 2876 (class 2604 OID 412806)
-- Name: genre_movies id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.genre_movies ALTER COLUMN id SET DEFAULT nextval('film.genre_movies_id_seq'::regclass);


--
-- TOC entry 2875 (class 2604 OID 412795)
-- Name: genres id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.genres ALTER COLUMN id SET DEFAULT nextval('film.genres_id_seq'::regclass);


--
-- TOC entry 2874 (class 2604 OID 412783)
-- Name: movie id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.movie ALTER COLUMN id SET DEFAULT nextval('film.movie_id_seq'::regclass);


--
-- TOC entry 2879 (class 2604 OID 412840)
-- Name: movie_person id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.movie_person ALTER COLUMN id SET DEFAULT nextval('film.movie_person_id_seq'::regclass);


--
-- TOC entry 2877 (class 2604 OID 412815)
-- Name: person id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.person ALTER COLUMN id SET DEFAULT nextval('film.person_id_seq'::regclass);


--
-- TOC entry 2880 (class 2604 OID 412848)
-- Name: rating id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.rating ALTER COLUMN id SET DEFAULT nextval('film.rating_id_seq'::regclass);


--
-- TOC entry 2878 (class 2604 OID 412828)
-- Name: role id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.role ALTER COLUMN id SET DEFAULT nextval('film.role_id_seq'::regclass);


--
-- TOC entry 2881 (class 2604 OID 412857)
-- Name: users id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.users ALTER COLUMN id SET DEFAULT nextval('film.users_id_seq'::regclass);


--
-- TOC entry 2882 (class 2604 OID 454527)
-- Name: watched_movies id; Type: DEFAULT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.watched_movies ALTER COLUMN id SET DEFAULT nextval('film.watched_movies_id_seq'::regclass);


--
-- TOC entry 3047 (class 0 OID 412803)
-- Dependencies: 206
-- Data for Name: genre_movies; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (1, 4, 1);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (2, 4, 6);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (3, 4, 7);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (4, 4, 3);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (5, 5, 8);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (6, 5, 5);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (7, 6, 6);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (8, 6, 9);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (9, 6, 2);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (10, 6, 8);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (12, 7, 8);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (13, 8, 2);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (14, 8, 9);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (16, 8, 8);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (11, 7, 6);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (17, 9, 2);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (18, 10, 1);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (19, 10, 7);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (20, 11, 2);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (21, 11, 8);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (22, 12, 1);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (23, 12, 2);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (24, 12, 3);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (25, 13, 4);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (26, 13, 5);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (27, 13, 6);
INSERT INTO film.genre_movies (id, movie_id, genre_id) VALUES (28, 13, 7);


--
-- TOC entry 3045 (class 0 OID 412792)
-- Dependencies: 204
-- Data for Name: genres; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.genres (id, genre_name) VALUES (1, 'Action');
INSERT INTO film.genres (id, genre_name) VALUES (2, 'Comedy');
INSERT INTO film.genres (id, genre_name) VALUES (3, 'Drama');
INSERT INTO film.genres (id, genre_name) VALUES (4, 'Horror');
INSERT INTO film.genres (id, genre_name) VALUES (5, 'Mystery');
INSERT INTO film.genres (id, genre_name) VALUES (6, 'Romance');
INSERT INTO film.genres (id, genre_name) VALUES (7, 'Thriller');
INSERT INTO film.genres (id, genre_name) VALUES (8, 'Adventure');
INSERT INTO film.genres (id, genre_name) VALUES (9, 'Science Fiction');


--
-- TOC entry 3043 (class 0 OID 412780)
-- Dependencies: 202
-- Data for Name: movie; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (4, 'Harry Potter', 2000, NULL, 10, 'US');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (5, 'Harry Potter 2', 2002, 4, 10, 'US');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (6, 'Back to the Future', 1980, NULL, 12, 'USA');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (7, 'Harry Potter 3', 2005, 4, 10, 'USA');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (8, 'Back to the future 2', 1990, 6, 12, 'Germany');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (9, 'Zero', 2017, NULL, 18, 'India');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (10, 'Jai Bheem', 2021, NULL, 18, 'India');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (11, 'Hangover', 2004, NULL, 18, 'USA');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (12, 'Hangover 2', 2006, 11, 18, 'USA');
INSERT INTO film.movie (id, title, release_year, parent_id, min_age, prod_country) VALUES (13, 'Hangover 3', 2010, 11, 18, 'America');


--
-- TOC entry 3053 (class 0 OID 412837)
-- Dependencies: 212
-- Data for Name: movie_person; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (17, 4, 1, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (19, 5, 1, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (20, 7, 1, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (21, 4, 2, 4);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (22, 4, 2, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (23, 5, 2, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (24, 5, 3, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (25, 7, 3, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (26, 6, 5, 3);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (27, 8, 5, 3);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (28, 9, 5, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (29, 10, 10, 3);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (30, 10, 10, 7);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (31, 10, 10, 6);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (32, 13, 8, 5);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (33, 12, 8, 8);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (34, 11, 8, 4);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (35, 9, 6, 7);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (36, 11, 6, 7);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (37, 13, 6, 4);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (38, 4, 4, 7);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (39, 12, 7, 7);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (40, 7, 9, 6);
INSERT INTO film.movie_person (id, movie_id, person_id, role_id) VALUES (41, 10, 8, 8);


--
-- TOC entry 3049 (class 0 OID 412812)
-- Dependencies: 208
-- Data for Name: person; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (1, 'Daniel Jacob Radcliffe', '12 jan 1999', 'Male', 'ajsdfnjna');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (2, 'Hermione Jean Granger', '19 Sept 1989', 'Female', 'jdfnn');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (3, 'Lord Voldemort', '12 33 1111', 'male', 'gfdsg');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (4, 'Ronald Bilius "Ron" Weasley', '1 March 1980', 'male', 'jsdnjfn');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (5, 'Michael J. Fox', '4 44 4444', 'maale', 'dfg');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (6, 'Dr. Emmett "Doc" Brown', '22 10 1938', 'male', 'sfdgdf');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (7, 'Lea Thompson', '31 May 1961', 'female', 'sdf');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (8, 'Thomas F. Wilson', '15 April 1959', 'male', 'dfsg');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (9, 'Bonnie Wright', '7 February 1991', 'female', 'sdf');
INSERT INTO film.person (id, person_name, dob, sex, cv) VALUES (10, 'James Phelps', '25 February 1986', 'male', 'asdfreqw');


--
-- TOC entry 3055 (class 0 OID 412845)
-- Dependencies: 214
-- Data for Name: rating; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (1, 4, 1, 5);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (2, 5, 1, 3);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (3, 6, 1, 5);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (4, 7, 1, 4);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (5, 8, 1, 3);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (6, 9, 2, 3);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (7, 10, 2, 5);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (8, 11, 2, 4);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (9, 12, 2, 5);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (10, 13, 2, 4);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (11, 9, 4, 2);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (12, 10, 4, 5);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (13, 11, 4, 1);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (14, 5, 4, 3);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (15, 9, 4, 1);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (16, 12, 5, 3);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (17, 13, 5, 3);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (18, 4, 5, 5);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (19, 5, 5, 5);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (20, 6, 5, 3);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (21, 7, 5, 3);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (22, 8, 5, 4);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (23, 9, 5, 1);
INSERT INTO film.rating (id, movie_id, user_id, rate) VALUES (24, 10, 5, 5);


--
-- TOC entry 3051 (class 0 OID 412825)
-- Dependencies: 210
-- Data for Name: role; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.role (id, role_name) VALUES (3, 'Director');
INSERT INTO film.role (id, role_name) VALUES (4, 'Producer');
INSERT INTO film.role (id, role_name) VALUES (5, 'Actor');
INSERT INTO film.role (id, role_name) VALUES (6, 'Writer');
INSERT INTO film.role (id, role_name) VALUES (7, 'Costume Designer');
INSERT INTO film.role (id, role_name) VALUES (8, 'Music Director');


--
-- TOC entry 3057 (class 0 OID 412854)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.users (id, name) VALUES (1, 'Lohit');
INSERT INTO film.users (id, name) VALUES (2, 'Sarthak');
INSERT INTO film.users (id, name) VALUES (3, 'AD');
INSERT INTO film.users (id, name) VALUES (4, 'Bedi');
INSERT INTO film.users (id, name) VALUES (5, 'Max');


--
-- TOC entry 3059 (class 0 OID 454524)
-- Dependencies: 218
-- Data for Name: watched_movies; Type: TABLE DATA; Schema: film; Owner: lohitaksh_rw
--

INSERT INTO film.watched_movies (id, movie_id, user_id) VALUES (1, 9, 2);


--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 205
-- Name: genre_movies_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.genre_movies_id_seq', 31, true);


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 203
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.genres_id_seq', 9, true);


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 201
-- Name: movie_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.movie_id_seq', 23, true);


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 211
-- Name: movie_person_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.movie_person_id_seq', 46, true);


--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 207
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.person_id_seq', 17, true);


--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 213
-- Name: rating_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.rating_id_seq', 33, true);


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 209
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.role_id_seq', 8, true);


--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.users_id_seq', 11, true);


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 217
-- Name: watched_movies_id_seq; Type: SEQUENCE SET; Schema: film; Owner: lohitaksh_rw
--

SELECT pg_catalog.setval('film.watched_movies_id_seq', 1, true);


--
-- TOC entry 2889 (class 2606 OID 412808)
-- Name: genre_movies genre_movies_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.genre_movies
    ADD CONSTRAINT genre_movies_pkey PRIMARY KEY (id);


--
-- TOC entry 2887 (class 2606 OID 412800)
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- TOC entry 2895 (class 2606 OID 412842)
-- Name: movie_person movie_person_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.movie_person
    ADD CONSTRAINT movie_person_pkey PRIMARY KEY (id);


--
-- TOC entry 2884 (class 2606 OID 412788)
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- TOC entry 2891 (class 2606 OID 412820)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 2897 (class 2606 OID 412850)
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (id);


--
-- TOC entry 2893 (class 2606 OID 412833)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 2899 (class 2606 OID 412862)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2901 (class 2606 OID 454529)
-- Name: watched_movies watched_movies_pkey; Type: CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.watched_movies
    ADD CONSTRAINT watched_movies_pkey PRIMARY KEY (id);


--
-- TOC entry 2885 (class 1259 OID 454958)
-- Name: title_rel_yr_unique; Type: INDEX; Schema: film; Owner: lohitaksh_rw
--

CREATE UNIQUE INDEX title_rel_yr_unique ON film.movie USING btree (title, release_year);


--
-- TOC entry 2903 (class 2606 OID 412875)
-- Name: genre_movies genre_movies_genre_id_fkey1; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.genre_movies
    ADD CONSTRAINT genre_movies_genre_id_fkey1 FOREIGN KEY (genre_id) REFERENCES film.genres(id) ON DELETE CASCADE;


--
-- TOC entry 2904 (class 2606 OID 412880)
-- Name: genre_movies genre_movies_movie_id_fkey1; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.genre_movies
    ADD CONSTRAINT genre_movies_movie_id_fkey1 FOREIGN KEY (movie_id) REFERENCES film.movie(id) ON DELETE CASCADE;


--
-- TOC entry 2902 (class 2606 OID 412914)
-- Name: movie movie_parent_id_fkey; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.movie
    ADD CONSTRAINT movie_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES film.movie(id) ON DELETE CASCADE;


--
-- TOC entry 2905 (class 2606 OID 412885)
-- Name: movie_person movie_person_movie_id_fkey; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.movie_person
    ADD CONSTRAINT movie_person_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES film.movie(id) ON DELETE CASCADE;


--
-- TOC entry 2906 (class 2606 OID 412893)
-- Name: movie_person movie_person_person_id_fkey; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.movie_person
    ADD CONSTRAINT movie_person_person_id_fkey FOREIGN KEY (person_id) REFERENCES film.person(id) ON DELETE CASCADE;


--
-- TOC entry 2907 (class 2606 OID 412899)
-- Name: movie_person movie_person_role_id_fkey; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.movie_person
    ADD CONSTRAINT movie_person_role_id_fkey FOREIGN KEY (role_id) REFERENCES film.role(id) ON DELETE CASCADE;


--
-- TOC entry 2908 (class 2606 OID 412904)
-- Name: rating rating_movie_id_fkey; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.rating
    ADD CONSTRAINT rating_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES film.movie(id) ON DELETE CASCADE;


--
-- TOC entry 2909 (class 2606 OID 412909)
-- Name: rating rating_user_id_fkey; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.rating
    ADD CONSTRAINT rating_user_id_fkey FOREIGN KEY (user_id) REFERENCES film.users(id) ON DELETE CASCADE;


--
-- TOC entry 2911 (class 2606 OID 457135)
-- Name: watched_movies watched_movies_movie_id_fkey; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.watched_movies
    ADD CONSTRAINT watched_movies_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES film.movie(id) ON DELETE CASCADE;


--
-- TOC entry 2910 (class 2606 OID 457130)
-- Name: watched_movies watched_movies_user_id_fkey; Type: FK CONSTRAINT; Schema: film; Owner: lohitaksh_rw
--

ALTER TABLE ONLY film.watched_movies
    ADD CONSTRAINT watched_movies_user_id_fkey FOREIGN KEY (user_id) REFERENCES film.users(id) ON DELETE CASCADE;


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 3065
-- Name: DATABASE lohitaksh; Type: ACL; Schema: -; Owner: dbservice
--

REVOKE CONNECT,TEMPORARY ON DATABASE lohitaksh FROM PUBLIC;
GRANT TEMPORARY ON DATABASE lohitaksh TO PUBLIC;
GRANT ALL ON DATABASE lohitaksh TO lohitaksh_rw;


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA film; Type: ACL; Schema: -; Owner: lohitaksh_rw
--

GRANT ALL ON SCHEMA film TO PUBLIC;
GRANT ALL ON SCHEMA film TO pg_execute_server_program;
GRANT ALL ON SCHEMA film TO pg_monitor;
GRANT ALL ON SCHEMA film TO pg_read_all_settings;
GRANT ALL ON SCHEMA film TO pg_read_all_stats;
GRANT ALL ON SCHEMA film TO pg_read_server_files;
GRANT ALL ON SCHEMA film TO pg_signal_backend;
GRANT ALL ON SCHEMA film TO pg_stat_scan_tables;
GRANT ALL ON SCHEMA film TO pg_write_server_files;


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO lohitaksh_rw;


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 697
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO lohitaksh_rw;


-- Completed on 2022-02-10 17:56:06

--
-- PostgreSQL database dump complete
--

