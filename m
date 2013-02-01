From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Fri, 1 Feb 2013 10:05:54 +0100
Subject: [Cocci] [PATCH 2 1/2] coccicheck: Allow the user to give a V=
	(verbose) argument
In-Reply-To: <20130129160337.28754.31558.stgit@localhost.localdomain>
References: <20130129160337.28754.31558.stgit@localhost.localdomain>
Message-ID: <CAAxaTiMGRTDe1g1HScQf8gKL4ygwt2iQbbNsbAQKDwY5KOHTkw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jan 29, 2013 at 5:03 PM, Bernd Schubert
<bernd.schubert@itwm.fraunhofer.de> wrote:
> Do not run with verbosity on/off depending on the ONLINE variable,
> which gets set with C=1 or C=2, but allow the user to set the
> verbosity using kernel default make V= paramemter.
> Verbosity is off by default now.
>
>
> Signed-off-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
> CC: Julia Lawall <Julia.Lawall@lip6.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>

> CC: cocci at systeme.lip6.fr
> CC: Michal Marek <mmarek@suse.cz>
> ---
>  Documentation/coccinelle.txt |    4 ++++
>  scripts/coccicheck           |   11 ++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
> index cf44eb6..dffa2d6 100644
> --- a/Documentation/coccinelle.txt
> +++ b/Documentation/coccinelle.txt
> @@ -87,6 +87,10 @@ As any static code analyzer, Coccinelle produces false
>  positives. Thus, reports must be carefully checked, and patches
>  reviewed.
>
> +To enable verbose messages set the V= variable, for example:
> +
> +   make coccicheck MODE=report V=1
> +
>
>   Using Coccinelle with a single semantic patch
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 1a49d1c..f8f15a2 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -2,6 +2,15 @@
>
>  SPATCH="`which ${SPATCH:=spatch}`"
>
> +# The verbosity may be set by the environmental parameter V=
> +# as for example with 'make V=1 coccicheck'
> +
> +if [ -n "$V" -a "$V" != "0" ]; then
> +       VERBOSE=1
> +else
> +       VERBOSE=0
> +fi
> +
>  if [ "$C" = "1" -o "$C" = "2" ]; then
>      ONLINE=1
>
> @@ -55,7 +64,7 @@ coccinelle () {
>  #
>  #    $SPATCH -D $MODE $FLAGS -parse_cocci $COCCI $OPT > /dev/null
>
> -    if [ "$ONLINE" = "0" ] ; then
> +    if [ $VERBOSE -ne 0 ] ; then
>
>         FILE=`echo $COCCI | sed "s|$srctree/||"`
>
>



-- 
Nicolas Palix
