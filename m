From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 23 Jul 2015 14:44:38 +0200 (CEST)
Subject: [Cocci] comment indentation
In-Reply-To: <CAMy_N63kc-dysJ3TS37Ju3+EqLtDqv50SyN31Poy3qTEprW=Xw@mail.gmail.com>
References: <CAMy_N63kc-dysJ3TS37Ju3+EqLtDqv50SyN31Poy3qTEprW=Xw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507231443510.2450@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 23 Jul 2015, Kris Borer wrote:

> I noticed a case where a comment seems to be incorrectly indented after
> transformation. Any advice would be appreciated. This is on v1.0.1 + 4
> patches.
>
> bash> cat comment.c
> void main() {
> ??? int x = 0;
>
> ??? if( x ) {
> ??? ??? x = 1;
> ??? } else if ( x = 1 ) {
> ??? ??? // set x
> ??? ??? x = 1;
> ??? }
> }
> bash> cat comment.cocci
> @@
> identifier i;
> expression E;
> statement S1, S2;
> @@
>
> + i = E;
> ? if (
> - (i = E)
> + i
> ? ) S1 else S2
>
> bash> spatch --sp-file comment.cocci comment.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> HANDLING: comment.c
> diff =
> --- comment.c
> +++ /tmp/cocci-output-7478-e7a9c5-comment.c
> @@ -3,8 +3,11 @@ void main() {
> ?
> ???? if( x ) {
> ???? ??? x = 1;
> -??? } else if ( x = 1 ) {
> -??? ??? // set x
> +??? } else {
> ???? ??? x = 1;
> +??? ??? if (x) {
> +??? ??? // set x

It looks like the indentation is simply not getting changed.  I'm not sure
that it tries to update the indentation of comments when the nesting level
changes.  I can check.

julia

> +??? ??? ??? x = 1;
> +??? ??? }
> ???? }
> ?}
>
>
> Thank you,
>
> Kris
>
>
