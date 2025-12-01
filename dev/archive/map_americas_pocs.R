# setup -------------------------------------------------------------------

# load packages
library(tidyverse)
library(refugees)
library(sf)
library(unhcrthemes)
library(ragg)

# vars
sf_use_s2(FALSE)
# robin <- "+proj=robin +lon_0=0 +datum=WGS84 +units=m +no_defs"
pop_threshold <- 1000
poly_col <- "#EAE6E4"
line_col <- "#A8AAAD"

# Define new meridian
meridian2 <- -74

# Split world at new meridian

# data --------------------------------------------------------------------

# geodata
wrl_a_sf <- st_read(
    here::here("boundaries", "wrl_boundaries.gpkg"),
    layer = "wrl_bnda_int_25m_ungis"
) |>
    filter(iso3cd != "ATA") |>
    filter(
        iso3cd %in%
            c(
                refugees::countries |>
                    filter(unhcr_region == "The Americas") |>
                    distinct(iso_code) |>
                    pull()
            )
    )

wld.new <- st_break_antimeridian(wrl_a_sf, lon_0 = meridian2)

wrl_a_sf <- st_transform(
    wld.new,
    paste(
        "+proj=robin +lon_0=",
        meridian2,
        "+k=1 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
    )
)


wrl_l_sf <- st_read(
    here::here("boundaries", "wrl_boundaries.gpkg"),
    layer = "wrl_bndl_int_25m_ungis"
) |>
    filter(bdystyle != "donotshow")

wrl_l.new <- st_break_antimeridian(wrl_l_sf, lon_0 = meridian2)

wrl_l_sf <- st_transform(
    wrl_l.new,
    paste(
        "+proj=robin +lon_0=",
        meridian2,
        "+k=1 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
    )
)


wrl_p_df <- read_csv(here::here(
    "boundaries",
    "wrl_polbnd_int_1m_p_unhcr.csv"
)) |>
    select(iso3, gis_name, color_code, lon, lat, secondary_territory) |>
    filter(
        iso3 %in%
            c(
                refugees::countries |>
                    filter(unhcr_region == "The Americas") |>
                    distinct(iso_code) |>
                    pull()
            )
    )


wrl_p_sf <- wrl_p_df |>
    group_by(iso3) |>
    mutate(n_iso = n()) |>
    ungroup() |>
    mutate(
        centroid = case_when(
            n_iso == 1 ~ TRUE,
            n_iso > 1 & secondary_territory == 0 ~ TRUE,
            TRUE ~ FALSE
        )
    ) |>
    filter(centroid) |>
    select(-(secondary_territory:centroid)) |>
    st_as_sf(coords = c("lon", "lat"), crs = 4326) |>
    filter(
        iso3 %in%
            c(
                refugees::countries |>
                    filter(unhcr_region == "The Americas") |>
                    distinct(iso_code) |>
                    pull()
            )
    )

# load poc data

pop_ras <- read_csv(here::here("data", "my25_ref_asy_ooc.csv"))
pop_oip_ido <- read_csv(here::here("data", "my25_oip_idp.csv"))

full_pop <- pop_oip_ido |>
    full_join(pop_ras, by = "coa")

pop <- full_pop |>
    left_join(
        refugees::countries |>
            select(iso_code, unhcr_code),
        by = c("coa" = "unhcr_code")
    ) |>
    rename(iso3 = iso_code)


# prepare map data --------------------------------------------------------

pop_sf <- wrl_p_sf |>
    left_join(pop, by = "iso3")


# Plot --------------------------------------------------------------------

# OIPs -------------------------------------------------------------------

