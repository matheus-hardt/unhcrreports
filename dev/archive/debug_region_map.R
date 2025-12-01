# Debug Region Map

pkgload::load_all(".")

tryCatch(
    {
        plot_reg_map(year = 2022, region = "The Americas")
    },
    error = function(e) {
        print(e)
        traceback()
    }
)
