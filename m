From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 19 Dec 2016 18:06:35 +0100
Subject: [Cocci] Improved filtering for a big function collection with
 SmPL?
In-Reply-To: <alpine.DEB.2.20.1612191748480.18389@hadrien>
References: <7cbfd2a7-fd79-da43-bc87-833ed26217b1@users.sourceforge.net>
 <alpine.DEB.2.20.1612191748480.18389@hadrien>
Message-ID: <3091421f-cb7e-b92c-ede1-73a9fd54e538@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Why were you looking for such functions in the first place?

These functions provide various return values. I am curious on how often
the returned values will actually be checked and used (or not).


> If you want non-static non-void functions and you find them,
> then what is the issue?

NetBSD contains a lot of components from various software. I tried to get
an impression from the size of the corresponding function collection.

The mentioned concrete size will show further software development challenges
if meaningful source code transformations should be performed with such data,
won't it?

Regards,
Markus
