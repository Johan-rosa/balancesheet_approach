library(shiny)
library(bslib)
library(highcharter)

options(box.path = here::here())

box::use(data / mocked / balances[balances])

cols <- c(
  "#855C75FF", "#D9AF6BFF", "#AF6458FF", "#736F4CFF", "#526A83FF", 
  "#625377FF", "#68855CFF", "#9C9C5EFF", "#A06177FF", "#8C785DFF", 
  "#467378FF", "#7C7C7CFF"
)


ui <- bslib::page_navbar(
  title = "Balancesheet Approach",
  div(
    style = "padding: 10px",
    layout_column_wrap(
      card(
        balances |>
          hchart("line", hcaes(x = year, y = total, group = siglas)) |>
          hc_plotOptions(line = list(marker = list(enabled = FALSE))) |>
          hc_xAxis(title = FALSE) |> 
          hc_yAxis(title = FALSE, labels = list(format = "{value} %")) |>
          hc_colors(cols)
      ),
      card(
        balances |>
          hchart("line", hcaes(x = year, y = total, group = siglas)) |>
          hc_plotOptions(line = list(marker = list(enabled = FALSE))) |>
          hc_xAxis(title = FALSE) |> 
          hc_yAxis(title = FALSE, labels = list(format = "{value} %")) |>
          hc_colors(cols)
      )
    ),
    layout_column_wrap(
      card(
        balances |>
          hchart("line", hcaes(x = year, y = total, group = siglas)) |>
          hc_plotOptions(line = list(marker = list(enabled = FALSE))) |>
          hc_xAxis(title = FALSE) |> 
          hc_yAxis(title = FALSE, labels = list(format = "{value} %")) |>
          hc_colors(cols)
      ),
      card(
        balances |>
          hchart("line", hcaes(x = year, y = total, group = siglas)) |>
          hc_plotOptions(line = list(marker = list(enabled = FALSE))) |>
          hc_xAxis(title = FALSE) |> 
          hc_yAxis(title = FALSE, labels = list(format = "{value} %")) |>
          hc_colors(cols)
      )
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
