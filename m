From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 May 2015 09:21:19 -0300
Subject: [Cocci] [PATCH 2/2] coccinelle: pci_free_consistent.cocci:
 Adjust commit log of generated patch
In-Reply-To: <alpine.DEB.2.10.1505251417110.2491@hadrien>
References: <1432554373-6444-1-git-send-email-fabio.estevam@freescale.com>
 <1432554373-6444-2-git-send-email-fabio.estevam@freescale.com>
 <alpine.DEB.2.10.1505251417110.2491@hadrien>
Message-ID: <CAOMZO5AgGZxwAgUrbeOK-sBbk09Zi5e5mZHit_uN5Kd0QdQWSQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, May 25, 2015 at 9:17 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Mon, 25 May 2015, Fabio Estevam wrote:
>
>> The commit log should better describe the action that the patch will do.
>>
>> In this case we are 'adding' the pci_free_consistent.
>
> Not sure to follow the reasoning.  The semantic patch doesn't add
> anything.

Right, the semantich patch finds the missing pci_free_consistent, but
the generated patch is not finding pci_free_consistent. It is actually
adding the missing pci_free_consistent instead.

So in the commit log of the generated patch, we should better use
'add' instead of 'find'.

Regards,

Fabio Estevam
