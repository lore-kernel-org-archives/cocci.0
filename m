From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 30 Dec 2017 15:39:51 -0200
Subject: [Cocci] coccicheck failed on Ubuntu 16.04
Message-ID: <CAOMZO5BpqrvDCEm8Z_bP+aO9Re2XJC+xjXpjrW1VARhPAHHoNw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I have installed coccinelle from github:

$ spatch --version
spatch version 1.0.6-00382-g2964968 compiled with OCaml version 4.02.3
Flags passed to the configure script: [none]
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expresssions: PCRE

My Linux PC runs Ubuntu 16.04 and I get the following error when
trying to run 'make coccicheck':

$ make coccicheck MODE=report M=drivers/net/wireless/

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

coccicheck failed

Any ideas on how to fix this coccicheck failure?

Thanks,

Fabio Estevam
