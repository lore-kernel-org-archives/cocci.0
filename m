From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 Dec 2015 18:28:42 +0100 (CET)
Subject: [Cocci] Coccinelle for other programming languages
In-Reply-To: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C22C@Mail1.FCMD.local>
References: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C22C@Mail1.FCMD.local>
Message-ID: <alpine.DEB.2.10.1512171825240.10291@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 17 Dec 2015, Dharmalingam Ganesan wrote:

>
> Hi,
>
> Coccinelle sounds very interesting. I?m curious whether you can comment on any other tools for other programming languages.

Coccinelle doesn't support any languages other than C, and a small amount
of C++.  For C++, it parses the C-like parts of the code, and ignores the
rest.  It could be conceptually possible to design a version of Coccinelle
for other languages, but it would require a lot of development work, so
funding would be required.

julia

>
> ?
>
> Thanks a lot.
>
> Dharma
>
> ?
>
> Dr. Dharmalingam Ganesan, PhD
>
> Senior Research Scientist
>
> Fraunhofer Center for Experimental Software Engineering (CESE)
>
> 5825 University Research Court (Suite 1300)
>
> College Park, Maryland 20740
>
> ?
>
> Tel: 240 487 2915
>
> ?
>
>
>
