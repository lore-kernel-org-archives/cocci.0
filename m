From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 10 Feb 2018 14:23:17 +0100 (CET)
Subject: [Cocci] please help me with a failing match
In-Reply-To: <kkk1vlt55g.fsf@bora.foobar.de>
References: <kkk1vlt55g.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1802101422060.3317@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 10 Feb 2018, Robert Larice wrote:

> Dear People,
>
>   I'm completely new here.
>
>   Attached is a small piece of .c and a .cocci file.
>   There is a "return 41;" in both files, commented out.
>   If I uncomment this "return 41;" in both files then
>     spatch will not match the pieces any more.
>
>   Could you please help me to undertand and circumvent this issue ?

I have not noticed this problem before, but I suspect that it is due to
the fact that Coccinelle is matching the control-flow path and not the
abstract syntax tree. In a control-flow graph, nothing follows a return.

julia
