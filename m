Return-Path: <SRS0=jkZ/=X4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EE6C4CED1
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 12:22:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274C820862
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 12:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274C820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93CMBJ9013389;
	Thu, 3 Oct 2019 14:22:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2F11A77B4;
	Thu,  3 Oct 2019 14:22:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 58C3576D9
 for <cocci@systeme.lip6.fr>; Sun, 29 Sep 2019 04:05:14 +0200 (CEST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8T25CGh011809
 for <cocci@systeme.lip6.fr>; Sun, 29 Sep 2019 04:05:13 +0200 (CEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CF3A645BA623D5B0E6AA;
 Sun, 29 Sep 2019 10:05:09 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0;
 Sun, 29 Sep 2019 10:04:59 +0800
To: Julia Lawall <julia.lawall@lip6.fr>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
From: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
Date: Sun, 29 Sep 2019 10:04:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909280542490.2168@hadrien>
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 14:22:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 29 Sep 2019 04:05:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 03 Oct 2019 14:22:09 +0200
Cc: michal.lkml@markovi.net, nicolas.palix@imag.fr, maennich@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        cocci@systeme.lip6.fr
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

On 2019/9/28 20:43, Julia Lawall wrote:
> 
> 
> On Sat, 28 Sep 2019, YueHaibing wrote:
> 
>> Run make coccicheck, I got this:
>>
>> spatch -D patch --no-show-diff --very-quiet --cocci-file
>>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
>>  -I ./arch/x86/include -I ./arch/x86/include/generated
>>  -I ./include -I ./arch/x86/include/uapi
>>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
>>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
>>  --jobs 192 --chunksize 1
>>
>> virtual rule patch not supported
>> coccicheck failed
>>
>> It seems add_namespace.cocci cannot be called in coccicheck.
> 
> Could you explain the issue better?  Does the current state cause make
> coccicheck to fail?  Or is it just silently not being called?

Yes, it cause make coccicheck failed like this:

...
./drivers/xen/xenbus/xenbus_comms.c:290:2-8: preceding lock on line 243
./fs/fuse/dev.c:1227:2-8: preceding lock on line 1206
./fs/fuse/dev.c:1232:3-9: preceding lock on line 1206
coccicheck failed
make[1]: *** [coccicheck] Error 255
make: *** [sub-make] Error 2


> 
> thanks,
> julia
> 
>>
>> Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  scripts/{coccinelle/misc => }/add_namespace.cocci | 0
>>  scripts/nsdeps                                    | 2 +-
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>  rename scripts/{coccinelle/misc => }/add_namespace.cocci (100%)
>>
>> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/add_namespace.cocci
>> similarity index 100%
>> rename from scripts/coccinelle/misc/add_namespace.cocci
>> rename to scripts/add_namespace.cocci
>> diff --git a/scripts/nsdeps b/scripts/nsdeps
>> index ac2b6031dd13..0f743b76e501 100644
>> --- a/scripts/nsdeps
>> +++ b/scripts/nsdeps
>> @@ -23,7 +23,7 @@ fi
>>
>>  generate_deps_for_ns() {
>>  	$SPATCH --very-quiet --in-place --sp-file \
>> -		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
>> +		$srctree/scripts/add_namespace.cocci -D ns=$1 $2
>>  }
>>
>>  generate_deps() {
>> --
>> 2.20.1
>>
>>
>>
> 
> .
> 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
