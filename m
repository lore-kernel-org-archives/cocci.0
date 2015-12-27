From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 27 Dec 2015 08:58:33 +0100
Subject: [Cocci] [PATCH v2] coccinelle: api: check for propagation of
 error from platform_get_irq
In-Reply-To: <alpine.DEB.2.02.1512262156580.2070@localhost6.localdomain6>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
 <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
 <567EF895.6080702@cogentembedded.com>
 <alpine.DEB.2.02.1512262156580.2070@localhost6.localdomain6>
Message-ID: <567F9A29.50202@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The error return value of platform_get_irq seems to often get dropped.

How do you think about any more fine-tuning here?

Commit message:
* ? of the platform_get_irq() function seems to get dropped too often.

* Why do you concentrate on a single function name?
  Do you plan to extend this source code analysis approach?


> + at script:python r_report depends on report@
> +j0 << r.j0;
> +j1 << r.j1;
> +@@
> +
> +msg = "Propagate return value of platform_get_irq around line %s." % (j1[0].line)

Are there more unchecked return values which are interesting
for further considerations?
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus
