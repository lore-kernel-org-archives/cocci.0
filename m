Return-Path: <SRS0=YDxQ=X7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C062FC4360C
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 05:29:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0985B2080F
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 05:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0985B2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x965T4dP015862;
	Sun, 6 Oct 2019 07:29:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 10269779A;
	Sun,  6 Oct 2019 07:29:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C13C17792
 for <cocci@systeme.lip6.fr>; Sun,  6 Oct 2019 06:23:29 +0200 (CEST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x964NRDB005552
 for <cocci@systeme.lip6.fr>; Sun, 6 Oct 2019 06:23:29 +0200 (CEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CFB20F71EDA02A3BA95B;
 Sun,  6 Oct 2019 12:23:23 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0;
 Sun, 6 Oct 2019 12:23:20 +0800
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Julia Lawall
 <julia.lawall@lip6.fr>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
 <alpine.DEB.2.21.1910011500470.13162@hadrien>
 <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
 <alpine.DEB.2.21.1910031422240.2406@hadrien>
 <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
From: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <490422f5-e33f-3aab-ba2d-747b9fecca91@huawei.com>
Date: Sun, 6 Oct 2019 12:23:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 07:29:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 06:23:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 06 Oct 2019 07:29:02 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias
 Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
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



On 2019/10/4 10:32, Masahiro Yamada wrote:
> On Thu, Oct 3, 2019 at 9:23 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>>
>>
>>
>> On Thu, 3 Oct 2019, Masahiro Yamada wrote:
>>
>>> On Tue, Oct 1, 2019 at 10:01 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>>>>> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
>>>>> index c832bb6445a8..99e93a6c2e24 100644
>>>>> --- a/scripts/coccinelle/misc/add_namespace.cocci
>>>>> +++ b/scripts/coccinelle/misc/add_namespace.cocci
>>>>> @@ -6,6 +6,8 @@
>>>>>  /// add a missing namespace tag to a module source file.
>>>>>  ///
>>>>>
>>>>> +virtual report
>>>>> +
>>>>>  @has_ns_import@
>>>>>  declarer name MODULE_IMPORT_NS;
>>>>>  identifier virtual.ns;
>>>>>
>>>>>
>>>>>
>>>>> Adding virtual report make the coccicheck go ahead smoothly.
>>>>
>>>> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>>>>
>>>
>>>
>>> Was this patch posted somewhere?
>>
>> It was probably waiting for moderation in the cocci mailing list.  Do you
>> have it now (or in a few minutes)?
> 
> No. I do not see it yet.
> 
> I want to pick the patch from LKML Patchwork
> https://lore.kernel.org/patchwork/project/lkml/list/
> 
> You gave Acked-by to the one-liner fix "virtual report",
> and I am happy to apply it to my tree.
> 
> YueHaibing, could you submit it as a patch?

Sorry for late, will send it.

> 
> 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
