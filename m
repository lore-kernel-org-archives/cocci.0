From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 29 May 2013 18:37:04 +0200 (CEST)
Subject: [Cocci] Converting old-style function definitions.
In-Reply-To: <20130529162209.GA30955@domone.kolej.mff.cuni.cz>
References: <20130529162209.GA30955@domone.kolej.mff.cuni.cz>
Message-ID: <alpine.DEB.2.02.1305291835300.2246@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 29 May 2013, Ond?ej B?lka wrote:

>
> Hi,
>
> I am interested in common cleanup to convert K&R function
> definitions to ISO ones (As gcc warning in -Wold-style-definition).
>
> Probably someone already wrote spatch so I ask here who?

Unfortunately, it is not supported.  The Coccinelle C parser makes at
least an attempt to parse K&R function definitions, but the SmPL parser,
ie the parser of the transformation specification language, doesn't accept
them.

julia
