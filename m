Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42253C432C3
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 08:29:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DCE21774
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 08:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FUj2tA6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DCE21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAT8TWxX006561;
	Fri, 29 Nov 2019 09:29:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9FCFC77D4;
	Fri, 29 Nov 2019 09:29:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0BD3477D2
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 09:29:31 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAT8TUak012240
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 09:29:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575016169;
 bh=+sm6kHz/YxWHIzZo6gAHfkCnrdCqbg0KH2G+lLPWiFk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=FUj2tA6PG7Iw77jQZWS0fTKfb7d2cTlA6SUKrCVZMILY58b9xGoqCHBLdFEw5wit/
 K1AWfzMGDSCBHEa2xrmnVgPmYDMQqS2B/tfNJex1wXzifMsTV8hlkNhXArgukortbW
 /LufB0ASx7NIqvMTQcw9gVMHeRiHvQyyLG4zCs08=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.90.162]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgHPM-1hxz2r1xaO-00neSd; Fri, 29
 Nov 2019 09:29:29 +0100
To: Jorge Pereira <jpereiran@gmail.com>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
Date: Fri, 29 Nov 2019 09:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
Content-Language: en-US
X-Provags-ID: V03:K1:PZIDwyGf/YkptbdsYSrlJs1nGe8Z/0M93KCpPnVg/Glme01W9xQ
 bODqvrli24wXvt5jcwoLo6lvJW6wRdF7cbRWtKxjpGF58rJ8D1wkG8VX6j/DNxRWVGRUcs6
 w3i7M4vtqq3p4a26KYeCA5WC/oFRuLgMjdKxqz15Qp6zPeJn4lop/QF58cvlE35wEB0Teys
 ycfZZPNRRJjE7WwQ4rgog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hS0eU+1aSIA=:32cXIW8gyTnsHM+xF9th8g
 gHAhwSzCrFQeQwihqZzFdasHwexGzIGl858gKxIAaIE8dK5HaHwg1cjABYwKa0Qj2gSpDRv7e
 H/7g7SHn8ePLU/jZe4dZNRJF1W+nDcGoekzoSDFFW2Sfz1rBZOKVs7gdWX2dHxrv7ABP1fvBi
 NzwgFVYEMvtJnrt+S6wuzsK6P4qB2R0QsRMxDRYwYVWXZ70j2nmgss+Y3oY2M7CUlAMZMDTF4
 7kOwgOWFxVbqqZEwa0PSCodvmYPmS7raUd2yA5JEx7JW0/w+SZNKQ5GcWPL+ZnZqGBZzehFKB
 zB3r1r98aWZGqQKgSKiZMXyd8ugFKItGXuvL5UhlNumLq9hIMFvDmho08bhx1s0xGpbVejIXa
 vmhzHM8xAfSnSQlKz8RMHdm1egNUNSSkF33yV6CU37bsPtfUOztmSdJc8YB5XNBfrzidWFrtv
 1mZIy772Rmo1swtcbSBmt/zBgtbm2IzIABvRDMXLZc72OpBQ4duN7vd4d7kfyRugElXlkyFmq
 hJW7FU7+C0O5+XYizbjbRSpQkmO7+gAYwXCHjCpVuClw7ozS7wCm03qA2nhElGRSydwfxz9oe
 4BUpJK+GZ8Il6g5CMiTmoVkWEwvAYUfgQayOhK5HUozkghG9feF0FiPJ1/Oty9Qmpeb3uaEOz
 ytfOD4WpGUI3evGgOGxpM/xwl5/xppdRR3pneSvKut8kvwnEKg/n6O43ynIt5nWTRIca34nvb
 c5ZPbLZUl4m0YgS+Y/uJKd8IgUZ8CqI+ymj6r7258NB1lmY6mPwrum7PSS5WwEihHhKol5Lcw
 /0XesReItUxmsr5URTP+cWIJ6mjP5uLSnmgu3OTkV6EU4EHePmOZVrl/ulYlZTgeOQ/5BkRC1
 OqYZNLK8nPNJvsdHfX3DEuFfKb5Nte52NtrlXib94VJsusLRszXPsScxTSrmgyz5FMRUKxyHC
 WpOshHNIsyHRdNNHB8pA2ajjRsqUdTramb+vTt5XcQbAFAlje8iDjiO9BsgXTqAG4fgABeU/1
 RYi8eE7VWC+NoKdmmJFcIirXDfgMqrCUReCJtic7r2q2t2TXuQ5oQca5iMhiQ/KJgPFPpyky0
 nMv//Z/njppMVEZ0epyfcs0lrykNYtDZdejm6djeeIAPJqMNBcZ7Xt6l4QrRKqIxV56giexfu
 98GWom3y+Lpfn91SWin29AQ+OF6Ozeam22UxUZJ8sPIt44bhTq3w/MM3QVVTCMI4TO/P3C3Ru
 EW4Ec9RVoCze6zY7yBVLusIQyAprP23K9ZHjtAq6NY8Iw6zB47e7iok0oDuQ=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 09:29:33 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 09:29:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf() parameters according to used data
 types
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

> For now, I just would like to detect and patch the mentioned example.

Did you try out to work with SmPL ellipses and disjunctions for this purpose?


> I could imagine that could be possible do using Python,.

The application of the semantic patch language (Coccinelle software) should be safer here,
shouldn't it?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
