# LifeCircle OS Design System

**Version:** 1.0  
**Owner:** Design System Lead

## Philosophy
The LifeCircle OS Design System is built on one core principle from our `PRODUCT_PRINCIPLES.md`:
> *We reduce anxiety. We do not increase engagement.*

Every token, component, and motion curve is a deliberate answer to the question: *"Does this make the family feel calmer?"*

## Architecture
```
lib/src/design_system/
├── tokens.dart    # Colors, Spacing, Typography, Radius, Shadows
├── motion.dart    # Durations and curves, named by human meaning
├── theme.dart     # Full Flutter ThemeData (Light + Dark)
└── widgets/       # Reusable components built from tokens
```

## Color Usage
| Token | Use Case |
| :--- | :--- |
| `peacefulTeal` | Primary actions, interactive elements |
| `trustNavy` | Headers, primary text on light backgrounds |
| `confidenceGreen` | Peace Score ≥ 80%, task confirmed |
| `watchAmber` | Peace Score 50-79%, task at risk |
| `escalationRose` | Peace Score < 50%, exception alert |

## Spacing System (4pt Grid)
All layout spacing must use multiples of 4: `xs(4)`, `sm(8)`, `md(16)`, `lg(24)`, `xl(32)`.

## Motion Principles
1. **Entrances decelerate** (`Curves.easeOutCubic`). Elements arrive with authority.
2. **Exits accelerate** (`Curves.easeInCubic`). Elements leave without lingering.
3. **Confirmations spring** (`Curves.elasticOut`). The Peace Score update should feel like a breath.
4. **Maximum duration: 600ms.** Any animation longer than this is UI punishment.

## Accessibility Requirements
- **Contrast**: All text must meet WCAG AA (4.5:1 for body, 3:1 for large text).
- **Touch Targets**: Minimum 48×48 dp for all interactive elements.
- **Dynamic Type**: All text must respect the system font scale setting.
- **Haptic Feedback**: Significant actions (task completed, family invited) must include haptic feedback.
