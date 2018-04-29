From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 29 Apr 2018 14:58:30 +0200 (CEST)
Subject: [Cocci] perhaps a bug
In-Reply-To: <kka7tm2na4.fsf@bora.foobar.de>
References: <kka7tm2na4.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1804291457570.3679@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 29 Apr 2018, Robert Larice wrote:

> Hello,
>
>   attached is a small example which does something strange
>     to a  "int i, j;" within a "#ifdef..."
>   Perhaps this points to a bug in coccinelle,
>   Would you please check ?

Thanks for the report.  It looks like a bug.  But everything is fine if
you removed the --defined BOO.

julia
