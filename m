Return-Path: <SRS0=yhX/=IB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03665C433E0
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 08:37:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9FD64EAE
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 08:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9FD64EAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1238arpn016791;
	Wed, 3 Mar 2021 09:36:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CCF6E77CC;
	Wed,  3 Mar 2021 09:36:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 68CEF571B
 for <cocci@systeme.lip6.fr>; Wed,  3 Mar 2021 09:36:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1238ap1x011271
 for <cocci@systeme.lip6.fr>; Wed, 3 Mar 2021 09:36:51 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,219,1610406000"; d="scan'208";a="374603122"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 09:36:19 +0100
Date: Wed, 3 Mar 2021 09:36:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
In-Reply-To: <22d22edd-4213-0f57-d801-1c570f04ec05@petrovitsch.priv.at>
Message-ID: <alpine.DEB.2.22.394.2103030935020.2980@hadrien>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
 <22d22edd-4213-0f57-d801-1c570f04ec05@petrovitsch.priv.at>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 09:36:55 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 09:36:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] linux-kernel janitorial RFP: Mark static arrays as const
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



On Tue, 2 Mar 2021, Bernd Petrovitsch wrote:

> Hi all!
>
> On 02/03/2021 18:42, Joe Perches wrote:
> [...]
> > ------------- For instance: (head -10 of the git grep for file statics)
> >
> > drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] = { 32, 16, 8, 4, 2, 1 };
> > drivers/accessibility/speakup/keyhelp.c:26:static u_char funcvals[] = {
> > drivers/accessibility/speakup/main.c:2059:static spkup_hand spkup_handler[] = {
> > drivers/accessibility/speakup/speakup_acntpc.c:35:static unsigned int synth_portlist[] = { 0x2a8, 0 };
> > drivers/accessibility/speakup/speakup_decpc.c:133:static int synth_portlist[] = { 0x340, 0x350, 0x240, 0x250, 0 };
> > drivers/accessibility/speakup/speakup_dectlk.c:110:static int ap_defaults[] = {122, 89, 155, 110, 208, 240, 200, 106, 306};
> > drivers/accessibility/speakup/speakup_dectlk.c:111:static int g5_defaults[] = {86, 81, 86, 84, 81, 80, 83, 83, 73};
> > drivers/accessibility/speakup/speakup_dtlk.c:34:static unsigned int synth_portlist[] = {
> > drivers/accessibility/speakup/speakup_keypc.c:34:static unsigned int synth_portlist[] = { 0x2a8, 0 };
> > drivers/acpi/ac.c:137:static enum power_supply_property ac_props[] = {
> >
> > For drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] = { 32, 16, 8, 4, 2, 1 };
>
> Looking at the examples: Just s/^static /static const / in the lines
> reported by the grep's above and see if it compiles (and save space)?

There is a small risk with compiling that there may be a problem for a
configuration you haven't considered.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
