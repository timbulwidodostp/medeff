*! version 1.0.0  15mar2022

program define mediate, eclass byable(onecall)

        version 18

        if _by() {
                local BY `"by `_byvars'`_byrc0':"'
        }

        `BY' _cma_mediate `0'

        if !replay() {
                ereturn local cmdline `"mediate `0'"'
        }

end

exit
