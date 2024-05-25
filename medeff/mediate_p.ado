*! version 1.0.0  14mar2023

program define mediate_p

        version 18

        if ("`e(cmd)'" != "mediate") {
                di as err "{help mediate##|_new:mediate} estimation " ///
                          "results not found"
                exit 301
        }

        syntax anything(name=vlist id="varlist") 	///
                        [if] [in] ,     		///
                        [                               ///
                        ite                             ///
                        dte                             ///
                        itec                            ///
                        dtet                            ///
                        tte                             ///
                        nie                             ///
                        nde                             ///
                        te                              ///
                        pnie                            ///
                        tnde                            ///
                        CMean                           ///
                        xb                              ///
                        medxb                           ///
                        mu                              ///
                        medmu                           ///
                        POlevels(string)                ///
                        TLevel(string)                  ///
                        ]

        marksample touse

        tempname b V bvec be bb
        mat `b' = e(b)
        local yvar   `"`e(ovar)'"'
        local mvar   `"`e(mvar)'"'
        local ecoleq `"`ecoleq'"'
        local ecolna `"`ecolna'"'
        local neff   = e(neqeff)
        mat `be'     = `b'[1,1..`neff']
        mat `bb'     = `b'[1,`=`neff'+1'...]
        mata : _cma_mreorder("`mvar'","`yvar'","`bb'",0)
        mat `bvec'   = `bb',`be'

        local tlevels `"`e(tlevels)'"'
        local dtype   `"`e(tvartype)'"'
        local k       `"`e(k_levels)'"'
        local base    `"`e(control)'"'
        local mvar    `"`e(mvar)'"'
        local tvar    `"`e(tvar)'"'
        local ymodel  `"`e(omodel)'"'
        local mmodel  `"`e(mmodel)'"'
        local mterms  `"`e(mterms)'"'
        local sig2    `"`e(sig2)'"'
        local npearl  `"`e(npearl)'"'
        local tlevspec `tlevel'

        // parse effects
        if ("`tte'" != "" & "`te'" == "") local tte te
        local eff1 `ite' `dte' `tte' `itec' `dtet'
        local eff2 `nie' `nde' `te' `pnie' `tnde'
        opts_exclusive "`eff1' `eff2' `cmean' `xb' `medxb' `mu' `medmu'"

        if ("`eff1'" != "")  local eff1 a`eff1'
        if ("`cmean'" != "") local pom pomeans

        local xbmu `xb'`medxb'`mu'`medmu'

        // cmean default
        if ("`cmean'" != "" & "`polevels'" == "") {
                local 0 `vlist'
                cap syntax newvarname
                local varn : copy local varlist
                local nvar : list sizeof varn
                if (`nvar' == 1) {
                        local c = e(control)
                        local polevels `c',`c'
                }
        }

        if ("`tlevspec'" != "" & "`cmean'`xb'`medxb'`mu'`medmu'" != "" ) {
                di as err                                               ///
                "{p}option {bf:tlevel()} allowed only with "            ///
                "effect statistics{p_end}"
                exit 198
        }
        if ("`polevels'" != "") {
                if ("`cmean'" == "") {
                        di as err                                       ///
                        "{p}option {bf:polevels()} allowed only with "  ///
                        "statistic {bf:cmean}{p_end}"
                        exit 198
                }
                local ee 0
                parse "`polevels'", parse(",")
                if (`"`4'"' != "" | `"`3'"' == "" | `"`2'"' == "") local ee 1
                local t_y `"`1'"'
                local t_m `"`3'"'
                local nty : list sizeof t_y
                local ntm : list sizeof t_m
                if (`nty' > 1 | `ntm' > 1) local ee 1
                if `ee' {
                        di as err                                       ///
                        "{p}option {bf:polevels()} incorrectly "        ///
                        "specified{p_end}"
                        di as err                                       ///
                        "{p 4 4 2}Specification must be of the "        ///
                        "form {bf:polevels(t,t')} for potential "       ///
                        "outcome Y[t,M(t')].{p_end}"
                        exit 198
                }
                cap confirm number `t_y'
                local rc1 = _rc
                cap confirm number `t_m'
                local rc2 = _rc
                if (`rc1' | `rc2') {
                        di as err                                       ///
                        "{p}option {bf:polevels()} incorrectly "        ///
                        "specified; levels must be numeric{p_end}"
                        exit 198
                }
                local t_y = `t_y'
                local t_m = `t_m'
                if ("`dtype'" != "continuous") {
                        local intly : list t_y in tlevels
                        local intlm : list t_m in tlevels
                        if !(`intly' & `intlm') {
                                local sintl = `intly'+`intlm'
                                if (`sintl' < 1) local s s
                                di as err                                ///
                                "{p}option {bf:polevels()} incorrectly " ///
                                "specified, treatment level`s' not "     ///
                                "found{p_end}"
                                exit 198
                        }
                }
                else {
                        local tlevels `t_y' `t_m'
                }
        }

        local effects `eff1' `eff2' `pom'
        if ("`effects'" == "" & "`xbmu'" == "")  {
                if ("`cmean'" != "") {
                        local effects pomeans
                }
                else {
                        if   `npearl' {
                                local effects nie
                                local dopn 1
                                local dmsg1 "option {bf:nie} assumed;"
                                local dmsg2 "natural indirect effect"
                        }
                        else {
                                local effects aite
                                local dopn 0
                                local dmsg1 "option {bf:ite} assumed;"
                                local dmsg2 "indirect treatment effect"
                        }
                        di as txt "(`dmsg1' `dmsg2')"
                }
        }
        tempname medidx pomidx
        _cma_effects, tvar(`tvar') tlevels(`tlevels') `pearlterms' `effects'
        local statstok   `"`r(statstok)'"'
        local statslis   `"`r(statslis)'"'
        local pearlterms `"`r(pearlterms)'"'
        mat `medidx' = r(medidx)
        mat `pomidx' = r(pomidx)

        // PO variables
        if ("`xbmu'" == "") {

                if ("`dtype'" == "continuous") {
                        if ("`tlevspec'" != "") {
                                cap confirm number `tlevspec'
                                if _rc {
                                        di as err                            ///
                                        "{p}{bf:tlevel()} must be a single " ///
                                        "numeric value{p_end}"
                                        exit 198
                                }
                                local tlevels `base' `tlevspec'
                                local k 2
                        }
                        local f 0
                        foreach i of local tlevels {
                                local tlevlab `tlevlab' `f'
                                local ++f
                        }
                }
                else {
                        local tlevlab `tlevels'
                }

                if ("`polevels'" != "" & "`dtype'" == "multivalued") {
                        local pol `t_y' `t_m'
                        local ipo : list base in pol
                        if (!`ipo' & "`t_y'" != "`t_m'") {
                                di as err                                 ///
                                "{p}specification of potential outcome "  ///
                                "Y[`t_y',M(`t_m')] not allowed{p_end}"
                                exit 198
                        }
                }

                local q 1 // col idx (M)
                foreach p of local tlevlab { // t prime
                        local z 1 // row idx (Y)
                        foreach t of local tlevlab { // t
                                if `pomidx'[`z',`q'] {
                                        tempvar y`t'm`p'
                                        local pomvars `pomvars' `y`t'm`p''
                                }
                                local ++z
                        }
                        local ++q
                }

                tempvar tvartmp mvartmp
                qui clonevar `tvartmp' = `tvar' if `touse'
                qui clonevar `mvartmp' = `mvar' if `touse'
                _cma_mkbtmp `tvar', tempvar(`tvartmp') b(`bvec')
                _cma_mkbtmp `mvar', tempvar(`mvartmp') b(`bvec')
                if ("`mterms'" != "") {
                        _cma_mkbtmp `tvar', tempvar(`tvartmp') colnames(`mterms')
                        local mtermstmp `"`s(tnames)'"'
                        _cma_mkbtmp `mvar', tempvar(`mvartmp') colnames(`mtermstmp')
                        local mtermstmp `"`s(tnames)'"'
                }

                _cma_poms if `touse',   mmodel(`mmodel')        ///
                                        ymodel(`ymodel')        ///
                                        mvar(`mvartmp')         ///
                                        tvar(`tvartmp')         ///
                                        bvec(`bvec')            ///
                                        pomvars(`pomvars')      ///
                                        sig2(`sig2')            ///
                                        mterms(`mtermstmp')     ///
                                        tlevels(`tlevels')      ///
                                        medidx(`medidx')        ///
                                        pomidx(`pomidx')
        }

        if ("`cmean'" != "") {

                local npom : list sizeof pomvars
                _stubstar2names `vlist', nvars(`npom') singleok noverify
                local varlist `"`s(varlist)'"'
                local typlist `"`s(typlist)'"'

                if ("`polevels'" == "") {
                        local nsc: word count `varlist'
                        if (`nsc' != `npom') {
                                di as err                               ///
                                "{p}need 1 or `npom' new variable "     ///
                                "names, or use the {it:stub}{bf:*} "    ///
                                "wildcard syntax{p_end}"
                                exit 198
                        }
                        local typl `typlist'
                        local varl `varlist'
                        local tlevp `tlevels'
                        local q 1 // col idx (M)
                        foreach p of local tlevlab { // t prime
                                local z 1 // row idx (Y)
                                        if ("`dtype'" == "continuous") {
                                        gettoken pp tlevp : tlevp
                                        local tlevt `tlevels'
                                }
                                foreach t of local tlevlab { // t
                                        if ("`dtype'" == "continuous") {
                                                gettoken tt tlevt : tlevt
                                        }
                                        if `pomidx'[`z',`q'] {
                                                gettoken ty typl : typl
                                                gettoken va varl : varl
                                                qui gen `ty' `va' =     ///
                                                `y`t'm`p'' if `touse'
                                                if ("`dtype'" != "continuous") {
                                        lab var `va'                    ///
                                        "Conditional mean, Y[`t',M(`p')]"
                                                }
                                                else {
                                        lab var `va'                    ///
                                        "Conditional mean, Y[`tt',M(`pp')]"
                                                }
                                        }
                                        local ++z
                                }
                                local ++q
                        }
                }
                else {
                        local tyva `typlist' `varlist'
                        if ("`dtype'" == "continuous") {
                                gen `tyva' = `y0m1' if `touse'
                        }
                        else {
                                gen `tyva' = `y`t_y'm`t_m'' if `touse'
                        }
                        lab var `varlist' "Conditional mean, Y[`t_y',M(`t_m')]"
                }
        }

        // Treatment effects
        else if ("`effects'" != "") {

                if ("`eff2'" != "" | `dopn') local pearl pearl

                local k1 = `k'-1
                _stubstar2names `vlist', nvars(`k1') singleok noverify
                local varlist `"`s(varlist)'"'
                local typlist `"`s(typlist)'"'
                local typl    `typlist'
                local varl    `varlist'

                local s 2
                local w `k'
                local nvar : list sizeof varl
                if (`nvar' == 1) {
                        local w 2
                }
                if (`nvar' != 1 & `nvar' != `k1') {
                        if (`k1' != 1) {
                                di as err                                   ///
                                "{p}need `k1' new variable names, or use "  ///
                                "the stub* wildcard syntax{p_end}"
                        }
                        else {
                                di as err                                   ///
                                "{p}need 1 new variable name{p_end}"
                        }
                        exit 198
                }
                if (`"`tlevspec'"' != "") {
                        if (`nvar' > 1) {
                                di as err                                   ///
                                "{p}too many variables specified{p_end}"
                                exit 103
                        }
                        if ("`dtype'" != "continuous") {
                                cap confirm number `tlevspec'
                                if _rc {
                                        _teffects_label2value `tvar',       ///
                                          label(`"`tlevspec'"')
                                        local h = r(value)
                                }
                                else local h `tlevspec'
                                local intl : list h in tlevels
                                if !`intl' {
                                di as err                                   ///
                                `"{p}{bf:tlevel(`tlevspec')} not a level "' ///
                                `"in `tvar'{p_end}"'
                                exit 198
                                }
                                local tlba = `h' == `base'
                                if `tlba' {
                                di as err                                   ///
                                `"{p}{bf:tlevel(`tlevspec')} not a "'       ///
                                `"noncontrol level in `tvar'{p_end}"'
                                exit 198
                                }
                                local w : list posof "`h'" in tlevels
                                local s `w'
                        }
                        else {
                                local s 2
                                local w 2
                        }
                }

                // POM varnames matrix
                tempname pomatm mpomv
                local tlevels `tlevlab'
                mata: _`mpomv'_ = J(`k',`k',"")
                local c 1
                local q 1 // col idx (M)
                foreach p of local tlevels { // t prime
                        local z 1 // row idx (Y)
                        foreach t of local tlevels { // t
                                if `pomidx'[`z',`q'] {
                                        local pov : word `c' of `pomvars'
                                        mata: _`mpomv'_[`z',`q'] = "`pov'"
                                        local ++c
                                }
                                local ++z
                        }
                        local ++q
                }

                if ("`dtype'" == "continuous" & "`tlevspec'" == "") {
                        tempname clevels
                        mat `clevels' = e(clevels)
                }

                // Treatment effects
                local es `effects'
                if (inlist("aite","`es'") | inlist("nie","`es'")) {
                        if ("`pearl'" == "pearl") {
                                local vlabg Natural indirect effect,
                        }
                        else {
                                local vlabg Indirect treatment effect,
                        }
                        forval i = `s'/`w' {
                                mata: st_local("ai", _`mpomv'_[`i',`i'])
                                mata: st_local("ak", _`mpomv'_[`i',1])
                                gettoken ty typl : typl
                                gettoken va varl : varl
                                qui gen `ty' `va' = `ai'-`ak' if `touse'
                                if ("`dtype'" == "continuous") {
                                        if ("`tlevspec'" != "") {
                                                local tlev `tlevspec'
                                        }
                                        else {
                                                local tlev = `clevels'[2,`i']
                                        }
                                }
                                else {
                                        local tlev : word `i' of `tlevels'
                                }
                                lab var `va' "`vlabg' `tvar': `tlev' vs `base'"
                        }
                }
                else if (inlist("adte","`es'") | inlist("nde","`es'")) {
                        if ("`pearl'" == "pearl") {
                                local vlabg Natural direct effect,
                        }
                        else {
                                local vlabg Direct treatment effect,
                        }
                        forval i = `s'/`w' {
                                mata: st_local("ai", _`mpomv'_[`i',1])
                                mata: st_local("ak", _`mpomv'_[1,1])
                                gettoken ty typl : typl
                                gettoken va varl : varl
                                qui gen `ty' `va' = `ai'-`ak' if `touse'
                                if ("`dtype'" == "continuous") {
                                        if ("`tlevspec'" != "") {
                                                local tlev `tlevspec'
                                        }
                                        else {
                                                local tlev = `clevels'[2,`i']
                                        }
                                }
                                else {
                                        local tlev : word `i' of `tlevels'
                                }
                                lab var `va' "`vlabg' `tvar': `tlev' vs `base'"
                        }
                }
                else if (inlist("aitec","`es'") | inlist("pnie","`es'")) {
                        if ("`pearl'" == "pearl") {
                            local vlabg Pure natural indirect effect,
                        }
                        else {
                            local vlabg Indirect treatment effect (controls),
                        }
                        forval i = `s'/`w' {
                                mata: st_local("ai", _`mpomv'_[1,`i'])
                                mata: st_local("ak", _`mpomv'_[1,1])
                                gettoken ty typl : typl
                                gettoken va varl : varl
                                qui gen `ty' `va' = `ai'-`ak' if `touse'
                                if ("`dtype'" == "continuous") {
                                        if ("`tlevspec'" != "") {
                                                local tlev `tlevspec'
                                        }
                                        else {
                                                local tlev = `clevels'[2,`i']
                                        }
                                }
                                else {
                                        local tlev : word `i' of `tlevels'
                                }
                                lab var `va' "`vlabg' `tvar': `tlev' vs `base'"
                        }
                }
                else if (inlist("adtet","`es'") | inlist("tnde","`es'")) {
                        if ("`pearl'" == "pearl") {
                                local vlabg Total natural direct effect,
                        }
                        else {
                                local vlabg Direct treatment effect (treated),
                        }
                        forval i = `s'/`w' {
                                mata: st_local("ai", _`mpomv'_[`i',`i'])
                                mata: st_local("ak", _`mpomv'_[1,`i'])
                                gettoken ty typl : typl
                                gettoken va varl : varl
                                qui gen `ty' `va' = `ai'-`ak' if `touse'
                                if ("`dtype'" == "continuous") {
                                        if ("`tlevspec'" != "") {
                                                local tlev `tlevspec'
                                        }
                                        else {
                                                local tlev = `clevels'[2,`i']
                                        }
                                }
                                else {
                                        local tlev : word `i' of `tlevels'
                                }
                                lab var `va' "`vlabg' `tvar': `tlev' vs `base'"
                        }
                }
                else if (inlist("ate","`es'") | inlist("te","`es'")) {
                        if ("`pearl'" == "pearl") {
                                local vlabg Total effect,
                        }
                        else {
                                local vlabg Total treatment effect,
                        }
                        forval i = `s'/`w' {
                                mata: st_local("ai", _`mpomv'_[`i',`i'])
                                mata: st_local("ak", _`mpomv'_[1,1])
                                gettoken ty typl : typl
                                gettoken va varl : varl
                                qui gen `ty' `va' = `ai'-`ak' if `touse'
                                if ("`dtype'" == "continuous") {
                                        if ("`tlevspec'" != "") {
                                                local tlev `tlevspec'
                                        }
                                        else {
                                                local tlev = `clevels'[2,`i']
                                        }
                                }
                                else {
                                        local tlev : word `i' of `tlevels'
                                }
                                lab var `va' "`vlabg' `tvar': `tlev' vs `base'"
                        }
                }
                cap mata mata drop _`mpomv'_
        }

        // Equation level fitted values
        else if ("`xbmu'" != "") {
                _stubstar2names `vlist', nvars(1)
                local var `"`s(varlist)'"'
                if ("`xb'" != "" | "`mu'" != "") {
                        tempvar xby
                        mat score double `xby' = `bvec' if `touse', equation(#2)
                        if ("`xb'" != "") {
                                qui gen `vlist' = `xby' if `touse'
                                lab var `var' ///
                                  "Linear prediction, outcome equation"
                        }
                }
                else if ("`medxb'" != "" | "`medmu'" != "") {
                        tempvar xbm
                        mat score double `xbm' = `bvec' if `touse', equation(#1)
                        if ("`medxb'" != "") {
                                qui gen `vlist' = `xbm' if `touse'
                                lab var `var' ///
                                  "Linear prediction, mediator equation"
                        }
                }
                if ("`mu'`medmu'" != "") {
                        if      ("`mu'" != "") local model `ymodel'
                        else                   local model `mmodel'
                        if      ("`model'" == "linear")         local F
                        else if ("`model'" == "probit")         local F normal
                        else if ("`model'" == "logit")          local F invlogit
                        else if ("`model'" == "poisson")        local F exp
                        else if ("`model'" == "expmean")        local F exp
                        if ("`mu'" != "") {
                                qui gen `vlist' = `F'(`xby') if `touse'
                                lab var `var' ///
                                  "Expected values, outcome equation"
                        }
                        else {
                                qui gen `vlist' = `F'(`xbm') if `touse'
                                lab var `var' ///
                                  "Expected values, mediator equation"
                        }
                }
        }

end

exit
