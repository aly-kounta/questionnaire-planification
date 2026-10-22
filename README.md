# Questionnaire planification (bords de route) — SAGID+

Formulaire statique (HTML/JS) dont les réponses sont enregistrées dans la table `planification` de Supabase.

- `index.html` : le questionnaire (25 questions, une page par groupe)
- `config.js` : URL du projet Supabase et clé publique `anon`
- `schema.sql` : création de la table et règle de sécurité (envoi autorisé, lecture interdite depuis le site)
- `migration_recreer_table.sql` : supprime puis recrée la table (efface les réponses ! à n'utiliser qu'avant la collecte)
- `assets/` : `logo.png` et `fond.jpg`

Déploiement : copier `index.html`, `config.js` et `assets/` dans un dossier du site (Hostinger).
Ne jamais mettre la clé `service_role` dans ce dépôt.
