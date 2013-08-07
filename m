From: rminnich@gmail.com (ron minnich)
Date: Wed, 7 Aug 2013 08:29:23 -0700
Subject: [Cocci]  Re: disjunction and parens
In-Reply-To: <CAP6exY+yyWBN5LPF7fT5KHuGe8VM4z0R5ywJ08Pq2rwOO3Hxaw@mail.gmail.com>
References: <CAP6exY+yyWBN5LPF7fT5KHuGe8VM4z0R5ywJ08Pq2rwOO3Hxaw@mail.gmail.com>
Message-ID: <CAP6exY+QnVVtxw+DFid5t5_VzL9P2JxAyL9bAdpwJFZ6uS2Jhg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinnelle is always right, that's the rule.

Fixed spatch:

@@
type T;
identifier f;
@@
T f(...
+, struct errbuf *errbuf)
-)
{...}



On Wed, Aug 7, 2013 at 8:21 AM, ron minnich <rminnich@gmail.com> wrote:
> I've never been sure what to do about this error:
>
> [rminnich at localhost akaros]$ spatch --sp-file !$ kern/src/chan.c
> spatch --sp-file scripts/spatch/waserror.cocci kern/src/chan.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> Fatal error: exception Failure("normal parenthesis in line 5 matched
> to disjunction parenthesis on line 7 column 0
>
> Spatch is:
>
> @@
> type T;
> identifier f;
> @@
> T F(...,
> +struct errbuf *errbuf
> ){...}
>
> What did I do wrong here?
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
