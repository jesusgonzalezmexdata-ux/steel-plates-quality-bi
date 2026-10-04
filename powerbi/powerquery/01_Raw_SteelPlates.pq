// Consulta base (deshabilitar "Habilitar carga"): lee el CSV una sola vez y tipifica.
let
    Origen   = Csv.Document(Web.Contents(RutaCSV), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Cabecera = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
    Tipos    = Table.TransformColumnTypes(Cabecera, List.Transform(Table.ColumnNames(Cabecera), each {_, type number}))
in
    Tipos
