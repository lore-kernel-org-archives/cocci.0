From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 11 Jun 2016 19:09:21 +0200
Subject: [Cocci] [PATCH 3/4] scripts: add glimpse.sh for indexing the
 kernel
In-Reply-To: <1465591332-31113-4-git-send-email-mcgrof@kernel.org>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-4-git-send-email-mcgrof@kernel.org>
Message-ID: <eb07efb3-4d46-00a9-a94f-f0c658f316c5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Glimpse is a tool you can use to index the kernel. The tool
> was recently open sourced under the ISC license and can be
> obtained at:

How do you think about to mention the script addition also directly in
the commit message?


> @@ -0,0 +1,12 @@
> +#!/bin/bash
> +
> +DIR=$(dirname $(readlink -f $0))
> +DIR="${DIR}/../"

Would you like to use the following variable assignment (instead of two
before)?

+DIR="$(dirname $(readlink -f $0))/../"


By the way: How are the chances to achieve further software improvements?
https://github.com/gvelez17/glimpse/issues

Regards,
Markus
