
nr <- tibble::tribble(
          ~sector, ~year, ~mn,  ~me, ~total,
  "No Residentes", 2005L,   0,  8.1,    8.1,
  "No Residentes", 2006L,   0,  6.3,    6.3,
  "No Residentes", 2007L,   0,  4.1,    4.1,
  "No Residentes", 2008L,   0,    5,      5,
  "No Residentes", 2009L,   0,  6.8,    6.8,
  "No Residentes", 2010L,   0, 11.2,   11.2,
  "No Residentes", 2011L,   0, 13.4,   13.4,
  "No Residentes", 2012L,   0, 15.3,   15.3,
  "No Residentes", 2013L,   0, 16.3,   16.3,
  "No Residentes", 2014L,   0,   16,     16,
  "No Residentes", 2015L,   0, 14.3,   14.3,
  "No Residentes", 2016L,   0, 13.9,   13.9,
  "No Residentes", 2017L,   0, 12.5,   12.5
)

econ_total <- tibble::tribble(
                           ~sector, ~year,  ~mn,   ~me, ~total,
"Total Economía Nacional Agregado", 2005L, -0.5,  -7.5,     -8,
"Total Economía Nacional Agregado", 2006L, -0.7,  -5.3,   -6.1,
"Total Economía Nacional Agregado", 2007L, -1.1,  -2.7,   -3.9,
"Total Economía Nacional Agregado", 2008L, -0.3,  -4.7,     -5,
"Total Economía Nacional Agregado", 2009L, -0.3,  -6.5,   -6.7,
"Total Economía Nacional Agregado", 2010L, -0.1, -10.9,    -11,
"Total Economía Nacional Agregado", 2011L, -0.3,   -13,  -13.3,
"Total Economía Nacional Agregado", 2012L, -0.1, -15.2,  -15.4,
"Total Economía Nacional Agregado", 2013L, -0.1, -16.1,  -16.2,
"Total Economía Nacional Agregado", 2014L,    0, -16.1,  -16.1,
"Total Economía Nacional Agregado", 2015L,  0.1, -14.1,  -13.9,
"Total Economía Nacional Agregado", 2016L,  0.5, -14.3,  -13.8,
"Total Economía Nacional Agregado", 2017L,  0.6,   -13,  -12.5
)

spriv <- tibble::tribble(
                        ~sector, ~year,  ~mn,  ~me, ~total,
 "Sector Privado", 2005L,   19,  8.4,   27.3,
 "Sector Privado", 2006L, 18.2,  9.4,   27.6,
 "Sector Privado", 2007L, 17.7,  8.3,     26,
 "Sector Privado", 2008L, 18.8,  7.2,   25.9,
 "Sector Privado", 2009L, 18.5,  7.8,   26.3,
 "Sector Privado", 2010L, 14.8,  5.8,   20.7,
 "Sector Privado", 2011L, 14.1,  6.3,   20.5,
 "Sector Privado", 2012L,   16,  7.1,   23.1,
 "Sector Privado", 2013L, 16.7,  6.9,   23.6,
 "Sector Privado", 2014L, 17.4,  6.3,   23.7,
 "Sector Privado", 2015L, 19.1,  6.4,   25.5,
 "Sector Privado", 2016L, 20.4,    7,   27.4,
 "Sector Privado", 2017L, 21.3, 10.5,   31.8
 )

osf <- tibble::tribble(
                      ~sector, ~year,   ~mn,  ~me, ~total,
"Otras Sociedades Financieras", 2005L, -1.68, 0.08,   -1.6,
"Otras Sociedades Financieras", 2006L, -0.99, 0.12,  -0.87,
"Otras Sociedades Financieras", 2007L, -0.54, 0.12,  -0.42,
"Otras Sociedades Financieras", 2008L, -0.88, 0.09,  -0.79,
"Otras Sociedades Financieras", 2009L, -0.69, 0.11,  -0.58,
"Otras Sociedades Financieras", 2010L, -0.15, 0.09,  -0.06,
"Otras Sociedades Financieras", 2011L, -0.46, 0.12,  -0.34,
"Otras Sociedades Financieras", 2012L, -0.72, 0.09,  -0.63,
"Otras Sociedades Financieras", 2013L, -0.09,  0.1,   0.01,
"Otras Sociedades Financieras", 2014L, -0.12, 0.08,  -0.04,
"Otras Sociedades Financieras", 2015L,  0.06, 0.28,   0.34,
"Otras Sociedades Financieras", 2016L,  0.19, 0.18,   0.38,
"Otras Sociedades Financieras", 2017L,  0.13, 0.16,   0.29
)

