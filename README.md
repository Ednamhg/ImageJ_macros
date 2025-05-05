# ImageJ_macros 
Macros for Fiji(Image J) and Octave to do things in "Laser Optic's Laboratory" at UNAM

## Acetato de Sodio Instrucciones
### Convertir el video en imágenes

1. Abrir VideoProc Converter
2. Cargar el video que se desea convertir picando en el botón de video y luego arrastrando este a donde dice arrastrar video aquí
3. Hacer click en Herramientas
4. Dar doble click en Instantánea
5. Mover las viñetas verdes al inicio y final del video que se desea convertir
6. Seleccionar PNG y el número de imágenes que se desea obtener.
7. Dar click en LISTO y después de que se cierre la ventana en RUN. 
8. Recuerda que debes tener la imagen de la referencia

### Preparar imagenes

Bajar https://fiji.sc/, instalar el plugin Template Maching

1. Abrir Fiji (ImageJ)
2. Arrastrar carpeta con las imagenes a la barra de herramientas.
3. Dar click en use virtual stack y ok
4. Revisar que no se mueva mucho la imagen si se mueve hacer pasos 5 y 6 si no, brincar al paso 7.
5. Convertir a grises. Dar click en Image → Type → 8 bit y esperar a que todo lo convierta a escala de grises.
6. Alinear las imagenes usando el Plugin Template Matching
7. Se puede si se desea hacer un crop para a la imagen no gastar tanta memoria (Seleccione el are a cortar con un cuadrado, picar en Image → crop).
8. Salvar en formato tiff.

### Obtener el valor de la frontera

1. Instalar el macro. Plugins → Macros → Install y elegir “Acetato_Sodio_mm_ImageJ_Edna2023.txt”

[Acetato_Sodio_mm_ImageJ_Edna2023.txt](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0415a1eb-4839-4c80-8302-a7c8acfa039d/Acetato_Sodio_mm_ImageJ_Edna2023.txt)

Abajo dejo la versión dos donde se usa una figura negra como referencia

[Acetato_Sodio_mm_ImageJ_Edna2023_v2.txt](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fcb64776-7d09-43e0-93ef-c04a946d2529/Acetato_Sodio_mm_ImageJ_Edna2023_v2.txt)

1. Seleccionar la ventana del video y presionar la letra c. Este macros creará dos copias del stack uno en el que le quita la última imagen y otro donde quita la primera y  resta ambos stacks. Al final muestra un stack de la resta de una imagen con la anterior. Lo que resulta en una serie de imagenes grises donde un círculo negro crece. 
2. Asegurarse que en el video se vea una figura semejante a un círculo o sección de un círculo que crece. Si las primeras imagenes no son muy claras hay que eliminarlas. Imagen —> Tools —> Makesubstack. Selecciona las imagenes que deseas usar
3. Presiona d. Este macro genera rois en forma de lineas que parten de un centro hacia alguna dirección formando un círculo no necesariamente concentrico. El roi pide que selecciones el circulo negro de la primera imagen (i.e. el más chico) y el de la última imagen (i.e. el más grande). En el RoiManager, el cual debe estar abierto al final del roi se puede seleccionar el recuadro “show all” para verlos todos.
4. Es conveniente saber cuanto mide el area de la figura a utilizar para realizar la conversión de pixeles a milìmetros. Para hacerlo asegura de tomar una foto de este con alguna otra referencia como una regla. Convierte la imagen a grises. Presion ctrl shift t y se abrirá una página con un threshold. usa el necesario para que toda la figura negra quede cubierta por la màscara. Presiona el cuadro con la varita mágica y da click sobre la figura negra. Se formará un roi alrededor de la figura. Presiona m para saber sus dimensiones.
5. Presiona f.
6. En la ventana de resultados se van a desplegar tres filas, una con el tiempo y el otro con el borde en pixeles.
7. Guarda los datos en .csv.
8. Puedes usar el siguiente script hecho en Octave para obtener la velocidad en función de la concentración o la temperatura. El programa lo que hace es leer los documentos de un folder y obtener todos los que terminen con .csv y leerlos. Hace un fit al sistema quitando los últimos valores que son iguales y puntos que se salgan mucho de la linea.

[calcVelocity.m](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/568dc0f9-3af5-420a-8669-305b4191c5c4/calcVelocity.m)

### Analizar los datos

1.  Elimina los datos que tengan el máximo de pixeles, ya que eso implica que no se observo un borde en el ROI de esas imagenes.
2. Convierte los pixeles en mm. Si hay algo en la imagen que tenga una distancia conocida, se hacer una linea que marque esa distancia, se da click en Analyze → set scale y se pone la distancia conocida y sus unidades en la ventana emergente. El programa nos indica el número de pixeles/unidad eg. 40 pixeles/cm.
3. Obten la pendiente de la recta que se forma distancia vs tiempo que es la velocidad. Si no se forma una recta repite desde el paso 4 de la sección anterior.
