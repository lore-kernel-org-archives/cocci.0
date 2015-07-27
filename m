From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 27 Jul 2015 17:34:38 +0200 (CEST)
Subject: [Cocci] Finding non-zero returning functions with SmPL
In-Reply-To: <55B64BE0.7050303@users.sourceforge.net>
References: <55B64BE0.7050303@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1507271733380.2453@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> *return_type work(...)
>  {
>   <+...
>   return ... when != 0
>              when != NULL

You can't put when on a ... that represents a single expression.

The simplest thing would be to put return e; and then when you declare e,
put

expression e != {0,NULL};

julia
