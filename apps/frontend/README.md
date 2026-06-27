# LifeCircle OS — Frontend

A server-side rendered frontend for the LifeCircle OS using FastAPI, Jinja2, HTMX, and Tailwind CSS.

## Architecture

This frontend is designed as a Python-first service:
*   **FastAPI:** Handles routing and serves HTML templates.
*   **Jinja2:** Serves as the template rendering engine.
*   **HTMX:** Used for partial DOM swaps and dynamic client-side interactions.
*   **Tailwind CSS:** Integrated via Tailwind Play CDN for visual styling.

## Local Setup

To install dependencies and start the local development server:

```bash
cd apps/frontend
poetry install
poetry run uvicorn lifecircle_frontend.main:app --reload --port 8080
```
