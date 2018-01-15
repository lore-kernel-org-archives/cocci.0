From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 15 Jan 2018 07:27:27 +0100
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <9eb82024-38fe-19d0-2aad-2e19869cf5a2@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +// Copyright: (C) 2017 Himanshu Jha GPLv2.

* Is the addition ?(C)? required?
* Does the year number need an update?



My software development attention was caught by further implementation details
in this evolving SmPL script.


> + at depends on context && r1@

Will the use of a position variable be helpful here?



> +  \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|

Did you consider to handle the relevant function names by a metavariable
instead of a SmPL disjunction?

Regards,
Markus
