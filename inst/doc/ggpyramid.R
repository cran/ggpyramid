## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4.5,
  out.width = "100%",
  dpi = 96
)

## ----setup--------------------------------------------------------------------
library(ggplot2)
library(ggpyramid)

## -----------------------------------------------------------------------------
head(europe_pop)

## ----first--------------------------------------------------------------------
france <- subset(europe_pop, country == "France" & year == 2024)

ggplot(france, aes(x = population, y = age, fill = sex)) +
  geom_pyramid() +
  scale_x_continuous(labels = scales::label_comma()) +
  coord_pyramid()

## ----left---------------------------------------------------------------------
ggplot(france, aes(x = population, y = age, fill = sex)) +
  geom_pyramid() +
  scale_x_continuous(labels = scales::label_comma()) +
  scale_fill_discrete(breaks = c("Female", "Male")) +
  coord_pyramid(left = "Female")

## ----eval = FALSE-------------------------------------------------------------
# # One row per person
# ggplot(people, aes(y = age_group, fill = sex)) +
#   geom_pyramid()

## ----centre-------------------------------------------------------------------
p <- ggplot(france, aes(x = population, y = age, fill = sex)) +
  geom_pyramid(width = 1, colour = "white") +
  scale_x_continuous(
    labels = scales::label_number(scale = 1e-6, suffix = "M")
  ) +
  labs(x = NULL, y = NULL, fill = NULL) +
  theme_pyramid()

p + coord_pyramid(age_axis = "centre")

## ----both---------------------------------------------------------------------
p + coord_pyramid(age_axis = "both", gap = 0.08)

## ----facets, fig.height = 6---------------------------------------------------
ggplot(europe_pop, aes(x = population, y = age, fill = sex)) +
  geom_pyramid(denominator = "total") +
  scale_x_continuous(labels = scales::label_percent()) +
  coord_pyramid() +
  facet_grid(year ~ country) +
  labs(x = "Share of the population", y = NULL, fill = NULL) +
  theme_pyramid()

## ----labels-------------------------------------------------------------------
ireland <- subset(europe_pop, country == "Ireland" & year == 2024)

ggplot(ireland, aes(x = population, y = age, fill = sex)) +
  geom_pyramid(denominator = "side") +
  geom_pyramid_text(
    denominator = "side",
    labels = scales::label_percent(accuracy = 0.1),
    size = 2.6
  ) +
  scale_x_continuous(
    labels = scales::label_percent(),
    expand = expansion(mult = 0.15)
  ) +
  coord_pyramid(age_axis = "centre") +
  labs(x = "Share of each sex", y = NULL, fill = NULL) +
  theme_pyramid()

## ----outline------------------------------------------------------------------
italy <- subset(europe_pop, country == "Italy")

ggplot(italy, aes(x = population, y = age, fill = sex)) +
  geom_pyramid(data = subset(italy, year == 2024), width = 1, alpha = 0.8) +
  geom_pyramid_outline(data = subset(italy, year == 2004), linewidth = 0.6) +
  scale_x_continuous(
    labels = scales::label_number(scale = 1e-6, suffix = "M")
  ) +
  coord_pyramid(age_axis = "centre") +
  labs(
    x = NULL,
    y = NULL,
    fill = "2024",
    caption = "The outline shows 2004."
  ) +
  theme_pyramid()

## ----subgroups----------------------------------------------------------------
recent <- subset(europe_pop, year == 2024 & country %in% c("Ireland", "Poland"))

ggplot(recent, aes(x = population, y = age, fill = country, side = sex)) +
  geom_pyramid(width = 1) +
  scale_x_continuous(
    labels = scales::label_number(scale = 1e-6, suffix = "M")
  ) +
  coord_pyramid(age_axis = "centre") +
  labs(x = NULL, y = NULL, fill = NULL) +
  theme_pyramid()

## ----vertical-----------------------------------------------------------------
ggplot(france, aes(x = age, y = population, fill = sex)) +
  geom_pyramid() +
  scale_y_pyramid(labels = scales::label_number(scale = 1e-6, suffix = "M")) +
  labs(x = NULL, y = NULL, fill = NULL) +
  theme_pyramid(flipped = TRUE) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

## ----eval = FALSE-------------------------------------------------------------
# geom_vline(xintercept = c(-1e6, 1e6), linetype = "dashed")
# coord_pyramid(xlim = c(-3e6, 3e6))

