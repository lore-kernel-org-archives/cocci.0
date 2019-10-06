Return-Path: <SRS0=YDxQ=X7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CB8C4360C
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 05:35:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75672084D
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 05:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ig1YpnHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75672084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x965ZH6N026995;
	Sun, 6 Oct 2019 07:35:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 57E08779A;
	Sun,  6 Oct 2019 07:35:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E56A67792
 for <cocci@systeme.lip6.fr>; Sun,  6 Oct 2019 07:35:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x965ZFwt009089;
 Sun, 6 Oct 2019 07:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570340093;
 bh=jqDEQy95paaaY/xlGarqK0guNTZVh7kmM1p09ETOPMI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Ig1YpnHzykbLhwBSFCMeHMsUGuu2J1CzRZqbwmKtHe2hiy/6KQsDW9sxJhUN3fHyo
 Re5Y+ghfP1EKA3ltCL44dGioL1AqTghqIfzB+MgG8HIi1ihHhzQDU3cHQ8ddsTOA60
 /Z+ru7Gy/lodEutaBLoC6+GXQSbbs8T3kci31AWM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.114.140]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudP2-1i8DhV01ei-00zrgu; Sun, 06
 Oct 2019 07:34:53 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu
 <jeyu@kernel.org>, Martijn Coenen <maco@android.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <21684307-d05c-1856-c849-95436aedeb86@web.de>
 <alpine.DEB.2.21.1910051425050.2653@hadrien>
 <f64fc086-7852-b074-6247-108b753dc272@web.de>
 <alpine.DEB.2.21.1910060727580.4623@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8390d1f8-1907-ef19-c527-6bdb380d96c9@web.de>
Date: Sun, 6 Oct 2019 07:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910060727580.4623@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:LwrOLrlkxdfIiJ+lK8xrwMAnIPgg176TR6uhPc5hUcrx3iVJFCz
 LVkWgZll/5S6gWtE/hN3kORFdnNHSUl8yl+dfXBQVRyVMkw6rPeZ6RCS5LiIDvX6vLyykZr
 V03aIPhiGP0uz2+E3Kuv5YnFwZW9+CvNFrIHwwVq1Erp2t6qTUZVWlQHEA1SMXvh1kmVTAV
 vrVDjaFI5OGgZNK35jimA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ntz5E/2JQh0=:PtDTYI7NtZF5xlYInvSP/7
 YgCFQKmZyPFegVGov1rptOZZQ3nt0Op0s1yI3LgUj/BA3qJ8UYEbNvJ0yIbghhZKVBR9mksRs
 BGasHCL1bSmN+LhBkLU8wDBuP8WNlC7o/CTgZqsdUDi0qck5uL5H1v6k2tbbVrHORNf027i1R
 f2bYpaUr6FeY9NQZILhzTFOwq9sRWYUshX1UNrDe+mCjRmQ4I/YHhi4REw2H1KYKTd/yYxqM7
 rC1pRzrOZfFxqvJKad5rQt0zssTRRtKph8mFQdobLbYUrwnvmm0jQqwYlWYa+LCfaly8tbY8V
 ql0Y4/ICwbCYy3jTxgm0XjUId0tq2FaBhA5LQSVFFXxovdLsmO3kMGhqk7VIDEp/yS34ixfgc
 bDvxYyK77Jq/dzwtgDNEEWRO8USGU7LcSPDubV9YrRUFgs8SB++0Q7p5uw+xsQLdd54ngl1Sr
 AyshQO9FucLIy9XnUj1yzcPYrOmk516usR9EdCg0JbthgQLfSdyCagv4ksS17fAVW7aAmNRRF
 sJFfoaixDlqD0PA1z7XMEe/fA/N6i8pEj98D01TRw4LaM6KgBaXwToe2Zomko3kJ1T6/MEuRl
 /pt8kbalKcRIjCs9FOh3Q24gzqVRULe1E7TTJNe6Ha4HPtuzKvPaBc6jZ5zN6lj33MNRKgTPN
 M51w6t9M9BvKNedDSsbeGW+yr2KXh2a5iuubt8REwhPovXrrSBJz4EVklJiATOcaTrTjqB/gH
 041c/hOnMQ5Z4jDgwQHZlHzHidD276aIiwNSlMTy4VubS1SPl2bC6wgclgvLcFYNL1lE6L+cl
 0e1KPlfC3MnXdJAn9VEuM1sda17XOkbm5xXyvtWSYN8lP0bdpAfKel+0uI+Y4wv7MsqnI4OzU
 Q7FgtlmIX1qYZVc6srWvMQvO1L0a6FfHlKOb3j/Ab793IC0wytDbMxS2EZ2TV8JB8CtGUA3fV
 cNTHwpuwTGmtxv2fEIMhvBqei5p8rTPHekzds3LT14cNpPw2Ct3ZGqJlSxA/3WyK53v3k/kCD
 GRmuDNX7/sOP0u86nxTn8lwNETc67HxWq6YhOTX2or4Z3WDC5x8+9/TrWbrX7q/nwZubnx9fL
 /ZVatjXdIuaMinbXi5pA0jlUfoAZNLFU2kuuzRTcY7ap/nnFgaYyVisCU0q26NP52VpegcsJp
 fXzbejfBShtBfxEreFzQJp/pRz4mfjmG6cD4Ld2q2L2yIv3oN1sNfZCtLiPvEpnXHlRGSC0BU
 +1Uj74o6mExNFL/b59geesWxTmsugwJbCsQYn+iKbPXY833zpoE4juROtsqc=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 07:35:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 07:35:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
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

>> Would you like to increase your software development attention for
>> efficient system configuration on this issue?
>
> No.

Thanks for this information.

I am still curious if other contributors will care more for this aspect.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
