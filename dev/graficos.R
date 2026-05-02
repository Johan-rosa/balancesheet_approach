library(dplyr)
library(tidyr)
library(readxl)
library(highcharter)


options(box.path = here::here())

box::use(data / mocked / balances[balances])

"#5495CFFF, #F5AF4DFF, #DB4743FF, #7C873EFF, #FEF4D5FF" |>
  stringr::str_split(", ") |>
  unlist() |> 
  dput()

cols <- c(
  "#855C75FF", "#D9AF6BFF", "#AF6458FF", "#736F4CFF", "#526A83FF", 
  "#625377FF", "#68855CFF", "#9C9C5EFF", "#A06177FF", "#8C785DFF", 
  "#467378FF", "#7C7C7CFF"
)

balances |>
  hchart("line", hcaes(x = year, y = total, group = siglas)) |>
  hc_plotOptions(line = list(marker = list(enabled = FALSE))) |>
  hc_xAxis(title = FALSE) |> 
  hc_yAxis(title = FALSE, labels = list(format = "{value} %")) |>
  hc_colors(cols)

plot_posicion <- function(
    balance, 
    sector = c("BC", "SPub", "OSD", "OSF", "SPriv", "TOT", "NR")
) {
  balance_long <- balance |>
    dplyr::select(-total) |>
    tidyr::pivot_longer(c(me, mn), names_to = "moneda", values_to = "balance") |>
    dplyr::mutate(moneda = toupper(moneda))

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
    hc_colors(c("#FDC718FF", "#3E938BFF", "#1D373AFF", "#1942CDFF", "#73D8FEFF"))
}

balances |>
  filter(siglas == "BC") |> 
  plot_posicion()

