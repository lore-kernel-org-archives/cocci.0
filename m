From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Apr 2014 07:11:24 +0200 (CEST)
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv=mEHrg0=VSRYAtMJq_papbLYQa4Y1y8j+38n7-3=V6SsQ@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <alpine.DEB.2.10.1404251821570.3323@hadrien>
 <CABxcv==diNNJ+5ZovQb+kmVrWO1v1sc59GeO2nXAs=i2b1gq0Q@mail.gmail.com>
 <alpine.DEB.2.02.1404252324460.2176@localhost6.localdomain6>
 <CABxcv=mEHrg0=VSRYAtMJq_papbLYQa4Y1y8j+38n7-3=V6SsQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1404260710580.1994@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Besides moving the function pointers assigned to the structure
> gpio_chip fields to the new struct gpio_chip_ops, a pointer to the new
> struct gpio_chip_ops has to be assigned to the struct gpio_chip .ops
> field.
> 
> So where to put the new structure is constrained by where struct
> gpio_chip fields are set. If is easier we can define to be just before
> the function where the assignments were made but I don't know if it
> can be generalized.
> 
> But I don't want to waste your time since I still didn't have time to
> get familiar with cocinelle/spatch syntax to get into the details.
> I'll figure out and let you know if I have any issues.

Good point!

julia
