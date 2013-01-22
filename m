From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Tue, 22 Jan 2013 15:31:33 +0100
Subject: [Cocci] [PATCH 1/2] coccicheck: Allow the user to give a
	VERBOSE= argument
In-Reply-To: <20130122133434.2543274.86646.stgit@fsdevel3>
References: <20130122133434.2543274.86646.stgit@fsdevel3>
Message-ID: <CAAxaTiOCLyNJt0Bmqg+7t1knByKfSUpiCDCGm85vtHveDJDzGw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Thank you Bernd for your proposition.

I added Michal in CC, who is responsible for the integration.

I was wondering if the V variable which already exists would not be better
than introducing a new variable. Bernd, is there any reason to not use V ?

Your patch also remove the check of the ONLINE variable. In doing so,
I think that your patch will badly interfere with the online checking
performed with the C variable. Am I missing something ?

Regards,

On Tue, Jan 22, 2013 at 2:34 PM, Bernd Schubert
<bernd.schubert@itwm.fraunhofer.de> wrote:
> Simply running "make coccicheck" returns very verbose output and warnings
> might not be noticed.  Allow the user to set the verbosity level.
>
>
> Signed-off-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
> CC: Julia Lawall <Julia.Lawall@lip6.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci at systeme.lip6.fr
> ---
>  scripts/coccicheck |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 1a49d1c..eab0b00 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -2,6 +2,12 @@
>
>  SPATCH="`which ${SPATCH:=spatch}`"
>
> +if [ -z "$VERBOSE" ] ; then
> +       RUN_VERBOSE=0
> +else
> +       RUN_VERBOSE=$VERBOSE
> +fi
> +
>  if [ "$C" = "1" -o "$C" = "2" ]; then
>      ONLINE=1
>
> @@ -55,7 +61,7 @@ coccinelle () {
>  #
>  #    $SPATCH -D $MODE $FLAGS -parse_cocci $COCCI $OPT > /dev/null
>
> -    if [ "$ONLINE" = "0" ] ; then
> +    if [ "$RUN_VERBOSE" != "0" ] ; then
>
>         FILE=`echo $COCCI | sed "s|$srctree/||"`
>
>



-- 
Nicolas Palix
