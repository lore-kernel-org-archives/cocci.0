Return-Path: <SRS0=gEjp=YG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A9C4360C
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 16:39:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7319206B7
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 16:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fLZI45Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7319206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DGdZaJ004525;
	Sun, 13 Oct 2019 18:39:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 12B597784;
	Sun, 13 Oct 2019 18:39:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B09A67415
 for <cocci@systeme.lip6.fr>; Sun, 13 Oct 2019 18:39:33 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DGdXwp004084;
 Sun, 13 Oct 2019 18:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570984768;
 bh=nYVj9nV7kX4Gc6axh515Sr2VRfk+MnL+aJnTx8Waf4I=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=fLZI45QyEMkftTJW7BoM64f1bO+vATL55VUZl9h4gD83DPdd56Wc+cTzk0bpX7lSM
 3IbbDQBt6Q1WnsZd8Kg8eZncLS8pDnKbNuMOsp5sVBPvpBAtq7FTBi8Du/UiTrRbuM
 LOFktkAAeajxEUv+RrByYVcBBS+Uk63DyQ2spUuc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.172]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrPw-1iJgu01PZg-0002f9; Sun, 13
 Oct 2019 18:39:28 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
 <a9ba6674-92cc-d8b6-f60c-1cf0162fba75@web.de>
 <alpine.DEB.2.21.1910131536290.3260@hadrien>
 <5bab8a17-168f-6bb7-da1e-e3d3b92ca260@web.de>
 <alpine.DEB.2.21.1910131808390.2565@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1808651c-0a61-3cc9-5cb2-54a5451f7c5c@web.de>
Date: Sun, 13 Oct 2019 18:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910131808390.2565@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:okAg3PNHrAN9AFawmO9AgGpbT8p6cTnnwHhvEbNAJbL2JS8L8Pk
 AYADoCk1XZlLFm9PF57p1FnUuoJmtfzCLIgs+ypn6AdlDtZ4Tavu+L56Cup0ZsiK8m1VGxC
 uPVjewGi2lTt0mAzl6F63b2i3Dc7kPotywoVmXl996q/HRZpMaXFZXI9Rp/GuIXCHPxle/7
 14tZEnzrRoOtx3wHKz+Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ze+8LaBZz9U=:GNKMt1d4Q1CZM+fmPiDd+g
 9QMnfVLFTUdn0vabMxLI4zXZ617S3KA0Oeph7ezULtUJFgLNVVP5G37PsxKHm+VkVCTopa7U6
 Tu3F9h5DdG0zuCmB9GSaTWWUR2gXesFAL9zwybTU4LfHAbc6gaIT1vt7GBr7lw1b4i0/obNoE
 9fUEtF6OY9yeNY/m+Yhyt5J9VPzFFWE0taQtkC3RZqchYOpS+DdMIfeSjJzIOJqCxD6lTfQ8S
 77MqL5otR52rA7leCSwPLOgRRPN3XyLirzNpDdXzk+6IVFyonK1Ex4TZcICEPDNM9/j9pRh05
 WFjoeu+KxaZwWkRS1Ulo7ub3zZciPu0894MaPbiRA4CwTdWfOstY2hI9cmfSSKUGCXESnALa1
 kP1NBbMul6stz8kJ2oqkQuuYeuYpLb7a6Kd4cw3Romoin0Wc4XT6ncOvv71wvISNBICYvHLlD
 HnwFEICyy5yGkNXkvHzSTgOa6UBKQM7LCutADQbP/lUsoVx4ZWsKJZ738SIim4lVf/kYGN/JC
 kwgljySPoG8Nx0ieUtHfP4ZH3rrxTlths6P7yUxFKT+mZro9/pKSx+lmc6weVNeG3uRtRznll
 jRiZpRBevhxxoZBp+R1ozhGrbx6y1JY9BGX44xZ+kaJ7/bpBb3eMv4R0y7Vqqu+nHT1GYTmEw
 sKI+rZTxcuEZS7Tyk4H62fRRQhfSV5QBCJuHgFyfUtjfMkl7Wt75PswfqtFYssp4go6bzT0x/
 dlXIzWk4MBy6PuUap6r3w0yeXwAFWzO3rWS9TyTONA48tJf26ZDmIvHUjzjmuowXeK3fKX8YU
 kLeM3ZJT/nb9BsZSo3hH1TEpPj1iF3dz/2LZVYCIL3vAM6u8OIzS78br39VTmY0Itv0SSJ61R
 gIANGXgBg/8Ros2Z2zK2NhI8ZQfK5geCDEQadeRSf1VCRM7ylfBXJGSHfcbhbta3wB+IyXsXE
 fF1csEMv44tloKbFcmmvjhhxUxIQc9uUGlEdR1EvM8LVgr+OW8aDsOxuHgCfYGbZ0YPCHo3n6
 ssfSnSPAaX6IO5kzTA85OZcLY+JuSvgELHstNGmvKfTH8xQhnd1MGVzTGLxsybz4AP9Scljy4
 oUC7dUiLFdB3iamkIrhnviKaliKUuTOuCXCo4HxyF46muI2L3lodHkSd99NCz15CMDiojHAyN
 ZJS6/5AcA123ULAw3jIJ7vgxwUjn1djmEGjAPAgrBrQ+zwWJRDKnXP7TK4NjspOMSehiuIVTw
 kVGEdMq5uwBq6X44vwr1B6NXnS6NSIvQENxYVuKWBWrFyGWDRXDlyRw7M4yU=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 18:39:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 18:39:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] =?utf-8?q?Checking_the_influence_of_=E2=80=9Cvirtual?=
 =?utf-8?q?=E2=80=9D_SmPL_variables?=
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

>> https://github.com/coccinelle/coccinelle/issues/35
>
> This comment is completely irrelevant.

I have got an other view.


> There is a difference between a virtual rule, that one can declare
> as being matched or not from the command line, and a virtual metavariable
> in a script, that has to be bound for the script to be executed.

There are different uses to consider for this kind of SmPL variable,
aren't there?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
