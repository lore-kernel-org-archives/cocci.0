From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 22:44:13 +0100 (CET)
Subject: [Cocci] might be bug report, breaking up of a comment
In-Reply-To: <kkd113ibim.fsf@bora.foobar.de>
References: <kkd113ibim.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1802172243470.12418@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, Robert Larice wrote:

> Hello,
>
>   attached is a small example which seems to
>     break up a comment line,
>     thus commenting out following lines.
>
>   Please look at the "long reuse" line
>     which will have an open comment when spatch is run,
>     thus commenting out the following "struct line *options"

I also see this undesriable behavior.  Thanks for the report.

julia
