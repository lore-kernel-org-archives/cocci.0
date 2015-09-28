From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 28 Sep 2015 14:07:23 +0200
Subject: [Cocci] [PATCH v2] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
References: <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
Message-ID: <56092D7B.4030106@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +// Options: --include-headers --all-includes

How do you think about the reuse of the parameter "--recursive-includes" here?

Will the list of checked function calls become more complete then?

Regards,
Markus
