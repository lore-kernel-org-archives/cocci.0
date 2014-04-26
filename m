From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 26 Apr 2014 10:30:43 +0200
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv=mEHrg0=VSRYAtMJq_papbLYQa4Y1y8j+38n7-3=V6SsQ@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <alpine.DEB.2.10.1404251821570.3323@hadrien>
 <CABxcv==diNNJ+5ZovQb+kmVrWO1v1sc59GeO2nXAs=i2b1gq0Q@mail.gmail.com>
 <alpine.DEB.2.02.1404252324460.2176@localhost6.localdomain6>
 <CABxcv=mEHrg0=VSRYAtMJq_papbLYQa4Y1y8j+38n7-3=V6SsQ@mail.gmail.com>
Message-ID: <535B6EB3.9070705@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Besides moving the function pointers assigned to the structure
> gpio_chip fields to the new struct gpio_chip_ops, a pointer to the new
> struct gpio_chip_ops has to be assigned to the struct gpio_chip .ops field.

Will any macros become relevant for such a source code reorganisation?


> So where to put the new structure is constrained by where struct
> gpio_chip fields are set. If is easier we can define to be just before
> the function where the assignments were made but I don't know if it
> can be generalized.

I am curious how a generalisation should be described here.


> But I don't want to waste your time since I still didn't have time to
> get familiar with cocinelle/spatch syntax to get into the details.

I find that the understanding of this syntax is a secondary issue. Is it more
important to clarify the basic change process before?

Do you need to consider any variations for the initialisation of the affected
data structure?
Is the specification precise enough so that such an algorithm can be added to a
kind of pattern collection?
http://refactoring.com/catalog/extractInterface.html
http://c2.com/cgi/wiki?ExtractInterface

Regards,
Markus
