From: mstefani@redhat.com (Michael Stefaniuc)
Date: Fri, 09 Aug 2013 12:56:20 +0200
Subject: [Cocci] disjunction and parens
In-Reply-To: <CAP6exY+yyWBN5LPF7fT5KHuGe8VM4z0R5ywJ08Pq2rwOO3Hxaw@mail.gmail.com>
References: <CAP6exY+yyWBN5LPF7fT5KHuGe8VM4z0R5ywJ08Pq2rwOO3Hxaw@mail.gmail.com>
Message-ID: <5204CAD4.9020507@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/07/2013 05:21 PM, ron minnich wrote:
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
) is special when it is on the first column in a line. If you add a
space before it, it will just work. It is a good practice to start code
matching lines with a space; like the context lines in the unified diff
format.

bye
	michael
