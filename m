From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 16 Oct 2014 21:28:15 +0200 (CEST)
Subject: [Cocci] Coccinelle rules for module_pci_driver
In-Reply-To: <54401BD2.9050209@free-electrons.com>
References: <543FB678.7000206@free-electrons.com>
 <alpine.DEB.2.10.1410161554230.2585@hadrien>
 <54401BD2.9050209@free-electrons.com>
Message-ID: <alpine.DEB.2.10.1410162127260.2633@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 16 Oct 2014, Michael Opdenacker wrote:

> Hi Julia,
>
> On 10/16/2014 03:56 PM, Julia Lawall wrote:
> > I suggest the following semantic patch.  It is in two parts.  The first
> > part matches all of the functions/declarations to ensure that they are all
> > present.  The second part then makes the transformation.
> >
> > I get a change in only one file.
>
> Many thanks for this new version (interesting approach that has the
> advantage of being progressive and repeatable) and for your explanations.
>
> I confirm that it works for me and that I will work on making it
> suitable for "make coccicheck" in the Linux kernel.

Just run coccinelle/tools/sgen/sgen on it and see what happens.

julia
