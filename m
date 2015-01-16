From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Jan 2015 21:22:56 +0100 (CET)
Subject: [Cocci] Find all variables/parameters of a given type.
In-Reply-To: <54B96F17.8080206@users.sourceforge.net>
References: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
 <54B95A32.9090600@users.sourceforge.net>
 <559AE227-484E-42F1-94ED-DB703D630EE3@gmail.com>
 <54B96F17.8080206@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1501162122110.2297@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 16 Jan 2015, SF Markus Elfring wrote:

> > Rule for function declaration doesn?t (gives parse error too).
> 
> Will the semantic filter approach work better if you specify
> a return type for the searched functions explicitly?
> 
> @find_integer_within_function_declaration@
> identifier func, var;
> type return_type;
> @@
>  return_type
>  func(...,
> *     long var,
>       ...);

The return type is indeed needed in this case; otherwise the parser will 
think it is a function call.

> )
> 
> @find_integer_from_function_definition@
> identifier func, var;
> type return_type;
> @@
>  return_type
>  func(...,
> *     long var,
>       ...)
>  { ... }

The return type is not needed in this case.

julia
