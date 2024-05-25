*! version 1.0.0  16feb2023

program define mediate_estat

        version 18

        if ("`e(cmd)'" != "mediate") {
                di as err "{help mediate##_new:mediate} estimation " ///
                 "results not found"
                exit 301
        }
        gettoken sub opts : 0, parse(" ,")
        local lsub = length("`sub'")
        if      ("`sub'" == "vce") {
                estat_default `0'
        }
        else if ("`sub'" == "bootstrap") {
                estat_default `0'
        }
        else if ("`sub'" == bsubstr("summarize",1,max(2,`lsub'))) {
                _cma_estat_summarize `opts'
        }
        else if ("`sub'" == bsubstr("proportions",1,max(4,`lsub'))) {
                _cma_estat_propmed `opts'
        }
        else if ("`sub'" == bsubstr("effectplot", 1,max(7,`lsub')) | ///
                 "`sub'" == bsubstr("effectsplot",1,max(8,`lsub'))) {
                _cma_estat_effectplot `opts'
        }
        else if ("`sub'" == "cde") {
                _cma_estat_cde `opts'
        }
        else if (inlist("`sub'","rd","rr","or","irr")) {
                _cma_estat_transf `sub' `opts'
        }
        else {
                di as err "{bf:estat `sub'} is not allowed"
                exit 321
        }

end

exit
