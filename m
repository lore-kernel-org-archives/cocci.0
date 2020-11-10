Return-Path: <SRS0=z9nG=EQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC0C4742C
	for <cocci@archiver.kernel.org>; Tue, 10 Nov 2020 14:04:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EA320797
	for <cocci@archiver.kernel.org>; Tue, 10 Nov 2020 14:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EA320797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AAE3hTT029675;
	Tue, 10 Nov 2020 15:03:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1AB4874CE;
	Tue, 10 Nov 2020 15:03:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E5A98454B
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 14:28:00 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0003.hostedemail.com
 [216.40.44.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AADRxEw016844
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 14:28:00 +0100 (CET)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 8102F180196A2
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 02:52:17 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id F008012CB;
 Tue, 10 Nov 2020 02:52:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ink22_1714ef1272f1
X-Filterd-Recvd-Size: 2439
Received: from [192.168.0.160] (cpe-72-134-80-165.natsow.res.rr.com
 [72.134.80.165]) (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Tue, 10 Nov 2020 02:52:09 +0000 (UTC)
Message-ID: <3c39c363690d0b46069afddc3ad09213011e5cd4.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: trix@redhat.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, cocci <cocci@systeme.lip6.fr>
Date: Mon, 09 Nov 2020 18:52:08 -0800
In-Reply-To: <20201027164255.1573301-1-trix@redhat.com>
References: <20201027164255.1573301-1-trix@redhat.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 10 Nov 2020 15:03:43 +0100 (CET)
X-Greylist: Delayed for 10:35:45 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Tue, 10 Nov 2020 14:28:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 10 Nov 2020 15:03:41 +0100
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-rdma@vger.kernel.org, qat-linux@intel.com,
        amd-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [Cocci] Subject: [RFC] clang tooling cleanups
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Tue, 2020-10-27 at 09:42 -0700, trix@redhat.com wrote:
> This rfc will describe
> An upcoming treewide cleanup.
> How clang tooling was used to programatically do the clean up.
> Solicit opinions on how to generally use clang tooling.
> =

> The clang warning -Wextra-semi-stmt produces about 10k warnings.
> Reviewing these, a subset of semicolon after a switch looks safe to
> fix all the time.  An example problem
> =

> void foo(int a) {
> =A0=A0=A0=A0=A0switch(a) {
> =A0=A0=A0=A0=A0	       case 1:
> 	       ...
> =A0=A0=A0=A0=A0}; <--- extra semicolon
> }
> =

> Treewide, there are about 100 problems in 50 files for x86_64 allyesconfi=
g.
> These fixes will be the upcoming cleanup.

coccinelle already does some of these.

For instance: scripts/coccinelle/misc/semicolon.cocci

Perhaps some tool coordination can be done here as
coccinelle/checkpatch/clang/Lindent call all be used
to do some facet or another of these cleanup issues.



_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