ggplot() +
    geom_sf(
        data = wrl_a_sf,
        fill = poly_col,
        color = "transparent"
    ) +
    geom_sf_text(
        data = wrl_a_sf |>
            filter(
                stscod == "State",
                (intreg != "Caribbean" | is.na(intreg)),
                !(iso3cd == "USA" & st_geometry_type(geom) == "POLYGON")
            ),
        aes(label = nam_en),
        color = "gray30", # Color del texto, puedes ajustarlo
        size = 2.5, # Tamaño del texto, ajústalo según necesites
        check_overlap = TRUE # Evita que las etiquetas se superpongan
    ) +
    geom_sf(
        data = wrl_l_sf,
        aes(linetype = bdystyle),
        color = "white",
        linewidth = .25
    ) +
    geom_sf(
        data = pop_sf,
        aes(size = oip),
        shape = 21,
        fill = unhcr_pal(n = 5, "pal_navy")[3],
        color = unhcr_pal(n = 5, "pal_navy")[5],
        alpha = 0.6,
        linewidth = 3
    ) +
    scale_linetype_identity() +
    scale_fill_unhcr_c(
        direction = 1,
        palette = 4,
        na.value = poly_col,
        limits = c(.2, .8),
        breaks = c(.2, .5, .8)
    ) +
    scale_size_area(
        max_size = 10,
        labels = scales::label_number(
            scale_cut = scales::cut_short_scale()
        ),
        breaks = c(100000, 500000, 1000000, 2500000)
    ) +
    labs(
        title = "Other people in need of international protection (OIPs)",
        size = "OIPs",
        caption = "<b>Sources:</b> UNHCR Refugee Data Finder"
    ) +
    theme_unhcr(void = TRUE, font_size = 13.5, legend_title = TRUE) +
    guides(
        size = guide_legend(
            theme = theme(
                legend.text.position = "bottom",
                legend.title = element_text(margin = margin(b = 0))
            )
        ),
        fill = guide_colorbar(
            barheight = unit(3, units = "mm")
        )
    ) +
    theme(
        legend.position = "inside",
        legend.justification.inside = c(0, 0),
        legend.direction = "horizontal",
        legend.title.position = "top",
        legend.title = element_text(
            hjust = 0,
            size = 10.5
        ),
        legend.text = element_text(
            size = 9.5
        ),
        legend.spacing.y = unit(.15, "cm")
    )

# save ----------------------------------------------------------

ggsave(
    "oip.svg",
    device = svg,
    dpi = 300,
    width = 1280 * 2 / 300, # width of saved image
    height = 800 * 2 / 300, # height of saved image
    units = "in", # units for width and height
)


# IDPs -------------------------------------------------------------------

ggplot() +
    geom_sf(
        data = wrl_a_sf,
        fill = poly_col,
        color = "transparent"
    ) +
    geom_sf_text(
        data = wrl_a_sf |>
            filter(
                stscod == "State",
                (intreg != "Caribbean" | is.na(intreg)),
                !(iso3cd == "USA" & st_geometry_type(geom) == "POLYGON")
            ),
        aes(label = nam_en),
        color = "gray30", # Color del texto, puedes ajustarlo
        size = 2.5, # Tamaño del texto, ajústalo según necesites
        check_overlap = TRUE # Evita que las etiquetas se superpongan
    ) +
    geom_sf(
        data = wrl_l_sf,
        aes(linetype = bdystyle),
        color = "white",
        linewidth = .25
    ) +
    geom_sf(
        data = pop_sf,
        aes(size = idp),
        shape = 21,
        fill = unhcr_pal(n = 5, "pal_navy")[3],
        color = unhcr_pal(n = 5, "pal_navy")[5],
        alpha = 0.6,
        linewidth = 3
    ) +
    scale_linetype_identity() +
    scale_fill_unhcr_c(
        direction = 1,
        palette = 4,
        na.value = poly_col,
        limits = c(.2, .8),
        breaks = c(.2, .5, .8)
    ) +
    scale_size_area(
        max_size = 10,
        labels = scales::label_number(
            scale_cut = scales::cut_short_scale()
        ),
        breaks = c(100000, 500000, 1000000, 7000000)
    ) +
    labs(
        title = "Internally Displaced People",
        size = "IDPs",
        caption = "<b>Sources:</b> UNHCR Refugee Data Finder"
    ) +
    theme_unhcr(void = TRUE, font_size = 13.5, legend_title = TRUE) +
    guides(
        size = guide_legend(
            theme = theme(
                legend.text.position = "bottom",
                legend.title = element_text(margin = margin(b = 0))
            )
        ),
        fill = guide_colorbar(
            barheight = unit(3, units = "mm")
        )
    ) +
    theme(
        legend.position = "inside",
        legend.justification.inside = c(0, 0),
        legend.direction = "horizontal",
        legend.title.position = "top",
        legend.title = element_text(
            hjust = 0,
            size = 10.5
        ),
        legend.text = element_text(
            size = 9.5
        ),
        legend.spacing.y = unit(.15, "cm")
    )


