From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sun, 16 Nov 2014 14:10:23 +0300
Subject: [Cocci] [PATCH 1/1] kernel-audit: Deletion of an unnecessary
 check before the function call "audit_log_end"
In-Reply-To: <54687F1A.1010809@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54687F1A.1010809@users.sourceforge.net>
Message-ID: <20141116111023.GA4905@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Please don't send these to trivial, because they can introduce bugs.

The make the code less clear and they are a layering violation.  If the
other maintainers want to take them that's fine, but don't send it to
trivial.

regards,
dan carpenter
