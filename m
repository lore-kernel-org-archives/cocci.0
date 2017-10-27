From: jim.epost@gmail.com (Jim Davis)
Date: Fri, 27 Oct 2017 16:56:40 -0700
Subject: [Cocci] [PATCH] coccinelle: fix verbose message about .cocci
	file being run
In-Reply-To: <1508993751-17218-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508993751-17218-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CA+r1Zhhy_kbW_EwruY9n_0LCccEfFaOdfk5Jhn3NN2vwyNhuTA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 25, 2017 at 9:55 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> If you run coccicheck with V=1 and COCCI=, you will see a strange
> path to the semantic patch file.  For example, run the following:
>
> $ make V=1 COCCI=scripts/coccinelle/free/kfree.cocci coccicheck
>   [ snip ]
>  The semantic patch that makes this report is available
>  in scriptcoccinelle/free/kfree.cocci.
>
> Notice "s/" was dropped from "scripts/coccinelle/free/kfree.cocci".
>
> When running coccicheck without O=, $srctree is expanded to ".", which
> represents one arbitrary character in the regular expression.  Using
> sed is not a good choice here.  Strip $srctree/ simply without sed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 1bfa2d2..9d18662 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -186,7 +186,7 @@ coccinelle () {
>
>      if [ $VERBOSE -ne 0 -a $ONLINE -eq 0 ] ; then
>
> -       FILE=`echo $COCCI | sed "s|$srctree/||"`
> +       FILE=${COCCI#$srctree/}

[jim at krebstar linux-rc]$ make CONFIG_SHELL=dash V=1
COCCI=scripts/coccinelle/free/kfree.cocci coccicheck
dash ./scripts/coccicheck
./scripts/coccicheck: 63: ./scripts/coccicheck: Bad substitution
make: *** [Makefile:1585: coccicheck] Error 2

-- 
Jim
