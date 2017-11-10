From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 10 Nov 2017 16:42:25 +0100 (CET)
Subject: [Cocci] [PATCH v2] coccinelle: fix parallel build with
 CHECK=scripts/coccicheck
In-Reply-To: <1510210850-28866-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510210850-28866-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <alpine.DEB.2.20.1711101634225.3187@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 9 Nov 2017, Masahiro Yamada wrote:

> The command "make -j8 C=1 CHECK=scripts/coccicheck" produces lots of
> "coccicheck failed" error messages.

The question is where parallelism should be specified.  Currently, make
coccicheck picks up the number of cores on the machine and passes that to
Coccinelle.

OPTIONS="$OPTIONS --jobs $NPROC --chunksize 1"

On my 80 core machine with hyperthreading, this runs 160 jobs in parallel,
while in practice that degrades the performance as compared to 40 or 80
cores.

On the other hand, if we use the make command line argument (-j), then we
will only get parallelism up to the number of semantic patches.  Since
some finish quickly, there will be a lot of wasted cycles.

The best would be that the user knows what works well for his machine, and
specifies it on the command line, and then that value gets propagated to
Coccinelle, eg so that -j8 would cause not 8 semantic patches to run in
parallel but instead would cause Coccinelle to run one semantic patch on 8
files in parallel.  But I don't know if that can be done.

julia

>
> I do not know the coccinelle internals, but I guess --jobs does not
> work well if spatch is invoked from Make running in parallel.
> Disable --jobs in this case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Grep '-j' instead of '--jobserver-auth'.
>     '--jobserver-*' is not a stable option flag.
>     Make 4.2 change '--jobserver-fds' into '--jobserver-auth'
>   - Add -q option to grep
>
>  scripts/coccicheck | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 040a8b1..8bab11e 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -70,6 +70,9 @@ if [ "$C" = "1" -o "$C" = "2" ]; then
>      # Take only the last argument, which is the C file to test
>      shift $(( $# - 1 ))
>      OPTIONS="$COCCIINCLUDE $1"
> +
> +    # --jobs does not work if Make is running in parallel
> +    echo $MAKEFLAGS | grep -q -E '(^| )-j' && USE_JOBS="no"
>  else
>      ONLINE=0
>      if [ "$KBUILD_EXTMOD" = "" ] ; then
> --
> 2.7.4
>
>
