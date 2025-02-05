
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vicdffhmap

<!-- badges: start -->
<!-- badges: end -->

***vicdffhmap*** is a simple package containing sf objects for the
Victorian Department of Families, Fairness and Housing’s divisions and
areas.

The Department of Families, Fairness and Housing has four divisions and
17 areas.

Areas are groups of local government areas.

Divisions are groups of areas.

We have used this simple aggregation approach to create sf objects by
summarising objects obtains using `strayr::read_absmap("lga2021")`

## Installation

You can install the development version of vicdffhmap from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("zerogetsamgow/vicdffhmap")
```

## division_map

The following plot shows a map of the four divisionss which are
contained in `vicdffhmap::division_map`.

``` r
library(vicdffhmap)

## basic division_map
ggplot2::ggplot(
  division_map,
  ggplot2::aes(
    geometry = geometry,
    fill = division_name,
    label = division_name,
    x = cent_long,
    y = cent_lat
    )
  ) +
  ggplot2::geom_sf(
   colour = vpstheme::bv.smoke
   )+
  ggplot2::geom_label(
    colour = vpstheme::bv.charcoal, 
    fill = "grey", size = ggplot2::unit(7,"pt"))+
  vpstheme::scale_fill_dffh(palette = "core", reverse = TRUE, guide = "none")+
  ggthemes::theme_map()+
  ggplot2::theme(
    legend.position.inside = c(.7,.7)
  )
```

<img src="man/figures/README-division_map-1.png" width="100%" />

## area_map

The following plot shows a map of the 17 areas which are contained in
`vicdffhmap::area_map`

``` r
## basic area_map
ggplot2::ggplot(
  area_map,
  ggplot2::aes(
    geometry = geometry,
    fill = area_name,
    label = area_name,
    x = cent_long,
    y = cent_lat
    )
  ) +
  ggplot2::geom_sf(
   colour = vpstheme::bv.smoke
   )+
  ggrepel::geom_label_repel(
    colour = vpstheme::bv.charcoal, 
    fill = vpstheme::bv.smoke, size = ggplot2::unit(3,"pt"),
    max.overlaps = 20,
    segment.colour = vpstheme::bv.smoke)+
  ggplot2::scale_fill_manual(
    values = c(north_colours, west_colours, east_colours, south_colours), guide = "none")+
  ggthemes::theme_map()+
  ggplot2::theme(
    legend.position.inside = c(.7,.7)
  )
```

<img src="man/figures/README-area_map-1.png" width="100%" />

## area_tbl

The package contains a third dataset `vicedumap::area_tbl` which shows
the mapping of local government areas, to areas, to divisions

``` r
## print full table of regions, areas and lgas
knitr::kable(
  area_tbl
)
```

| division_name  | area_name               | lga_name             |
|:---------------|:------------------------|:---------------------|
| West division  | Wimmera South West      | Corangamite          |
| West division  | Wimmera South West      | Glenelg              |
| West division  | Wimmera South West      | Hindmarsh            |
| West division  | Wimmera South West      | Horsham              |
| West division  | Wimmera South West      | Moyne                |
| West division  | Wimmera South West      | Northern Grampians   |
| West division  | Wimmera South West      | Southern Grampians   |
| West division  | Wimmera South West      | Warrnambool          |
| West division  | Wimmera South West      | West Wimmera         |
| West division  | Wimmera South West      | Yarriambiack         |
| West division  | Barwon                  | Colac Otway          |
| West division  | Barwon                  | Greater Geelong      |
| West division  | Barwon                  | Surf Coast           |
| West division  | Barwon                  | Queenscliffe         |
| West division  | Central Highlands       | Ararat               |
| West division  | Central Highlands       | Ballarat             |
| West division  | Central Highlands       | Golden Plains        |
| West division  | Central Highlands       | Hepburn              |
| West division  | Central Highlands       | Moorabool            |
| West division  | Central Highlands       | Pyrenees             |
| West division  | Western Melbourne       | Hobsons Bay          |
| West division  | Western Melbourne       | Maribyrnong          |
| West division  | Western Melbourne       | Melbourne            |
| West division  | Western Melbourne       | Moonee Valley        |
| West division  | Western Melbourne       | Wyndham              |
| West division  | Brimbank Melton         | Brimbank             |
| West division  | Brimbank Melton         | Melton               |
| North division | Mallee                  | Mildura              |
| North division | Mallee                  | Swan Hill            |
| North division | Mallee                  | Buloke               |
| North division | Mallee                  | Gannawarra           |
| North division | Loddon                  | Campaspe             |
| North division | Loddon                  | Central Goldfields   |
| North division | Loddon                  | Greater Bendigo      |
| North division | Loddon                  | Loddon               |
| North division | Loddon                  | Macedon Ranges       |
| North division | Loddon                  | Mount Alexander      |
| North division | Hume Meri-bek           | Hume                 |
| North division | Hume Meri-bek           | Merri-bek            |
| North division | North Eastern Melbourne | Banyule              |
| North division | North Eastern Melbourne | Darebin              |
| North division | North Eastern Melbourne | Nillumbik            |
| North division | North Eastern Melbourne | Whittlesea           |
| North division | North Eastern Melbourne | Yarra                |
| East division  | Ovens Murray            | Alpine               |
| East division  | Ovens Murray            | Benalla              |
| East division  | Ovens Murray            | Indigo               |
| East division  | Ovens Murray            | Mansfield            |
| East division  | Ovens Murray            | Towong               |
| East division  | Ovens Murray            | Wangaratta           |
| East division  | Ovens Murray            | Wodonga              |
| East division  | Goulburn                | Greater Shepparton   |
| East division  | Goulburn                | Mitchell             |
| East division  | Goulburn                | Moira                |
| East division  | Goulburn                | Murrindindi          |
| East division  | Goulburn                | Strathbogie          |
| East division  | Outer Easten Melbourne  | Knox                 |
| East division  | Outer Easten Melbourne  | Maroondah            |
| East division  | Outer Easten Melbourne  | Yarra Ranges         |
| East division  | Inner Easter Melbourne  | Boroondara           |
| East division  | Inner Easter Melbourne  | Manningham           |
| East division  | Inner Easter Melbourne  | Monash               |
| East division  | Inner Easter Melbourne  | Whitehorse           |
| South division | Outer Gippsland         | East Gippsland       |
| South division | Outer Gippsland         | Wellington           |
| South division | Outer Gippsland         | Bass Coast           |
| South division | Outer Gippsland         | Baw Baw              |
| South division | Outer Gippsland         | Latrobe              |
| South division | Outer Gippsland         | South Gippsland      |
| South division | Southern Melbourne      | Cardinia             |
| South division | Southern Melbourne      | Casey                |
| South division | Southern Melbourne      | Greater Dandenong    |
| South division | Bayside Peninsula       | Bayside              |
| South division | Bayside Peninsula       | Frankston            |
| South division | Bayside Peninsula       | Glen Eira            |
| South division | Bayside Peninsula       | Kingston             |
| South division | Bayside Peninsula       | Mornington Peninsula |
| South division | Bayside Peninsula       | Port Phillip         |
| South division | Bayside Peninsula       | Stonnington          |
