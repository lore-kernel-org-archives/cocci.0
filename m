From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 18 Jun 2016 09:12:16 +0200
Subject: [Cocci] [PATCH] bundles/pycaml/: force pycaml preparation to be
 done serially
In-Reply-To: <20160617223327.GX11948@wotan.suse.de>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606172009220.3164@hadrien>
 <20160617184724.GW11948@wotan.suse.de> <20160617223327.GX11948@wotan.suse.de>
Message-ID: <7d8c0732-59ba-a49d-4834-48f1dc0285f7@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> It makes parallel building work with a minimal change. The bigger
>> hammer is to not trust any bundles and add +.NOTPARALLEL: all to
>> the top level bundles/Makefile, that was my first approach, however
>> it didn't seem like a good idea either as then you'd slow the bundle
>> build generally.
> I actually thing we also need .ONESHELL on all bundle Makefiles as well.
> This alone does not suffice to make it build correctly, however it seems
> this is correct. So the following patch seems more appropriate.

I do not agree on the suggested combination.


> Bundles need their preparation to run in one shell [0],

I do not think so. - Such a setting can make sense for efficiency reasons.
https://www.gnu.org/software/make/manual/html_node/One-Shell.html


> for pycaml we also need to disable parallel builds on the preparation.

I can agree to this view.


>  include ../Makefile.bundles
>  
> +.ONESHELL:
> +.NOTPARALLEL: .prepare
>  .prepare: $(MARKER)
>  	rm -f "$(SRC_DIR)/pycaml.mli"

I find this change mixture questionable.

1. Would such an adjustment be cleaner by separate commits?

2.  You try to express that only such a preparation should be performed
in a serial way. It seems that your approach does not completely fit to
the documentation.

   https://www.gnu.org/software/make/manual/html_node/Special-Targets.html :
   "?
   If .NOTPARALLEL is mentioned as a target, then this invocation of
make will be run serially, even if the ?-j? option is given. ? Any
prerequisites on this target are ignored.
   ?"

   I would appreciate if other parts of the affected make scripts can
still be executed in parallel. Do you want to switch off parallelisation
for the whole script so far?


Regards,
Markus
