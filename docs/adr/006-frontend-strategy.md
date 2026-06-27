# ADR-006: Frontend Platform Strategy

## Status
Accepted

## Context
Life Circle OS requires a robust, scalable frontend strategy that can support both a rich web experience and a high-performance native mobile application. Previous discussions explored various permutations including React + Vite for the web. To eliminate ambiguity and establish a single source of truth for the Technology Layer, we must formally designate the canonical frameworks for web and mobile development.

## Decision
We will use **Next.js** for the web frontend and **Flutter** for the mobile application.

## Rationale
1. **Web (Next.js):** Next.js provides superior Server-Side Rendering (SSR) capabilities, improved SEO, and built-in API routing compared to a standard React + Vite SPA. This aligns with our enterprise goal of delivering a high-performance, accessible, and scalable web platform.
2. **Mobile (Flutter):** Flutter enables us to maintain a single unified codebase for both iOS and Android platforms without sacrificing native-like performance. Its widget ecosystem aligns perfectly with our design system and accessibility requirements (including Elder Mode).

## Consequences
- All future web development will occur within the `apps/frontend` Next.js ecosystem.
- All future mobile development will occur within the `apps/mobile` Flutter ecosystem.
- React + Vite is formally deprecated for this project.
- Frontend and Mobile Engineering teams must align their CI/CD pipelines to support these specific frameworks (e.g., Playwright for Next.js, Patrol/integration_test for Flutter).
