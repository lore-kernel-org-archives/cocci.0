Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5A1C4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:40:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CAD2072D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gWAlUumQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CAD2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K7eIvH026214;
	Fri, 20 Mar 2020 08:40:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 03633780E;
	Fri, 20 Mar 2020 08:40:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B85A53B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:40:15 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K7eFQu026209
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584690013;
 bh=uPWc8NRRsF0AEnCvFXtYnyq1fR4Fd/ha4UlR5WsJjfI=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=gWAlUumQAg9wk0Xmsvr1GoqTN80PGPflj91Ww+rs+pmxQwHHC5SoH2Y2QR03GZmFG
 6GMpAkdHoWBhbiCyPXL9PQ9UrsSP5J+gtPuqto4gnL15WPpTGvSyDFcGADT0zLhQ9F
 COybHj7fJ5s6sc2LWf1KtlgLtDtHCf+SmjW+5o+0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.75.57]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o3y-1jZcYh113K-00tmmb; Fri, 20
 Mar 2020 08:40:13 +0100
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
Message-ID: <4174a7f7-a012-e2c5-72bc-77196f4a16ef@web.de>
Date: Fri, 20 Mar 2020 08:40:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:+c/DwuZTQZc7HLBrBsFf4rIQsuxdu8IHT8ZL8RNqQbfmnNG6Tka
 vHelPGGVJ2IBGf3QHNZS6jLpVxrh7leF2lH5O+/uuwWfws1vWHfOYHuWdO35YIB2EHm/Hmb
 hg6v0QmHU2JirK8W/pg4CdpV9lxvrPKjTiN8vqASa6MYrS9Lfp8TEz4bMHIUT1HTzgnq0wM
 Evxt7EQwtPLPtNFoaKoTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ogGotsT5P54=:a305xLh9aLv1XwLHGTl6bc
 DTbeWuJBBUeKGdgIoyX6z/i+3cpU0Iu3ecS596WvjPWMo8ti+9RPlcPXu7NpYAdOhb752bsaq
 uIkZ97wOc8bSr8WX31vq0eAJmK4yzKEMYcJ6J0KrczA9nhJeqykrRUAPGEPnHPutKoCepUUs1
 i6GCEUcwxAWyvefGlZftHsTarXGQkNixC8uSSyHVEJl01geDrgqQ/EMBdGmRkg7F4JJaIgI/f
 XMbh3QIkB/SPhuLHMmHGKHGOkG8X8Y/mIdLN5ncpDrTrMVQv79t6N71urwdIXshBmY4AY90rB
 DvbuFBu1CUnFbRiNxk+lfFi5zfx7bOqIQKFwF6jzwlIjWReVwfUzAiWkOXiwIXaKut48v1WvT
 2YMk1dArFexs3MbDOTjYqARzBI88RX5o8EQPgwnq+EoSCYKzdO4hzY4dWwd1DOijMyXbL4u6A
 FTI/oJ5AIEZJDMbH7A/SzGp0hETHifRvZh1frbSvKMlfuX0NkYGNYbKnQc66LNCwvRmui50fF
 BmkJPmeW8/qVtg9XnksR5OXCzUY6Du62+dqpTAXrzpe4k88PgvjoZO8rp51qY/pis+qWq9bOD
 FW51JxvDG1OZvK7BfMWfDv+Ju95j9p5yksJRXjCeBFQHcTaJ2eyVKbUOrYpm403yhHwbeE+Sf
 j5x2Pbvtw3LzUWrBXqR03k8AV9piS2SDXPKwUfOSYZ5iCF6tz/t0+5XU2w3p0Ind119JOaEP+
 z42lDe7wMO1j6SinQfZlUPuuxAJ5y4mRpSlVipR5OptdJFW2xN7jFi1F2Hsd6dg7/nIlC+ExO
 BaLDbAAAxz4+yM7x9tvtC371haruZnVBjdmqb+68LbRy8dHehNrnN++tTL4IGQNKb6jzXL56d
 FvuiOztP1KhdbH3WBG7MSG7uusM2MwwYdk+AwFaD6uhTUYNJvSmfZDgsgtM2DgU7v548ixv6p
 wf5ZSh4g84a5DVh6dFOHiFwEmWf9fF+PcBT/8BSucdwtqDAiN2SIhpXM13AIWRE2yPKOR07D4
 PQJ4XGdYGcUZ0rQaDMNaXtWiwydwVRzdaKc966XzjHibzgrMMu/1ZzTfdEx63x197F0Hu/QVh
 oN9yKw8fqHKZ5ahhWfNYgJ/EzOMaGlswHOuuHs/f5fxWed4N5MhivFO0x7BgT4K+02eZ0xZoN
 yRCB9QiYvKzQawYWziDfZHoSNmgmDz8VXs/6xAoiCD8mCnG/Qcxs490LwrvbmNEISIJGLbk/Q
 uPZGICPrJ9grf5GkJ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:40:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:40:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH v3 02/26] parsing_cocci: AST: Add ParenType and
 FunctionType to SmPL ASTs
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

> ParenType and FunctionType are types present in the C AST that
> are not present in the SmPL AST.

Can the understanding of mentioned details be improved by reconsidering
the usage of abbreviations?


> In the pursuit of aligning both the C and SmPL ASTs,

I find this approach also helpful.


> add these types to the SmPL ASTs.

* Does such an extension mean a copy of functionality?

* Can any components be shared between affected software areas?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
