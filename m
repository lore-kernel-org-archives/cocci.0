From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Fri, 1 Feb 2013 10:07:06 +0100
Subject: [Cocci] [PATCH 2 2/2] coccicheck: Allow to show the executed
	command line
In-Reply-To: <20130129160342.28754.96853.stgit@localhost.localdomain>
References: <20130129160342.28754.96853.stgit@localhost.localdomain>
Message-ID: <CAAxaTiOGUo092Fgigs2U0R7Ry0HPvLTFqvvANp8TMFJbY+KgLw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jan 29, 2013 at 5:03 PM, Bernd Schubert
<bernd.schubert@itwm.fraunhofer.de> wrote:
> On my system one of the tests failed with
> "Fatal error: exception Failure("No OCaml compiler found! Install either ocamlopt or ocamlopt.opt")".
>
> Investigating such issues is easier if the executed command line is being shown.
>
> Signed-off-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
> CC: Julia Lawall <Julia.Lawall@lip6.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>

Acked-by: Nicolas Palix <nicolas.palix@imag.fr>

> CC: cocci at systeme.lip6.fr
> CC: Michal Marek <mmarek@suse.cz>
> ---
>  scripts/coccicheck |   28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index f8f15a2..85d3189 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -55,6 +55,14 @@ if [ "$ONLINE" = "0" ] ; then
>      echo ''
>  fi
>
> +run_cmd() {
> +       if [ $VERBOSE -ne 0 ] ; then
> +               echo "Running: $@"
> +       fi
> +       eval $@
> +}
> +
> +
>  coccinelle () {
>      COCCI="$1"
>
> @@ -100,15 +108,21 @@ coccinelle () {
>      fi
>
>      if [ "$MODE" = "chain" ] ; then
> -       $SPATCH -D patch   $FLAGS -sp_file $COCCI $OPT $OPTIONS               || \
> -       $SPATCH -D report  $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff || \
> -       $SPATCH -D context $FLAGS -sp_file $COCCI $OPT $OPTIONS               || \
> -       $SPATCH -D org     $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff || exit 1
> +       run_cmd $SPATCH -D patch   \
> +               $FLAGS -sp_file $COCCI $OPT $OPTIONS               || \
> +       run_cmd $SPATCH -D report  \
> +               $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff || \
> +       run_cmd $SPATCH -D context \
> +               $FLAGS -sp_file $COCCI $OPT $OPTIONS               || \
> +       run_cmd $SPATCH -D org     \
> +               $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff || exit 1
>      elif [ "$MODE" = "rep+ctxt" ] ; then
> -       $SPATCH -D report  $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff && \
> -       $SPATCH -D context $FLAGS -sp_file $COCCI $OPT $OPTIONS || exit 1
> +       run_cmd $SPATCH -D report  \
> +               $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff && \
> +       run_cmd $SPATCH -D context \
> +               $FLAGS -sp_file $COCCI $OPT $OPTIONS || exit 1
>      else
> -       $SPATCH -D $MODE   $FLAGS -sp_file $COCCI $OPT $OPTIONS || exit 1
> +       run_cmd $SPATCH -D $MODE   $FLAGS -sp_file $COCCI $OPT $OPTIONS || exit 1
>      fi
>
>  }
>



-- 
Nicolas Palix
