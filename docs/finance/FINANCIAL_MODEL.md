# Financial Model

**Note: This is a simulated baseline model for Series A/Seed planning.**

## 1. Unit Economics
- **Price:** $99 / Year / Household (Paid annually).
- **Target LTV (Lifetime Value):** $297 (Assuming an average lifespan of 3 years before churn).
- **Target CAC (Customer Acquisition Cost):** < $30. 
- **LTV:CAC Ratio:** ~10:1.

## 2. Infrastructure Costs (COGS)
Due to the Offline-First architecture, compute and storage costs are heavily subsidized by the user's device.
- **Cloud Sync API (PostgreSQL/Redis):** Highly efficient because it only routes small encrypted CRDT event blobs, not rich media or complex queries.
- **Estimated COGS per Household:** < $5 / Year.
- **Gross Margin:** > 90%.

## 3. Burn Rate & Operating Expenses (OpEx)
- **Engineering:** Lean team focusing on local execution and cryptography.
- **Customer Support:** Low volume expected due to deterministic design and lack of complex cloud-state bugs.
- **Marketing:** High focus on organic growth and editorial content.

## 4. Subscription Strategy
We do not offer a monthly plan. Family coordination is a long-term behavioral change that takes months to solidify. A monthly plan encourages premature churn before the habit is formed. The $99 annual commitment filters for high-intent households.
