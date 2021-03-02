Return-Path: <SRS0=yhX/=IB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FBC433E0
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 07:12:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1A664EBD
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 07:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1A664EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=petrovitsch.priv.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1237CCpq025303;
	Wed, 3 Mar 2021 08:12:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0923B77CC;
	Wed,  3 Mar 2021 08:12:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9B22A5DC3
 for <cocci@systeme.lip6.fr>; Tue,  2 Mar 2021 23:47:06 +0100 (CET)
Received: from esgaroth.petrovitsch.at (esgaroth.petrovitsch.at
 [IPv6:2a01:4f8:120:527b:6876:2a4f:a044:62ad] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 122Ml598004077
 for <cocci@systeme.lip6.fr>; Tue, 2 Mar 2021 23:47:05 +0100 (CET)
Received: from thorin.petrovitsch.priv.at (80-110-91-187.cgn.dynamic.surfer.at
 [80.110.91.187]) (authenticated bits=0)
 by esgaroth.petrovitsch.at (8.16.1/8.16.1) with ESMTPSA id 122MIGmL914592
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
 Tue, 2 Mar 2021 23:18:16 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 122MIGmL914592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
 s=default; t=1614723497;
 bh=+MVoVMUVm8capWlNcUWJStxtBvOtui4ewlEULmYwlXE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fS0wk1Xm132rltWm/1oyGznxEdWPToAqz2hoNZC11FcfHkqVTyx9yXdHBtk/KQgYu
 CUW9zFrgfDiXTM+mo+IlrHMlPPr9NFHKgyMAaMTebilLaUnd2681oIcofQtw1oWtZW
 WSq3taGbZHYFOVrfZvd+8Y37Sy4pPgxmVrownKX4=
X-Info-sendmail: I was here
To: Joe Perches <joe@perches.com>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Bimi-Selector: v=BIMI1; s=default
Message-ID: <22d22edd-4213-0f57-d801-1c570f04ec05@petrovitsch.priv.at>
Date: Tue, 2 Mar 2021 23:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
Content-Language: en-US
X-DCC-x.dcc-servers-Metrics: esgaroth.petrovitsch.priv.at 104; Body=5 Fuz1=5
 Fuz2=5
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 08:12:12 +0100 (CET)
X-Greylist: Delayed for 00:28:39 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Tue, 02 Mar 2021 23:47:05 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 03 Mar 2021 08:12:09 +0100
Cc: cocci <cocci@systeme.lip6.fr>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
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

Hi all!

On 02/03/2021 18:42, Joe Perches wrote:
[...]
> ------------- For instance: (head -10 of the git grep for file statics)
> 
> drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] = { 32, 16, 8, 4, 2, 1 };
> drivers/accessibility/speakup/keyhelp.c:26:static u_char funcvals[] = {
> drivers/accessibility/speakup/main.c:2059:static spkup_hand spkup_handler[] = {
> drivers/accessibility/speakup/speakup_acntpc.c:35:static unsigned int synth_portlist[] = { 0x2a8, 0 };
> drivers/accessibility/speakup/speakup_decpc.c:133:static int synth_portlist[] = { 0x340, 0x350, 0x240, 0x250, 0 };
> drivers/accessibility/speakup/speakup_dectlk.c:110:static int ap_defaults[] = {122, 89, 155, 110, 208, 240, 200, 106, 306};
> drivers/accessibility/speakup/speakup_dectlk.c:111:static int g5_defaults[] = {86, 81, 86, 84, 81, 80, 83, 83, 73};
> drivers/accessibility/speakup/speakup_dtlk.c:34:static unsigned int synth_portlist[] = {
> drivers/accessibility/speakup/speakup_keypc.c:34:static unsigned int synth_portlist[] = { 0x2a8, 0 };
> drivers/acpi/ac.c:137:static enum power_supply_property ac_props[] = {
> 
> For drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] = { 32, 16, 8, 4, 2, 1 };

Looking at the examples: Just s/^static /static const / in the lines
reported by the grep's above and see if it compiles (and save space)?

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
     There is NO CLOUD, just other people's computers. - FSFE
                     LUGA : http://www.luga.at
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
