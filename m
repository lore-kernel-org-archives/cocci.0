From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri,  2 Jan 2015 04:59:09 -0500
Subject: [Cocci] [PATCH 0/3 RFC] Coccinelle: completion API checking
Message-ID: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


This little set of semantic patches is for partially checking the
completion API. It seems to be working correctly and has not yet
produced any false-positive.

The cases being detected are:

1/3 - duplicate init_completions.
2/3 - incorrect static initialization of completion on stack.
3/3 - re-initialization of completion with init_completion() rather
      than reinit_completion().

semantic patch                  findings   files  confirmed
duplicate_init_completion.cocci    2         2        2
false_declare_completion.cocci     6         5        3 
false_init_compltion.cocci         9         6        5 

Note: false_declare_completion.cocci runs extremely slow on my system
      roughly a factor 10 slower than the other two - not clear why.

All findings have been submitted based on these scripts. Some have 
not yet been confirmed.

Note sure if it makes sense putting this type of API misuse cleanup
into mainline given the relatively small number of findings.

patch is against linux-next 3.19.0-rc1 (-next-20141226)
