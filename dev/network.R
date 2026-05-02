library(echarts4r)
library(dplyr)

options(box.path = here::here())
box::use(
  data / mocked / balances[balances],
  tablas = data / mocked / matriz[balance_matriz, diferencias]
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
  
#' @export
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
  