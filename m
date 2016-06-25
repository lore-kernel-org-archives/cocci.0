From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 25 Jun 2016 14:54:46 +0200
Subject: [Cocci] [PATCH v3] bundles/pycaml/: use .NOTPARALLEL on bundles
In-Reply-To: <1466461206-6960-1-git-send-email-mcgrof@kernel.org>
References: <1466461206-6960-1-git-send-email-mcgrof@kernel.org>
Message-ID: <f1af02e0-02ae-98be-5e79-b0b6dcf3e08c@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>  bundles/menhirLib/Makefile | 1 +
>  bundles/parmap/Makefile    | 1 +
>  bundles/pcre/Makefile      | 1 +
>  bundles/pycaml/Makefile    | 1 +

How do you think about to omit the key word "pycaml" from the commit subject
when four software areas are affected here?


> +.NOTPARALLEL: .prepare

Would you like to leave the prerequisite specification empty?
https://www.gnu.org/software/make/manual/html_node/Special-Targets.html


Will an other design approach be better for these make scripts?

Regards,
Markus
