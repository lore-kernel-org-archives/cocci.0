Return-Path: <SRS0=oEM1=56=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E91DC2BA19
	for <cocci@archiver.kernel.org>; Tue, 14 Apr 2020 09:06:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C392063A
	for <cocci@archiver.kernel.org>; Tue, 14 Apr 2020 09:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C392063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03E96MTu013861;
	Tue, 14 Apr 2020 11:06:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 55BB63DC8;
	Tue, 14 Apr 2020 11:06:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 714673B93
 for <cocci@systeme.lip6.fr>; Tue, 14 Apr 2020 11:01:32 +0200 (CEST)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03E91WQ0009665
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 14 Apr 2020 11:01:32 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id r26so13093025wmh.0
 for <cocci@systeme.lip6.fr>; Tue, 14 Apr 2020 02:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZSEHFc2eh+N6K60wyVHbBWfK0AmjMN90oe2OMNtMMJ0=;
 b=mmHQKspnCZBGxzYuFQGrjuJ8gNxBTYsXt8LaBS3Ilfiss59NCSv7/eZbL2uIHlwNTv
 wo3b7sRamk8PlpHxdTVsRixODEW6vRLUGkddhB4+FDyrrHz3EWUBqGxaLD3HsOQpZ03r
 guX0DEGnQgjL5x7ie2RnUgxucEKW2Zgbzw51JkLP99jOii0SHUN92haAX/gNxIjOTLQt
 RAxVqa/dChi1g4kvIRpvXc8HXal7lnIfmfDKOSbb9fQxOwia7LxiBv4jwuYHikGSXZ9r
 ECY4g5TKV/jBV8pmtVOfdqzb6EoYYtTUQBIb/iVBASYzoFpyIsOl1CKAP5bBWSjN93Gz
 USxw==
X-Gm-Message-State: AGi0PuYYm9p2sHC17SKqNTT2iJ7wf79QQ+0/ObLNW2TNzldDrce6xEJh
 0qBesk55nvlecMcM+2CFVnM=
X-Google-Smtp-Source: APiQypIjMMKQ1krTcIb7iRe2Mn/fScrYHKTluZiYEwYRZsrwjhiGsUjKHrgwCKNk20IxGSD17N1euw==
X-Received: by 2002:a1c:a913:: with SMTP id s19mr23660673wme.134.1586854891811; 
 Tue, 14 Apr 2020 02:01:31 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
 by smtp.gmail.com with ESMTPSA id n6sm18637096wrs.81.2020.04.14.02.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 02:01:30 -0700 (PDT)
Date: Tue, 14 Apr 2020 11:01:29 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Waiman Long <longman@redhat.com>
Message-ID: <20200414090129.GE4629@dhcp22.suse.cz>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-2-longman@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200413211550.8307-2-longman@redhat.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 14 Apr 2020 11:06:22 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 14 Apr 2020 11:01:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 14 Apr 2020 11:06:21 +0200
Cc: linux-btrfs@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        virtualization@lists.linux-foundation.org,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-sctp@vger.kernel.org, keyrings@vger.kernel.org,
        kasan-dev@googlegroups.com, samba-technical@lists.samba.org,
        linux-stm32@st-md-mailman.stormreply.com, devel@driverdev.osuosl.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
        James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>,
        cocci@systeme.lip6.fr, linux-wpan@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, David Rientjes <rientjes@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-pm@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-security-module@vger.kernel.org,
        target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com,
        linux-ppp@vger.kernel.org
Subject: Re: [Cocci] [PATCH 1/2] mm,
	treewide: Rename kzfree() to kfree_sensitive()
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

On Mon 13-04-20 17:15:49, Waiman Long wrote:
> As said by Linus:
> 
>   A symmetric naming is only helpful if it implies symmetries in use.
>   Otherwise it's actively misleading.
> 
>   In "kzalloc()", the z is meaningful and an important part of what the
>   caller wants.
> 
>   In "kzfree()", the z is actively detrimental, because maybe in the
>   future we really _might_ want to use that "memfill(0xdeadbeef)" or
>   something. The "zero" part of the interface isn't even _relevant_.
> 
> The main reason that kzfree() exists is to clear sensitive information
> that should not be leaked to other future users of the same memory
> objects.
> 
> Rename kzfree() to kfree_sensitive() to follow the example of the
> recently added kvfree_sensitive() and make the intention of the API
> more explicit. In addition, memzero_explicit() is used to clear the
> memory to make sure that it won't get optimized away by the compiler.
> 
> The renaming is done by using the command sequence:
> 
>   git grep -w --name-only kzfree |\
>   xargs sed -i 's/\bkzfree\b/kfree_sensitive/'
> 
> followed by some editing of the kfree_sensitive() kerneldoc and the
> use of memzero_explicit() instead of memset().
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Makes sense. I haven't checked all the conversions and will rely on the
script doing the right thing. The core MM part is correct.

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
