{smcl}
{* *! version 1.0.1  27mar2023}{...}
{viewerdialog mediate "dialog mediate"}{...}
{vieweralsosee "[CAUSAL] mediate" "mansection CAUSAL mediate"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[CAUSAL] mediate postestimation" "help mediate postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[CAUSAL] teffects" "help teffects"}{...}
{vieweralsosee "[CAUSAL] teffects ra" "help teffects ra"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem command"}{...}
{viewerjumpto "Syntax" "mediate##syntax"}{...}
{viewerjumpto "Menu" "mediate##menu"}{...}
{viewerjumpto "Description" "mediate##description"}{...}
{viewerjumpto "Links to PDF documentation" "mediate##linkspdf"}{...}
{viewerjumpto "Options" "mediate##options"}{...}
{viewerjumpto "Examples" "mediate##examples"}{...}
{viewerjumpto "Stored results" "mediate##results"}{...}
{p2colset 1 21 23 2}{...}
{p2col:{bf:[CAUSAL] mediate} {hline 2}}Causal mediation analysis{p_end}
{p2col:}({mansection CAUSAL mediate:View complete PDF manual entry}){p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:mediate}
        {cmd:(}{help varlist:{it:ovar}} 
	[{help varlist:{it:omvarlist}}{cmd:,}
        {help mediate##omodel:{it:omodel}}
	{opt nocons:tant}]{cmd:)}
	{cmd:(}{help varlist:{it:mvar}} 
	[{help varlist:{it:mmvarlist}}{cmd:,}
        {help mediate##mmodel:{it:mmodel}}
	{opt nocons:tant}]{cmd:)}
	{cmd:(}{help varlist:{it:tvar}}
	[{cmd:,} {opt cont:inuous(numlist)}]{cmd:)}
	{ifin}
	[{help mediate##weight:{it:weight}}]
	[{cmd:,}
	{help mediate##stat:{it:stat}}
	{help mediate##optstbl:{it:options}}]

{phang}
{it:ovar} is a continuous, binary, or count outcome of interest.{p_end}
{phang}
{it:omvarlist} specifies the covariates in the outcome model.{p_end}
{phang}
{it:mvar} is the mediator variable and may be continuous, binary, or count.
{p_end}
{phang}
{it:mmvarlist} specifies the covariates in the mediator model.{p_end}
{phang}
{it:tvar} is the treatment variable and may be binary, multivalued, or
continuous.

{marker omodel}{...}
{synoptset 25 tabbed}{...}
{synopthdr:omodel}
{synoptline}
{syntab:Model}
{synopt :{opt linear}}linear model; the default{p_end}
{synopt :{opt exp:mean}}exponential-mean model{p_end}
{synopt :{opt logit}}logistic regression model{p_end}
{synopt :{opt probit}}probit regression model{p_end}
{synopt :{opt poisson}}Poisson model{p_end}
{synoptline}
{p 4 6 2}
{it:omodel} specifies the model for the outcome variable.

{marker mmodel}{...}
{synopthdr:mmodel}
{synoptline}
{syntab:Model}
{synopt :{opt linear}}linear model; the default{p_end}
{synopt :{opt exp:mean}}exponential-mean model{p_end}
{synopt :{opt logit}}logistic regression model{p_end}
{synopt :{opt probit}}probit regression model{p_end}
{synopt :{opt poisson}}Poisson model{p_end}
{synoptline}
{p 4 6 2}
{it:mmodel} specifies the model for the mediator variable.{p_end}
{p 4 6 2}
The {cmd:logit} outcome model may not be combined
with the {cmd:linear} or {cmd:expmean} mediator model; 
{cmd:probit} rather than {cmd:logit} may be used in these cases.

{marker stat}{...}
{synopthdr:stat}
{synoptline}
{syntab:Stat}
      {it:Pearl's labeling of effects}
{synopt :{opt nie}}natural indirect effect{p_end}
{synopt :{opt nde}}natural direct effect{p_end}
{synopt :{opt te}}total effect{p_end}
{synopt :{opt pnie}}pure natural indirect effect{p_end}
{synopt :{opt tnde}}total natural direct effect{p_end}

      {it:ATE labeling of effects}
{synopt :{opt aite}}average indirect treatment effect; synonym for {cmd:nie}{p_end}
{synopt :{opt adte}}average direct treatment effect; synonym for {cmd:nde}{p_end}
{synopt :{opt ate}}total average treatment effect; synonym for {cmd:te}{p_end}
{synopt :{opt aitec}}average indirect treatment effect with respect to controls; synonym for {cmd:pnie}{p_end}
{synopt :{opt adtet}}average direct treatment effect with respect to the treated; synonym for {cmd:tnde}{p_end}

{synopt :{opt pom:eans}}potential-outcome means{p_end}
{synopt :{opt all}}all effects and potential-outcome means{p_end}
{synoptline}
{p 4 6 2}
Multiple effects may be specified; default is {cmd:nie} {cmd:nde} {cmd:te}. 

{marker optstbl}{...}
{synopthdr:options}
{synoptline}
{syntab:Model}
{synopt :{opt nointer:action}}exclude interaction of mediator and treatment{p_end}
{synopt :{opt con:trol(# | label)}}specify the level of {it:tvar} that is the control; default is first treatment level{p_end}

{syntab:SE/Robust}
{synopt :{opth vce:(vcetype)}}{it:vcetype} may be {opt r:obust}, 
	{opt cl:uster} {it:clustvar}, 
	{opt boot:strap}, or {opt jack:knife}{p_end}
{synopt :{opt nose}}do not estimate standard errors{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt ateterms}}use ATE terminology to label effects{p_end}
{synopt :{opt aeq:uations}}display auxiliary-equation results{p_end}
{synopt :{opt nolegend}}suppress table legend{p_end}
{synopt :{it:{help mediate##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Optimization}
{synopt :{help mediate##optopts:{it:optimization_options}}}control the 
optimization process; seldom used{p_end}

{syntab:Advanced}
{synopt :{cmd:force}}force estimation when the number of treatment groups exceeds 10{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p 4 6 2}
{it:omvarlist} and {it:mmvarlist} may contain
factor variables; see {help fvvarlist}.{p_end}
{p 4 6 2}
{cmd:bootstrap}, {cmd:by}, {cmd:collect}, {cmd:jackknife}, and {cmd:statsby}
are allowed; see {help prefix}.{p_end}
{p 4 6 2}
Weights are not allowed with the bootstrap prefix; see {manhelp bootstrap R}.
{p_end}
{marker weight}{...}
{p 4 6 2}
{cmd:pweight}s, {cmd:fweight}s, and {cmd:iweight}s are allowed; see
{help weight}.{p_end}
{p 4 6 2}
{cmd:coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp mediate_postestimation CAUSAL:mediate postestimation} for
features available after estimation.


{marker menu}{...}
{title:Menu}

{phang}
{bf:Statistics > Causal inference/treatment effects > Continuous outcomes > Causal mediation}

{phang}
{bf:Statistics > Causal inference/treatment effects > Binary outcomes > Causal mediation}

{phang}
{bf:Statistics > Causal inference/treatment effects > Count outcomes > Causal mediation}

{phang}
{bf:Statistics > Causal inference/treatment effects > Nonnegative outcomes > Causal mediation}


{marker description}{...}
{title:Description}

{pstd}
{cmd:mediate} fits causal mediation models and estimates effects of a treatment
on an outcome.  The treatment effect can occur both directly and indirectly
through another variable, a mediator.  The outcome and mediator variables may
be continuous, binary, or count.  The treatment may be binary, multivalued, or
continuous. The estimated direct, indirect, and total effects have a causal
interpretation provided that assumptions pertaining to causal mediation models
are met.


{marker linkspdf}{...}
{title:Links to PDF documentation}

        {mansection CAUSAL mediateQuickstart:Quick start}

        {mansection CAUSAL mediateRemarksandexamples:Remarks and examples}

        {mansection CAUSAL mediateMethodsandformulas:Methods and formulas}

{pstd}
The above sections are not included in this help file.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}; see {helpb estimation options:[R] Estimation options}.

{phang}
{opt continuous(numlist)} specifies that the treatment variable is
continuous; {it:numlist} specifies the values at which the 
potential-outcome means are to be evaluated, where the first value in the list
is taken as the control.

{phang}
{opt nointeraction} excludes the interaction between the treatment and the
mediator; by default, the model includes the treatment-mediator interaction.

{phang}
{opt control(# | label)} specifies the level of {it:tvar} that is the control.
The default is the first treatment level.  You may specify the numeric level
{it:#} (a nonnegative integer) or the label associated with the numeric level.
{cmd:control()} may not be specified with continuous treatments.

{dlgtab:Stat}

{phang}
{it:stat} specifies the statistics to be estimated.  You may select from among
five effects, each of which can be labeled according to terminology used by
Pearl and others or by ATE terminology.  In addition to effects, you may
request that potential-outcome means be reported.  The default is {cmd:nie}
{cmd:nde} {cmd:te}.

{pmore}
{it:stat} may be one or more of the following:

{p2colset 16 27 29 6}{...}
{synopt:{it:stat}}Description{p_end}
{p2line}
{synopt:{opt nie}}natural indirect effect{p_end}
{synopt:{opt nde}}natural direct effect{p_end}
{synopt:{opt te}}total effect{p_end}
{synopt:{opt pnie}}pure natural indirect effect{p_end}
{synopt:{opt tnde}}total natural direct effect{p_end}
{synopt:{opt aite}}average indirect treatment effect; synonym for {cmd:nie}{p_end}
{synopt:{opt adte}}average direct treatment effect; synonym for {cmd:nde}{p_end}
{synopt:{opt ate}}average treatment effect; synonym for {cmd:te}{p_end}
{synopt:{opt aitec}}average indirect treatment effect with respect to controls; synonym for {cmd:pnie}{p_end}
{synopt:{opt adtet}}average direct treatment effect with respect to the treated; synonym for {cmd:tnde}{p_end}
{synopt:{opt pomeans}}potential-outcome means{p_end}
{p2colreset}{...}

{phang2}
{cmd:all} specifies that all effects and potential-outcome means be estimated;
specifying {cmd:all} is equivalent to specifying 
{cmd:nie} {cmd:nde} {cmd:te} {cmd:pnie} {cmd:tnde} {cmd:pomeans}.
When option {cmd:ateterms} is specified, {cmd:all} is equivalent to specifying
{cmd:aite} {cmd:adte} {cmd:ate} {cmd:aitec} {cmd:adtet} {cmd:pomeans}.

{dlgtab:SE/Robust}

INCLUDE help vce_rcbj

{phang}
{opt nose} suppresses calculation of the variance-covariance matrix and
standard errors.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options:[R] Estimation options}.

{phang}
{opt ateterms} specifies that ATE terminology be used to label effects.
{cmd:ateterms} is strictly a labeling option.  This option may not be
specified on replay.

{phang}
{opt aequations} specifies that the estimation results for the outcome model
and the mediator model be displayed.  By default, they are not displayed.

{phang}
{opt nolegend} suppresses the display of the table legend.

{marker display_options}{...}
INCLUDE help displayopts_list

{dlgtab:Optimization}

{marker optopts}{...}
{phang}
{it:optimization_options}: {opt conv_maxiter()},
{opt conv_ptol()},
{opt conv_vtol()},
{opt tracelevel()}, and
[{opt no}]{cmd:log}.  See
{helpb mf_optimize:[M-5] optimize()}.

{phang2}
{opt conv_maxiter(#)} specifies the maximum number of iterations.
The default is the number set using
{helpb set maxiter}, which by default is 300.

{phang2}
{opt conv_ptol(#)} specifies the convergence criteria
for the parameters. The default is {cmd:conv_ptol(1e-6)}.

{phang2}
{opt conv_vtol(#)} specifies the convergence criteria 
for the gradient.  The default is {cmd:conv_vtol(1e-7)}.

{phang2}
{opt tracelevel(tracelevel)} allows you to display additional information
about the iterative process in the iteration log.   {it:tracelevel} may be
{cmd:none}, {cmd:value}, {cmd:tolerance}, {cmd:step}, {cmd:params}, or
{cmd:gradient}.  See {help mf_optimize##tracelevel:{it:tracelevel}} in
{helpb mf_optimize:[M-5] optimize()}.

{phang2}
INCLUDE help lognolog

{dlgtab:Advanced}

{phang}
{opt force} forces estimation when the number of treatment groups exceeds 10.
By default, only 10 groups are allowed for multivalued treatments.  Do not use
the {cmd:force} option if the treatment is continuous; instead, use the
{cmd:continuous()} option.

{pstd}
The following option is available with {opt mediate} but is not shown
in the dialog box:

{phang}
{opt coeflegend}; see {helpb estimation options:[R] Estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse birthweight}

{pstd}Estimate natural direct effect, natural indirect effect,
and total effect using a linear model for both the
outcome and mediator variable{p_end}
{phang2}{cmd:. mediate (bweight age) (ncigs sespar age) (college)}

{pstd}Estimate all effects and potential-outcome means
{p_end}
{phang2}{cmd:. mediate (bweight age) (ncigs sespar age) (college), all}

{pstd}Estimate the natural direct effect, natural indirect effect,
and total effect, using a logit
model for the binary outcome and a Poisson model for the count mediator
variable{p_end}
{phang2}{cmd:. mediate (lbweight age, logit) (ncigs sespar age, poisson)}
        {cmd:(college)}

{pstd}Refit the above model but estimate potential-outcome means and display
results for the auxiliary equations{p_end}
{phang2}{cmd:. mediate (lbweight age, logit) (ncigs sespar age, poisson)}
        {cmd:(college), pomeans aequations}

{pstd}Estimate treatment effects using a continuous treatment variable,
setting the value 8 as the control level and values 4 and 12 as the
treatment levels{p_end}
{phang2}{cmd:. mediate (lbweight age, logit) (ncigs age sespar, poisson)}
        {cmd:(ses, continuous(8 4 12))}

{pstd}Same as above, but without the interaction between the treatment and mediator{p_end}
{phang2}{cmd:. mediate (lbweight age, logit) (ncigs age sespar, poisson)}
        {cmd:(ses, continuous(8 4 12)), nointeraction}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:mediate} stores the following in {cmd:e()}:

{synoptset 23 tabbed}{...}
{p2col 5 23 26 2: Scalars}{p_end}
{synopt :{cmd:e(N)}}number of observations{p_end}
{synopt :{cmd:e(N_clust)}}number of clusters{p_end}
{synopt :{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt :{cmd:e(k_levels)}}number of levels in treatment variable{p_end}
{synopt :{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt :{cmd:e(interact)}}{cmd:1} if treatment-mediator interaction included, {cmd:0} otherwise{p_end}
{synopt :{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{p2col 5 23 26 2: Macros}{p_end}
{synopt :{cmd:e(cmd)}}{cmd:mediate}{p_end}
{synopt :{cmd:e(cmdline)}}command as typed{p_end}
{synopt :{cmd:e(depvar)}}name of outcome variable{p_end}
{synopt :{cmd:e(mvar)}}name of mediator variable{p_end}
{synopt :{cmd:e(tvar)}}name of treatment variable{p_end}
{synopt :{cmd:e(omodel)}}{cmd:linear}, {cmd:logit}, {cmd:probit}, {cmd:poisson},
        or {cmd:expmean}{p_end}
{synopt :{cmd:e(mmodel)}}{cmd:linear}, {cmd:logit}, {cmd:probit}, {cmd:poisson},
        or {cmd:expmean}{p_end}
{synopt :{cmd:e(wtype)}}weight type{p_end}
{synopt :{cmd:e(wexp)}}weight expression{p_end}
{synopt :{cmd:e(title)}}title in estimation output{p_end}
{synopt :{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt :{cmd:e(tlevels)}}levels of treatment variable{p_end}
{synopt :{cmd:e(tvartype)}}{cmd:binary}, {cmd:multivalued}, or {cmd:continuous}{p_end}
{synopt :{cmd:e(control)}}control level{p_end}
{synopt :{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt :{cmd:e(vcetype)}}title used to label Std. err.{p_end}
{synopt :{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt :{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt :{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt :{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}

{p2col 5 23 26 2: Matrices}{p_end}
{synopt :{cmd:e(b)}}coefficient vector{p_end}
{synopt :{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{p2col 5 23 26 2: Functions}{p_end}
{synopt :{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

INCLUDE help rtable
