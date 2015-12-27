From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 27 Dec 2015 12:41:30 +0100 (CET)
Subject: [Cocci] [PATCH v2] coccinelle: api: check for propagation of
 error from platform_get_irq
In-Reply-To: <567F9A29.50202@users.sourceforge.net>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
 <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
 <567EF895.6080702@cogentembedded.com>
 <alpine.DEB.2.02.1512262156580.2070@localhost6.localdomain6>
 <567F9A29.50202@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1512271239460.2038@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 27 Dec 2015, SF Markus Elfring wrote:

> > The error return value of platform_get_irq seems to often get dropped.
> 
> How do you think about any more fine-tuning here?
> 
> Commit message:
> * ? of the platform_get_irq() function seems to get dropped too often.
> 
> * Why do you concentrate on a single function name?
>   Do you plan to extend this source code analysis approach?
> 
> 
> > + at script:python r_report depends on report@
> > +j0 << r.j0;
> > +j1 << r.j1;
> > +@@
> > +
> > +msg = "Propagate return value of platform_get_irq around line %s." % (j1[0].line)
> 
> Are there more unchecked return values which are interesting
> for further considerations?
> https://cwe.mitre.org/data/definitions/252.html

The value is not unchecked.  I made a specific rule because the specific 
problem is quite common.

julia
