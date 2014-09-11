From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Thu, 11 Sep 2014 15:16:14 +0200
Subject: [Cocci] How to add a few declarations?
In-Reply-To: <54119DC7.7020005@users.sourceforge.net>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <54119DC7.7020005@users.sourceforge.net>
Message-ID: <20140911131614.GA23824@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Sep 11, 2014 at 03:04:07PM +0200, SF Markus Elfring wrote:
> > So the idea is to replace a method by another one but to be able to do that, I need to add two new variables n_values and values.
> 
> Have you got any expectations on the placement for the added variables?

I imagine at the begining of the scope where the ..._set_v method is located.

> Do any other scopes (or separate statement blocks) matter here?

what do you mean exactly by other scopes matter ?

REgards

Frederic
