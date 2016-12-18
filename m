From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 18 Dec 2016 09:22:10 +0100 (CET)
Subject: [Cocci] Replace typedef INT with int
In-Reply-To: <CAJ3s=NAfRwWN5=F0nf+DsHSDv7dVLw9wrJaSUsL1FPs1ZexucA@mail.gmail.com>
References: <CAJ3s=NAfRwWN5=F0nf+DsHSDv7dVLw9wrJaSUsL1FPs1ZexucA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1612180921360.2048@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 18 Dec 2016, Kishan Sandeep wrote:

> Hi,
>
>
> Please help me to write cocci script here -
>
> I have below typedef -
>
> typedef int INT;
>
> INT is used so-many files in the code. Now i want to remove this typedef and
> want to replace with int.

@@
typedef INT;
@@

- INT
+ int

@@
@@

- typedef int INT;

julia
