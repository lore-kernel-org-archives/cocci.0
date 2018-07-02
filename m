From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 2 Jul 2018 07:43:58 +0200 (CEST)
Subject: [Cocci] [PATCH] a few typo fixes and formatting suggestions
In-Reply-To: <20180701233851.GD18012@localhost>
References: <20180701233851.GD18012@localhost>
Message-ID: <alpine.DEB.2.20.1807020743470.2348@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 2 Jul 2018, Michele Martone wrote:

> A few typo fixes and formatting suggestions. For revision 75de16b.

Applied, thanks.

julia

>
> Signed-off-by: Michele Martone <michelemartone@users.sf.net>
> ---
> diff --git a/docs/manual/cocci_syntax.tex b/docs/manual/cocci_syntax.tex
> index a2410a08..d0d27830 100644
> --- a/docs/manual/cocci_syntax.tex
> +++ b/docs/manual/cocci_syntax.tex
> @@ -256,16 +256,16 @@ i.e., including as an element of another statement list.
>    \CASE{binary operator \NT{COMMA\_LIST}\mth{(}\T{binopdecl}\mth{)} ;}
>
>    \RULE{\rt{assignopdecl}}
> -  \CASE{\NT{id} \OPT{ = \NT{assignop\_contraint}}}
> +  \CASE{\NT{id} \OPT{ = \NT{assignop\_constraint}}}
>
> -  \RULE{\rt{assignop\_contraint}}
> +  \RULE{\rt{assignop\_constraint}}
>    \CASE{\mth{\{}\NT{COMMA\_LIST}\mth{(}\NT{assign\_op}\mth{)}\mth{\}}}
>    \CASE{\NT{assign\_op}}
>
>    \RULE{\rt{binopdecl}}
> -  \CASE{\NT{id} \OPT{ = \NT{binop\_contraint}}}
> +  \CASE{\NT{id} \OPT{ = \NT{binop\_constraint}}}
>
> -  \RULE{\rt{binop\_contraint}}
> +  \RULE{\rt{binop\_constraint}}
>    \CASE{\mth{\{}\NT{COMMA\_LIST}\mth{(}\NT{bin\_op}\mth{)}\mth{\}}}
>    \CASE{\NT{bin\_op}}
>  \end{grammar}
> @@ -294,8 +294,8 @@ An {\bf identifier list} is only used for the parameter list of a macro.
>  It is possible to specify its length.
>
>  It is possible to specify some information about the definition of a {\bf
> -  fresh identifier}.  Examples are found in demos/plusplus1.cocci and
> -demos/plusplus2.cocci %See the wiki.
> +  fresh identifier}.  Examples are found in {\tt demos/plusplus1.cocci} and
> +{\tt demos/plusplus2.cocci} %See the wiki.
>
>  A {\bf symbol} declaration specifies that the provided identifiers should
>  be considered C identifiers when encountered in the body of the rule.
> @@ -338,7 +338,7 @@ string contains format descriptors.  Note that this makes it impossible to
>  require \texttt{\ldots} to match exactly in a string, if the semantic patch
>  string contains format descriptors.  If that is needed, some processing
>  with a scripting language would be required.  And example for the use of
> -string format metavariables is found in demos/format.cocci.
> +string format metavariables is found in {\tt demos/format.cocci}.
>
>  Matching of various kinds of format strings within strings is supported.
>  With the {\tt -{}-ibm} option, matching of decimal format declarations is
> @@ -431,7 +431,7 @@ metavariable must be used consistently.  These metavariables cannot be used
>  in all contexts; specifically, they cannot be used in context that would
>  make the parsing ambiguous.  Some examples are the leftmost term of an
>  expression, such as the left-hand side of an assignment, or the type in a
> -variable declaration.  These restrictions may seems somewhat arbitrary from
> +variable declaration.  These restrictions may seem somewhat arbitrary from
>  the user's point of view.  Thus, it is better to use metavariables with
>  metavariable types.  If Coccinelle is given the argument {\tt
>    -parse\_cocci}, it will print information about the type that is inferred
> @@ -482,7 +482,7 @@ lifting.  The result of disjunction lifting can be observed using {\tt
>  return or an assignment, or a loop header, if header, etc.  The variable
>  being declared can also be referenced in the script code by its name.  All
>  parameters, except position variables, have their string representation.
> -An example is in demos/poscon.cocci.
> +An example is in {\tt demos/poscon.cocci}.
>
>  Script constraints may be executed more than once for a given metavariable
>  binding.  Executing the script constraint does not guarantee that the
> @@ -588,7 +588,7 @@ Initialize and finalize rules do have access to virtual metavariables,
>  using the usual syntax.  As for other scripting language rules, the rule
>  is not run (and essentially does not exist) if some of the required virtual
>  metavariables are not bound.  In ocaml, a warning is printed in this case.
> -An example is found in demos/initvirt.cocci.
> +An example is found in {\tt demos/initvirt.cocci}.
>
>  A script metavariable that does not specify an origin, using \texttt{<<},
>  is newly declared by the script.  This metavariable should be assigned to a
> @@ -629,7 +629,7 @@ the string actually represents the kind of term represented by the
>  metavariable.  Normally, a script rule is only applied if all of the
>  metavariables have values.  If default values are provided, then the script
>  rule is only applied if all of the metavariables for which there are no
> -default values have values.  See demos/defaultscript.cocci for examples of
> +default values have values.  See {\tt demos/defaultscript.cocci} for examples of
>  the use of this feature.
>
>  \section{Control Flow}
> @@ -1737,7 +1737,7 @@ be matched against.  The entire line is added, but it is not parsed.
>  \section{Command-Line Semantic Match}
>
>  It is possible to specify a semantic match on the spatch command line,
> -using the argument {\tt -sp}.  In such a semantic match, any token
> +using the argument {\tt --sp}.  In such a semantic match, any token
>  beginning with a capital letter is assumed to be a metavariable of type
>  {\tt metavariable}.  In this case, the parser must be able to figure out what
>  kind of metavariable it is.  It is also possible to specify the type of a
> @@ -1745,7 +1745,7 @@ metavariable by enclosing the type in :'s, concatenated directly to the
>  metavariable name.
>
>  Some examples of semantic matches that can be given as an argument to {\tt
> -  -sp} are as follows:
> +  --sp} are as follows:
>
>  \begin{itemize}
>  \item \texttt{f(e)}: This only matches the expression \texttt{f(e)}.
> @@ -1865,7 +1865,7 @@ this with scripting is necessary.
>  \section{{\tt .cocciconfig} Support}
>
>  Coccinelle supports enabling custom options to be preferred when running
> -spatch.  This is supported through the search of .cocciconfig files in each of
> +spatch.  This is supported through the search of {\tt .cocciconfig} files in each of
>  the following directories, later lines extend and may override earlier ones:
>
>  \begin{itemize}
> diff --git a/docs/manual/spatch_options.tex b/docs/manual/spatch_options.tex
> index e7bc933e..0d3b75b1 100644
> --- a/docs/manual/spatch_options.tex
> +++ b/docs/manual/spatch_options.tex
> @@ -548,7 +548,7 @@ version of {\bf -{}-partial-match}.}
>  \normal{-D variable=value}{Run the patch considering that the virtual
>    identifier metavariable ``variable'' is bound to ``value''.  Any
>    identifier metavariable can be designated as being virtual by giving it
> -  the rule name {\tt virtual}.  An example is in demos/vm.coci}
> +  the rule name {\tt virtual}.  An example is in {\tt demos/vm.cocci}}
>
>  \rare{-{}-allow-inconsistent-paths}{Normally, a term that is transformed
>    should only be accessible from other terms that are matched by the
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
