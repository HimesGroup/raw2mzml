server <- function(input, output, session) {
  shinyFileChoose(
    input, "fin", roots = home_dir, filetypes = c("", "Raw", "raw")
  )
  flist <- reactive({
    req(input$fin)
    ## input$fin
    parseFilePaths(home_dir, input$fin)
  })

  observeEvent(flist(), {
    d <- flist()[, "datapath", drop = FALSE]
    names(d) <- "File"
    output$inputlist <- renderDT(datatable(d))
  })

  shinyDirChoose(input, "fout", roots = home_dir)

  out_dir <- reactive({
    req(input$fout)
    parseDirPath(home_dir, input$fout)
  })

  v <- reactiveValues(dir = getwd())

  observeEvent(out_dir(), {
    v$dir <- out_dir()
    output$print_dir <- renderText(v$dir)
  })

  observeEvent(input$run, {
    msconvert <- find_msconvert()
    withProgress(message = "Converting Data...", value = 0, {
      n <- length(flist()$name)
      for (i in 1:n) {
        run_msconvert(msconvert, flist()$datapath[i], v$dir)
        incProgress(1/n, detail = paste0("File: ", flist()$name[i]))
      }
      showModal(
        modalDialog(
          "Done! Please check the files.",
          size = "l", easyClose = TRUE
        )
      )
    })
  })
}
