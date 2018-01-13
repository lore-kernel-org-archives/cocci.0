From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 13 Jan 2018 19:19:25 +0100
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <721a4579-336b-c367-d802-746cf0ecbeca@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Add more memory allocating functions that are frequently used in the kernel
> code to the existing list and remove the useless casts where it is
> unnecessary.

Thanks for your approach to extend this SmPL script.

I would find the term ?selection? more appropriate than the word ?list? here.



>+  \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|

I suggest to choose an other code layout for such growing SmPL disjunctions.
How are the chances to specify each function name on a separate script line?


Would you ever like to reduce code duplication by including external files?


Could an alternation (regular expression) be used for a SmPL constraint?

Regards,
Markus
