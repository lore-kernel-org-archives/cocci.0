From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Jun 2016 12:26:19 +0200
Subject: [Cocci] [PATCH v3 3/6] scripts: add glimpse.sh for indexing the
 kernel
In-Reply-To: <1465935820-14010-4-git-send-email-mcgrof@kernel.org>
References: <20160614201923.GC11948@wotan.suse.de>
 <1465935820-14010-1-git-send-email-mcgrof@kernel.org>,
 <1465935820-14010-4-git-send-email-mcgrof@kernel.org>
Message-ID: <trinity-8eae95d7-f827-44c4-b4d3-123561a053f8-1465986379121@3capp-webde-bap31>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Glimpse is a tool you can use to index the kernel.
> The tool was recently open sourced under the ISC license
> and can be obtained at:

Do you find any official announcement for this software evolution?

Is the wording "recent" really appropriate if you would eventually like to refer to a repository which was published in the year 2014?
https://github.com/gvelez17/glimpse/


Is it nice to mention the script addition also directly in the commit message?


> +DIR=$(dirname $(readlink -f $0))
> +DIR="${DIR}/../"

I would prefer that these variable assignments will be merged into one.

+DIR="$(dirname $(readlink -f $0))/../"

Regards,
Markus
