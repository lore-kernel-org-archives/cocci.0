Return-Path: <SRS0=qWDJ=5C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3B7C10F29
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 08:41:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82AA205ED
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 08:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eAUA6pk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82AA205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02H8eswP018567;
	Tue, 17 Mar 2020 09:40:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 618577808;
	Tue, 17 Mar 2020 09:40:54 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5BA323B93
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 09:40:52 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02H8epMA023026
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 09:40:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584434449;
 bh=ELW+pI6XbAB4+LrQB4O7d8eTi9jILFCzAJHmhYtH5V0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=eAUA6pk7AwICXy+oxPP6OKAENFurroNhMbPr6UKw/KttgTdq6UXR4q4fY12y85vg0
 VHMB905TpIDSRn+HEBfCAUeYb+OP+lkBPlGteh3/p4Uw2Pv93nut+osNNvbD5oUksF
 RfdP2MEUQN+KTT6cDdvE3sGMbatxsmPjhW4HLdlk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.173.244]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LkPjj-1jqCcd3wJX-00cSnS; Tue, 17
 Mar 2020 09:40:49 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
References: <4d55d76c-29d1-1c88-d8ad-606e32a938d9@web.de>
 <3a335c7aef78ea5762248484a645eb5ff27b973c.camel@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <934ab7fb-87cc-b81a-6e5e-1eb601a81c88@web.de>
Date: Tue, 17 Mar 2020 09:40:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3a335c7aef78ea5762248484a645eb5ff27b973c.camel@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:v1BR+Yjm+YoPBncSCOOC0mS0+hCsb5Kb1b0JiRB07YFZLFEwI7g
 B04wuRziCegqPGCPyCYjZqI3TqkOAQL7/HzIiLc5N1YfLewllLsoQOMQKndUf/2Ty2OnNC3
 ips/F6hePl3LuCukrS+lVIwTZGou0wNCWwf4ES5bv8DZiL3sQT17kGNJ5uOHPWFrf3qEjNO
 /w+z/j3XMkS8qCQrsNpVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZiSxqUynIWI=:mEv/rpPMoP7JZt7m4ynYvy
 y80LV2wsYzzyEgHtdVte0guWMGw4VeecNZJmbf5ygxvUlJqHemc2p4tCq6PrJIrjflKkqZZrQ
 XcLR6s9ObR14Y+38+TVpEws9tUQKqyVMrkJPHbG6QcTkC+4y98r1VXcxa1W+by2N/zP3t8nxo
 uTKaQMcWyxVuUGS7GtRqx7rGY/eoOKXUMeqyeVKpmDNQvwz8HJUAQLBn3yB6YvcXVIIL0rIeW
 FAWpoiGA55mVDDRaHstHMJ5kMBSof9Z7c1+FQtue+Wk2yAmZvV62J34VklD5XZLIQ5ug1vNCT
 IVhnXVWI7Zd6Mjtwre2T2nH2kFOQhm4Ah7i7A+6u++oHS/i65PUcvThv9huV6Myie9pslbLbz
 3OVPxldRHyLqN1WVvbN4N4ZgKvV339bdllnjQ6cIVYsn0IIo1q2IByhjFj1AePqSeT6QGd6OL
 GRzP4wfmeOCr7wvTLFmMYrgG3dxF+Suo+W3jQ6FLyXTn3pkXggukKNQ8dSzuViEeDl7qS0hE6
 gYJysXwGhqUgkuUOhaQE2CVBOd4ZjPwOWxEcjuoiaAGjoktcJMzplG1nMRGBAwLaK8BgtfJAq
 K8vn74LscqVpbBGuGYq8semIjX/H+VSBWjOOQYCfXArqdt5bkWyI8BOQM0j9S2bjC3nZEU6vc
 fRZ3fDATSRDL2FFC/QHwy2EX5R+mq7f71O5Fdn4807Fbh8jnxwA0HhbVPV8hcelGFNygoI5UH
 DPxCf768YbgGElguy4zU1k+0BR1p1MlJOnf3chsLpE+/XV3/ZRxEEbdXZSs3jj68xsz1+XCv+
 Ja4ElC1xoRC+l4Awzpo1KTJMFnppk0Ylqc8yI1vztDBmZtPc9pTK8Irsc6JhYMtC840ZFRamR
 RdAWm1TnDVE1G72HbQuzYOeWuGCGtACdpE0yt0nKJvgYzHJT5w7UIpvUNkEB5XykF5x2fEsxW
 7twJqmEsKQ2dsOVUgOXcOhwzQXA5jvxmxiyHXndLIrv7kX35JObmJ+kAdLefcMbPYF6vVijLt
 iqZP4ZcllL1AU22GplEFgCckRb4l2fTembJarE7yEU5ua7fAhoJIhR7tAHgVGzNkIoMjJnFeu
 eFkjktvSskqKTW1LUtTxmLSaAhu00xt507iVJjb55hQ+l6UnBb4wBA3Oob53FYTvZ3C1GJxiV
 gB0I4g2CWxP5YQcxJGqKJK6dEtjrTfFpkAosaE6aI/EHhbuR+OcYDnR4Mr+GvqL7Lj1qLwNa8
 ly5lmS2lzGm6Cw/5q
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 09:40:54 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 09:40:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [06/26] parsing_cocci: arity: Add cases for
 ParenType/FunctionType
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

>> How do you think about to combine such changes in a bigger update step?
>
> These are separated this way so that it's easier for Julia to review.

I suggest to reconsider such an approach.


> She will probably just squash all 26 of these together and apply them later.

I got special views also around patch squashing.
Would you like to reduce the number of update steps
according to the really desired software transformation?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
