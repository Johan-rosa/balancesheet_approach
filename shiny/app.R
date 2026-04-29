library(shiny)
library(bslib)
library(highcharter)
library(imola)
library(dplyr)
library(reactable)

options(box.path = here::here())

box::use(
  data / mocked / balances[balances],
  tablas = data / mocked / matriz[balance_matriz, diferencias]
)

cols <- c("#5495CFFF", "#F5AF4DFF", "#7C873EFF", "#DB4743FF", "#FEF4D5FF")

plot_posicion <- function(
    balance, 
    sector = c("BC", "SPub", "OSD", "OSF", "SPriv", "TOT", "NR")
) {
  balance_long <- balance |>
    dplyr::select(-total) |>
    tidyr::pivot_longer(c(me, mn), names_to = "moneda", values_to = "balance") |>
    dplyr::mutate(moneda = toupper(moneda))
  
  sector <- unique(balance_long$sector)
  
  balance_long |>
    hchart("column", hcaes(x = year, y = balance, group = moneda)) |>
    hc_plotOptions(column = list(stacking = "normal")) |>
    hc_add_series(
      type = "scatter",
      data = list_parse2(select(balance, x = year, y = total)),
      name = "Total",
      tooltip = list(
        headerFormat = "",
        pointFormat ="Total: {point.y} %"
      )
    ) |>
    hc_yAxis(
      title = FALSE,
      labels = list(format = "{value} %")
    ) |>  
    hc_xAxis(title = FALSE) |>
    hc_colors(cols) |>
    hc_title(text = sector)
}

# Tablas 

diferencias_table <- diferencias |>
  mutate(
    across(4, \(x) x * 100),
    across(where(is.numeric), \(x) round(x, 2))
  )

matriz_html <- tablas$balance_matriz |>
  mutate(across(where(is.numeric), \(x) round(x, 2))) |> 
  reactable(
    defaultColDef = colDef(
      cell = \(vals, index, name) {
        if (name == "sector") return(vals)
        scales::comma(vals, accuracy = 0.01)
      },
      headerClass = "header"
    ),
    columns = list(
      sector = colDef(name = "", class = "header")
    ),
    class = "matrix",
    highlight = TRUE,
    sortable = FALSE
  )

total <- diferencias_table |> 
  filter(sector == "total") |>
  mutate(sector = stringr::str_to_title(sector))

diferencias_html <- diferencias_table |>
  filter_out(sector == "total") |> 
  reactable(
    class = "matrix",
    defaultColDef = colDef(
      headerClass = "header", 
      footer = \(values, col) total[[col]],
      footerStyle = list(fontWeight = "bold")
    ),
    columns = list(
      sector = colDef(name = "Sector")
    )
  )


plots <- purrr::map(
  c("BC", "SPub", "OSD", "OSF", "SPriv", "TOT", "NR"),
  \(st) {
    balances |>
      dplyr::filter(siglas == st) |> 
      plot_posicion()
  }
)

ui <- page_sidebar(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  title = "Balancesheet Approach",
  layout_columns(
    fill = FALSE,
    style = css(grid_template_columns = "2fr 1fr"),
    div(matriz_html),
    div(diferencias_html)
  ),
  layout_columns(
    !!!plots[1:3]
  ),
  layout_columns(
    !!!plots[4:6]
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
