# Design System Strategy: The Playful Professional

## 1. Overview & Creative North Star
The core objective of this design system is to bridge the gap between "childish play" and "teenage autonomy." For users aged 10–15, a design system must feel sophisticated enough to be a productivity tool, yet vibrant enough to remain engaging.

**Creative North Star: "The Tactile Oasis"**
We are moving away from the flat, clinical "SaaS" look. Instead, we treat the UI as a physical playground of soft, rounded objects floating in a bright, airy space. By utilizing high-contrast typography scales, intentional asymmetry in layout, and overlapping 3D-style elements, we create an experience that feels custom-built and "alive." We don't just organize time; we make time feel like a tangible, friendly resource.

---

## 2. Colors & Surface Philosophy
The palette is rooted in energy and warmth. We avoid "dead" grays, opting instead for tinted neutrals that keep the interface feeling "sunny" even in utility-heavy views.

### The "No-Line" Rule
To maintain a premium, high-end feel, **1px solid borders are strictly prohibited for sectioning.** Traditional dividers create visual clutter that overwhelms younger users. Boundaries must be defined through:
- **Tonal Shifts:** Placing a `surface-container-low` card against a `surface` background.
- **Organic Depth:** Using the `surface-container` tiers to indicate hierarchy.
- **Negative Space:** Using the `Spacing Scale` (specifically `8` to `12`) to separate functional groups.

### Surface Hierarchy & Nesting
Treat the interface as a series of stacked, soft-molded sheets. 
- **Base Layer:** `surface` (#f5f6f7).
- **Secondary Content Layer:** `surface-container-low` (#eff1f2).
- **Interactive Component Layer (Cards):** `surface-container-lowest` (#ffffff) to provide a "pop" of clean white against the background.

### The "Glass & Gradient" Rule
To achieve a "3D-style" feel without performance lag, use **Glassmorphism** for floating navigation bars or Buddy’s dialogue bubbles.
- **Token Usage:** Use `primary-container` at 80% opacity with a `20px` backdrop-blur. 
- **Signature Textures:** Apply a linear gradient (Top-Left to Bottom-Right) from `primary` (#006289) to `primary-container` (#00baff) for all high-value CTAs. This creates a "gem-like" depth that flat buttons lack.

---

## 3. Typography
We utilize a high-contrast scale to create an editorial feel that guides the eye naturally.

- **Display & Headlines:** `plusJakartaSans`. This font provides the "Bold, Rounded" aesthetic requested. Use `display-lg` (3.5rem) for big motivational wins (e.g., "Great job!") and `headline-md` for page headers. The generous x-height ensures it feels friendly but authoritative.
- **Body & Labels:** `beVietnamPro`. This is our "Clean/Readable" workhorse. It offers high legibility for task lists and settings.
- **Intentional Scale:** We use a "Tight-Wide" approach. Headlines should have a letter-spacing of `-0.02em` to feel chunky and impactful, while body text uses standard spacing for maximum readability.

---

## 4. Elevation & Depth
In this design system, "Elevation" is a color property, not just a shadow property.

- **The Layering Principle:** Depth is achieved by stacking. A `surface-container-highest` element should never sit directly on the `surface` layer; it must transition through a `surface-container-low` intermediary to feel "natural."
- **Ambient Shadows:** Shadows are reserved for "Buddy" (the character) and high-priority floating action buttons.
    - **Specs:** Blur: `24px`, Y-Offset: `8px`, Color: `on-surface` at 6% opacity. This mimics soft, overhead museum lighting.
- **The "Ghost Border" Fallback:** If high-contrast accessibility is required, use `outline-variant` at **15% opacity**. Never use a fully opaque outline.
- **3D Softness:** All interactive elements must use the `xl` (3rem) or `full` (9999px) roundedness scale to mimic the "squishy" feel of a physical toy.

---

## 5. Components

### Buttons (The "Soft-Press" Style)
- **Primary:** Gradient from `primary` to `primary-container`. `full` roundedness. Text: `title-sm` (White).
- **Secondary:** `surface-container-highest` background with `on-primary-container` text.
- **Interaction:** On hover, the button should scale by 1.05x. We favor "Transform" over "Color Change" to keep the 3D playfulness.

### Cards & Lists
- **The Rule:** No dividers. 
- **Structure:** Use `surface-container-low` as a wrapper. Use `surface-container-lowest` for the individual list items.
- **Padding:** Always use `spacing-4` (1.4rem) or `spacing-5` (1.7rem) for internal card padding to maintain "Generous White Space."

### The "Buddy" Widget
- **Styling:** A floating element using `tertiary-container` (#feb700) to stand out from the blue/green UI.
- **Emotion States:** Buddy’s container color shifts slightly to `secondary-container` (Mint) when tasks are completed, or `error-container` (Coral) if a deadline is missed.

### Progress Trackers
- **Visual:** Thick, chunky bars (Height: `1.5rem`) using `primary-fixed`. The "unfilled" portion should be `surface-container-highest`, creating a "carved out" effect.

---

## 6. Do's and Don'ts

### Do
- **Do** use intentional asymmetry. Place a large Buddy illustration overlapping the corner of a card to break the "grid" feel.
- **Do** use `lavender purple` (`on-tertiary-fixed-variant`) for secondary tags to keep the palette vibrant.
- **Do** use "Warm White" (#f5f6f7) for the background to reduce eye strain compared to pure #FFFFFF.

### Don't
- **Don't** use 90-degree corners. Even the smallest "None" scale is forbidden; everything must have at least an `sm` radius.
- **Don't** use pure black (#000000) for text. Use `on-surface` (#2c2f30) to keep the "Playful Professional" tone soft.
- **Don't** overcrowd a screen. If a view has more than 5 primary actions, use a "Nested Layer" (a slide-up sheet) to hide secondary complexity.

---

## 7. Iconography
- **Style:** 2.5pt stroke weight with rounded ends.
- **Color:** Always use the `primary` or `secondary` tokens.
- **Interaction:** Icons should have a "bounce" animation when tapped, reinforcing the 3D-style tactile nature of this design system.