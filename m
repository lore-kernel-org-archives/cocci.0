From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 13 Jan 2018 21:21:47 +0100
Subject: [Cocci] [PATCH] Coccinelle: alloc_cast: Add more memory
 allocating functions to the list
In-Reply-To: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

My software development attention was caught by another implementation detail
in this evolving SmPL script.


> + at initialize:python@

The added script rule should get a condition.
Would the specification ?depends on report? be appropriate there?


Regards,
Markus
