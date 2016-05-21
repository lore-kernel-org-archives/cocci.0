From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 21 May 2016 09:08:29 +0200
Subject: [Cocci] [PATCH v2 2/3] demos: add basic series of demos for
 exists and forall
In-Reply-To: <1463699336-16151-3-git-send-email-mcgrof@kernel.org>
References: <1463699336-16151-1-git-send-email-mcgrof@kernel.org>
 <1463699336-16151-3-git-send-email-mcgrof@kernel.org>
Message-ID: <dae8bbea-525e-bd4a-9dc8-314e09f79c5f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +int main(void)
> +{
> +	int a;
> +
> +	a = 10;

Is it nicer to write such a variable initialisation in a single line?

+    int a = 10;


> +	c = 400;
> +	c();

Can such source code trigger understanding difficulties?
How do you think about to specify a function implementation (or pointer)
before its assignment?

Regards,
Markus
