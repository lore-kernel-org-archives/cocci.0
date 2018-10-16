From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Tue, 16 Oct 2018 22:40:07 +0530
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <CAOZdJXXdbNO-S7iQgmV3nJ6q-1jjy0sJFGmJ7m2inZ3HLOOC3Q@mail.gmail.com>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810132318330.15695@hadrien>
 <CAOZdJXUJhwYkzJc6LLb_4Vm7nj_si8igx-fgs-q-PyRkOHr2Dw@mail.gmail.com>
 <20181016151052.GA26422@himanshu-Vostro-3559>
 <CAOZdJXXdbNO-S7iQgmV3nJ6q-1jjy0sJFGmJ7m2inZ3HLOOC3Q@mail.gmail.com>
Message-ID: <20181016171006.GA28822@himanshu-Vostro-3559>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Oct 16, 2018 at 11:28:31AM -0500, Timur Tabi wrote:
> On 10/16/18 10:10 AM, Himanshu Jha wrote:
> > FYI coccinelle works fine on Ubuntu 18.04.1 when built through
> > source code.
> 
> I've attached my config.log, can you compare it with yours and post the diff?


himanshu at himanshu-Vostro-3559:~/coccinelle$ diff timur-config.log config.log 
4c4
< It was created by coccinelle configure 1.0.7-00033-g21afa515-dirty, which was
---
> It was created by coccinelle configure 1.0.7-00498-g41ec93a2, which was
13c13
< hostname = ttabi
---
> hostname = himanshu-Vostro-3559
15c15
< uname -r = 4.15.0-34-generic
---
> uname -r = 4.15.0-36-generic
17c17
< uname -v = #37-Ubuntu SMP Mon Aug 27 15:21:48 UTC 2018
---
> uname -v = #39-Ubuntu SMP Mon Sep 24 16:19:09 UTC 2018
30c30,31
< PATH: /home/ttabi/bin
---
> PATH: /home/himanshu/Downloads/nRF5x-Command-Line-Tools_9_7_3_Linux-x86_64/nrfjprogs
> PATH: /home/himanshu/.local/bin
38a40
> PATH: /home/himanshu/Downloads/nRF5x-Command-Line-Tools_9_7_3_Linux-x86_64
40,44d41
< PATH: /home/ttabi/bin
< PATH: /home/ttabi/sw/misc/linux
< PATH: /home/ttabi/sw/automation/dvs/dvsbuild/
< PATH: /home/ttabi/sw/main/apps/p4review
< PATH: /home/ttabi/ttabi_p4hw-1/hw/nv/utils/as2/beta_0.4/bin
51c48
< configure:2191: configuring coccinelle 1.0.7-00033-g21afa515-dirty in /home/ttabi/coccinelle
---
> configure:2191: configuring coccinelle 1.0.7-00498-g41ec93a2 in /home/himanshu/coccinelle
59,60c56,59
< configure:2556: found /usr/bin/gawk
< configure:2567: result: gawk
---
> configure:2570: result: no
> configure:2540: checking for mawk
> configure:2556: found /usr/bin/mawk
> configure:2567: result: mawk
70c69
< configure:2996: version suffix set to Sun, 14 Oct 2018 21:55:15 +0200
---
> configure:2996: version suffix set to Thu, 9 Aug 2018 21:43:25 +0200
163,164c162,163
< | #define PACKAGE_VERSION "1.0.7-00033-g21afa515-dirty"
< | #define PACKAGE_STRING "coccinelle 1.0.7-00033-g21afa515-dirty"
---
> | #define PACKAGE_VERSION "1.0.7-00498-g41ec93a2"
> | #define PACKAGE_STRING "coccinelle 1.0.7-00498-g41ec93a2"
168c167
< | #define VERSION "1.0.7-00033-g21afa515-dirty"
---
> | #define VERSION "1.0.7-00498-g41ec93a2"
184,185c183,184
< | #define PACKAGE_VERSION "1.0.7-00033-g21afa515-dirty"
< | #define PACKAGE_STRING "coccinelle 1.0.7-00033-g21afa515-dirty"
---
> | #define PACKAGE_VERSION "1.0.7-00498-g41ec93a2"
> | #define PACKAGE_STRING "coccinelle 1.0.7-00498-g41ec93a2"
189c188
< | #define VERSION "1.0.7-00033-g21afa515-dirty"
---
> | #define VERSION "1.0.7-00498-g41ec93a2"
259c258
< configure:11145: coccinelle may use external ocaml libraries in /home/ttabi/coccinelle/bundles
---
> configure:11145: coccinelle may use external ocaml libraries in /home/himanshu/coccinelle/bundles
285c284
< configure:12926: using bundled substitute for pyml in /home/ttabi/coccinelle/bundles/pyml
---
> configure:12926: using bundled substitute for pyml in /home/himanshu/coccinelle/bundles/pyml
317c316
< This file was extended by coccinelle config.status 1.0.7-00033-g21afa515-dirty, which was
---
> This file was extended by coccinelle config.status 1.0.7-00498-g41ec93a2, which was
326c325
< on ttabi
---
> on himanshu-Vostro-3559
428c427
< ac_cv_prog_AWK=gawk
---
> ac_cv_prog_AWK=mawk
446c445
< ACLOCAL='${SHELL} /home/ttabi/coccinelle/setup/missing aclocal-1.15'
---
> ACLOCAL='${SHELL} /home/himanshu/coccinelle/setup/missing aclocal-1.15'
455,458c454,457
< AUTOCONF='${SHELL} /home/ttabi/coccinelle/setup/missing autoconf'
< AUTOHEADER='${SHELL} /home/ttabi/coccinelle/setup/missing autoheader'
< AUTOMAKE='${SHELL} /home/ttabi/coccinelle/setup/missing automake-1.15'
< AWK='gawk'
---
> AUTOCONF='${SHELL} /home/himanshu/coccinelle/setup/missing autoconf'
> AUTOHEADER='${SHELL} /home/himanshu/coccinelle/setup/missing autoheader'
> AUTOMAKE='${SHELL} /home/himanshu/coccinelle/setup/missing automake-1.15'
> AWK='mawk'
466,468c465,467
< COCCI_OCAML_EXTERNAL='/home/ttabi/coccinelle/bundles'
< COCCI_SRCDIR='/home/ttabi/coccinelle'
< COCCI_VERSION='1.0.7-00033-g21afa515-dirty'
---
> COCCI_OCAML_EXTERNAL='/home/himanshu/coccinelle/bundles'
> COCCI_SRCDIR='/home/himanshu/coccinelle'
> COCCI_VERSION='1.0.7-00498-g41ec93a2'
470c469
< CONFVERSION='Sun, 14 Oct 2018 21:55:15 +0200'
---
> CONFVERSION='Thu, 9 Aug 2018 21:43:25 +0200'
475c474
< DEFS='-DPACKAGE_NAME=\"coccinelle\" -DPACKAGE_TARNAME=\"coccinelle\" -DPACKAGE_VERSION=\"1.0.7-00033-g21afa515-dirty\" -DPACKAGE_STRING=\"coccinelle\ 1.0.7-00033-g21afa515-dirty\" -DPACKAGE_BUGREPORT=\"cocci@systeme.lip6.fr\" -DPACKAGE_URL=\"http://coccinelle.lip6.fr/\" -DPACKAGE=\"coccinelle\" -DVERSION=\"1.0.7-00033-g21afa515-dirty\"'
---
> DEFS='-DPACKAGE_NAME=\"coccinelle\" -DPACKAGE_TARNAME=\"coccinelle\" -DPACKAGE_VERSION=\"1.0.7-00498-g41ec93a2\" -DPACKAGE_STRING=\"coccinelle\ 1.0.7-00498-g41ec93a2\" -DPACKAGE_BUGREPORT=\"cocci at systeme.lip6.fr\" -DPACKAGE_URL=\"http://coccinelle.lip6.fr/\" -DPACKAGE=\"coccinelle\" -DVERSION=\"1.0.7-00498-g41ec93a2\"'
520c519
< MAKEINFO='${SHELL} /home/ttabi/coccinelle/setup/missing makeinfo'
---
> MAKEINFO='${SHELL} /home/himanshu/coccinelle/setup/missing makeinfo'
527c526
< MAKE_pyml='/home/ttabi/coccinelle/bundles/pyml'
---
> MAKE_pyml='/home/himanshu/coccinelle/bundles/pyml'
583c582
< PACKAGE_STRING='coccinelle 1.0.7-00033-g21afa515-dirty'
---
> PACKAGE_STRING='coccinelle 1.0.7-00498-g41ec93a2'
586c585
< PACKAGE_VERSION='1.0.7-00033-g21afa515-dirty'
---
> PACKAGE_VERSION='1.0.7-00498-g41ec93a2'
594,595c593,594
< PATH_menhirLib_bundle='/home/ttabi/coccinelle/bundles/menhirLib'
< PATH_menhir_bundle='/home/ttabi/coccinelle/bundles/menhirLib/menhir'
---
> PATH_menhirLib_bundle='/home/himanshu/coccinelle/bundles/menhirLib'
> PATH_menhir_bundle='/home/himanshu/coccinelle/bundles/menhirLib/menhir'
598c597
< PATH_pyml='/home/ttabi/coccinelle/bundles/pyml'
---
> PATH_pyml='/home/himanshu/coccinelle/bundles/pyml'
604c603
< PKG_CONFIG='/home/ttabi/coccinelle/setup/fake-subst.sh /usr/bin/pkg-config'
---
> PKG_CONFIG='/home/himanshu/coccinelle/setup/fake-subst.sh /usr/bin/pkg-config'
630c629
< VERSION='1.0.7-00033-g21afa515-dirty'
---
> VERSION='1.0.7-00498-g41ec93a2'
663c662
< install_sh='${SHELL} /home/ttabi/coccinelle/setup/install-sh'
---
> install_sh='${SHELL} /home/himanshu/coccinelle/setup/install-sh'
696,697c695,696
< #define PACKAGE_VERSION "1.0.7-00033-g21afa515-dirty"
< #define PACKAGE_STRING "coccinelle 1.0.7-00033-g21afa515-dirty"
---
> #define PACKAGE_VERSION "1.0.7-00498-g41ec93a2"
> #define PACKAGE_STRING "coccinelle 1.0.7-00498-g41ec93a2"
701c700
< #define VERSION "1.0.7-00033-g21afa515-dirty"
---
> #define VERSION "1.0.7-00498-g41ec93a2"


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
