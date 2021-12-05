# Librerias:
library(shiny)
library(shinydashboard)
library(shinycssloaders)

# UI:
# Header ----
dbHeader <- dashboardHeader(title = "Datatón 2021",
                            tags$li(a(href = '',
                                      img(src = 'assets/perro.jpg',
                                          title = "perro", height = "30px", id = "optionalstuff3"),
                                      style = "padding-top:10px; padding-bottom:10px;"),
                                    class = "dropdown")
                            )

# Sidebar ----
dbSidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Introducción", tabName = "int"),
        menuItem("Consulta por Dependencia", tabName = "dep"),
        menuItem("Consulta Individual", tabName = "ind"),
        menuItem("Tablas Resumen", tabName = "tablas_resumen")
    )
)

# Body ----
dbBody <- dashboardBody(

    tags$head(
        tags$style(
            includeCSS("styles.css")
        )
    ),

    tabItems(
        tabItem(tabName = "tablas_resumen",
                h2("Tablas resumen de las banderas"),
                p("A continuación se muestra el agregado de los datos para los dos niveles de análisis: A nivel Institución y a Nivel Individual"),
                br(),
                fluidRow(
                    column(12,
                           wellPanel(
                            tabsetPanel(
                                tabPanel("Nivel Institución",
                                         br(),
                                         DT::dataTableOutput("tabla_datos_institucion")
                                         ),
                                tabPanel("Nivel Individual",
                                         br(),
                                         DT::dataTableOutput("tabla_datos_individuales")
                                         )
                            )
                            )
                         )
                    )
                ),
# introduccion ------------------------------------------------------------
        tabItem(tabName = "int",
                h1("Introducción"),
                p("Las declaraciones patrimoniales y de intereses son una herramienta valiosa en el combate a la corrupción y la detección de conflictos de interés. Este ejercicio de obligaciones presenta retos importantes para el manejo de su información, ya que requiere del análisis de varias categorías y miles de declaraciones para poder detectar posibles actos de corrupción o colusión. Entendiendo los recursos limitados de aquellos encargados de utilizar esta información para mejorar el funcionamiento de la administración pública, surge la necesidad de utilizar mecanismos y técnicas de análisis que vuelvan eficiente y rápido la revisión de información. Con el fin de facilitar esta comprobación, se propone un sistema que detecta anomalías en las declaraciones patrimoniales de los funcionarios tanto por lo declarado como por lo omitido."),
                p("El proyecto Anomalías en el Sistema tienen como objetivo facilitar la detección de anomalías en declaraciones patrimoniales y de interés de funcionarios públicos en 4 categorías:"),

tags$ul(
    tags$li("Anomalías en evolución de ingresos"),
    tags$li("Anomalías en evolución patrimonial"),
    tags$li("Anomalías en la consistencia del perfil del declarante con el patrimonio declarado"),
    tags$li("Existencia de funcionarios públicos sancionados")
),

p("El sistema permite al usuario navegar por institución para conocer el puntaje general respecto a la cantidad de funcionarios con anomalías, explorar cada una de las anomalías en la institución e identificar a detalle las anomalías por funcionario."),

h4("Metodología: ¿Cómo se detectan las anomalías?"),

p("Cada una de las anomalías considera distintos criterios con el objetivo de determinar de la mejor manera un comportamiento atípico dentro de las 40,019 declaraciones públicas analizadas:"),

h4("Anomalías en evolución de ingresos"),

p("Sé calculó el crecimiento del ingreso anual por funcionario y se calificaron como anómalos los casos en los que el funcionario que incrementó su ingreso en mas del doble"),

h4("Anomalias en evolución patrimonial"),

p("Se dividió el patrimonio acumulado del declarante entre su ingreso total anual, lo que ejemplifica el total de años de trabajo necesarios para acumular el patrimonio declarado. Aquellos individuos con más de 60 años de patrimonio acumulado son casos anómalos."),

h4("Anomalías en la consistencia del perfil vs patrimonio"),
p('Consideramos que existen inconsistencias entre el perfil de un funcionario y su declaración cuando el monto declarado no corresponde a lo que sería considerado "normal" dado el nivel del cargo, ingresos, profesión, nivel educativo, años de experiencia laboral y número de bienes, vehículos (de lujo o normal) y cuentas declaradas por el funcionario. Por ejemplo, esperaríamos que las personas que se desempeñan como Titulares de Unidad y tengan una maestría declaren un patrimonio mayor que un Jefe de Departamento que tiene una licenciatura.'),

p('Para calcular qué tan alejado se encuentra el valor de una declaración de lo que sería "esperable" dado su perfil, corrimos un modelo de regresión (Gradient boosting regression) en el que la variable dependiente es el monto total del patrimonio declarado (valor de los inmuebles, vehículos e inversiones) y las variables explicativas fueron el nivel del cargo, ingresos anuaales netos, profesión, nivel educativo, años de experiencia laboral, número de bienes, vehículos y cuentas declarados por el funcionario. A partir del modelo ajustado, calculamos el valor predicho del patrimonio para cada funcionario. Este valor es el que consideramos como lo "esperable" dadas sus características. Se determina la anomalía, si lo declarado está 20% por encima o por debajo de lo esperable.'),

p("Para el caso de las personas que declararon tener 0 de patrimonio, se inspeccionaron los datos inspección y se consideró anormal si un funcionario de nivel superior a subdirección declara 0 de patrimonio. Lo anterior debido a que se considera poco probable no contar con patrimonio dado el nivel de ingreso anual recibido."),

p("Adicionalmente, aplicamos un modelo de detección de anomalías no supervisado (isolation Forest) sobre los datos declarados: número y valor de los inmuebles, vehículos e inversiones, nivel educativo, experiencia laboral en sector público y privado, ingreso neto anual, nivel del cargo y profesión. El modelo clasifica a las observaciones como anómalas o no dependiendo de los valores de las variables declaradas. De esta forma encontramos que hay un grupo de funcionarios que normalmente declara grandes montos de patrimonio, pero particularmente llamó la atención que en este grupo el número de vehículos es muy alto (7), así como también el número de vehículos de lujo (3.6) en promedio."),


h4("Existencia de funcionarios públicos sancionados"),
p("Indica si el funcionario ha sido san en al algún momento de su carrera y agrega una agravante si el funcionario operaba en el área de contrataciones públicas."),

h2("Repositorio"),

p("El código con el que se analizaron los datos y se creó el dashboard puede ser consultado en:
    https://github.com/jjsantos01/datatonanticorrupcion2021"),

p('El análisis de los datos de las declaraciones y los modelos de regresión generados se encuentran dentro de la carpeta "analisis_datos". Están generados usando el lenguaje Python y para correrlos solo es necesario descargar la distribución de Anaconda (https://www.anaconda.com/products/individual) con Python 3.8. Las librerías necesarias ya vienen incluidas. Es importante notar que dentro de este repo no están los datos de las declaraciones patrimoniales porque son muy pesadas. Pueden descargarse desde el repositorio oficial del concurso https://github.com/pdnmx/dataton2021-datos'),

p("Para la creación del tablero empleamos el software R y las librerías Tidyverse y Shiny.")
    ),

# Por Dependencia ---------------------------------------------------------
        tabItem(tabName = "dep",
            fluidPage(
                wellPanel(
                    fluidRow(

                        column(12,
                               selectizeInput("selDependencia_1",
                                              "Seleccione Dependencia",
                                              choices = instituciones))

                        )
                    )
                ),
                fluidPage(
                    wellPanel(
                        fluidRow(
                    column(12,
                           tabsetPanel(
                               tabPanel(
                                   "Evolución Ingreso Neto",
                                   br(),
                                   h3("Evolución del Ingreso Neto de todos los empleados de la Institución seleccionada",
                                      style = "text-align:center;"),
                                   br(),
                                   plotOutput("gen_grafica_evo_ingreso_por_dependencia", height = "60vh") %>% withSpinner()
                               ),
                               tabPanel("Flags",
                                        br(),
                                        fluidPage(
                                            fluidRow(
                                                h3("Banderas de Contrataciones", style = "text-align: center;"),
                                                br(),
                                                column(3,
                                                       valueBoxOutput("flag_1_1", width = "100%")
                                                ),
                                                column(3,
                                                       valueBoxOutput("flag_1_9", width = "100%")
                                                )
                                            ),
                                            br(),
                                            h3("Banderas de Patrimonio", style = "text-align: center;"),
                                            fluidRow(
                                                column(4,
                                                       valueBoxOutput("flag_1_3", width = "100%")
                                                ),
                                                column(4,
                                                       valueBoxOutput("flag_1_4", width = "100%")
                                                ),
                                                column(4,
                                                       valueBoxOutput("flag_1_5", width = "100%")
                                                )
                                            ),
                                            br(),
                                            h3("Banderas de Evolución del Ingreso", style = "text-align: center;"),
                                            fluidRow(
                                                column(4,
                                                       valueBoxOutput("flag_1_6", width = "100%")
                                                ),
                                                column(4,
                                                       valueBoxOutput("flag_1_7", width = "100%")
                                                ),
                                                column(4,
                                                       valueBoxOutput("flag_1_8", width = "100%")
                                                )
                                            ),
                                            br(),
                                            h3("Banderas de Modelo No supervisado", style = "text-align: center;"),
                                            fluidRow(
                                                column(4,
                                                       valueBoxOutput("flag_1_2", width = "100%")
                                                )
                                            ),

                                            h3("Total", style = "text-align: center;"),
                                            fluidRow(
                                                column(4, offset = 4,
                                                       valueBoxOutput("flag_1_total", width = "100%")
                                                )
                                            )
                                        )
                                ) # FIn de FLAGS
                           ) #Fin del TabPanel
                        )
                    )
                )
            )
        ),
# Por individuo -----------------------------------------------------------
        tabItem(tabName = "ind",
                h1("Sistema de Consulta por Individuo", style = 'text-align: center;'),
                fluidRow(column(10, offset = 1,
                                p("En esta sección el usuario podrá consultar la información de las personas a nivel declarante")
                                )),
                fluidRow(
                    column(10, offset = 1,
                    wellPanel(
                        selectInput("selDependencia",
                                    "Seleccione una dependencia",
                                    choices = instituciones),
                        uiOutput("selIndividuo")
                    )
                    )
                ),
                fluidRow(
                    column(12,
                           wellPanel(
                               uiOutput("nombre_funcionario") %>% withSpinner(),
                               uiOutput("institucion") %>% withSpinner(),
                               uiOutput("cargo") %>% withSpinner(),
                           tabsetPanel(
                               tabPanel("Histórico de Ingreso Neto", plotOutput("grafica_1") %>% withSpinner()),
                               tabPanel("Componentes del Ingreso Neto", plotOutput("grafica_origen") %>% withSpinner()),
                               tabPanel("Flags",
                                        br(),
                                        fluidPage(
                                        fluidRow(
                                            h3("Banderas de Contrataciones", style = "text-align: center;"),
                                            br(),
                                            column(5,
                                                   valueBoxOutput("flag_1", width = "100%")
                                                   )
                                            ,
                                            column(5,
                                                   valueBoxOutput("flag_2", width = "100%")
                                            )
                                            ),
                                        br()
                                        ,
                                        h3("Banderas de Patrimonio", style = "text-align: center;"),
                                        fluidRow(
                                            column(4,
                                                   valueBoxOutput("flag_3", width = "100%")
                                            ),
                                            column(4,
                                                   valueBoxOutput("flag_4", width = "100%")
                                            ),
                                            column(4,
                                                   valueBoxOutput("flag_5", width = "100%")
                                            )
                                        ),
                                        br(),
                                        h3("Banderas de Evolución del Ingreso", style = "text-align: center;"),
                                        fluidRow(
                                            column(4,
                                                   valueBoxOutput("flag_6", width = "100%")
                                            ),
                                            column(4,
                                                   valueBoxOutput("flag_7", width = "100%")
                                            ),
                                            column(4,
                                                   valueBoxOutput("flag_8", width = "100%")
                                            )
                                        ),
                                        br(),
                                        h3("Banderas de Modelo No supervisado", style = "text-align: center;"),
                                        fluidRow(
                                            column(4,
                                                   valueBoxOutput("flag_9", width = "100%")
                                            )
                                        ),

                                        h3("Total", style = "text-align: center;"),
                                        fluidRow(
                                            column(4, offset = 4,
                                                   valueBoxOutput("total_banderas", width = "100%")
                                                   )
                                        )
                                        )
                                        )
                            )
                           )
                 )
            )
        )
    )

)

# Aplicación completa: ----
shinyUI(dashboardPage(skin = "black",
                      dbHeader,
                      dbSidebar,
                      dbBody))
