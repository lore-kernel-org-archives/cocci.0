From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 28 Aug 2017 16:44:25 +0200
Subject: [Cocci] Addition of support for conjunctions on types
In-Reply-To: <alpine.DEB.2.20.1708281334400.3266@hadrien>
References: <alpine.DEB.2.20.1708281334400.3266@hadrien>
Message-ID: <a03956ce-b42c-179d-7b87-956f8238bf42@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> type t;
> identifier i;
> @@
>
> (
> struct i
> &
> t
> )
>
> will now bind both i and t appropriately.


I would like to know a bit more for the application of such a metavariable combination.
I hoped also to read something about it in the current manual.
Unfortunately, I get the information ?? Fatal error occurred, no output PDF
file produced! ?? from data processing by the command ?make docs?.

Regards,
Markus
