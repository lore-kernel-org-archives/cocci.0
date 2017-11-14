From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Nov 2017 13:35:35 +0100 (CET)
Subject: [Cocci] [PATCH v4] coccinelle: fix parallel build with
 CHECK=scripts/coccicheck
In-Reply-To: <1510659487-16361-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510659487-16361-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <alpine.DEB.2.20.1711141335220.2874@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 14 Nov 2017, Masahiro Yamada wrote:

> The command "make -j8 C=1 CHECK=scripts/coccicheck COCCI=..." produces
> lots of "coccicheck failed" error messages.
>
> Julia Lawall explained the Coccinelle behavior as follows:
> "The problem on the Coccinelle side is that it uses a subdirectory
> with the name of the semantic patch to store standard output and
> standard error for the different threads.  I didn't want to use a
> name with the pid, so that one could easily find this information
> while Coccinelle is running.  Normally the subdirectory is cleaned
> up when Coccinelle completes, so there is only one of them at a time.
> Maybe it is best to just add the pid.  There is the risk that these
> subdirectories will accumulate if Coccinelle crashes in a way such
> that they don't get cleaned up, but Coccinelle could print a warning
> if it detects this case, rather than failing."
>
> When scripts/coccicheck is used as CHECK tool and -j option is given
> to Make, the whole of build process runs in parallel.  So, multiple
> processes try to get access to the same subdirectory.
>
> I notice spatch creates the subdirectory only when it runs in parallel
> (i.e. --jobs <N> is given and <N> is greater than 1).
>
> Setting NPROC=1 is a reasonable solution; spatch does not create the
> subdirectory.  Besides, ONLINE=1 mode takes a single file input for
> each spatch invocation, so there is no reason to parallelize it in
> the first place.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Julia Lawall <Julia.Lawall@lip6.fr>

> ---
>
> Changes in v4:
>   - Remove unnecessary comments.  One line comment will be enough.
>
> Changes in v3:
>   - Set NPROC=1 because this is a more sensible solution
>     given that there is no reason to run coccinelle in parallel
>     for ONLINE=1 mode.
>   - Move J= option handling to a proper place.
>   - Add more detailed explanation
>
> Changes in v2:
>   - Grep '-j' instead of '--jobserver-auth'.
>     '--jobserver-*' is not a stable option flag.
>     Make 4.2 change '--jobserver-fds' into '--jobserver-auth'
>   - Add -q option to grep
>
>  scripts/coccicheck | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 040a8b1..fefda40 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -30,12 +30,6 @@ else
>  	VERBOSE=0
>  fi
>
> -if [ -z "$J" ]; then
> -	NPROC=$(getconf _NPROCESSORS_ONLN)
> -else
> -	NPROC="$J"
> -fi
> -
>  FLAGS="--very-quiet"
>
>  # You can use SPFLAGS to append extra arguments to coccicheck or override any
> @@ -70,6 +64,9 @@ if [ "$C" = "1" -o "$C" = "2" ]; then
>      # Take only the last argument, which is the C file to test
>      shift $(( $# - 1 ))
>      OPTIONS="$COCCIINCLUDE $1"
> +
> +    # No need to parallelize Coccinelle since this mode takes one input file.
> +    NPROC=1
>  else
>      ONLINE=0
>      if [ "$KBUILD_EXTMOD" = "" ] ; then
> @@ -77,6 +74,12 @@ else
>      else
>          OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
>      fi
> +
> +    if [ -z "$J" ]; then
> +        NPROC=$(getconf _NPROCESSORS_ONLN)
> +    else
> +        NPROC="$J"
> +    fi
>  fi
>
>  if [ "$KBUILD_EXTMOD" != "" ] ; then
> --
> 2.7.4
>
>
