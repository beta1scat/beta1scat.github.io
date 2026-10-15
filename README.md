# beta1scat.github.io

Static bilingual academic homepage for GitHub Pages, together with Chinese and English LaTeX resumes.

## Files

- `index.html`: homepage entry.
- `style.css`: visual system and responsive layout.
- `script.js`: English/Chinese switching logic.
- `pyproject.toml`: Python version and dependencies managed by `uv`.
- `Makefile`: automated build, compilation, and file synchronization.
- `latex/cv_zh.tex`: Chinese full LaTeX resume source.
- `latex/cv_zh_print.tex`: Chinese 2-page print-optimized LaTeX resume source.
- `latex/cv_en.tex`: English LaTeX resume source.
- `resume/`: generated PDF resumes.

## Generate PDF resumes

The repository includes a `Makefile` to automate compilation, renaming, and synchronization. Run from the repository root:

```bash
make          # Build all resumes (ZH, EN, Print) and automatically sync to resume/
```

Granular commands are also available:

```bash
make zh       # Build Chinese resume and copy to resume/
make en       # Build English resume and copy to resume/
make print    # Build Chinese 2-page print resume to latex/build-zh/cv_zh_print.pdf
make clean    # Clean intermediate auxiliary files (*.aux, *.log, *.fls, etc.)
make serve    # Start local preview server via uv
```

If `make` is not used, the manual compilation commands remain:

```bash
latexmk -xelatex -interaction=nonstopmode -output-directory=latex/build-zh -jobname=cv_zh latex/cv_zh.tex
latexmk -xelatex -interaction=nonstopmode -output-directory=latex/build-en -jobname=cv_en latex/cv_en.tex
latexmk -xelatex -interaction=nonstopmode -output-directory=latex/build-zh -jobname=cv_zh_print latex/cv_zh_print.tex
```

## Preview locally

Install [`uv`](https://docs.astral.sh/uv/getting-started/installation/), then synchronize the Python environment from the repository root:

```bash
uv sync
```

Start a local static file server through the `uv`-managed environment:

```bash
uv run python -m http.server 8000
```

Then open `http://localhost:8000/`.

Python dependencies are declared in `pyproject.toml` and locked in `uv.lock`. Use `uv add <package>` to add a runtime dependency or `uv add --dev <package>` to add a development dependency.

## Deploy to GitHub Pages

1. Create a GitHub repository named `beta1scat.github.io`.
2. Push all files in this directory to the repository.
3. In GitHub, open `Settings -> Pages`.
4. Set `Build and deployment` to `Deploy from a branch`.
5. Select the `main` branch and the repository root folder.
6. Save and wait for the Pages URL to be generated.

The expected address format is:

```text
https://beta1scat.github.io/
```

## Migrate to object storage or CDN later

Because the site only uses relative paths and static files, the same directory can be uploaded directly to Qiniu, Alibaba Cloud OSS, or other static hosting/CDN services without changing the code structure.
