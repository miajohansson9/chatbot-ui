create table "public"."mentor_questions" (
    "id" uuid not null default gen_random_uuid(),
    "question_text" text not null,
    "pillar" text not null,
    "category" text,
    "sub_tags" text[] default '{}'::text[],
    "is_active" boolean default true,
    "created_at" timestamp with time zone default now()
);


create table "public"."mentor_responses" (
    "id" uuid not null default gen_random_uuid(),
    "question" text,
    "answer" text,
    "mentor_first_name" text,
    "mentor_last_name" text,
    "job_title" text,
    "company" text,
    "industry" text,
    "career_stage" text,
    "pillar" text,
    "sub_tags" text[],
    "date_answered" timestamp with time zone default now(),
    "privacy_choices" text,
    "source_type" text default 'Form'::text,
    "form_session_id" uuid,
    "created_at" timestamp with time zone default now()
);


CREATE UNIQUE INDEX mentor_questions_pkey ON public.mentor_questions USING btree (id);

CREATE UNIQUE INDEX mentor_responses_pkey ON public.mentor_responses USING btree (id);

alter table "public"."mentor_questions" add constraint "mentor_questions_pkey" PRIMARY KEY using index "mentor_questions_pkey";

alter table "public"."mentor_responses" add constraint "mentor_responses_pkey" PRIMARY KEY using index "mentor_responses_pkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.delete_storage_object(bucket text, object text, OUT status integer, OUT content text)
 RETURNS record
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  project_url TEXT := 'https://krbbjarmgqkykgrlfedr.supabase.co';
  service_role_key TEXT := ''; -- full access needed for http request to storage
  url TEXT := project_url || '/storage/v1/object/' || bucket || '/' || object;
BEGIN
  SELECT
      INTO status, content
           result.status::INT, result.content::TEXT
      FROM extensions.http((
    'DELETE',
    url,
    ARRAY[extensions.http_header('authorization','Bearer ' || service_role_key)],
    NULL,
    NULL)::extensions.http_request) AS result;
END;
$function$
;

grant delete on table "public"."mentor_questions" to "anon";

grant insert on table "public"."mentor_questions" to "anon";

grant references on table "public"."mentor_questions" to "anon";

grant select on table "public"."mentor_questions" to "anon";

grant trigger on table "public"."mentor_questions" to "anon";

grant truncate on table "public"."mentor_questions" to "anon";

grant update on table "public"."mentor_questions" to "anon";

grant delete on table "public"."mentor_questions" to "authenticated";

grant insert on table "public"."mentor_questions" to "authenticated";

grant references on table "public"."mentor_questions" to "authenticated";

grant select on table "public"."mentor_questions" to "authenticated";

grant trigger on table "public"."mentor_questions" to "authenticated";

grant truncate on table "public"."mentor_questions" to "authenticated";

grant update on table "public"."mentor_questions" to "authenticated";

grant delete on table "public"."mentor_questions" to "service_role";

grant insert on table "public"."mentor_questions" to "service_role";

grant references on table "public"."mentor_questions" to "service_role";

grant select on table "public"."mentor_questions" to "service_role";

grant trigger on table "public"."mentor_questions" to "service_role";

grant truncate on table "public"."mentor_questions" to "service_role";

grant update on table "public"."mentor_questions" to "service_role";

grant delete on table "public"."mentor_responses" to "anon";

grant insert on table "public"."mentor_responses" to "anon";

grant references on table "public"."mentor_responses" to "anon";

grant select on table "public"."mentor_responses" to "anon";

grant trigger on table "public"."mentor_responses" to "anon";

grant truncate on table "public"."mentor_responses" to "anon";

grant update on table "public"."mentor_responses" to "anon";

grant delete on table "public"."mentor_responses" to "authenticated";

grant insert on table "public"."mentor_responses" to "authenticated";

grant references on table "public"."mentor_responses" to "authenticated";

grant select on table "public"."mentor_responses" to "authenticated";

grant trigger on table "public"."mentor_responses" to "authenticated";

grant truncate on table "public"."mentor_responses" to "authenticated";

grant update on table "public"."mentor_responses" to "authenticated";

grant delete on table "public"."mentor_responses" to "service_role";

grant insert on table "public"."mentor_responses" to "service_role";

grant references on table "public"."mentor_responses" to "service_role";

grant select on table "public"."mentor_responses" to "service_role";

grant trigger on table "public"."mentor_responses" to "service_role";

grant truncate on table "public"."mentor_responses" to "service_role";

grant update on table "public"."mentor_responses" to "service_role";


