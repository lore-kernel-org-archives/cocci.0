From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 14:39:02 +0100 (CET)
Subject: [Cocci] Avoiding code duplication for SmPL constraints
In-Reply-To: <06b4669e-7419-e4f8-1761-4e58eef44fbd@users.sourceforge.net>
References: <06b4669e-7419-e4f8-1761-4e58eef44fbd@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802171437580.2205@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> Hello,
>
> Constraints can be specified for metavariables of the semantic patch language.
> I noticed that they can trigger software maintenance challenges
> when bigger specifications are repeated in some SmPL rules.
> Now I am looking again for further possibilities to avoid corresponding
> code duplication.
>
> * Scripted constraints might be a design option.
>   Unfortunately, I find the documentation for this functionality still incomplete.

What information do you find to be lacking?

> * I imagine that it would nice if constraints could be set by programming script
>   rules at a single place.

The simplest thing to do is to define a function in the initialize part of
the semantic patch, and then call that function in the constraints as
needed.

julia
