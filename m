From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Mar 2015 07:08:29 -0500 (EST)
Subject: [Cocci] Skipping of source code between preprocessor statements?
In-Reply-To: <54F6F112.4010004@users.sourceforge.net>
References: <F3E7ABF7-5E64-4AEF-B9CF-AE8CA0CE458B@allegro.com>
 <alpine.DEB.2.10.1503021753060.2763@hadrien>
 <54F6F112.4010004@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1503040708010.3976@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 4 Mar 2015, SF Markus Elfring wrote:

> > Because the C lexer explicitly does parse ''
>
> In which contexts does the syntax allow the use of single quotes
> for the C programming language?

As far as I can tell, all.

>
>
> > and I tried a couple of examples and everything was fine.
>
> How would you like to handle text within the construct "#if 0 / #endif"
> by the analysis tool?

There is a flag for choosing whether to do this.

julia
