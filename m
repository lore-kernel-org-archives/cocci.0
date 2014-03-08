From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Mar 2014 22:41:29 +0100 (CET)
Subject: [Cocci] Determination of the number for named function
 parameters
In-Reply-To: <531B771D.3020900@users.sourceforge.net>
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
 <531B32F4.9080004@users.sourceforge.net>
 <531B771D.3020900@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1403082240410.2126@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 8 Mar 2014, SF Markus Elfring wrote:

> > I am missing documentation for corresponding data structures I can depend on in
> > further reports.
> 
> The display from the function "pprint.pformat" shows another implementation
> detail in my simple script.
> http://docs.python.org/2/library/pprint.html
> 
> Would you like to clarify data analysis according to the current situation
> around "coccilib.elems.TermList instance"?

I know nothing about this.  Maybe look at the python code and see what it 
does.  But I am not sure that using it is the best way to do whjat you 
want, although I also don't know what you want to do.

julia
