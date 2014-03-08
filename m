From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 08 Mar 2014 16:10:44 +0100
Subject: [Cocci] Determination of the number for named function
	parameters
In-Reply-To: <alpine.DEB.2.10.1403081514140.2156@hadrien>
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
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
Message-ID: <531B32F4.9080004@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> In declaratin a parameter list, you can also say;
> 
> parameter list[n] ps;
> 
> and then n is the number of parameters that are matched.

Thanks for your interesting details.

I find the use of the element "n" (the name in square brackets) not obvious from
the Coccinelle manual so far.

But I would like to try more analysis with the data that is passed by the
metavariable type "parameter list". I have started to look a bit into it by the
function "pickle.dumps". This kind of display is not so useful for me yet.
I am missing documentation for corresponding data structures I can depend on in
further reports.

Regards,
Markus
