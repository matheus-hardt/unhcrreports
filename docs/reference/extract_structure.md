# Extract Plot Structure and Metadata (Phase 1)

This function implements Phase 1 of the AI reporting architecture. It
extracts visual metadata from a ggplot object by forcing a render build.
Unlike simple label extraction, this captures the "trained" ranges and
legend mappings that are actually displayed to the user.

## Usage

``` r
extract_structure(p)
```

## Arguments

- p:

  A `ggplot` object.

## Value

A list containing:

- labels:

  Title, subtitle, caption, and axis labels.

- ranges:

  Exact x and y ranges for each panel (trained).

- guides:

  Mapping of visuals (color/shape) to data values.

- geoms:

  List of geometric layers used.
