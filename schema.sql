-- Questionnaire planification (bords de route)
-- À coller dans Supabase > SQL Editor > Run.
-- Une ligne = une réponse, comme une feuille Google Sheets.

create table if not exists public.planification (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  q01_fonction text not null,
  q01_fonction_autre text,
  q02_structure text not null,
  q02_structure_autre text,
  q03_lineaire text not null,
  q04_equipe text not null,
  q05_anciennete text not null,
  q06_supports_preparation text[] not null,
  q06_supports_preparation_autre text,
  q07_supports_preparation_precisions text,
  q08_frequence text not null,
  q08_frequence_autre text,
  q09_validation text not null,
  q09_validation_autre text,
  q10_supports_suivi text[] not null,
  q10_supports_suivi_autre text,
  q11_supports_suivi_precisions text,
  q12_elements_compliques text[] not null,
  q12_elements_compliques_autre text,
  q13_outil_anciennete text not null,
  q14_outil_nom text,
  q15_fonctions_utilisees text[],
  q15_fonctions_utilisees_autre text,
  q16_satisfaction text,
  q17_smartphone text not null,
  q18_forme_plan text[] not null,
  q18_forme_plan_autre text,
  q19_elements_cles text[] not null,
  q19_elements_cles_autre text,
  q20_difficultes_outil text[] not null,
  q20_difficultes_outil_autre text,
  q21_types_outils text[] not null,
  q21_types_outils_autre text,
  q22_fonctionnalites text[] not null,
  q22_fonctionnalites_autre text,
  q23_infos_resume text[] not null,
  q23_infos_resume_autre text,
  q24_scenario_chantier text,
  q25_amelioration text,
  q26_entretien text not null,
  q26_email_contact text,
  constraint q22_fonctionnalites_max check (cardinality(q22_fonctionnalites) <= 3),
  constraint q01_fonction_autre_len check (q01_fonction_autre is null or char_length(q01_fonction_autre) <= 3000),
  constraint q02_structure_autre_len check (q02_structure_autre is null or char_length(q02_structure_autre) <= 3000),
  constraint q06_supports_preparation_autre_len check (q06_supports_preparation_autre is null or char_length(q06_supports_preparation_autre) <= 3000),
  constraint q07_supports_preparation_precisions_len check (q07_supports_preparation_precisions is null or char_length(q07_supports_preparation_precisions) <= 3000),
  constraint q08_frequence_autre_len check (q08_frequence_autre is null or char_length(q08_frequence_autre) <= 3000),
  constraint q09_validation_autre_len check (q09_validation_autre is null or char_length(q09_validation_autre) <= 3000),
  constraint q10_supports_suivi_autre_len check (q10_supports_suivi_autre is null or char_length(q10_supports_suivi_autre) <= 3000),
  constraint q11_supports_suivi_precisions_len check (q11_supports_suivi_precisions is null or char_length(q11_supports_suivi_precisions) <= 3000),
  constraint q12_elements_compliques_autre_len check (q12_elements_compliques_autre is null or char_length(q12_elements_compliques_autre) <= 3000),
  constraint q14_outil_nom_len check (q14_outil_nom is null or char_length(q14_outil_nom) <= 3000),
  constraint q15_fonctions_utilisees_autre_len check (q15_fonctions_utilisees_autre is null or char_length(q15_fonctions_utilisees_autre) <= 3000),
  constraint q18_forme_plan_autre_len check (q18_forme_plan_autre is null or char_length(q18_forme_plan_autre) <= 3000),
  constraint q19_elements_cles_autre_len check (q19_elements_cles_autre is null or char_length(q19_elements_cles_autre) <= 3000),
  constraint q20_difficultes_outil_autre_len check (q20_difficultes_outil_autre is null or char_length(q20_difficultes_outil_autre) <= 3000),
  constraint q21_types_outils_autre_len check (q21_types_outils_autre is null or char_length(q21_types_outils_autre) <= 3000),
  constraint q22_fonctionnalites_autre_len check (q22_fonctionnalites_autre is null or char_length(q22_fonctionnalites_autre) <= 3000),
  constraint q23_infos_resume_autre_len check (q23_infos_resume_autre is null or char_length(q23_infos_resume_autre) <= 3000),
  constraint q24_scenario_chantier_len check (q24_scenario_chantier is null or char_length(q24_scenario_chantier) <= 3000),
  constraint q25_amelioration_len check (q25_amelioration is null or char_length(q25_amelioration) <= 3000),
  constraint q26_email_contact_len check (q26_email_contact is null or char_length(q26_email_contact) <= 3000)
);

-- Sécurité : tout le monde peut ENVOYER une réponse, personne ne peut les LIRE
-- depuis le site (lecture uniquement via votre tableau de bord Supabase).
alter table public.planification enable row level security;

drop policy if exists "insertion anonyme" on public.planification;
create policy "insertion anonyme"
  on public.planification
  for insert
  to anon
  with check (true);

grant insert on public.planification to anon;

-- Lire/exporter : Supabase > Table Editor > planification > Export (CSV).
