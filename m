Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FBC432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 21:00:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2EA207FD
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 21:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bbUBqQ0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2EA207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OL0GsP003951;
	Tue, 24 Sep 2019 23:00:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7E04377AB;
	Tue, 24 Sep 2019 23:00:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 22B2C779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 23:00:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OL0DX8008957;
 Tue, 24 Sep 2019 23:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569358813;
 bh=TAupxNrRSrpLIz1YPAPnLjfHGra+izETjU9Puci+uSY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=bbUBqQ0oXXbq2qzRfNNOS+H/HSh3RGgvyVhqixCXttF58lLBu0xmzTbvNs6ZAUx4/
 wtPnC9H9N3O48JeBKhZXBy/AQW6rSKz9mNAYB3XBoWSG2ETi9NSNOerV7QHyY1CWlg
 BhS87cb6IHfGV7Vz/+Y2TTtjsUfY7LfZhptm46yA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3SxQ-1hvCTV16i8-00qzKH; Tue, 24
 Sep 2019 23:00:13 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <e3e922ef-fab2-ee5c-57f1-0f36ccc682fd@web.de>
 <alpine.DEB.2.21.1909242219450.2589@hadrien>
 <3628f3d4-b9c2-d42a-b1a9-d5e7fe32f171@web.de>
 <alpine.DEB.2.21.1909242249540.2589@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d77d6c40-d148-540b-3071-dd2bce76c158@web.de>
Date: Tue, 24 Sep 2019 23:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909242249540.2589@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:K21LobuUJj04QaZswiMUhbEFULK2utn8Cpflel2UDkxKFZMrlvX
 8aOPa1du0qeXP8h5o3pub+OTYJMwJ35eczN5jd4GTZIrWp7dJXKJDNK5r1trNwIx9kYtoaO
 KFD03/zlFp55Nqd/Mhj/Egs1CGlOZpVkevzqhT50EiYVMe24X4iyVjGO3a2r19AxNcKgxVe
 MPs/xR3xzPb909jeYmsXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B0CkmeIVx5I=:fsSk6m/yHCKnj2GUAfonHO
 kxwrl1rDDigeTN26EC2tVj7IOZrVYnXp3mc4dD5FMiTU5wg99gdUuh6Xm3/X8RKnH1VhXf7qV
 T6ABZTlc11ci35w6PL1rlw86xPpqapP/dcrj32Ij8fModD72fOVNwJRM57xsrr+zKC9TWTbFy
 x/ksXlaCyngJXaX0CLLSsUFVWBnZbVhlf4QzqnUvNDQzf/prmjgMAYI7pMqm6qK0kQ/fvaqPM
 NcsaJUJpbcgBvf4W02yy0Q+602OFbqNoCco6lm8ygPYYnTvZopc+hb9K1kdQCoWS4QSSe5q04
 DTiTgmn7iJZIw3ozQhwSWRi692Fmc6WRLqcFNyUoGQcpF9So6cbR2Og7FfQOg0ZDTwptjrt6L
 IELy0cxOh4jyeRjDVr1zdBKMgGc4Z9h9PQyuQtzvxy2/qJOEEfi51hAwKhkcg0MNWbLXHeShJ
 vPLEpnCRK2MCWVpHdGoX1s0Nylkd1PtQ7dRYYSed0qHI1X9K8NxOrpNDCKe0O1pkk3oy9cxvT
 6GLRMnWNYkz7kZLi4zYUOcI+2NTT+LHsh+sWymp8gYwpS/b5KFuLUVVPchBj5+dH2o91lVHu0
 RKOC10LX3Ui0zlv0+WF9SRy0eFn64882OTICzzV3nL2i+EsCQtUwZr9JmGwIkvBU9TkBGW9lD
 5c+NFdD7d7nM4F9Ze5xK3Ek2RttCCj84qcXbiNdA3w6Duxu2+t7Kua7kt9iuonvfDnY1lP8oS
 JqJkXmHnDqnMHbA/X9IT1OO4hfbQcpqBKFaYmHZ6wPBZEbn5TmhqfTR/zipUXbkmDlEua6UxK
 FhkYZH07eUjjxvfEYRgnFXIhC0alO/NzViZKznDos2fbvzYBh/c1jV+lJlAIXZYM5o/5lznMS
 FbSxT8+4BluG9D91TKlixGuhbCOfK9mlj1kYCI7Yj2R7alOUKAEj63NSoRPEcseaoem0wGoAB
 DWFabL18tpPa+d2mqw6ZZFHBNNUfP1YKWVE1P2sveTKJMVPTuMLGL72NuEm8Jvz7cYeIDjcm5
 Mu1ZXOkRubPgTtYgHM0sZOR2CksJUfGO98Uva9jVkeFa5gCogctJZzQ1PMWuCpCCD2AvWohdA
 RkrpdQCo4W6BmkNspm4R7yUgAwmYdaD1IyzabvEyH5c8p4ztUMX9YMuiTTEmVKDxwJX4UjGkb
 HrPdCzoI0iZQM5c3//0gtNjXSSYBEvuHlrtITka4Zc10pocR25752Pb9kFp8759C2CQFJu0VC
 WNL4JHnHarYEdmO9vD0DATxXRhlK4NsgZJ2EDkbJJIc+Q3uQZl5LJJu7HThY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 23:00:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 23:00:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

>> I would expect that the selected identifier should refer to the same scope
>> of the enclosing function implementation.
>
> It doesn't.  Identifier metavariables have no scope, and scope is only
> taken into account within a rule, not beterrn rules.

Will this information become relevant also for further improvements
of the software documentation?

Which object references can refer to items in an unique way?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
