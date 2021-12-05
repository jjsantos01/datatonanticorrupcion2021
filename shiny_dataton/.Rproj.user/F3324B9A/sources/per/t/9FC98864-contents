# Library
library(tidyverse)

# Objetos.
funcionarios <- read_csv("www/datos/datos_funcionarios_2021.csv")
flags <- read_csv("www/datos/FLAGS_datos_funcionarios_2021.csv")
instituciones <- funcionarios %>% pull(metadata.institucion) %>% unique() %>% sort()
ing_neto <- readRDS("www/objetos/ingreso_neto_por_curp.rds") %>% ungroup()
ing_desglosado <- readRDS("www/objetos/ingreso_descompuesto_por_curp.rds")  %>% ungroup()
umbral = 500000

suma_flags <- flags %>%
  select(curp, nombre, institucion = metadata.institucion_x, contains("flag")) %>%
  pivot_longer(4:ncol(.)) %>%
  group_by(curp) %>%
  summarise(`Total Banderas` = sum(value))


# Flags por Dependencia:

datos_dependencia <- flags %>%
  select(metadata.institucion_x, contains("flag")) %>%
  pivot_longer(2:ncol(.)) %>%
  group_by(metadata.institucion_x, name) %>%
  summarise(value = sum(value))  %>%
  mutate(name_2  = str_replace_all(name, c("red_flag_sancionado" = "Funcionario Sancionado",
                                           "red_flag_anomalia_isol" = "Flag de modelo no supervisado",
                                           "^red_flag_sancionado_contrataciones$" = "Flag de Contrataciones",
                                           "red_flag_bajo_patrimonio" = "Flag de Bajo Patrimonio Declarado",
                                           "red_flag_alto_patrimonio" = "Flag de Alto Patrimonio Declarado",
                                           "red_flag_cero_patrimonio" = "Flag de Cero Patrimonio",
                                           "red_flag_evolucion_ingreso" = "Flag de la Evolución del Ingreso",
                                           "red_flag_desviacion" = "Flag de Ingreso Extraordinario",
                                           "red_flag_lib_fin" = "Flag de Acumulación extraordinaria de Patrimonio")))

datos_dependencia_suma <- datos_dependencia %>%
  group_by(metadata.institucion_x) %>%
  summarise(`Suma total` = sum(value))

datos_dependencia_total <- datos_dependencia %>%
  group_by( metadata.institucion_x) %>%
  summarise(value = sum(value))

gen_total_flags_dependencia <- function(dep_sel){
  datos_dependencia_total %>%
    filter(metadata.institucion_x == dep_sel) %>%
    pull(value)
}

dep_sel <- datos_dependencia$metadata.institucion_x[1]
# datos_flags_dependencia <- gen_banderas_dependencia(dep_sel)
gen_banderas_dependencia <- function(dep_sel){
  datos_dependencia %>%
    filter(metadata.institucion_x == dep_sel)
}


total_variaciones = ing_desglosado %>%
  # filter(year != 2015) %>%
  group_by(curp, year, metadata.institucion) %>%
  arrange(curp, year) %>%
  summarise(value = sum(value)) %>%
  ungroup() %>%
  group_by(curp) %>%
  mutate(diff = c(diff(value), 0)) %>%
  mutate(tipo_variacion = case_when(diff > umbral & year != 2015 ~ "Anomalía",
                                    diff <= umbral ~ "Esperado",
                                    year == 2015 ~ "Esperado"))

gen_ingreso_desglosado_dependencia <- function(inst_sel){
  bd = total_variaciones %>%
    filter(metadata.institucion == inst_sel)
}

# Funciones propias: ----
gen_funcionarios_por_inst <- function(inst_sel){
  bi <- funcionarios %>%
    filter(metadata.institucion == inst_sel)
  nombres <- bi$curp
  names(nombres) <- bi$nombre
  return(nombres)
}

# Gráfica de evolucion ----
cur = "SAAC850107MPUNRC02"

# datx <- gen_flag_data(cur)
gen_flag_data <- function(curp_sel){
  # curp_sel = cur
  datos_flag <- flags %>%
    filter(curp == curp_sel) %>%
    select(curp, contains("flag")) %>%
    pivot_longer(2:ncol(.)) %>%
    mutate(name_2  = str_replace_all(name, c("red_flag_sancionado" = "Funcionario Sancionado",
                                 "^red_flag_sancionado_contrataciones$" = "Flag de Contrataciones",
                                 "red_flag_anomalia_isol" = "Flag de modelo no supervisado",
                                 "red_flag_bajo_patrimonio" = "Flag de Bajo Patrimonio Declarado",
                                 "red_flag_alto_patrimonio" = "Flag de Alto Patrimonio Declarado",
                                 "red_flag_cero_patrimonio" = "Flag de Cero Patrimonio",
                                 "red_flag_evolucion_ingreso" = "Flag de la Evolución del Ingreso",
                                 "red_flag_desviacion" = "Flag de Ingreso Extraordinario",
                                 "red_flag_lib_fin" = "Flag de Acumulación extraordinaria de Patrimonio")))

  datos_flag$name_2[2]  <- "Flag de Contrataciones"
  return(datos_flag)
}

