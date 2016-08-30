From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 30 Aug 2016 20:58:30 +0100 (IST)
Subject: [Cocci] [PATCH] Fix typos
In-Reply-To: <20160830181920.6807-1-jwilk@jwilk.net>
References: <20160830181920.6807-1-jwilk@jwilk.net>
Message-ID: <alpine.DEB.2.10.1608302058160.3120@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 30 Aug 2016, Jakub Wilk wrote:

> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>

Applied.  Thanks for resending.

julia

> ---
>  docs/Coccilib.3cocci         | 2 +-
>  docs/manual/cocci_syntax.tex | 4 ++--
>  docs/manual/main.tex         | 4 ++--
>  docs/pycocci.1               | 2 +-
>  docs/spgen.1                 | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/docs/Coccilib.3cocci b/docs/Coccilib.3cocci
> index bbd7203..288a209 100644
> --- a/docs/Coccilib.3cocci
> +++ b/docs/Coccilib.3cocci
> @@ -236,7 +236,7 @@ in an initialize or finalize rule).
>  :
>  .B unit -> string
>  .sp
> -Returns the a string indicating the current version.  Note that if
> +Returns a string indicating the current version.  Note that if
>  Coccinelle has been modified since a release, the version number will be
>  postfixed with "-dirty".
>  .sp
> diff --git a/docs/manual/cocci_syntax.tex b/docs/manual/cocci_syntax.tex
> index d0c9b49..b485159 100644
> --- a/docs/manual/cocci_syntax.tex
> +++ b/docs/manual/cocci_syntax.tex
> @@ -25,7 +25,7 @@ presence of that term is optional.
>  A PDF version of this documentation is available at
>  \url{http://coccinelle.lip6.fr/docs/main_grammar.pdf}.
>  \else
> -A HTML version of this documentation is available online at
> +An HTML version of this documentation is available online at
>  \url{http://coccinelle.lip6.fr/docs/main_grammar.html}.
>  \fi
>
> @@ -257,7 +257,7 @@ that is all capital letters (possibly containing numbers) as a constant as
>  well, because the names given to macros in Linux usually have this form.
>
>  An identifier is the name of a structure field, a macro, a function, or a
> -variable.  Is is the name of something rather than an expression that has a
> +variable.  It is the name of something rather than an expression that has a
>  value.  But an identifier can be used in the position of an expression as
>  well, where it represents a variable.
>
> diff --git a/docs/manual/main.tex b/docs/manual/main.tex
> index 73ff8c9..712e83d 100644
> --- a/docs/manual/main.tex
> +++ b/docs/manual/main.tex
> @@ -60,7 +60,7 @@
>  %------------------------------------------------------------------------------
>
>  \input{macros_common}
> -%e.g:
> +%e.g.:
>  %  \newcommand{\mita}[1]{\mbox{\it{{#1}}}}
>
>  \input{macros_options}
> @@ -73,7 +73,7 @@
>  % Globals
>  %------------------------------------------------------------------------------
>  \input{macros}
> -%e.g:
> +%e.g.:
>  % \newcommand{\avgcorrect}{96\%\xspace} % if consider all files
>  % \newcommand{\MyTool}{aComment\xspace}
>  % \newcommand{\bugsfound}{XXX\xspace}
> diff --git a/docs/pycocci.1 b/docs/pycocci.1
> index 46d500f..a0f8180 100644
> --- a/docs/pycocci.1
> +++ b/docs/pycocci.1
> @@ -227,7 +227,7 @@ This will immediately clear old entries from your reflog.
>  \fBpycocci\fP and this man page was written by Luis R. Rodriguez <mcgrof@kernel.org>
>
>  .SH REPORTING BUGS
> -Send an mail to <cocci@systeme.lip6.fr>
> +Send a mail to <cocci@systeme.lip6.fr>
>
>  .SH COPYRIGHT
>  Copyright 2015, Luis R. Rodriguez
> diff --git a/docs/spgen.1 b/docs/spgen.1
> index 6328cbb..83de051 100644
> --- a/docs/spgen.1
> +++ b/docs/spgen.1
> @@ -158,7 +158,7 @@ that the input script and configuration file are parsable.
>  \fBspgen\fP and this man page were written by Chi Pham <chidaph@gmail.com>
>
>  .SH REPORTING BUGS
> -Send an mail to <cocci@systeme.lip6.fr>
> +Send a mail to <cocci@systeme.lip6.fr>
>
>  .SH COPYRIGHT
>  Copyright 2015, Chi Pham
> --
> 2.9.3
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
