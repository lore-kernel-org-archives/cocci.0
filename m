From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 25 Feb 2014 21:11:43 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.10.1402251840450.7035@hadrien>
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
Message-ID: <530CF8FF.8080600@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I don't think it is a good approach to do anything related to 5142
> different functions at once.

A source code search with the following pattern found only six functions for
further consideration.

@is_unnecessary_check@
expression data;
identifier work;
identifier release =~ "^kz?free$";
position pos;
type t;
@@
 t work at pos(...)
 {
  ...
( if (data) release(data);
| if (likely(data)) release(data);
)
  ...
 }


I wonder a bit about this analysis result because the SmPL pattern I started
this discussion thread with showed a few more update candidates.


> It would be better to pick a small set of functions, and work on them carefully.

I would prefer to handle a more complete fix pattern.

By the way: I read about corresponding software update approaches in an article
"Best practices for a big patch series" by Wolfram Sang.


How are the chances to resolve the message "Fatal error: exception
Pcre.Error(_)" with a proposed long alternation?

Regards,
Markus
