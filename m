From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 30 Dec 2016 07:38:42 +0100 (CET)
Subject: [Cocci] Adding calls to devm_add_action_or_reset()
In-Reply-To: <20161229232006.GA31143@roeck-us.net>
References: <20161229200826.GA3657@roeck-us.net>
 <alpine.DEB.2.20.1612292240440.2245@hadrien>
 <20161229232006.GA31143@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1612300737350.1943@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 29 Dec 2016, Guenter Roeck wrote:

> On Thu, Dec 29, 2016 at 10:41:42PM +0100, Julia Lawall wrote:
> > I have added function type to the set of types that can appear in a cast.
> > The change has been pushed to github.
> >
> Pulled and working ...
>
> I had to install the following packages on my system (Ubuntu 16.04):
>
> 	menhir libpcre-ocaml-dev libparmap-ocaml-dev libmenhir-ocaml-dev
> 	libfindlib-ocaml-dev
>
> to fix various build errors. The bundled versions did not work.

Thanks for the report.  I got another report about libparmap-ocaml-dev
recently as well.  We will look into it.

julia
