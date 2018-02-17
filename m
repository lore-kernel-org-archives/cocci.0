From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 17:05:40 +0100 (CET)
Subject: [Cocci] Determination for the absence of an option in a
 function call
In-Reply-To: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
References: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802171703560.2205@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> Hello,
>
> I am working with the following specification in some scripts for the semantic
> patch language.
>
> ?
>  target = action(...);
> ?
>
>
> This source code search pattern shows that a return value from a function call
> should be stored somewhere. The concrete call is restricted by a selection of
> function names. Such an approach is working to some degree when restrictions
> on function call parameters can be omitted.
>
> But a safer source code analysis requires to distinguish these parameters in
> more detail.
>
> 1. How should be ensured that a specific option was not passed?
>
> 2. The parameter number becomes also relevant then.
>    How should functions be split based on their signature?

I don't understand the questions.  What do you mean by option?  A
command-line option of Coccinelle?  A particular argument of action?

For the second question, maybe you are looking for the following:

@r@
expression list[n] es;
@@

target = action(es)

Now r.n is the number of arguments to action.

julia
