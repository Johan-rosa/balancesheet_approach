library(shiny)
library(bslib)
library(highcharter)
library(imola)
library(dplyr)
library(reactable)
library(shinyjs)
library(echarts4r)

options(box.path = here::here())

box::use(
  data / mocked / balances[balances],
  tablas = data / mocked / matriz[balance_matriz, diferencias]
)


cols <- c("#5495CFFF", "#F5AF4DFF", "#7C873EFF", "#DB4743FF", "#FEF4D5FF")
cols2 <- c(
  "#855C75FF", "#D9AF6BFF", "#AF6458FF", "#736F4CFF", "#526A83FF", 
  "#625377FF", "#68855CFF", "#9C9C5EFF", "#A06177FF", "#8C785DFF", 
  "#467378FF", "#7C7C7CFF"
)

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
    hc_title(
      text = sector,
      style = list(
        fontSize = "0.9rem"
      )
    )
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
        fmtd <- scales::comma(vals, accuracy = 0.01)
        ifelse(is.na(fmtd), "", fmtd)
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
    ),
    highlight = TRUE
  )


plots <- purrr::map(
  c("BC", "SPub", "OSD", "OSF", "SPriv", "TOT", "NR"),
  \(st) {
    balances |>
      dplyr::filter(siglas == st) |> 
      plot_posicion()
  }
)


edges <- tablas$balance_matriz |>
  filter_out(sector == "Sub-Totales") |> 
  tidyr::pivot_longer(-sector, names_to = "target", values_to = "value") |>
  filter_out(is.na(value)) |>
  rename(source = sector)

to_recode <- balances |> 
  filter(year == max(year)) |>
  filter_out(siglas == "TOT")

tr <- setNames(to_recode$siglas, to_recode$sector)

edges <- edges |>
  mutate(
    source = recode(source, !!!tr),
    target = recode(target, !!!tr),
    grp = source, 
    size = abs(value) / max(abs(value)) * 15
  )

nodes <- tablas$balance_matriz |>
  filter(sector == "Sub-Totales") |>
  tidyr::pivot_longer(-sector, names_to = "target", values_to = "value") |>
  select(-sector) |>
  arrange(desc(abs(value))) |> 
  mutate(
    target = recode(target, !!!tr),
    grp = target,
    size = c(100, 50, 30, 10, 5, 5)
  ) |>
  rename(name = target)

network <- e_charts() |> 
  e_graph(
    layout = "circular", 
    circular = list(
      rotateLabel = TRUE
    ),
    roam = TRUE,
    lineStyle = list(
      color = "source",
      curveness = 0.3
    )
  ) |> 
  e_graph_nodes(nodes, name, value, size, grp) |> 
  e_graph_edges(edges, source, target, size = size) |> 
  e_tooltip()


serie_act_netos <- balances |>
  hchart("line", hcaes(x = year, y = total, group = siglas)) |>
  hc_plotOptions(line = list(marker = list(enabled = FALSE))) |>
  hc_xAxis(title = FALSE) |> 
  hc_yAxis(title = FALSE, labels = list(format = "{value} %")) |>
  hc_colors(cols2)

ui <- page_sidebar(
  fillable = FALSE,
  useShinyjs(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  title = "Balance Sheet Approach",
  sidebar = sidebar(
    width = "400px",
    fileInput("sr1", "1SR"),
    fileInput("sr2", "2SR")
  ),
  div(
    id = "empty-state",
    tags$image(id = "upload-img", src = "undraw_upload-warning_aqma.svg"),
    h2("Upload the 1SR and 2SR forms to start.")
  ),
  div(
    id = "loading-state",
    div(class = "spinner")
  ) |> hidden(),
  div(
    id = "main-panel",
    
    layout_columns(
      fill = FALSE,
      #style = css(grid_template_columns = "2fr 1fr"),
      col_widths = breakpoints(
        sm = c(12, 12),
        xl = c(8, 4)
      ),
      div(matriz_html),
      div(diferencias_html)
    ),
    card(
      full_screen = TRUE,
      card_header(
        "Activos financieros netos, según sector y moneda"
      ),
      layout_columns(
        !!!plots[-7],
        col_widths = breakpoints(
          sm = rep(12, 6),
          md = rep(6, 6),
          xl = rep(4, 6)
        ),
        row_heights = "350px"
      )
    ),
    layout_columns(
      card(
        card_header("Poscición financiera neta por sector (% del PIB)"),
        serie_act_netos
      ),
      card(
        card_header("Red de vínculos financieros"),
        network
      )
    )
  ) |> hidden(),
  tags$script(src = "main.js")
)

server <- function(input, output, session) {
  observe({
    req(input$sr1, input$sr2)
    hide(id = "empty-state")
    show(id = "loading-state")
    Sys.sleep(3)
    hide(id = "loading-state")
    show(id = "main-panel")
  })
}

shinyApp(ui, server)
