Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE43C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 09:00:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F48D2075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 09:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F48D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04B90aEp017897;
	Mon, 11 May 2020 11:00:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 267703E6B;
	Mon, 11 May 2020 11:00:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F1A8C3E68
 for <cocci@systeme.lip6.fr>; Thu,  7 May 2020 06:10:38 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0474AZAw018775
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 7 May 2020 06:10:38 +0200 (CEST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5E42A59B51338C268F28;
 Thu,  7 May 2020 12:10:33 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.180) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 7 May 2020 12:10:28 +0800
To: Joe Perches <joe@perches.com>, Luciano Coelho <luciano.coelho@intel.com>,
        <johannes.berg@intel.com>, <emmanuel.grumbach@intel.com>,
        <linuxwifi@intel.com>, <kvalo@codeaurora.org>, <davem@davemloft.net>,
        "Julia Lawall" <julia.lawall@lip6.fr>
References: <1588734423-33988-1-git-send-email-zou_wei@huawei.com>
 <f8b258e0c8bb073c445090e637195df2fc989543.camel@perches.com>
 <bfd6b3a7db0c50cd3d084510bd43c9e540688edd.camel@intel.com>
 <2208e464cd8bd399cfb9b49abb5aed211f27b3a8.camel@perches.com>
From: Samuel Zou <zou_wei@huawei.com>
Message-ID: <8431ed30-b9c7-e91b-e6e6-2afd03dde360@huawei.com>
Date: Thu, 7 May 2020 12:10:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2208e464cd8bd399cfb9b49abb5aed211f27b3a8.camel@perches.com>
Content-Language: en-US
X-Originating-IP: [10.166.212.180]
X-CFilter-Loop: Reflected
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 11:00:36 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 07 May 2020 06:10:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 11 May 2020 11:00:34 +0200
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH -next] iwlwifi: pcie: Use bitwise instead of
 arithmetic operator for flags
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Both of you are right.
I neglected, and this patch is wrong.

Thanks.

On 2020/5/6 23:15, Joe Perches wrote:
> On Wed, 2020-05-06 at 16:51 +0300, Luciano Coelho wrote:
>> On Tue, 2020-05-05 at 20:19 -0700, Joe Perches wrote:
>>> On Wed, 2020-05-06 at 11:07 +0800, Samuel Zou wrote:
>>>> This silences the following coccinelle warning:
>>>>
>>>> "WARNING: sum of probable bitmasks, consider |"
>>>
>>> I suggest instead ignoring bad and irrelevant warnings.
>>>
>>> PREFIX_LEN is 32 not 0x20 or BIT(5)
>>> PCI_DUMP_SIZE is 352
>>>
>>>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
>>> []
>>>> @@ -109,9 +109,9 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
>>>>   
>>>>   	/* Alloc a max size buffer */
>>>>   	alloc_size = PCI_ERR_ROOT_ERR_SRC +  4 + PREFIX_LEN;
>>>> -	alloc_size = max_t(u32, alloc_size, PCI_DUMP_SIZE + PREFIX_LEN);
>>>> -	alloc_size = max_t(u32, alloc_size, PCI_MEM_DUMP_SIZE + PREFIX_LEN);
>>>> -	alloc_size = max_t(u32, alloc_size, PCI_PARENT_DUMP_SIZE + PREFIX_LEN);
>>>> +	alloc_size = max_t(u32, alloc_size, PCI_DUMP_SIZE | PREFIX_LEN);
>>>> +	alloc_size = max_t(u32, alloc_size, PCI_MEM_DUMP_SIZE | PREFIX_LEN);
>>>> +	alloc_size = max_t(u32, alloc_size, PCI_PARENT_DUMP_SIZE | PREFIX_LEN);
>>>>   
>>>>   	buf = kmalloc(alloc_size, GFP_ATOMIC);
>>>>   	if (!buf)
>>
>> Yeah, those macros are clearly not bitmasks.  I'm dropping this patch.
> 
> Can the cocci script that generated this warning
> 
> scripts/coccinelle/misc/orplus.cocci
> 
> be dropped or improved to validate the likelihood that
> the defines or constants used are more likely than
> not are bit values?
> 
> Maybe these should be defined as hex or BIT or BIT_ULL
> or GENMASK or the like?
> 
> 
> Right now it seems it just tests for two constants.
> 
> 
> 
> .
> 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
