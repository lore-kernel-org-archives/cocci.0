From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 9 Dec 2015 15:15:18 +0100
Subject: [Cocci] Finding usage of the statement "goto" with SmPL
In-Reply-To: <alpine.DEB.2.10.1512091458390.2491@hadrien>
References: <566831B8.1020306@users.sourceforge.net>
 <alpine.DEB.2.10.1512091458390.2491@hadrien>
Message-ID: <56683776.3000602@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> It doesn't match anything because when you write a rule that has no *,
> then it is considered that you want the pattern to match on every
> execution path.  It is unlikely that the goto is on every execution path,
> so you get nothing.

This is true.


> To solve the problem, just put exists in the initial @@

Thanks for your quick clarification.

I'm sorry that I overlooked this SmPL script setting somehow.
Now I get also the expected results for this SmPL approach.


function|"source file"|line|column|go_to|label_line|label_column
__zram_make_request|"/home/elfring/Projekte/Linux/next-patched/drivers/block/zram/zram_drv.c"|841|13|out|874|10
?
zram_rw_page|"/home/elfring/Projekte/Linux/next-patched/drivers/block/zram/zram_drv.c"|937|12|put_zram|952|8


> If you don't care about the position of the function header of the
> containing function, but could live with just the function name,

I reuse the information "line" and "column" from this metavariable intentionally.


> you can access it much more efficiently from a position variable on the goto,
> in the field current_element.

I will consider such fine-tuning for other source code analysis.

Regards,
Markus
