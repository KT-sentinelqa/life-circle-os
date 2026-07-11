# Key Performance Indicators (KPIs)

These metrics differ from OKRs in that they are continuous operational health checks, rather than quarterly stretch goals.

## 1. Product Health
- **Daily Active Households (DAH):** Number of households with >1 interaction per day.
- **Weekly Active Members (WAM):** Number of unique family members interacting weekly.
- **Invite Velocity:** Average time from household creation to the first secondary member joining.

## 2. Engineering Health (SRE-005)
- **Crash-Free Sessions:** Target > 99.9%.
- **Sync Conflict Rate:** Percentage of CRDT sync events requiring manual resolution (Target: < 0.1%).
- **API Response Time:** P95 < 200ms for cloud sync endpoints.

## 3. Financial Health
- **Customer Acquisition Cost (CAC):** Target < $30.
- **Monthly Recurring Revenue (MRR):** Tracking compounding growth of the $99/yr subscription (amortized).
- **Churn Rate:** Percentage of households canceling their subscription (Target < 2% monthly).
