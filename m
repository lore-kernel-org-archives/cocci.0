Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B82EC2D0B1
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 14:43:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4823D2166E
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 14:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oKXtqfmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4823D2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 014Egx1v025255;
	Tue, 4 Feb 2020 15:42:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A502277EC;
	Tue,  4 Feb 2020 15:42:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A9CB977E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 15:42:58 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 014EgvKN028997
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 15:42:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580827377;
 bh=FiyAIDP45VSpGbakYlsyTWf9nQAP08hBnR0GDk09Dbk=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=oKXtqfmAw5nI8imfvWOroGXS63b7ZGg7i8rmzjZrb07Y04/1hsHRUpgW6ZEbWbltM
 0AYJa1v93VpvzAU3hTiBi2E7/G+faU8K98q1m4OlZ94LPnO6Ysneq8Qqa4XD2hxO1x
 bZRU3z9qD8K1fdQTgJRYZAN5d0FCKC592ou9VY5Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpOKb-1jUUsP3waD-00f8A6; Tue, 04
 Feb 2020 15:42:57 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <CAAJnyheEpd44ShTijdOAq6QZ9dyjJ387dcJDHg5qcd4aN90PYw@mail.gmail.com>
 <5fe198eb-2e43-4ae3-f82a-e7bcfc394623@web.de>
 <alpine.DEB.2.21.2002041418420.3345@hadrien>
 <6debc5f9-839a-1b7f-7d11-cd7a7c6b3866@web.de>
 <alpine.DEB.2.21.2002041446400.3456@hadrien>
 <e2cbe977-8ffc-90a8-d115-e868d138e98f@web.de>
 <alpine.DEB.2.21.2002041524400.3345@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d83ef383-fa56-6b0e-91af-4a8dfdab980c@web.de>
Date: Tue, 4 Feb 2020 15:42:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002041524400.3345@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:j4UCmFntsBNTCDqALqBbDbJcnX3Cvm+XkOYj5CO/yFdm53z9DHj
 zVRqPS8Th5ngi4XPRyecD6wn9YHm5L4h5uKbqbPq7mYf773H7gY8Jb6m7KLpfT9qFUXIWUs
 MerOrCRf6hIOLHDOf68g0o5/iojRaz1Rrv41Om39YA+pA4CKncW+ote+Ydp4zX5XCpEAoiH
 pYri2Tfvk8+SPD4kCkTYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EAO/jdmlJ3I=:44kZ/uz9KuEbeBDYVReT/a
 3FEKM//J152SuMU5UKX8c2EhLe5ui5J+sJQkeUmvIP4Rl050BB6wyZilklq1tQS3eTxN3oN/L
 0WAMJwAzCHzXYqO0n5TqJAbDb9kaZbfbQTUWGoHRuCN1//QW2d54QR7IQQFTcnd6ZS9nVkkC7
 L1bsaK2Sv9adpfzLuYr8EqnM42nXlZ/76VITP5R9t6+g5k/y6N4Q1XOgKg8LujrRano/mIqxX
 LFrsQ3H/vkIsuCUPaw7GqijEbRquFBeXH/rb3KUO7MA1GJOTy/71YNxw8qqCOd9OeD/pnxB/V
 wJilfSHVUgM4TanZcJFuwEi8XyYPcxf2sqg9W/BU18xXajqikYtemwigRobogyXDb0RrF0Taw
 ncrmi9X+q4VnCfqhXOb1GY0OUz4WDvVEg73ns7+hcoKMeGgKnhZSXy6fTYllpELeqEP3OSOlS
 AL6YU0XGtQ8S22mRb7cjpoX3ihlKS5TxEXf+6iJk+xPBRNMuPD/b/ga+KrfmIIyoLMYuSYFcm
 3ATG67f8teIJiNxBnBEhFMhdrmbqnbHHmhlhADCUTU61HAt4L+glk6PSiv0XNZ1aEaH42v7Dc
 AE0+ZgKnSuYwoAJDOG0YXpPqx3DB6jzt4RkvPvsZbvhnEuT2xt/SpnqFP1rh0txXoz6pQ4sS0
 6wzqqDPiQF0+ml5TAOaLHgdvVl9mdqUmaaBpoy4slGgSRJoSJxh97DuSDt3C1NxUxkpL4OrSi
 5NlyD4HiDvPFDwn5qgBNQa2TLta0m34S4bKk+grSchTgv64agbPm6LCuyL07zfh/TaoZLo2QE
 7sTt7sLCYkjB/UqRGNavsaiIF7Buh1pyqDpnE9dBD9iXZirELp4EAUwliTkBFSymvpDQOa/48
 +XB+kw36+JiJhPo3klycRqHIjRxzoJfn+pPrhdDgnh/ugQLCp5U+BPmvA4F5Af+wR4r6gRyZx
 EC+j2NOA+uhFcexwrLv2n+n8ZhIqLVkhxhMlFIM1vtnO/NbgNV6YvU7ObypTrn4nwh+OHaBdz
 N2Q4ulLyQoktnCEZWCzvBX7sUOFjbk5NpGhEFsR6Td+uE3UUOmB375CzCLuNFPXvtere5tXqK
 57HVLANc0nap3p+e8wTfOJKb2uUtJ1gG99LoX+/LxkZfHYeolHNap9CwyQLoCNZ0Mj/C65sag
 1WGvS6mmcn+qPeVFdVGXrjQf2pC0jhj6mXBXfVLbIA3B6lY5d2+jR7p37fde8PvtzqcVmeX62
 RhQ1obfwu5oqBZR3U
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 15:43:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 15:42:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] =?utf-8?q?Usage_concerns_around_the_SmPL_construct_?=
 =?utf-8?b?4oCcPCsuLi4g4oCmIC4uLis+4oCd?=
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

> Coccinelle could provide an appropriate running time by just ignoring the
> <+... ...+>.  But that seems like a pointless optimization, when the user
> could just not put the <+... ...+> in the first place.

I would like to express a specific SmPL functionality.


> Coccinelle already applies a rule everywhere that it occurs,

This aspect is clear to some degree.


> regardless of whether the two occurrences are in the same function.

Our views can be different also for the discussed use case.

* How much will the requirement for changing selected items
  multiple times matter?

* Are we eventually looking for another clarification also
  in the software documentation?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
