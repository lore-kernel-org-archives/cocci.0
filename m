From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 17 Jun 2016 22:52:40 +0200
Subject: [Cocci] Further fine-tuning for parallel software builds?
In-Reply-To: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
Message-ID: <eb20433c-fba4-5e36-9b3b-15d582ddbca8@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>  include ../Makefile.bundles
>  
> +.NOTPARALLEL: .prepare
> +
>  .prepare: $(MARKER)
>  	rm -f "$(SRC_DIR)/pycaml.mli"

Do you eventually need to consider further preparation for several
processing stages?
Will any more dependencies matter between special software build targets?

Regards,
Markus
