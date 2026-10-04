# Cómo armar el .pbix en Windows (≈ 40 min)

Power BI Desktop solo corre en Windows, y este repositorio se preparó en Linux. **El .pbix no está incluido ni se probó**: las medidas DAX y las consultas M están escritas y validadas contra una réplica en Python y SQL (ver `tests/`), pero no se ejecutaron en Power BI Desktop.

1. **Datos.** `Obtener datos > Consulta en blanco`, Editor avanzado, y pega cada archivo de `powerbi/powerquery/` en este orden, con el nombre indicado:
   `RutaCSV` (00), `Raw_SteelPlates` (01, sin cargar), `Dim_TipoDefecto` (02), `Dim_Acero` (03), `Dim_BandaTamano` (04), `Fact_Defecto` (05), `Param_Especificacion` (06).
2. **Relaciones.** Las tres dimensiones al hecho por su `id_*`: uno a muchos, filtro de dimensión a hecho, sentido único. Oculta las columnas `id_*` del hecho.
3. **Medidas.** Crea una tabla `_Medidas` y pega cada bloque de `powerbi/dax/measures.dax`. Si alguna da error de nombre, revisa que las tablas se llamen exactamente igual.
4. **Tema.** `Vista > Temas > Examinar temas` y elige `powerbi/theme.json`.
5. **Páginas.** Lectura en Z: tarjetas arriba (`Defectos`, `COPQ MXN`, `Defectos Grandes`, `Cpk` con color de `Semaforo Cpk Color`), en medio la carta de medias (líneas `Linea Central`, `UCL`, `LCL` y `Media Log Area` por `Dim_Acero[espesor]`), abajo el Pareto (columnas `COPQ MXN` y línea `COPQ Acumulado %` por `Dim_TipoDefecto[tipo_defecto]`). Una tarjeta con `Texto ISO 10.2`.
6. **Tooltip.** Página oculta con tamaño "Información sobre herramientas" que muestre `Defectos`, `COPQ MXN` y un histograma por `Dim_BandaTamano[banda_tamano]`; actívala en el Pareto.
7. **Publicar.** `Publicar` en Power BI Service. Si los datos públicos lo permiten, `Archivo > Insertar informe > Publicar en la web` genera un enlace público; agrégalo al README.

**Control de versiones.** No subas el .pbix. Guarda el proyecto como `.pbip` (Archivo > Guardar como, con la vista previa de "Proyecto de Power BI" activada) para versionar el modelo y los informes como texto.

**Valores esperados para comprobar tu tablero** (sin filtros, USL = 500, costos por defecto): 1,941 placas; COPQ 2,242,600 MXN; 289 defectos ≥ 5,000 px²; Cpk global 0.09; el Pareto ordena Otros defectos, Rayón en K, Abolladuras.
