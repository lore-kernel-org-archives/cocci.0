From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 25 Feb 2014 22:29:26 +0100 (CET)
Subject: [Cocci] Source code analysis with big regular expressions?
In-Reply-To: <530D08D7.9040501@users.sourceforge.net>
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
 <530CFF11.9090001@users.sourceforge.net>
 <alpine.DEB.2.02.1402252141510.2047@localhost6.localdomain6>
 <530D02F3.7050804@users.sourceforge.net>
 <alpine.DEB.2.02.1402252158530.2047@localhost6.localdomain6>
 <530D08D7.9040501@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1402252227050.2047@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 25 Feb 2014, SF Markus Elfring wrote:

> > Those two lines at least are not from Coccinelle, so I guess that they are 
> > from the PCRE implementation.
> 
> Are there any chances to retrieve a more detailed error information?
> 
> 
> > The regular expression engine is just not likely to be designed to support 
> > such a large regular expression.
> 
> I would try to compare the processing of big patterns with similar interfaces
> from other software.
> 
> 
> > If you like you can give each of the function names one by one as a 
> > command line argument.
> 
> I imagine that this approach will result also in different opinions about a
> useful patch granularity.
> http://lwn.net/Articles/585782/

In my opinion, the change you are proposing is controversial.  Particular 
code instances may be corrected in a better way.  If you try to do 
everything at once then the kernel maintainer will have a big block that 
he has to either accept or reject.  If there is one change that is not 
made in the best way, then he will have to reject it.

On the other hand, if you do a few things at a time, then most of the 
individual things you do will perhaps be noncontroversial.

julia
