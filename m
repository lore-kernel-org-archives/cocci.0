From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Dec 2014 10:38:16 +0100 (CET)
Subject: [Cocci] Dynamic construction of SmPL constraints
In-Reply-To: <54991C80.6000508@users.sourceforge.net>
References: <54991C80.6000508@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1412231037320.2462@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 23 Dec 2014, SF Markus Elfring wrote:

> Hello,
>
> I try to extract data and filter on properties from various
> function implementations.
> Now I would like to clarify consequences from the name resolution
> process of the C programming language a bit more for safer
> development of semantic patches.
>
> Implementations from separate directories can provide different properties.
> It can occasionally happen that functions from different folders
> have got the same name.
>
> I see that there are some development challenges when I would like
> to construct SmPL constraints in the way that they will take the directory
> hierarchy for a source file into account.
> How can this functionality be achieved?

You always have the file name information available in a position
variable.

Without knowing concretely what you want to do that is the only suggestion
that I have.

julia
