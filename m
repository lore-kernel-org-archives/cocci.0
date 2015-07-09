From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 9 Jul 2015 21:13:23 +0200 (CEST)
Subject: [Cocci] binary operator matching
In-Reply-To: <CAMy_N61zJQ8xg7BcsC6tGnNDLdK2nHHKDvfevc3MYpOdNzBBMw@mail.gmail.com>
References: <CAMy_N61zJQ8xg7BcsC6tGnNDLdK2nHHKDvfevc3MYpOdNzBBMw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507092112340.2532@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 9 Jul 2015, Kris Borer wrote:

> Could someone give an example of how to match binary operators? For example,
> I can create a rule that matches addition and subtraction using a
> disjunction, but would like to simplify it further. I tried using the
> contents of metaops0.cocci from the repository, but got an error. Any advice
> would be appreciated.

Easy answer :)  Upgrade to the latest version.  Binary operatrs weren't
supported in 1.0.0.-rc19.

I tested your example, and it works ok in 1.0.1.

julia


> bash> cat simple.c
> void main() {
> ??? int i = 0;
> ??? int j = 0;
>
> ??? i = i + 1;
> ??? j = j - 1;
>
> ??? i = i + j;
> ??? j = i - j;
> }
> bash> cat add_subtract.cocci
> @@
> identifier i, j;
> @@
>
> (
> * i + j
> |
> * i - j
> )
> bash> spatch --sp-file add_subtract.cocci simple.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: simple.c
> diff =
> --- simple.c
> +++ /tmp/cocci-output-11070-1e7c84-simple.c
> @@ -5,6 +5,4 @@ void main() {
> ???? i = i + 1;
> ???? j = j - 1;
> ?
> -??? i = i + j;
> -??? j = i - j;
> ?}
> bash> cat metaops0.cocci
> @@
> expression e1, e2;
> binary operator op1;
> @@
>
> *? e1 op1 e2
>
> bash> spatch --sp-file metaops0.cocci simple.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> 38 41
> Fatal error: exception Failure("meta: parse error:
> ?= File "metaops0.cocci", line 3, column 16,? charpos = 38
> ??? around = 'op1', whole content = binary operator op1;
> ")
> bash> spatch --version
> spatch version 1.0.0-rc19 with Python support and with PCRE support
>
>
> Thanks,
>
> Kris
>
>
