# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal website for Drew DeNardo at `www.haff.tech`. Built with Hugo and the CareerCanvas theme (a Git submodule at `themes/careercanvas/`). Tailwind CSS is compiled separately from the Hugo build. Deployed to Firebase Hosting.

This site was cloned from Felipe Cordero's personal site and is being personalized for Drew. The English `config.toml` params and static files (resume, images) have been updated, but the content markdown files (`content/en/*.md`) and the Spanish/French language configs still contain Felipe's information.

## Commands

```bash
# Local dev (includes drafts, uses config.local.toml if present)
npm run dev
# or with local API keys:
./dev.sh   # runs: hugo server --config config.toml,config.local.toml

# Watch CSS (run alongside dev server when editing CSS)
npm run watch:css

# Production build
npm run build:css && npm run build
```

## Architecture

### Content model
All page sections are **data-only markdown files** — the body is empty and everything is YAML frontmatter. Files live at `content/{en,es,fr}/{section}.md` and must include `type: "homepage"`. The theme's partial templates (`themes/careercanvas/layouts/partials/`) read the frontmatter directly with `.Params`.

Sections: `about`, `skills`, `experience`, `technical`, `contact`. The homepage layout (`_default/index.html`) composes them in order.

### CSS pipeline
Tailwind is processed **outside Hugo**: source at `themes/careercanvas/assets/css/main.css`, output to `themes/careercanvas/static/css/main.css`. Hugo serves the pre-built static file. Run `npm run watch:css` in parallel with the dev server when making style changes. The built CSS lives in the theme submodule — don't commit it to this repo.

### Theme submodule
`themes/careercanvas/` is a separate Git repo. Layout changes belong there. This repo has a local `layouts/` override directory (`layouts/_default/`, `layouts/shortcodes/`) for site-specific template overrides.

### Color palettes
Multiple color palettes are defined in `config.toml` under `[params.color_palettes]`. One is selected randomly on each page load via `themes/careercanvas/assets/js/dynamic-colors.js`. To add or change a palette, edit `config.toml`.

### Multilingual
Three languages configured: `en` (primary, English), `es` (Spanish), `fr` (French). Content lives in `content/{lang}/`. Language-specific parameters (`tagline`, `hero_description`, `resume_url`, etc.) are set per-language in `config.toml` under `[languages.{lang}.params]`.

### Local API keys
The contact form (Formspree) and hero background images (Pexels API) require keys not in `config.toml`. Create `config.local.toml` (gitignored) with:
```toml
[params]
  pexelsapikey = "your_key"
  formspreeendpoint = "https://formspree.io/f/your_id"
```

### Deployment
Hosted on Firebase Hosting. The build script `./build.sh` calls `hugo --minify` after updating submodules. Set `HUGO_PARAMS_PEXELSAPIKEY` and `HUGO_PARAMS_FORMSPREEENDPOINT` as environment variables in your build environment — no underscores in the param names.
