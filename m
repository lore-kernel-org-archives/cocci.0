From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 02 Apr 2014 11:00:34 +0200
Subject: [Cocci] code style reformatting
In-Reply-To: <alpine.DEB.2.10.1404021033420.2080@hadrien>
References: <1396374174.21529.93.camel@joe-AO722>
 <CA+MoWDr-vry3W3T-duYPYr=H4b3OE0YshuDN9caH56o+WE4CQA@mail.gmail.com>
 <1396393876.21529.99.camel@joe-AO722>
 <alpine.DEB.2.02.1404020749280.2007@localhost6.localdomain6>
 <533BCAAA.1050202@users.sourceforge.net>
 <alpine.DEB.2.10.1404021033420.2080@hadrien>
Message-ID: <533BD1B2.7010301@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Are there any chances that this software will become able to restore a preferred
>> source code layout from the matched expressions?
> 
> No, a metavariable contains no information about its format, so that it
> can match with other metavariables, and when it is printed, Coccinelle
> follows whatever strategy it follows, which is intended to follow the
> conventions of Linux, but is not always successful.

Thanks for this clarification.


> There are tools such as indent that reformat software as a whole using
> various conventions.

How do you think about to avoid such additional source code style reformatting?
Can alternative layout rules be integrated into an improved handling of semantic
patches?

Regards,
Markus
