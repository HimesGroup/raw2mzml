##' @export
run_raw2mzml <- function() {
  if (.Platform$OS.type == "windows") {
    shinyApp(ui, server, options = list(launch.browser = TRUE))
  } else {
    stop("This app requires Windows OS")
  }
}
