From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 27 Dec 2015 17:24:02 +0100
Subject: [Cocci] [PATCH v2] coccinelle: api: check for propagation of
 error from platform_get_irq
In-Reply-To: <alpine.DEB.2.02.1512271239460.2038@localhost6.localdomain6>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
 <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
 <567EF895.6080702@cogentembedded.com>
 <alpine.DEB.2.02.1512262156580.2070@localhost6.localdomain6>
 <567F9A29.50202@users.sourceforge.net>
 <alpine.DEB.2.02.1512271239460.2038@localhost6.localdomain6>
Message-ID: <568010A2.3000902@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> https://cwe.mitre.org/data/definitions/252.html
> 
> The value is not unchecked.

Would you like to express any stronger relationship between
the function call example and the occurrence of an if statement
by the discussed SmPL script?


> I made a specific rule because the specific problem is quite common.

Can it become also interesting to generalise this search pattern?

Regards,
Markus
