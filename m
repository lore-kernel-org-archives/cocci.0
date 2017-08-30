From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 30 Aug 2017 13:12:51 +0200
Subject: [Cocci] cocci script to add static to const declarations ?
In-Reply-To: <1504090145.2786.16.camel@perches.com>
References: <1504090145.2786.16.camel@perches.com>
Message-ID: <c9df65da-eee6-ae21-93b3-ae4110b0cd28@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Any idea on how to write a cocci script that looks for
> const array declarations and adds static to them only when
> all the initializers of the array are constants?

Yes. - But I imagine that my ideas would not fit to the currently available
Coccinelle software.
How do you think about to support further evolution with additional resources
so that advanced source code transformations will become really feasible?

Regards,
Markus
