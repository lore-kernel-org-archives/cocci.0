Return-Path: <SRS0=Oul2=6V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1DBC28CBC
	for <cocci@archiver.kernel.org>; Thu,  7 May 2020 01:54:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857A42075E
	for <cocci@archiver.kernel.org>; Thu,  7 May 2020 01:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857A42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0471s5dp007226;
	Thu, 7 May 2020 03:54:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6EB20775A;
	Thu,  7 May 2020 03:54:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CF0807559
 for <cocci@systeme.lip6.fr>; Thu,  7 May 2020 03:54:02 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0050.hostedemail.com
 [216.40.44.50])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0471s19f017502
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 7 May 2020 03:54:02 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 6184A18037D54
 for <cocci@systeme.lip6.fr>; Wed,  6 May 2020 15:15:15 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id B51AB246E;
 Wed,  6 May 2020 15:15:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bears23_ff76a315943a
X-Filterd-Recvd-Size: 2948
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf10.hostedemail.com (Postfix) with ESMTPA;
 Wed,  6 May 2020 15:15:09 +0000 (UTC)
Message-ID: <2208e464cd8bd399cfb9b49abb5aed211f27b3a8.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Luciano Coelho <luciano.coelho@intel.com>,
        Samuel Zou
 <zou_wei@huawei.com>, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, linuxwifi@intel.com, kvalo@codeaurora.org,
        davem@davemloft.net, Julia Lawall <julia.lawall@lip6.fr>
Date: Wed, 06 May 2020 08:15:08 -0700
In-Reply-To: <bfd6b3a7db0c50cd3d084510bd43c9e540688edd.camel@intel.com>
References: <1588734423-33988-1-git-send-email-zou_wei@huawei.com>
 <f8b258e0c8bb073c445090e637195df2fc989543.camel@perches.com>
 <bfd6b3a7db0c50cd3d084510bd43c9e540688edd.camel@intel.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 07 May 2020 03:54:06 +0200 (CEST)
X-Greylist: Delayed for 07:00:00 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 07 May 2020 03:54:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Wed, 2020-05-06 at 16:51 +0300, Luciano Coelho wrote:
> On Tue, 2020-05-05 at 20:19 -0700, Joe Perches wrote:
> > On Wed, 2020-05-06 at 11:07 +0800, Samuel Zou wrote:
> > > This silences the following coccinelle warning:
> > > 
> > > "WARNING: sum of probable bitmasks, consider |"
> > 
> > I suggest instead ignoring bad and irrelevant warnings.
> > 
> > PREFIX_LEN is 32 not 0x20 or BIT(5)
> > PCI_DUMP_SIZE is 352
> > 
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > []
> > > @@ -109,9 +109,9 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
> > >  
> > >  	/* Alloc a max size buffer */
> > >  	alloc_size = PCI_ERR_ROOT_ERR_SRC +  4 + PREFIX_LEN;
> > > -	alloc_size = max_t(u32, alloc_size, PCI_DUMP_SIZE + PREFIX_LEN);
> > > -	alloc_size = max_t(u32, alloc_size, PCI_MEM_DUMP_SIZE + PREFIX_LEN);
> > > -	alloc_size = max_t(u32, alloc_size, PCI_PARENT_DUMP_SIZE + PREFIX_LEN);
> > > +	alloc_size = max_t(u32, alloc_size, PCI_DUMP_SIZE | PREFIX_LEN);
> > > +	alloc_size = max_t(u32, alloc_size, PCI_MEM_DUMP_SIZE | PREFIX_LEN);
> > > +	alloc_size = max_t(u32, alloc_size, PCI_PARENT_DUMP_SIZE | PREFIX_LEN);
> > >  
> > >  	buf = kmalloc(alloc_size, GFP_ATOMIC);
> > >  	if (!buf)
> 
> Yeah, those macros are clearly not bitmasks.  I'm dropping this patch.

Can the cocci script that generated this warning

scripts/coccinelle/misc/orplus.cocci

be dropped or improved to validate the likelihood that
the defines or constants used are more likely than
not are bit values?

Maybe these should be defined as hex or BIT or BIT_ULL
or GENMASK or the like?


Right now it seems it just tests for two constants.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
