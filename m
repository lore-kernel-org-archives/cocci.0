From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Tue, 18 Jun 2013 23:51:22 +0200
Subject: [Cocci] [PATCH v3] coccicheck: span checks across CPUs
In-Reply-To: <20130618214929.GA15976@www.outflux.net>
References: <20130618214929.GA15976@www.outflux.net>
Message-ID: <CAAxaTiMxZV4gLmB6=hm4WBWPj6D+V-g+puU1Gm_E_Zzhm8UEWw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 18, 2013 at 11:49 PM, Kees Cook <keescook@chromium.org> wrote:
> This adds parallelism by default to the "coccicheck" target using
> spatch's "-max" and "-index" arguments.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>

> ---
> v3:
>  - quiet bash typo, thanks to Nicholas Palix for catching that.
> v2:
>  - added job control to clean up on interrupt, suggested by Nicolas Palix.
> ---
>  Documentation/coccinelle.txt |    5 +++++
>  scripts/coccicheck           |   31 ++++++++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
> index 18de785..408439d 100644
> --- a/Documentation/coccinelle.txt
> +++ b/Documentation/coccinelle.txt
> @@ -91,6 +91,11 @@ To enable verbose messages set the V= variable, for example:
>
>     make coccicheck MODE=report V=1
>
> +By default, coccicheck tries to run as parallel as possible. To change
> +the parallelism, set the J= variable. For example, to run across 4 CPUs:
> +
> +   make coccicheck MODE=report J=4
> +
>
>   Using Coccinelle with a single semantic patch
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 06fcb33..446497f 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -2,15 +2,24 @@
>
>  SPATCH="`which ${SPATCH:=spatch}`"
>
> +trap kill_running SIGTERM SIGINT
> +declare -a SPATCH_PID
> +
>  # The verbosity may be set by the environmental parameter V=
>  # as for example with 'make V=1 coccicheck'
>
>  if [ -n "$V" -a "$V" != "0" ]; then
> -       VERBOSE=1
> +       VERBOSE="$V"
>  else
>         VERBOSE=0
>  fi
>
> +if [ -z "$J" ]; then
> +       NPROC=$(getconf _NPROCESSORS_ONLN)
> +else
> +       NPROC="$J"
> +fi
> +
>  FLAGS="$SPFLAGS -very_quiet"
>
>  # spatch only allows include directories with the syntax "-I include"
> @@ -61,12 +70,28 @@ if [ "$ONLINE" = "0" ] ; then
>  fi
>
>  run_cmd() {
> +       local i
>         if [ $VERBOSE -ne 0 ] ; then
> -               echo "Running: $@"
> +               echo "Running ($NPROC in parallel): $@"
>         fi
> -       eval $@
> +       for i in $(seq 0 $(( NPROC - 1)) ); do
> +               eval "$@ -max $NPROC -index $i &"
> +               SPATCH_PID[$i]=$!
> +               if [ $VERBOSE -eq 2 ] ; then
> +                       echo "${SPATCH_PID[$i]} running"
> +               fi
> +       done
> +       wait
>  }
>
> +kill_running() {
> +       for i in $(seq $(( NPROC - 1 )) ); do
> +               if [ $VERBOSE -eq 2 ] ; then
> +                       echo "Killing ${SPATCH_PID[$i]}"
> +               fi
> +               kill ${SPATCH_PID[$i]} 2>/dev/null
> +       done
> +}
>
>  coccinelle () {
>      COCCI="$1"
> --
> 1.7.9.5
>
>
> --
> Kees Cook
> Chrome OS Security



--
Nicolas Palix
Tel: +33 4 76 51 46 27
http://membres-liglab.imag.fr/palix/
