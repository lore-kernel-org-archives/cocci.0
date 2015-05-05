From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 05 May 2015 15:45:48 +0200
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
 function signature
In-Reply-To: <20150505130405.GA1956@opentech.at>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
 <5548B87B.4060103@users.sourceforge.net> <20150505130405.GA1956@opentech.at>
Message-ID: <5548C98C.6090908@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> How do you think about to import the result list into a database table?
> 
> working on that "re-cycling" your parameter count example
> top 10:
>     488 ssize_t != int
>     195 int != unsigned int
>     183 long != int

?

Would you like to provide a static source code analysis
directly in such a report format?
Will a drill-down into corresponding implementation details
become more interesting for the detection of further open issues?

Regards,
Markus
