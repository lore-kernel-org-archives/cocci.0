From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 16 Jun 2017 09:06:59 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <alpine.DEB.2.20.1706160829130.3459@hadrien>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
 <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
 <alpine.DEB.2.20.1706152233080.3015@hadrien>
 <75d88a53-ace7-3bea-a3b2-bbc100091e78@users.sourceforge.net>
 <alpine.DEB.2.20.1706160802420.3013@hadrien>
 <8acbcd33-5eb7-08d3-c841-734d0359f87b@users.sourceforge.net>
 <alpine.DEB.2.20.1706160829130.3459@hadrien>
Message-ID: <0e92a764-c68e-c279-4d33-228690b47172@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> OK, I don't undertand what command you are doing to get the problem,

I showed how I could stumble on open issues.


> so I can't reproduce it, so I can't determine whether it is a real issue.

There are chances for the reproduction if you would also dare to fiddle
more with the build scripts (and the Autotools build system generally).
Which software combinations would you like to try out further there?


> If you want feedback, you have to give the complete command.

The mentioned command examples reference generated files.


> The OCaml makefile specifies an order in which the files should be
> compiled in the project.

I agree that the make scripts of the Coccinelle software contain also
some dependency specifications. Unfortunately, I observe that they are not
completely effective to avoid unwanted error messages.


> If you are sidestepping that ordering, then you are not doing things
> in the intended manner.

We got different views about corresponding software evolution.


> There is only an intent to support running make or make opt in the
> subdirectories or at the root.

I find this kind of restriction unnecessary.


> Perhaps Thierry will put a new make file that has some other properties
> (I don't know which ones) in the future.

I am curious on your ideas for this software area.


> But there is no intent to support anything else at the moment.

I hope that the desired support will also evolve together with solutions
for the remaining open issues.


> Only Thierry would do somehting about the build system,

How are the chances that additional software developers will care about
any more update candidates in this software?


> and if his existing work makes your efforts useless,

Would you like to share any related information for your plans?


> then you are just wasting your time.

This is also one of the usual risk in free software development, isn't it?

Regards,
Markus
