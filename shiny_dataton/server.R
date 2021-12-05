# Librerias:
library(shiny)

shinyServer(function(input, output, session) {

  output$tabla_datos_institucion <- DT::renderDataTable({
      DT::datatable(datos_dependencia %>%
                      ungroup() %>%
                      pivot_wider(id_cols = metadata.institucion_x,
                                  values_from = value,
                                  names_from = name_2) %>%
                      left_join(datos_dependencia_suma),
                    extensions = 'FixedColumns',
                    escape = FALSE,
                    rownames= FALSE,
                    filter = 'top',
                    options = list(
                      pageLength = 10,
                      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'
                      ),
                      language = list(searchPlaceholder = "setosa"),
                      autoWidth = FALSE,
                      scrollX = TRUE
                    ))
  })

  output$tabla_datos_individuales <- DT::renderDataTable({
    DT::datatable(flags %>%
                    select(curp, nombre, institucion = metadata.institucion_x, contains("flag")) %>%
                    mutate(across(.cols = contains("flag"), .fns = as.numeric)) %>%
                    left_join(suma_flags),
                  extensions = 'FixedColumns',
                  escape = FALSE,
                  rownames= FALSE,
                  filter = 'top',
                  options = list(
                    pageLength = 10,
                    language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'
                    ),
                    language = list(searchPlaceholder = "setosa"),
                    autoWidth = FALSE,
                    scrollX = TRUE
                  ))
  })


  datos_flags_individuo <- reactive({
    gen_flag_data(input$selIndividuo)
  })

  datos_flags_dependencia <- reactive({
    gen_banderas_dependencia(input$selDependencia_1)
  })


  # output$flag_1_9 <- renderValueBox({
  #   # print(datos_flags_dependencia)
  #   dato_flag <- datos_flags_dependencia()[9,]
  #   color = ifelse(dato_flag$value == 0,
  #                  yes = "green",
  #                  no = "red")
  #   valueBox(
  #     value = dato_flag$value,
  #     subtitle = dato_flag$name_2,
  #     color = color,
  #     icon = icon("flag")
  #   )
  # })

  output$flag_1_total <- renderValueBox({
    # print(datos_flags_dependencia)
    # dato_flag <- datos_flags_dependencia()[8,]
    color = "purple"

    valueBox(
      value = gen_total_flags_dependencia(input$selDependencia_1),
      subtitle = "Total de Banderas",
      color = color,
      icon = icon("flag")
    )

  })

  output$flag_1_9 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[9,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })


  output$flag_1_8 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[8,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_1_7 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[7,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_1_6 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[6,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_1_5 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[5,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_1_4 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[4,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_1_3 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[3,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })


  output$flag_1_2 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[2,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })


  output$flag_1_1 <- renderValueBox({
    # print(datos_flags_dependencia)
    dato_flag <- datos_flags_dependencia()[1,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$total_banderas <- renderValueBox({
    valor <- total_flags(datos_flags_individuo())
    color = "purple"
    valueBox(
      value = valor,
      subtitle = "Total de Banderas",
      color = color,
      icon = icon("flag")
    )

  })

  output$flag_9 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[9,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_8 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[8,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_7 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[7,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_6 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[6,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_5 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[5,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_4 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[4,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  output$flag_3 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[3,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })


  output$flag_2 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[2,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })


  output$flag_1 <- renderValueBox({
    dato_flag <- datos_flags_individuo()[1,]
    color = ifelse(dato_flag$value == 0,
                   yes = "green",
                   no = "red")
    valueBox(
      value = dato_flag$value,
      subtitle = dato_flag$name_2,
      color = color,
      icon = icon("flag")
    )
  })

  gen_ingreso_desglosado_dependencia_1 <- reactive({
    gen_ingreso_desglosado_dependencia(input$selDependencia_1)
  })

  output$gen_grafica_evo_ingreso_por_dependencia <- renderPlot({
    gen_ingreso_desglosado_dependencia_1() %>%
      ggplot(aes(x = year,
                 y = value,
                 group = curp,
                 color = tipo_variacion)) +
      geom_line() +
      geom_point() +
      scale_y_continuous(label = scales::dollar_format(prefix = "$"))
  })


  output$selIndividuo <- renderUI({
    selectInput("selIndividuo",
                "Seleccione persona de interés",
                choices = gen_funcionarios_por_inst(input$selDependencia))
  })

  info_funcionario <- reactive({
    get_datos_funcionario(curp_sel = req(input$selIndividuo))
  })

  output$nombre_funcionario <- renderUI({
    h3(info_funcionario()$Nombre, style = "text-align:center;")
  })

  output$institucion <- renderUI({
    h5(str_c("Institución: ", info_funcionario()$Institucion), style = "text-align:center;")
  })

  output$cargo <- renderUI({
    h5(str_c("Cargo: ", info_funcionario()$Cargo), style = "text-align:center;")
  })

  output$progressBox <- renderValueBox({
    valueBox(
      paste0(25 + input$count, "%"), "Progress", icon = icon("list"),
      color = "purple"
    )
  })


  output$caja_carros <- renderValueBox({
    valueBox(
      str_c(info_funcionario()$`Número de vehículos`),
      "Número de vehículos",
      color = "red",
      icon = shiny::icon(name = "car")
    )
  })


  ingreso_desglosado <- reactive({
    gen_ingreso_desgosado(input$selIndividuo)
  })

  ingreso_neto <- reactive({
    gen_ingreso_neto(ingreso_desglosado())
  })



  output$grafica_1 <- renderPlot({
    gen_grafica_neto(ingreso_neto_fun = ingreso_neto())
  })

  output$grafica_origen <- renderPlot({
    gen_grafico_origen(ingreso_desglosado_fun = ingreso_desglosado())
  })


})