osd <- tibble::tribble(
                       ~sector, ~year,   ~mn,   ~me, ~total,
"Otras Sociedades de Depósito", 2005L, -8.95,  1.93,  -7.02,
"Otras Sociedades de Depósito", 2006L, -0.29,  0.83,   0.54,
"Otras Sociedades de Depósito", 2007L,  0.49,  1.04,   1.54,
"Otras Sociedades de Depósito", 2008L,   0.9,  0.78,   1.68,
"Otras Sociedades de Depósito", 2009L,  1.13,  0.78,   1.91,
"Otras Sociedades de Depósito", 2010L,  2.91, -0.48,   2.44,
"Otras Sociedades de Depósito", 2011L,  3.09, -1.08,   2.01,
"Otras Sociedades de Depósito", 2012L,  2.86, -0.54,   2.32,
"Otras Sociedades de Depósito", 2013L,  2.46,  0.16,   2.63,
"Otras Sociedades de Depósito", 2014L,  2.82, -0.21,    2.6,
"Otras Sociedades de Depósito", 2015L,  2.89, -0.18,   2.71,
"Otras Sociedades de Depósito", 2016L,  3.08,  -0.2,   2.88,
"Otras Sociedades de Depósito", 2017L,  3.43, -0.37,   3.06
)

sp <- tibble::tribble(
        ~sector, ~year,    ~mn,    ~me, ~total,
"Sector Público", 2005L,  -9.37, -18.81, -28.18,
"Sector Público", 2006L, -16.75, -17.83, -34.59,
"Sector Público", 2007L, -16.64, -15.79, -32.43,
"Sector Público", 2008L, -17.85, -15.73, -33.58,
"Sector Público", 2009L, -17.65, -18.51, -36.16,
"Sector Público", 2010L, -16.58,  -19.5, -36.08,
"Sector Público", 2011L, -15.08, -21.69, -36.77,
"Sector Público", 2012L,  -17.2, -24.63, -41.83,
"Sector Público", 2013L, -17.06, -26.91, -43.97,
"Sector Público", 2014L, -17.12, -26.55, -43.66,
"Sector Público", 2015L, -18.88,  -25.1, -43.98,
"Sector Público", 2016L, -20.25, -25.64,  -45.9,
"Sector Público", 2017L, -20.39, -28.81,  -49.2
)

bc <- tibble::tribble(
        ~sector, ~year,   ~mn,  ~me, ~total,
"Banco Central", 2005L,  0.55, 0.95,    1.5,
"Banco Central", 2006L, -0.91, 2.14,   1.23,
"Banco Central", 2007L, -2.14, 3.58,   1.45,
"Banco Central", 2008L, -1.21, 2.99,   1.78,
"Banco Central", 2009L,  -1.6, 3.36,   1.76,
"Banco Central", 2010L, -1.15, 3.14,   1.99,
"Banco Central", 2011L, -1.95, 3.34,    1.4,
"Banco Central", 2012L, -1.08, 2.71,   1.64,
"Banco Central", 2013L, -2.11, 3.61,    1.5,
"Banco Central", 2014L, -2.92, 4.29,   1.37,
"Banco Central", 2015L, -2.98, 4.45,   1.47,
"Banco Central", 2016L, -2.95,  4.4,   1.45,
"Banco Central", 2017L, -3.95, 5.51,   1.55
)

#' @export
balances <- dplyr::bind_rows(
  list(
    BC = bc,
    SPub = sp,
    OSD = osd,
    OSF = osf,
    SPriv = spriv,
    TOT = econ_total,
    NR = nr
  ),
  .id = "siglas"
)
