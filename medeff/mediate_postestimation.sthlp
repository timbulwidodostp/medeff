{smcl}
{* *! version 1.0.1  27mar2023}{...}
{viewerdialog "predict" "dialog mediate_p"}{...}
{viewerdialog "estat" "dialog mediate_estat"}{...}
{* estat or, ir, irr are only listed when relevant so only -estat- listed and not individual dbs *}{...}
{vieweralsosee "[CAUSAL] mediate postestimation" "mansection CAUSAL mediatepostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[CAUSAL] mediate" "help mediate"}{...}
{viewerjumpto "Postestimation commands" "mediate postestimation##description"}{...}
{viewerjumpto "Links to PDF documentation" "mediate postestimation##linkspdf"}{...}
{viewerjumpto "predict" "mediate postestimation##syntax_predict"}{...}
{viewerjumpto "estat" "mediate postestimation##syntax_estat"}{...}
{viewerjumpto "Examples" "mediate postestimation##examples"}{...}
{viewerjumpto "Stored results" "mediate postestimation##results"}{...}
{p2colset 1 36 38 2}{...}
{p2col:{bf:[CAUSAL] mediate postestimation} {hline 2}}Postestimation tools for
mediate{p_end}
{p2col:}({mansection CAUSAL mediatepostestimation:View complete PDF manual entry}){p_end}
{p2colreset}{...}


{marker description}{...}
{title:Postestimation commands}

{pstd}
The following postestimation commands are of special interest after
{cmd:mediate}:

