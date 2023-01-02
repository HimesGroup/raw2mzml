ui <- fluidPage(
  theme = bs_theme(bootswatch = "minty"),
  titlePanel("Convert Thermo Raw to mzML"),
  hr(),
  h4("1. Choose Thermo Raw Files", style = "color: gray;"),
  tags$div(
         shinyFilesButton(
           "fin", "File Select", "Please Select Files", multiple = TRUE
         ),
         style = "margin-bottom: 20px;"
       ),
  DTOutput("inputlist"),
  h4("2. Choose an Output Directory", style = "color: gray"),
  tags$div(
         shinyDirButton("fout", "Output Directory", "Please Select a Folder"),
         style = "margin-bottom: 10px;"
       ),
  verbatimTextOutput("print_dir"),
  br(),
  ## actionButton("run", "Convert Files", class="btn-warning"),
  actionButton(
    "run", "Convert Files", icon("paper-plane"),
    style=paste0(
      "color: white; background-color: orange; border-color: orange; ",
      "padding: 10px; font-size: 120%"
    )
  )
)
