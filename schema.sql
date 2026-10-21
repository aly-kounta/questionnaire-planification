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
  q06_preparation text[] not null,
  q06_preparation_autre text,
  q07_frequence text not null,
  q07_frequence_autre text,
  q08_decideur text not null,
  q08_decideur_autre text,
  q09_suivi text not null,
  q09_suivi_autre text,
  q10_difficultes text[] not null,
  q10_difficultes_autre text,
  q11_outil text not null,
  q12_outil_nom text,
  q13_fonctions_utilisees text[],
  q13_fonctions_utilisees_autre text,
  q14_satisfaction text,
  q15_smartphone text not null,
  q16_reseau text not null,
  q17_format_plan text[] not null,
  q17_format_plan_autre text,
  q18_elements_cles text[] not null,
  q18_elements_cles_autre text,
  q19_format_outil text not null,
  q19_format_outil_autre text,
  q20_fonctionnalites text[] not null,
  q20_fonctionnalites_autre text,
  q21_infos_tableau_bord text[] not null,
  q21_infos_tableau_bord_autre text,
  q22_freins text[] not null,
  q22_freins_autre text,
  q23_scenario_chantier text,
  q24_amelioration text,
  q25_entretien text not null,
  q25_contact text,
  constraint q20_fonctionnalites_max check (cardinality(q20_fonctionnalites) <= 3),
  constraint q01_fonction_autre_len check (q01_fonction_autre is null or char_length(q01_fonction_autre) <= 3000),
  constraint q02_structure_autre_len check (q02_structure_autre is null or char_length(q02_structure_autre) <= 3000),
  constraint q06_preparation_autre_len check (q06_preparation_autre is null or char_length(q06_preparation_autre) <= 3000),
  constraint q07_frequence_autre_len check (q07_frequence_autre is null or char_length(q07_frequence_autre) <= 3000),
  constraint q08_decideur_autre_len check (q08_decideur_autre is null or char_length(q08_decideur_autre) <= 3000),
  constraint q09_suivi_autre_len check (q09_suivi_autre is null or char_length(q09_suivi_autre) <= 3000),
  constraint q10_difficultes_autre_len check (q10_difficultes_autre is null or char_length(q10_difficultes_autre) <= 3000),
  constraint q12_outil_nom_len check (q12_outil_nom is null or char_length(q12_outil_nom) <= 3000),
  constraint q13_fonctions_utilisees_autre_len check (q13_fonctions_utilisees_autre is null or char_length(q13_fonctions_utilisees_autre) <= 3000),
  constraint q17_format_plan_autre_len check (q17_format_plan_autre is null or char_length(q17_format_plan_autre) <= 3000),
  constraint q18_elements_cles_autre_len check (q18_elements_cles_autre is null or char_length(q18_elements_cles_autre) <= 3000),
  constraint q19_format_outil_autre_len check (q19_format_outil_autre is null or char_length(q19_format_outil_autre) <= 3000),
  constraint q20_fonctionnalites_autre_len check (q20_fonctionnalites_autre is null or char_length(q20_fonctionnalites_autre) <= 3000),
  constraint q21_infos_tableau_bord_autre_len check (q21_infos_tableau_bord_autre is null or char_length(q21_infos_tableau_bord_autre) <= 3000),
  constraint q22_freins_autre_len check (q22_freins_autre is null or char_length(q22_freins_autre) <= 3000),
  constraint q23_scenario_chantier_len check (q23_scenario_chantier is null or char_length(q23_scenario_chantier) <= 3000),
  constraint q24_amelioration_len check (q24_amelioration is null or char_length(q24_amelioration) <= 3000),
  constraint q25_contact_len check (q25_contact is null or char_length(q25_contact) <= 3000)
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
