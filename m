Return-Path: <SRS0=lWmI=34=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDCDC35250
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 08:31:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660CF2051A
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 08:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="I8cGoZie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660CF2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0188Un9Y012428;
	Sat, 8 Feb 2020 09:30:49 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B32DE77ED;
	Sat,  8 Feb 2020 09:30:49 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C492A7718
 for <cocci@systeme.lip6.fr>; Sat,  8 Feb 2020 09:30:47 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0188UlZr013538
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 8 Feb 2020 09:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581150645;
 bh=qExT0HKsLJtJm7FeJlbc+OUWcDIfTKN7JrNWQzb8zDw=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=I8cGoZie3LEsSh42f9rYFXr+TicoQAlReU8/iiatawqaEx9vFLakpWtEJmPXRY06X
 IXWqoELAQdE2yn3ZpW2TohSGHBACZ2i4xd1MTd5IwYZW4Tk5UvoExPD93+ii4E0Nsw
 IZyOAS2DeFyauJVa5Mbi04hjQa8EkLelt/8QkyKU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.97]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnjRP-1jRhdq1FIF-00hvcH; Sat, 08
 Feb 2020 09:30:45 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <88e09c8a-e39f-2722-9f87-333d2c14a7a2@web.de>
Date: Sat, 8 Feb 2020 09:30:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:7zPL1jOO08iLCic0pWMNe68gGt1pa97fMljRWjcyY9xDHtN96dn
 hbs/hWOy7dcjk2RR3lyGk1dsyfwiFiTVbgYG4ABmA9vman7fsCMCCMFD1bhnPPe+Y8pH9/R
 YnjIlmV2zIBWSIbovjcg9KwliOtT4j6fy32f/8W/0/neB+Kc2bnXIQrr3XlvDbaKGBLQP+m
 vGIKF048VnHtRBaz25i0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yDj+sK5P8Pk=:BNF56iF79N62Q/V4mMCm3g
 cjp5+xB6bltcREf+B87Q/9jD8JqqarNV5vKxHoUYNXqUqpQVVT4T3znJZi+Jruu9l1oHTXPDc
 1GsvrThJ7LlBQV/PqYoZ1TrP4R2t1uCCciY9SZtbRkE8OfkdQI99f1k+bVE4c1SRSyMkw8hcx
 3vA98eoEybsgBJpDDaWzsCcco3K/FoQE7LBhEjiIeEprxjXKoSY/MQFhnEzr71v03nV7u/49E
 NnKeNpHSu1ahBPsN5bffvmWHze/E7Yx7uGWzP9WA3PaGS1WwcB0XhHtkch9zQMtAPpCFuv36K
 /7Sh8BqncYDydQELCRrCjohePMVFBSYmUq9m2NKnUc+oqJyrGu5BOBrz12Za87N4oUa/ozUhi
 txRDIKREf9jro+oioEIP9GXkPW8g5O4u6peYJCHPZpElqAJ663sHViN6THSRb/zFwbWHWtL1k
 74RHY15Pi5PAhRkN8iNtON0F/rSxxYMOEUtBJpalKl22eni4mlA/7wi/y0njCsyOm26Ay2+ox
 ptA+gdE4teBhSit4iUlA7ibxnrrGg0NzdhFY25fEg+hp/j3CtsN600RazWuPIrmP9iKbymgn4
 MLMLhW7xf3zyiT0M7Tohhf3LMnN03/LEOW98lFLtawzOFMj9nkaWGUs+gAkOhC4MlHWmAVgOf
 JTg9BNlZISqFcH3822+1jop2PEbmCSBaihnG+FnLHVYZu7qLborTA9t1lKPYAoFl6kDAsB3nN
 dd45UiVrXnbZu1+AUuNwTUhVkcg0ishUSd0DVRCTc3zcTc8uFw6VuiK40nd03zjj9m5Hi3XQT
 Xc8lkp1Dfaq5qVR53M0K1CPT+bOJBwgMG0RHtpwXeZjzmz8OXWSpJTqF/AzljtmbI0hneJfRv
 MD181fzwFfzfEcOZSjC+laBoC+7Qb/q2lkKMf/WA/cizPkGgOeaXRCc2RTo53GQlYROztXhTT
 RV7NEMON/w5QddJIhqmL3qe80uesiEytZvaZpOR7yvv9kDcA4vFNA/A5p8CcREIc2/Us1Y2nH
 8WmOulODHVeOaivycmBl37k74cghFZuPmnmuA9UiFB2PIuNuUatPH3HfOmZPCtAnOlWsMrVDZ
 qV/Iatk92GtbYJdY0jFMfVSeoqt4/lGeqnwYjmWv0LTPCNdMvQORK1EZEE1+X/befM7bEPDic
 vyjmj4l91BtP2/lQid4eILH3p/hdcdBkLG6IRCBN+pzPCBekUXMgEOr9siC/jnQ2TfVyHjcOd
 sMdRS/sq/WE0xLBs6
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 09:30:50 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 09:30:47 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 1/2] parsing_c: Align C AST and Cocci AST for
 const pointer variants
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

> For a pointer, the C parser constructed an AST dissimilar from that
> of the Cocci AST. This caused failures in matching with certain
> pointer types. For example, for the following case:
>
> char *1 const *2 id;
>
> The C AST constructed would be:
> const Pointer1 -> Pointer2 -> char
>
> The Cocci AST constructed would be:
> Pointer2 -> const Pointer1 -> char

Which software development tools support to check such information?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
