Return-Path: <SRS0=QaTm=YN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE6ACA9EA9
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 05:44:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735C221929
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 05:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735C221929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K5i4Z7019755;
	Sun, 20 Oct 2019 07:44:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BCA7577C3;
	Sun, 20 Oct 2019 07:44:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B25BD7792
 for <cocci@systeme.lip6.fr>; Sun, 20 Oct 2019 02:43:12 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0143.hostedemail.com
 [216.40.44.143])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K0hBbY023735
 for <cocci@systeme.lip6.fr>; Sun, 20 Oct 2019 02:43:11 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 27EB51802CCB3
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 22:13:31 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 60D29181D2FC9;
 Sat, 19 Oct 2019 22:13:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pull40_1de9676909547
X-Filterd-Recvd-Size: 2185
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf02.hostedemail.com (Postfix) with ESMTPA;
 Sat, 19 Oct 2019 22:13:25 +0000 (UTC)
Message-ID: <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Marc Zyngier <maz@kernel.org>, Markus Elfring <Markus.Elfring@web.de>
Date: Sat, 19 Oct 2019 15:13:24 -0700
In-Reply-To: <868spgzcti.wl-maz@kernel.org>
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
 <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de>
 <868spgzcti.wl-maz@kernel.org>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 20 Oct 2019 07:44:04 +0200 (CEST)
X-Greylist: Delayed for 01:49:59 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sun, 20 Oct 2019 02:43:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 20 Oct 2019 07:44:00 +0200
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Marek <michal.lkml@markovi.net>,
        YueHaibing <yuehaibing@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] coccinelle: api/devm_platform_ioremap_resource: remove
 useless script
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Sat, 2019-10-19 at 21:43 +0100, Marc Zyngier wrote:
> Providing Coccinelle scripts that scream about perfectly valid code is
> pointless, and the result is actively harmful.

Doubtful.

If the new code is smaller object code and correct
than the conversion is worthwhile.

fyi:

There are already ~450 uses of this function and maybe
~800 possible additional conversions.

> If said script was providing a correct semantic patch instead of being
> an incentive for people to churn untested patches that span the whole
> tree, that'd be a different story.

Right.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
