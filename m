From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Jun 2016 14:01:37 +0200
Subject: [Cocci] [PATCH 2/4] scripts: add reqs python library
In-Reply-To: <1465942217-14452-3-git-send-email-mcgrof@kernel.org>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>,
 <1465942217-14452-3-git-send-email-mcgrof@kernel.org>
Message-ID: <trinity-423abc00-b03e-4813-a090-da059bb5ee4e-1465992097699@3capp-webde-bap45>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +class Req:

Will a longer identifier like "requirement" be more useful than the suggested abbreviation?


> +    "To be used for verifying binay package dependencies on Python code"

Would you like to fix a typo here?

... binary ...


> +    def req_old_program(self, program, version_req):

Does such a name selection need also further considerations?

Regards,
Markus
