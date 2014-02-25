From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 25 Feb 2014 11:01:02 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.10.1402251014170.2080@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
Message-ID: <530C69DE.9030801@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> This is not allowed.  Inside a disjunction you need to have complete terms.

Thanks for your information. I guess that another adjustment will fit to the
SmPL syntax then.

( if (input) is else es
| if (likely(input)) is else es
)


> I'm not sure to understand your goal.  If the code currently has:
> 
> if (x != NULL)
>    call(x);
> 
> then the developer does not want to execute any of the code within call if
> x is NULL.

Yes. - This is one of the use cases I am trying to improve. It depends on the
knowledge if something unwanted will happen if a null pointer (or zero) would be
passed. If it is documented for example that an implementation of the function
"call" checks the condition "!= NULL", I find the same check by the caller
redundant.


> If you just check that there is a NULL test on x somewhere within the definition
> of call, then that is not enough to ensure that nothing is executed within call.

Would you like to suggest any more fine-tuning?


> If you remove the NULL test, you could drastically change the behavior of the program.

I agree in principle.

But I would like to delete redundant checks from some source files.

Regards,
Markus