# save ----------------------------------------------------------

ggsave(
    "idp.svg",
    device = svg,
    dpi = 300,
    width = 1280 * 2 / 300, # width of saved image
    height = 800 * 2 / 300, # height of saved image
    units = "in", # units for width and height
)


# OOCs -------------------------------------------------------------------

ggplot() +
    geom_sf(
        data = wrl_a_sf,
        fill = poly_col,
        color = "transparent"
    ) +
    geom_sf_text(
        data = wrl_a_sf |>
            filter(
                stscod == "State",
                (intreg != "Caribbean" | is.na(intreg)),
                !(iso3cd == "USA" & st_geometry_type(geom) == "POLYGON")
            ),
        aes(label = nam_en),
        color = "gray30", # Color del texto, puedes ajustarlo
        size = 2.5, # Tamaño del texto, ajústalo según necesites
        check_overlap = TRUE # Evita que las etiquetas se superpongan
    ) +
    geom_sf(
        data = wrl_l_sf,
        aes(linetype = bdystyle),
        color = "white",
        linewidth = .25
    ) +
    geom_sf(
        data = pop_sf,
        aes(size = ooc),
        shape = 21,
        fill = unhcr_pal(n = 5, "pal_navy")[3],
        color = unhcr_pal(n = 5, "pal_navy")[5],
        alpha = 0.6,
        linewidth = 3
    ) +
    scale_linetype_identity() +
    scale_fill_unhcr_c(
        direction = 1,
        palette = 4,
        na.value = poly_col,
        limits = c(.2, .8),
        breaks = c(.2, .5, .8)
    ) +
    scale_size_area(
        max_size = 10,
        labels = scales::label_number(
            scale_cut = scales::cut_short_scale()
        ),
        breaks = c(1000, 10000, 30000, 50000)
    ) +
    labs(
        title = "Other of concern",
        size = "ooc",
        caption = "<b>Sources:</b> UNHCR Refugee Data Finder"
    ) +
    theme_unhcr(void = TRUE, font_size = 13.5, legend_title = TRUE) +
    guides(
        size = guide_legend(
            theme = theme(
                legend.text.position = "bottom",
                legend.title = element_text(margin = margin(b = 0))
            )
        ),
        fill = guide_colorbar(
            barheight = unit(3, units = "mm")
        )
    ) +
    theme(
        legend.position = "inside",
        legend.justification.inside = c(0, 0),
        legend.direction = "horizontal",
        legend.title.position = "top",
        legend.title = element_text(
            hjust = 0,
            size = 10.5
        ),
        legend.text = element_text(
            size = 9.5
        ),
        legend.spacing.y = unit(.15, "cm")
    )


# save ----------------------------------------------------------

ggsave(
    "ooc.svg",
    device = svg,
    dpi = 300,
    width = 1280 * 2 / 300, # width of saved image
    height = 800 * 2 / 300, # height of saved image
    units = "in", # units for width and height
)


# REF -------------------------------------------------------------------

