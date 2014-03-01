From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 01 Mar 2014 09:16:30 +0100
Subject: [Cocci] Improvements for passing of big regular expressions in
	SmPL constraints?
In-Reply-To: <530DD06F.4090703@users.sourceforge.net>
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
Message-ID: <5311975E.9010805@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @Delete_unnecessary_checks@
> expression x;
> identifier release =~ "^(?x)
> (?:
>    (?:kz?|slob_)free
> |
>    (?:
>       # alternation/disjunction of 893 strings ...
>    )
> )$";
> @@
> -if (x)
>     release(x);

Would it be useful that the shown regular expression could be included from an
other source file?
How do you think about an extension for the semantic patch language so that such
a string could be assigned to a special metavariable with a type like "regex"?
Can it be passed from a "virtual" parameter?

Regards,
Markus
