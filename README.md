Repositorio del equipo Databuesos

**Introducción**

Las declaraciones patrimoniales y de intereses son una herramienta valiosa en el combate a la corrupción y la detección de conflictos de interés. Este ejercicio de obligaciones presenta retos importantes para el manejo de su información, ya que requiere del análisis de varias categorías y miles de declaraciones para poder detectar posibles actos de corrupción o colusión. Entendiendo los recursos limitados de aquellos encargados de utilizar esta información para mejorar el funcionamiento de la administración pública, surge la necesidad de utilizar mecanismos y técnicas de análisis que vuelvan eficiente y rápido la revisión de información. Con el fin de facilitar esta comprobación, se propone un sistema que detecta anomalías en las declaraciones patrimoniales de los funcionarios tanto por lo declarado como por lo omitido.

El proyecto **Anomalías en el Sistema** tienen como objetivo facilitar la detección de anomalías en declaraciones patrimoniales y de interés de funcionarios públicos en 4 categorías:

- Anomalías en evolución de ingresos
- Anomalías en evolución patrimonial
- Anomalías en la consistencia del perfil del declarante con el patrimonio declarado
- Existencia de funcionarios públicos sancionados

El sistema permite al usuario navegar por institución para conocer el puntaje general respecto a la cantidad de funcionarios con anomalías, explorar cada una de las anomalías en la institución e identificar a detalle las anomalías por funcionario.

**Metodología: ¿Cómo se detectan las anomalías?**

Cada una de las anomalías considera distintos criterios con el objetivo de determinar de la mejor manera un comportamiento atípico dentro de las 40,019 declaraciones públicas analizadas:

Anomalías en evolución de ingresos

Sé calculó el crecimiento del ingreso anual por funcionario y se calificaron como anómalos los casos en los que el funcionario que incrementó su ingreso en mas del doble

Anomalias en evolución patrimonial

Se dividió el patrimonio acumulado del declarante entre su ingreso total anual, lo que ejemplifica el total de años de trabajo necesarios para acumular el patrimonio declarado. Aquellos individuos con más de 60 años de patrimonio acumulado son casos anómalos.

Anomalías en la consistencia del perfil vs patrimonio

Consideramos que existen inconsistencias entre el perfil de un funcionario y su declaración cuando el monto declarado no corresponde a lo que sería considerado &quot;normal&quot; dado el nivel del cargo, ingresos, profesión, nivel educativo, años de experiencia laboral y número de bienes, vehículos (de lujo o normal) y cuentas declaradas por el funcionario. Por ejemplo, esperaríamos que las personas que se desempeñan como Titulares de Unidad y tengan una maestría declaren un patrimonio mayor que un Jefe de Departamento que tiene una licenciatura.

Para calcular qué tan alejado se encuentra el valor de una declaración de lo que sería &quot;esperable&quot; dado su perfil, corrimos un modelo de regresión (Gradient boosting regression) en el que la variable dependiente es el monto total del patrimonio declarado (valor de los inmuebles, vehículos e inversiones) y las variables explicativas fueron el nivel del cargo, ingresos anuaales netos, profesión, nivel educativo, años de experiencia laboral, número de bienes, vehículos y cuentas declarados por el funcionario. A partir del modelo ajustado, calculamos el valor predicho del patrimonio para cada funcionario. Este valor es el que consideramos como lo &quot;esperable&quot; dadas sus características. Se determina la anomalía, si lo declarado está 20% por encima o por debajo de lo esperable.

Para el caso de las personas que declararon tener 0 de patrimonio, se inspeccionaron los datos inspección y se consideró anormal si un funcionario de nivel superior a subdirección declara 0 de patrimonio. Lo anterior debido a que se considera poco probable no contar con patrimonio dado el nivel de ingreso anual recibido.

Adicionalmente, aplicamos un modelo de detección de anomalías no supervisado (isolation Forest) sobre los datos declarados: número y valor de los inmuebles, vehículos e inversiones, nivel educativo, experiencia laboral en sector público y privado, ingreso neto anual, nivel del cargo y profesión. El modelo clasifica a las observaciones como anómalas o no dependiendo de los valores de las variables declaradas. De esta forma encontramos que hay un grupo de funcionarios que normalmente declara grandes montos de patrimonio, pero particularmente llamó la atención que en este grupo el número de vehículos es muy alto (7), así como también el número de vehículos de lujo (3.6) en promedio.

Los resultados se pueden consultar en el siquiente tablero:
https://lnppmicrositio.shinyapps.io/dataton_anticorrupcion_2021/

Existencia de funcionarios públicos sancionados

Indica si el funcionario ha sido san en al algún momento de su carrera y agrega una agravante si el funcionario operaba en el área de contrataciones públicas.

**Repositorio**

El código con el que se analizaron los datos y se creó el dashboard puede ser consultado en:

[https://github.com/jjsantos01/datatonanticorrupcion2021](https://github.com/jjsantos01/datatonanticorrupcion2021)

El análisis de los datos de las declaraciones y los modelos de regresión generados se encuentran dentro de la carpeta &quot;analisis\_datos&quot;. Están generados usando el lenguaje Python y para correrlos solo es necesario descargar la distribución de Anaconda ([https://www.anaconda.com/products/individual](https://www.anaconda.com/products/individual)) con Python 3.8. Las librerías necesarias ya vienen incluidas. Es importante notar que dentro de este repo no están los datos de las declaraciones patrimoniales porque son muy pesadas. Pueden descargarse desde el repositorio oficial del concurso [https://github.com/pdnmx/dataton2021-datos](https://github.com/pdnmx/dataton2021-datos)

Para la creación del tablero empleamos el software R y las librerías Tydiverse y Shiny.
