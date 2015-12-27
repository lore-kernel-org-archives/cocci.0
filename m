From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 27 Dec 2015 14:18:44 +0300
Subject: [Cocci] [PATCH v2] coccinelle: api: check for propagation of
 error from platform_get_irq
In-Reply-To: <alpine.DEB.2.02.1512270709420.2038@localhost6.localdomain6>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
 <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
 <567EF895.6080702@cogentembedded.com>
 <alpine.DEB.2.02.1512262156580.2070@localhost6.localdomain6>
 <567F141C.8010000@cogentembedded.com>
 <alpine.DEB.2.02.1512262330430.2070@localhost6.localdomain6>
 <567F166B.7030208@cogentembedded.com>
 <alpine.DEB.2.02.1512270709420.2038@localhost6.localdomain6>
Message-ID: <567FC914.4080705@cogentembedded.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/27/2015 9:13 AM, Julia Lawall wrote:

>>     Well, looking again, the patch should be good. I just thought its goal was
>> to fix the code as well...
>
> I could do that for the irq < 0 case, but I think that in that case, kbuild
> will only run the patch version, and the <= cases will not be reported on.
> I don't have a general fix for the <= 0.  Is it even correct to have < in
> some cases and <= in others?

    That's a good question...
    In my prior fixes of this case I preferred to consider IRQ0 valid and so 
used 'irq < 0'. I myself don't share the "IRQ0 is invalid" sentiment...

> julia

MBR, Sergei