{synoptset 17}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb mediate postestimation##estat:estat proportion}}proportion mediated{p_end}
{synopt :{helpb mediate postestimation##estat:estat cde}}controlled direct effects{p_end}
{synopt :{helpb mediate postestimation##estat:estat or}}effects on the odds-ratio scale{p_end}
{synopt :{helpb mediate postestimation##estat:estat rr}}effects on the risk-ratio scale{p_end}
{synopt :{helpb mediate postestimation##estat:estat irr}}effects on the incidence-rate-ratio scale{p_end}
{synopt :{helpb mediate postestimation##estat:estat effectsplot}}effects plot{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset 17}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_estatsum
INCLUDE help post_estatvce
INCLUDE help post_estimates
INCLUDE help post_etable
INCLUDE help post_lincom
INCLUDE help post_nlcom
{synopt :{helpb mediate postestimation##predict:predict}}{findalias p_mediate}{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker linkspdf}{...}
{title:Links to PDF documentation}

        {mansection CAUSAL mediatepostestimationRemarksandexamples:Remarks and examples}

{pstd}
The above sections are not included in this help file.


{marker syntax_predict}{...}
{marker predict}{...}
{title:predict}

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:{help newvarlist##stub*:stub}}{cmd:*} | {it:{help newvar}} | {it:{help newvarlist}}{c )-}
{ifin}
[{cmd:,}
{help mediate postestimation##effect_statistic:{it:effect_statistic}}
{opt tl:evel(treat_level)}]


{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:{help newvarlist##stub*:stub}}{cmd:*} | {it:{help newvar}} | {it:{help newvarlist}}{c )-}
{ifin} 
[{cmd:,}
{help mediate postestimation##po_statistic:{it:po_statistic}}
{opt po:levels(t, t')}]


{p 8 16 2}
{cmd:predict}
{dtype}
{it:{help newvar}}
{ifin} 
[{cmd:,} {help mediate postestimation##fitted_statistic:{it:fitted_statistic}}]


{marker effect_statistic}{...}
{synoptset 25 tabbed}{...}
{synopthdr:effect_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt nie}}natural indirect effect; the default{p_end}
{synopt :{opt nde}}natural direct effect{p_end}
{synopt :{opt te}}total effect{p_end}
{synopt :{opt pnie}}pure natural indirect effect{p_end}
{synopt :{opt tnde}}total natural direct effect{p_end}
{synopt :{opt ite}}indirect treatment effect; synonym for {opt nie}{p_end}
{synopt :{opt dte}}direct treatment effect; synonym for {opt nde}{p_end}
{synopt :{opt tte}}total treatment effect; synonym for {opt te}{p_end}
{synopt :{opt itec}}indirect treatment effect with respect to controls; synonym for {opt pnie}{p_end}
{synopt :{opt dtet}}direct treatment effect with respect to the treated; synonym for {opt tnde}{p_end}
{synoptline}

{marker po_statistic}{...}
{synopthdr:po_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt cmean}}conditional mean at treatment levels{p_end}
{synoptline}

{marker fitted_statistic}{...}
{synopthdr:fitted_statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction for outcome model{p_end}
{synopt :{opt medxb}}linear prediction for mediator model{p_end}
{synopt :{opt mu}}expected values for outcome model{p_end}
{synopt :{opt medmu}}expected values for mediator model{p_end}
{synoptline}
{p2colreset}{...}

{p 4 6 2}
If you do not specify {cmd:tlevel()} and only specify one new variable, then
{it:effect_statistic}s assume {cmd:tlevel()} specifies the first noncontrol
treatment level. You specify one or t - 1 new variables with
{it:effect_statistic}, where t is the number of treatment levels.

{p 4 6 2}
If you do not specify {cmd:polevels()} and only specify one new variable, then
{opt polevels(c, c)} is assumed, where {it:c} is the control group. You
specify one or {it:d} new variables with {cmd:cmean}, where {it:d} is the
number of potential outcomes.

{phang}
You specify one new variable with {it:fitted_statistic}.


INCLUDE help menu_predict


{marker des_predict}{...}
{title:Description for predict}

{pstd}
{cmd:predict} creates a new variable (or variables) containing predictions
such as treatment effects, conditional means, linear predictions, and expected
values.


{marker opts_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{cmd:nie}, the default, calculates the natural indirect effect for each
noncontrol treatment level or for the treatment level specified in
{cmd:tlevel()}.  If you specify the {cmd:tlevel()} option, you must specify
only one new variable; otherwise, you must specify a new variable for each
treatment level (except the control level).

{phang}
{cmd:nde} calculates the natural direct effect for each noncontrol treatment
level or for the treatment level specified in {cmd:tlevel()}.  If you specify
the {cmd:tlevel()} option, you must specify only one new variable; otherwise,
you must specify a new variable for each treatment level (except the control
level).

{phang}
{cmd:te} calculates the total effect for each noncontrol treatment level or
for the treatment level specified in {cmd:tlevel()}.  If you specify the
{cmd:tlevel()} option, you must specify only one new variable; otherwise, you
must specify a new variable for each treatment level (except the control
level).

{phang}
{cmd:pnie} calculates the pure natural indirect effect
for each noncontrol treatment level or for the treatment level specified in 
{cmd:tlevel()}. If you specify the {cmd:tlevel()} option, you must specify 
only one new variable; otherwise, you must specify a new variable for each 
treatment level (except the control level).

{phang}
{cmd:tnde} calculates the total natural direct effect for each noncontrol
treatment level or for the treatment level specified in {cmd:tlevel()}. If you
specify the {cmd:tlevel()} option, you must specify only one new variable;
otherwise, you must specify a new variable for each treatment level (except
the control level).

{phang}
{opt ite} calculates the indirect treatment effect for each noncontrol
treatment level or for the treatment level specified in {cmd:tlevel()}.  If
you specify the {cmd:tlevel()} option, you must specify only one new variable;
otherwise, you must specify a new variable for each treatment level (except
the control level).

{phang}
{cmd:dte} calculates the direct treatment effect for each noncontrol treatment
level or for the treatment level specified in {cmd:tlevel()}.  If you specify
the {cmd:tlevel()} option, you must specify only one new variable; otherwise,
you must specify a new variable for each treatment level (except the control
level).

{phang}
{cmd:tte} calculates the total treatment effect for each noncontrol treatment
level or for the treatment level specified in {cmd:tlevel()}.  If you specify
the {cmd:tlevel()} option, you must specify only one new variable; otherwise,
you must specify a new variable for each treatment level (except the control
level).

{phang}
{cmd:itec} calculates the indirect treatment effect with respect to controls
for each noncontrol treatment level or for the treatment level specified in 
{cmd:tlevel()}. If you specify the {cmd:tlevel()} option, you must specify 
only one new variable; otherwise, you must specify a new variable for each 
treatment level (except the control level).

{phang}
{cmd:dtet} calculates the direct treatment effect with respect to the treated
for each noncontrol treatment level or for the treatment level specified in 
{cmd:tlevel()}. If you specify the {cmd:tlevel()} option, you must specify 
only one new variable; otherwise, you must specify a new variable for each 
treatment level (except the control level).

{phang}
{opt tlevel(treat_level)} specifies the treatment level for prediction.

{phang}
{cmd:cmean} calculates the conditional mean for each potential outcome
Y(t, M(t')) or the potential outcome specified in {cmd:polevels()}. 
If you specify the {cmd:polevels()} option, you must specify only one new 
variable; otherwise, you must specify a new variable for each potential
outcome. 

{phang}
{opt polevels(t, t')} specifies the values of the treatment for which
potential outcomes are to be calculated. The first value, {it:t}, refers to
the value that the treatment is set to in the outcome equation; the second
value, {it:t}', refers to the value of the treatment in the mediator equation.

{phang}
{cmd:xb} calculates the linear prediction for the outcome model.

{phang}
{cmd:medxb} calculates the linear prediction for the mediator model.

{phang}
{cmd:mu} calculates the expected values of the dependent variable of
the outcome model.

{phang}
{cmd:medmu} calculates the expected values of the dependent variable
of the mediator model.


{marker syntax_estat}{...}
{marker estat}{...}
{title:estat}

{pstd}
Proportion mediated

{p 8 16 2}
{cmd:estat} {cmdab:prop:ortion}
[{cmd:,}
{help mediate postestimation##prop_options:{it:prop_options}}]


{pstd}
Controlled direct effects

{p 8 16 2}
{cmd:estat cde,}
{opt mvalue(numlist)}
[{help mediate postestimation##cde_options:{it:cde_options}}]


{pstd}
Effects on the odds-ratio scale

{p 8 16 2}
{cmd:estat or}
[{cmd:,}
{help mediate_postestimation##scale_options:{it:scale_options}}]


{pstd}
Effects on the risk-ratio scale

{p 8 16 2}
{cmd:estat rr}
[{cmd:,}
{help mediate_postestimation##scale_options:{it:scale_options}}]


{pstd}
Effects on the incidence-rate-ratio scale

{p 8 16 2}
{cmd:estat irr}
[{cmd:,}
{help mediate_postestimation##scale_options:{it:scale_options}}]


{pstd}
Effects plot

{p 8 16 2}
{cmd:estat} {cmdab:effectsp:lot}
[{cmd:,}
{help mediate postestimation##effectsplot_options:{it:effectsplot_options}}]


{marker prop_options}{...}
{synoptset 25}{...}
{synopthdr:prop_options}
{synoptline}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt perc:ent}}display percentage instead of proportion{p_end}
{synopt :{opt force}}force calculations to proceed in case of conflicting signs{p_end}
{synopt :{opt noleg:end}}suppress table legend{p_end}
{synopt :{it:{help mediate_postestimation##prop_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall
{synoptline}

{marker cde_options}{...}
{synoptset 25 tabbed}{...}
{synopthdr:cde_options}
{synoptline}
{p2coldent :* {opt mvalue(numlist)}}value of the mediator variable{p_end}
{synopt :{opt rr}}controlled direct effect on risk-ratio scale{p_end}
{synopt :{opt or}}controlled direct effect on odds-ratio scale{p_end}
{synopt :{opt irr}}controlled direct effect on incidence-rate-ratio scale{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt contr:ast}}differences of controlled direct effects{p_end}
{synopt :{opt noleg:end}}suppress table legend{p_end}
{synopt :{opt atmeans}}controlled direct effect at the means of covariates{p_end}
{synopt :{it:{help mediate_postestimation##cde_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall
{synoptline}
{p 4 6 2}
* {opt mvalue(numlist)} is required.

{marker scale_options}{...}
{synoptset 25}{...}
{synopthdr:scale_options}
{synoptline}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt noleg:end}}suppress table legend{p_end}
{synopt :{it:{help mediate_postestimation##scale_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall
{synoptline}
{p 4 6 2}
{cmd:estat or}, {cmd:estat rr}, and {cmd:estat irr}
require estimation of potential-outcome means with {cmd:mediate}.{p_end}
{p 4 6 2}
If no potential-outcome means were estimated, {cmd:estat or}, {cmd:estat rr},
and {cmd:estat irr} will refit the model in the background; the reestimation
does not affect the results, but computation takes longer.

{marker effectsplot_options}{...}
{synoptset 25 tabbed}{...}
{synopthdr:effectsplot_options}
{synoptline}
    {it:When} {cmd:mediate} {it:had Pearl's labeling of effects}
{synopt :{cmd:nie}}plot natural indirect effects{p_end}
{synopt :{cmd:nde}}plot natural direct effects{p_end}
{synopt :{cmd:te}}plot total effects{p_end}
{synopt :{cmd:pnie}}plot pure natural indirect effects{p_end}
{synopt :{cmd:tnde}}plot total natural direct effects{p_end}

    {it:When} {cmd:mediate} {it:had ATE labeling of effects}
{synopt :{cmd:aite}}plot average indirect treatment effects{p_end}
{synopt :{cmd:adte}}plot average direct treatment effects{p_end}
{synopt :{cmd:ate}}plot average treatment effects{p_end}
{synopt :{cmd:aitec}}plot average indirect treatment effects with respect to controls{p_end}
{synopt :{cmd:adtet}}plot average direct treatment effects with respect to the treated{p_end}

{syntab:Main}
{synopt :{cmd:noci}}do not plot confidence intervals{p_end}

{syntab:Plot}
{synopt :{help mediate postestimation##plotopts:{it:plot_options}}}affect rendition of all effect plots{p_end}
{synopt :{cmdab:plot:}{it:{ul:#}}{cmd:opts(}{help mediate postestimation##plotopts:{it:plot_options}}{cmd:)}}affect rendition of {it:#}th effect plot{p_end}
{synopt :{opth recast:(graph_twoway:plottype)}}plot effects using {it:plottype}{p_end}

{syntab:CI plot}
{synopt :{opth ciop:ts(rcap_options:rcap_options)}}affect rendition of confidence intervals{p_end}
{synopt :{cmdab:ci:}{it:{ul:#}}{cmd:opts(}{it:{help rcap_options}}{cmd:)}}affect rendition of {it:#}th confidence interval plot{p_end}
{synopt :{opth recastci:(graph_twoway:plottype)}}plot confidence intervals using {it:plottype}{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}

{syntab:Add plots}
{synopt :{opth addplot:(addplot_option:plot)}}add other plots to the graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {cmd:by()} 
documented in {manhelpi twoway_options G-3}{p_end}
{synoptline}

{marker plotopts}{...}
{synopthdr:plot_options}
{synoptset 25}{...}
{synoptline}
{synopt :{it:{help marker_options}}}change look of markers (color, size, etc.){p_end}
{synopt :{it:{help marker_label_options}}}add marker labels; change look or position{p_end}
{synopt :{it:{help cline_options}}}change look of the line{p_end}
{synoptline}


INCLUDE help menu_estat


{title:Description for estat}

{pstd}
{cmd:estat proportion} calculates the indirect effect as a proportion of the
total effect.

{pstd}
{cmd:estat cde} calculates controlled direct effects.

{pstd}
{cmd:estat or} calculates effects on the odds-ratio scale after
{cmd:mediate} with the {cmd:logit} or {cmd:probit} outcome model.

{pstd}
{cmd:estat rr} calculates effects on the risk-ratio scale after
{cmd:mediate} with the {cmd:logit} or {cmd:probit} outcome model.

{pstd}
{cmd:estat irr} calculates effects on the incidence-rate-ratio scale after
{cmd:mediate} with the {cmd:poisson} or {cmd:expmean} outcome model.

{pstd}
{cmd:estat effectsplot} plots the estimated effects.  Typically,
this is useful if there are more than two treatment groups in the case of a
multivalued treatment or if a continuous treatment is evaluated at more than
two points.  By default, {cmd:estat effectsplot} plots the effects estimated
in the previous {cmd:mediate} command.


{title:Options for estat proportion}

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for
confidence intervals. The default is {cmd:level(95)} or as set by
{helpb set level}.

{phang}
{cmd:percent} specifies to calculate percentages. By default, 
{cmd:estat proportion} calculates proportions.

{phang}
{cmd:force} forces calculations to proceed in case of conflicting 
signs. By default, {cmd:estat proportion} issues an error message if opposite 
signs among indirect, direct, and total effects are detected. In that case,
the result is typically not interpretable in a meaningful way.

{phang}
{cmd:nolegend} suppresses the display of the table legend.

{marker prop_display_options}{...}
{phang}
{it:display_options}:
{opt noci},
{opt nopv:alues},
{opt nofvlab:el},
{opt fvwrap(#)},
{opt fvwrapon(style)},
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
see {helpb estimation options:[R] Estimation options}.


{title:Options for estat cde}

{phang}
{opt mvalue(numlist)} specifies the value of the mediator variable at which to
evaluate the controlled direct effect.  If the causal mediation model
contained a continuous treatment variable, only a single value may be
specified.  {cmd:mvalue()} is required.

{phang}
{opt rr} specifies to calculate controlled direct effect on the risk-ratio
scale after {cmd:mediate} with the {cmd:logit} or {cmd:probit} outcome model.

{phang}
{opt or} specifies to calculate controlled direct effect on the odds-ratio
scale after {cmd:mediate} with the {cmd:logit} or {cmd:probit} outcome model.

{phang}
{opt irr} specifies to calculate controlled direct effect on the
incidence-rate-ratio scale after {cmd:mediate} with the {cmd:poisson} or
{cmd:expmean} outcome model.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for
confidence intervals. The default is {cmd:level(95)} or as set by
{helpb set level}.

{phang}
{cmd:contrast} specifies to calculate differences of controlled 
direct effects between evaluations at different points of the mediator, where
the base effect is the one defined by the first value in {cmd:mvalue()};
this option requires at least two evaluation points to be specified in 
{cmd:mvalue()}.

{phang}
{cmd:nolegend} suppresses the display of the table legend.

{phang}
{cmd:atmeans} specifies to evaluate the controlled direct effect at the 
means of covariates. By default, the counterfactual predictions are averaged
over the covariates.

{marker cde_display_options}{...}
{phang}
{it:display_options}:
{opt noci},
{opt nopv:alues},
{opt nofvlab:el},
{opt fvwrap(#)},
{opt fvwrapon(style)},
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
see {helpb estimation options:[R] Estimation options}.


{title:Options for estat or, estat rr, and estat irr}

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for
confidence intervals. The default is {cmd:level(95)} or as set by
{helpb set level}.

{phang}
{cmd:nolegend} suppresses the display of the table legend.

{marker scale_display_options}{...}
{phang}
{it:display_options}:
{opt noci},
{opt nopv:alues},
{opt nofvlab:el},
{opt fvwrap(#)},
{opt fvwrapon(style)},
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
see {helpb estimation options:[R] Estimation options}.


{title:Options for estat effectsplot}

{phang}
{cmd:nie}, {cmd:nde}, {cmd:te}, {cmd:pnie}, {cmd:tnde},
{cmd:aite}, {cmd:adte}, {cmd:ate}, {cmd:aitec}, and {cmd:adtet}
specify to plot the respective treatment effects.  For these effects to be
plotted, they must be part of the model estimates.  By default,
{cmd:estat effectsplot} plots the effects estimated in the previous
{cmd:mediate} command.

{dlgtab:Main}

{phang}
{cmd:noci} removes plots of the pointwise confidence intervals. The default 
is to plot the confidence intervals.

{dlgtab:Plot}

{phang}
{help mediate postestimation##plotopts:{it:plot_options}}
        affects the rendition of all effect plots.  The {it:plot_options}
        can affect the size and color of markers, whether and how the markers
        are labeled, and whether and how the points are connected; see
	{manhelpi marker_options G-3}, {manhelpi marker_label_options G-3}, and
	{manhelpi cline_options G-3}.

{pmore}
        These settings may be overridden for specific plots by using the 
        {cmd:plot}{it:#}{cmd:opts()} option.

{phang}
{cmd:plot}{it:#}{cmd:opts(}{help mediate postestimation##plotopts:{it:plot_options}}{cmd:)}
        affects the rendition of the {it:#}th effect plot. The
        {it:plot_options} can affect the size and color of markers, whether
        and how the markers are labeled, and whether and how the points are
        connected; see {manhelpi marker_options G-3}, 
        {manhelpi marker_label_options G-3}, and
        {manhelpi cline_options G-3}.

{phang}
{opt recast(plottype)}
        specifies that effects be plotted using {it:plottype}.  
        {it:plottype} may be {cmd:scatter}, {cmd:line}, {cmd:connected},
        {cmd:bar}, {cmd:area}, {cmd:spike}, {cmd:dropline}, or {cmd:dot}; see
	{manhelp graph_twoway G-2:graph twoway}.  When {cmd:recast()} is
	specified, the plot-rendition options appropriate to the specified
	{it:plottype} may be used in lieu of
	{help mediate postestimation##plotopts:{it:plot_options}}.
	 For details on those options, follow the appropriate link from
	 {manhelp graph_twoway G-2:graph twoway}.

{dlgtab:CI plot}

{phang}
        {opt ciopts(rcap_options)} affects the rendition of confidence
        intervals; see {manhelpi rcap_options G-3}.

{pmore}
        These settings may be overridden for specific confidence interval
        plots with the {cmd:ci}{it:#}{cmd:opts()} option.

{phang}
{cmd:ci}{it:#}{cmd:opts(}{it:rcap_options}{cmd:)}
        affects the rendition of the {it:#}th confidence interval; 
        see {manhelpi rcap_options G-3}.

{phang}
{opt recastci(plottype)}
        specifies that confidence intervals be plotted using {it:plottype}.
        {it:plottype} may be {cmd:rarea}, {cmd:rbar}, {cmd:rspike},
        {cmd:rcap}, {cmd:rcapsym}, {cmd:rline}, {cmd:rconnected}, or
	{cmd:rscatter}; see {manhelp graph_twoway G-2:graph twoway}.  When
	{cmd:recastci()} is specified, the plot-rendition options appropriate
	to the specified {it:plottype} may be used in lieu of
	{it:rcap_options}.  For details on those options, follow the
	appropriate link from {manhelp graph_twoway G2:graph twoway}.

{phang}
        {opt level(#)} specifies the confidence level, as a percentage, for
        confidence intervals. The default is {cmd:level(95)} or as set by
	{helpb set level}.

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} 
        provides a way to add other plots to the generated graph; see
        {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in 
{manhelpi twoway_options G-3},
excluding {cmd:by()}.  These include options for titling the graph (see
{manhelpi title_options G-3}) and for saving the graph to disk (see 
{manhelpi saving_option G-3}).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse birthweight}

{pstd}Estimate the natural indirect effect, natural direct effect,
and total effect using a linear model for both the
outcome and mediator variable{p_end}
{phang2}{cmd:. mediate (bweight age) (ncigs sespar age) (college)}

{pstd}Estimate the controlled direct effect with the mediator set
to 0{p_end}
{phang2}{cmd:. estat cde, mvalue(0)}

{pstd}Plot the natural indirect effect, natural direct effect, and total
effect from the model above{p_end}
{phang2}{cmd:. estat effectsplot}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:estat proportion} stores the following results in {cmd:r()}:

{synoptset 12 tabbed}{...}
{p2col 5 12 16 2: Scalars}{p_end}
{synopt :{cmd:r(N)}}number of observations{p_end}

{p2col 5 12 16 2: Macros}{p_end}
{synopt :{cmd:r(title)}}title in estimation output{p_end}

{p2col 5 12 16 2: Matrices}{p_end}
{synopt :{cmd:r(b)}}vector of estimated proportions or percentages{p_end}
{synopt :{cmd:r(V)}}variance-covariance matrix of the estimates{p_end}
{synopt :{cmd:r(table)}}matrix containing the estimates with their standard 
errors, test statistics, {it:p}-values, and confidence intervals{p_end}

{pstd}
{cmd:estat cde} stores the following results in {cmd:r()}:

{p2col 5 12 16 2: Scalars}{p_end}
{synopt :{cmd:r(N)}}number of observations{p_end}

{p2col 5 12 16 2: Macros}{p_end}
{synopt :{cmd:r(title)}}title in estimation output{p_end}

{p2col 5 12 16 2: Matrices}{p_end}
{synopt :{cmd:r(b)}}vector of estimated controlled direct effects or their contrasts{p_end}
{synopt :{cmd:r(V)}}variance-covariance matrix of the estimates{p_end}
{synopt :{cmd:r(table)}}matrix containing the estimates with their standard 
errors, test statistics, {it:p}-values, and confidence intervals{p_end}

{pstd}
{cmd:estat or}, {cmd:estat rr}, and {cmd:estat irr} store the following
results in {cmd:r()}:

{p2col 5 12 16 2: Scalars}{p_end}
{synopt :{cmd:r(N)}}number of observations{p_end}
{synopt :{cmd:r(level)}}confidence level{p_end}

{p2col 5 12 16 2: Matrices}{p_end}
{synopt :{cmd:r(b)}}vector of transformed treatment effects (log scale){p_end}
{synopt :{cmd:r(V)}}variance-covariance matrix of the estimates{p_end}
{synopt :{cmd:r(table)}}matrix containing the estimates with their standard 
errors, test statistics, {it:p}-values, and confidence intervals{p_end}
{p2colreset}{...}