total_flags <- function(data_flags){
  valor = data_flags %>%
    pull(value) %>%
    sum()
  return(valor)
}

# dato_flag <- datos_flag[1,]
# Gen_flag_individual
# gen_flag_individual(dato_flag = dato_flag)
gen_flag_individual <- function(dato_flag){
  color = ifelse(dato_flag$value == 0,
                 yes = "green",
                 no = "red")
  vB = valueBox(
    value = dato_flag$value,
    subtitle = dato_flag$name_2,
    color = color,
    icon = icon("flag")
  )
  return(vB)
}

# Generador de cartas:
gen_cards <- function(datos_flag){
  banderas_efectivas <- datos_flag %>%
    filter(value != 0)
  lapply(1:nrow(banderas_efectivas), function(x){
    # x = 1
    ban <- banderas_efectivas[x,]
    vB = valueBox(
      value = str_c(ban$name_2),
      subtitle = "",
      color = "red",
      icon = icon("flag")
    )
    return(vB)
  })

}

# gen_ingreso_desgosado(cur)
gen_ingreso_desgosado <- function(fun_sel){
  ingreso_desglosado_fun <- ing_desglosado %>%
    filter(curp == fun_sel)
  return(ingreso_desglosado_fun)
}

# gen_ingreso_desgosado(cur) %>% gen_ingreso_neto()
gen_ingreso_neto <- function(ingreso_desglosado_fun){

  ingreso_neto_fun <-  ingreso_desglosado_fun %>%
    group_by(year) %>%
    summarise(value = sum(value)) %>%
    ungroup() %>%
    mutate(diff = c(diff(value), 0)) %>%
    mutate(tipo_variacion = case_when(diff > umbral & year != 2015 ~ "Anomalía",
                                      diff <= umbral ~ "Esperado",
                                      year == 2015 ~ "Esperado"))
  return(ingreso_neto_fun)
}

infu <- gen_ingreso_neto(gen_ingreso_desgosado(cur))

# info_funcionario <- get_datos_funcionario(curp_sel = cur)
# funcionarios$curp[45]
# get_datos_funcionario(curp_sel = "ADAJ870425HAGMML03")
get_datos_funcionario <- function(curp_sel){
  # curp_sel = cur
  b = funcionarios %>%
    filter(curp == curp_sel)

  list(
       "Nombre" = b$nombre,
       "Institucion" = b$metadata.institucion,
       "Cargo" = b$declaracion.situacionPatrimonial.datosEmpleoCargoComision.areaAdscripcion,
       "Honorarios" = b$declaracion.situacionPatrimonial.datosEmpleoCargoComision.contratadoPorHonorarios,
       "Nivel empleos" = b$declaracion.situacionPatrimonial.datosEmpleoCargoComision.nivelEmpleoCargoComision,
       "Nivel Educativo" = str_to_title(b$edu_nivel),
       "Experiencia en el Sector Privado" = b$exp_privado,
       "Experiencia en el Sector Público" = b$exp_publico,
       "Experiencia total" = b$exp_total,
       "Número de vehículos" = b$n_vehiculos,
       "Número de bienes inmuebles" = b$n_bienes,
       "Valor de los bienes inmuebles" = b$valor_bienes,
       "Valor de las inversiones" = b$valor_inversiones,
       "Patrimonio total" = b$patrimonio_total)
}

# gen_ingreso_desgosado(cur) %>% gen_ingreso_neto() %>% gen_grafica_neto()
# ingreso_neto_fun = infu
gen_grafica_neto <- function(ingreso_neto_fun){

  ingreso_neto_fun %>%
    mutate(tipo_variacion = factor(tipo_variacion,
                                   levels = c("Esperado", "Anomalía"))) %>%
    ggplot(aes(x = year,
               y = value,
               color = tipo_variacion,
               group = 1)) +
    geom_line(size = 1.5) +
    scale_color_manual(values = c("skyblue", "salmon")) +
    geom_point(pch = 21, size = 3, fill = "white") +
    scale_y_continuous(labels = scales::dollar_format(prefix = "$")) +
    scale_x_continuous(breaks = min(ingreso_neto_fun$year):max(ingreso_neto_fun$year)) +
    labs(color = "Tipo de Variación") +
    theme_bw() +
    theme(text = element_text(family = "Poppins"))
  }

gen_grafico_origen <- function(ingreso_desglosado_fun){
  ingreso_desglosado_fun %>%
    ggplot() +
    geom_col(aes(x = year,
                 y = value,
                 group = `Origen del ingreso`,
                 fill = `Origen del ingreso`)) +
    # geom_point(data = ingreso_neto_fun,
    #            aes(x = year, y = value)) +
    labs(x = "Año", y = "Ingreso") +
    scale_x_continuous(breaks = 2015:2021) +
    scale_y_continuous(labels = scales::dollar_format(prefix = "$")) +
    theme(legend.position = "bottom") +
    guides(fill = guide_legend(ncol = 4,
                               title.position = "top",
                               title.hjust = 0.5))
}

