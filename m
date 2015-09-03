From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 3 Sep 2015 13:45:50 +0200
Subject: [Cocci] [RFC] firmware: annotate thou shalt not request fw on
 init or probe
In-Reply-To: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
References: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <55E832EE.7050801@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +@ calls_fw_on_init depends on defines_module_init @
> +identifier defines_module_init.init;
> +position p1;
> +@@
> +
> +init(void)
> +{
> + ...

Would it make sense to use the specification "when any"
for such a SmPL ellipsis?
http://coccinelle.lip6.fr/docs/main_grammar004.html


> +(
> +request_firmware at p1(...)
> +|
> +request_firmware_nowait at p1(...)
> +|
> +request_firmware_direct at p1(...)
> +)
> +...
> +}


Are there any more source code variants to check today?

Regards,
Markus
