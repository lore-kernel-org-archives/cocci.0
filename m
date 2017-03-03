From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 3 Mar 2017 11:34:54 +0100
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <20160801070233.GA19102@amitoj-Inspiron-3542>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
Message-ID: <90a9cad7-5712-c507-94ce-1bdd89d7a272@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> This script finds instances of allocate and memset which can be
> replaced with a direct call to zalloc equivalent of a function.

What is the software development status for this SmPL script in comparison
to an other directory for source code transformations?
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/scripts/coccinelle/api/alloc

Regards,
Markus