ggplot() +
    geom_sf(
        data = wrl_a_sf,
        fill = poly_col,
        color = "transparent"
    ) +
    geom_sf_text(
        data = wrl_a_sf |>
            filter(
                stscod == "State",
                (intreg != "Caribbean" | is.na(intreg)),
                !(iso3cd == "USA" & st_geometry_type(geom) == "POLYGON")
            ),
        aes(label = nam_en),
        color = "gray30", # Color del texto, puedes ajustarlo
        size = 2.5, # Tamaño del texto, ajústalo según necesites
        check_overlap = TRUE # Evita que las etiquetas se superpongan
    ) +
    geom_sf(
        data = wrl_l_sf,
        aes(linetype = bdystyle),
        color = "white",
        linewidth = .25
    ) +
    geom_sf(
        data = pop_sf,
        aes(size = ref),
        shape = 21,
        fill = unhcr_pal(n = 5, "pal_navy")[3],
        color = unhcr_pal(n = 5, "pal_navy")[5],
        alpha = 0.6,
        linewidth = 3
    ) +
    scale_linetype_identity() +
    scale_fill_unhcr_c(
        direction = 1,
        palette = 4,
        na.value = poly_col,
        limits = c(.2, .8),
        breaks = c(.2, .5, .8)
    ) +
    scale_size_area(
        max_size = 10,
        labels = scales::label_number(
            scale_cut = scales::cut_short_scale()
        ),
        breaks = c(10000, 100000, 200000, 400000)
    ) +
    labs(
        title = "Refugees",
        size = "ref",
        caption = "<b>Sources:</b> UNHCR Refugee Data Finder"
    ) +
    theme_unhcr(void = TRUE, font_size = 13.5, legend_title = TRUE) +
    guides(
        size = guide_legend(
            theme = theme(
                legend.text.position = "bottom",
                legend.title = element_text(margin = margin(b = 0))
            )
        ),
        fill = guide_colorbar(
            barheight = unit(3, units = "mm")
        )
    ) +
    theme(
        legend.position = "inside",
        legend.justification.inside = c(0, 0),
        legend.direction = "horizontal",
        legend.title.position = "top",
        legend.title = element_text(
            hjust = 0,
            size = 10.5
        ),
        legend.text = element_text(
            size = 9.5
        ),
        legend.spacing.y = unit(.15, "cm")
    )


# save ----------------------------------------------------------

ggsave(
    "ref.svg",
    device = svg,
    dpi = 300,
    width = 1280 * 2 / 300, # width of saved image
    height = 800 * 2 / 300, # height of saved image
    units = "in", # units for width and height
)


# ASY -------------------------------------------------------------------

ggplot() +
    geom_sf(
        data = wrl_a_sf,
        fill = poly_col,
        color = "transparent"
    ) +
    geom_sf_text(
        data = wrl_a_sf |>
            filter(
                stscod == "State",
                (intreg != "Caribbean" | is.na(intreg)),
                !(iso3cd == "USA" & st_geometry_type(geom) == "POLYGON")
            ),
        aes(label = nam_en),
        color = "gray30", # Color del texto, puedes ajustarlo
        size = 2.5, # Tamaño del texto, ajústalo según necesites
        check_overlap = TRUE # Evita que las etiquetas se superpongan
    ) +
    geom_sf(
        data = wrl_l_sf,
        aes(linetype = bdystyle),
        color = "white",
        linewidth = .25
    ) +
    geom_sf(
        data = pop_sf,
        aes(size = asy),
        shape = 21,
        fill = unhcr_pal(n = 5, "pal_navy")[3],
        color = unhcr_pal(n = 5, "pal_navy")[5],
        alpha = 0.6,
        linewidth = 3
    ) +
    scale_linetype_identity() +
    scale_fill_unhcr_c(
        direction = 1,
        palette = 4,
        na.value = poly_col,
        limits = c(.2, .8),
        breaks = c(.2, .5, .8)
    ) +
    scale_size_area(
        max_size = 10,
        labels = scales::label_number(
            scale_cut = scales::cut_short_scale()
        ),
        breaks = c(100000, 500000, 1000000, 3000000)
    ) +
    labs(
        title = "Asylum seekers",
        size = "asy",
        caption = "<b>Sources:</b> UNHCR Refugee Data Finder"
    ) +
    theme_unhcr(void = TRUE, font_size = 13.5, legend_title = TRUE) +
    guides(
        size = guide_legend(
            theme = theme(
                legend.text.position = "bottom",
                legend.title = element_text(margin = margin(b = 0))
            )
        ),
        fill = guide_colorbar(
            barheight = unit(3, units = "mm")
        )
    ) +
    theme(
        legend.position = "inside",
        legend.justification.inside = c(0, 0),
        legend.direction = "horizontal",
        legend.title.position = "top",
        legend.title = element_text(
            hjust = 0,
            size = 10.5
        ),
        legend.text = element_text(
            size = 9.5
        ),
        legend.spacing.y = unit(.15, "cm")
    )


# save ----------------------------------------------------------

ggsave(
    "asy.svg",
    device = svg,
    dpi = 300,
    width = 1280 * 2 / 300, # width of saved image
    height = 800 * 2 / 300, # height of saved image
    units = "in", # units for width and height
)
