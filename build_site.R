
tryCatch({
  pkgdown::build_site(new_process = FALSE)
}, error = function(e) {
  print(e)
})
