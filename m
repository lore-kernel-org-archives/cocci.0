From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 11 Jul 2017 09:17:34 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
Message-ID: <9bf5b541-93f2-c171-087a-11cc37913807@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> So I get the impression that an other build approach will be safer there.
> How do you think about to add a dependency specification so that interface
> descriptions will be always compiled before the corresponding OCaml code?

I showed change possibilities which can improve the software situation
to some degree.

* Improve several dependency specifications in make rules
  https://github.com/coccinelle/coccinelle/pull/108

* Fix specifications for build dependencies between shared components
  https://github.com/coccinelle/coccinelle/issues/110

* Support references for the top-level source file directory in build scripts
  https://github.com/coccinelle/coccinelle/issues/104


Which ideas would you like to integrate from the available development approaches?

Regards,
Markus
