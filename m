Return-Path: <SRS0=8+TR=VJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AD0C742C7
	for <cocci@archiver.kernel.org>; Fri, 12 Jul 2019 15:27:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B224A21019
	for <cocci@archiver.kernel.org>; Fri, 12 Jul 2019 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kbJ9ErBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B224A21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6CFRdvk004330;
	Fri, 12 Jul 2019 17:27:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 28F6B777E;
	Fri, 12 Jul 2019 17:27:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C17BD7772
 for <cocci@systeme.lip6.fr>; Fri, 12 Jul 2019 17:27:36 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6CFRY4T024986
 for <cocci@systeme.lip6.fr>; Fri, 12 Jul 2019 17:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1562945252;
 bh=hJfyxKi8Dv3K6bksKrUQIE4F7Jrhxd+srnGx/xqqSpc=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=kbJ9ErBoIMNwzmL4y1NByn3rvXVJMdmLgbulzj84QBCJiJ9SixZU4NBSgz8jBjE+l
 Z94iUvJRromQGHfYBWxJbp/lp90f1kVBSt5Hy5ToJN1B0VgD+tY7WveQVezV5d4eRm
 WsdQn8eoS7tKIDVPbt1GE9kKdQXxp7fZ02upUPuQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.134.246]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MC1VQ-1hd7kh3tce-008ogw; Fri, 12
 Jul 2019 17:27:32 +0200
To: Enrico Weigelt <lkml@metux.net>
References: <732996cf-5813-22a3-ee69-d8dc353845f4@metux.net>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e7139f13-c1e2-b5be-a86e-a235b3b75f22@web.de>
Date: Fri, 12 Jul 2019 17:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <732996cf-5813-22a3-ee69-d8dc353845f4@metux.net>
Content-Language: en-GB
X-Provags-ID: V03:K1:A41rKL5N++JspIYkDHLw4c9MDhgDsQV5wLxNQF3nxrA3bNRefA3
 46w/R63NcWWqU6Ls5KZBs/ZkrD5k55SRYGUj4o6p47obK8xGJZMz/un+GgFnkVTlERxk61a
 xeT5ab2L6+RgF6r3hOq0lLY0Mdjm/O/TpleJRQDNs+FNHMz29lWpPv3OqaWxIUsXkSyYLWm
 ib2WNe9FHzMV4eoj71Xgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fyEM4wd2kyU=:sqDT+GS9zQpbyQDYoTOpA0
 l8r9GP/iXu5B+maploY24huvqWiKIN7ve6vqGb2kTkJtSR64GmFCbr3sO22mZcBtM1flSxP90
 qLN4sEx2j14ExO3ZOgM9OVCfNF9zW79p1eTWiqpT2c440KtNnP/bFdsmBiFvdp6GUyAXDIenL
 kHSQba9w66lkT7YIvombVClquRE8kYS6THnosugx5SPBwvKXjjoQSH16FhcNYtiJ4eYHNZ6Tf
 plUi3ZdUmEh38BkyFb1lPuWbVGbVRb7/wsNh08Gg3O0TYdQHv+dW7TuPk474KRiGyg+u3REYi
 mizuyvaZB7q4NMbZ3PGG2snwX08zHG882BnPj41lHZ5QOaOAEI9Ieapex1xPrD9oIsW1IftV6
 yzDGAfo4g/d8C02ykGlcWOWjlxQ6lVdAijaqvhmDuIrQlkJ0v9NH6UzRoCwunN6bnwlno8aHs
 00aBwxRTgaBJ78utmZtG/uaLCP/JJwcPn30IazKP9Dxjji8wTmGt0N+JTXWz4V5aRNoAkrOtw
 96JI/ibllpLxY9/a9vDx0hN2Cz99gbMQSrNnUs0mHShZBF6jPqfSQ9xXzZZluzCYAJQVyuiI/
 3CLsOD6wM+Qv7dZSaloRsywjZsvyK7kBaPEoFcStZ10Y37gMSpqUYwNFH2+ro8CG8lys7yfaD
 yZx6BkJ8q7TDCRV+1HpbGZV8FJDjiUFQnESVdXrrNLkTQmNp67uCEtHhmZLm95qqNu0kgQRFF
 oMVXmquakebv/G3O3rMFSiQkn3rK+nvGtib5/RCMcvJad8f9yQh8GM/uv33AV1ToFLGppI/jk
 W8mCTukX8AegBZO46zuWCRYkmpSY5fMg6A+djBYubSWoibqdwAsIXgKrBJt08224ulboHcAeG
 9fsyc/oYNPGRYZy8j2PuWXN+AULgJ8cEo5fULUMnnWMixLyniI1NJWEOGy1gs75Nh0dRfv1oJ
 sNQ1PQcX1T3sg3NxS+oxu5PGro8JCbcL43yWpUZ5KclRAxMo0sF9WxdoWWfwR/LpZcJsOrA6t
 tAohBH03fd5rqTmLVDTc8de2+bhUDYmOQAv69935FjG+eF/RiVho+QlI0kL9b7w0mcHeVKQpm
 TTuBdZ40RLn6r2ZO5yMEn6uYUPVdGKcwkib
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jul 2019 17:27:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jul 2019 17:27:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] NULL pointer constraints vs. compiler checks
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

> we recently have lots of patches for either adding missing NULL checks,

> removing unneeded ones, etc.

Would you like to point any more concrete change examples out?


> It seems that's an non-trivial terrain,


This area can be also challenging.


> so I'm thinking about potential compiler support.

Can any more development tools help?


> Does anybody know whether gcc has some way for not-null constraints ?

Will you get corresponding answers better from other information systems
than the mailing list here?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
