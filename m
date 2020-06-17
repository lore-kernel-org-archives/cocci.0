Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC940C433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 16:38:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664FB21527
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 16:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJ5nAdeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664FB21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HGcEIj004357;
	Wed, 17 Jun 2020 18:38:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD2267577;
	Wed, 17 Jun 2020 18:38:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 76D183D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 18:38:13 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e:0:0:0:133])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HGc4b1000180
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 18:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=1iQRiCO+mx3OYZyN21ZE72alQEGuSoAxSJ9LzUzbTEY=; b=pJ5nAdeVBy/2uJ6x93JZ/5dhUp
 hxHoOxAfzkE2zXSzcvK7/llxjtvluR/UaaftfUbBjTDP0T0WTXxGFZJFsOw8v4KcdVle0jWrLffH1
 IXoVj5Is22AtgoMJTgbYJA7UmojrNulXru1ttXPFizhZCgu+9fFimvB6BT85vqs4IlexXNwsfDZ7I
 8XMNcRNS1Byh8ys1s1XOoYNxSdh94v3WeCaQWm5TYLlmiM0Bck+SDZigTuqaj5i7N8/QDZiQ8+GMQ
 3G/q9Ip632llDcJef5wSBri8Y2KGrri2LhSJBXJ5P87FRXYjNm+V5cHWcP3kaFwZ9egO/9Nlqq3Cs
 I7rkv2OA==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlb4Y-0008Tc-HF; Wed, 17 Jun 2020 16:37:58 +0000
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
 <1592115803.27290.33.camel@gmail.com>
 <alpine.DEB.2.22.394.2006140940000.2849@hadrien>
 <1592121432.2129.9.camel@gmail.com>
 <alpine.DEB.2.22.394.2006141042270.2849@hadrien>
 <1592124280.2129.22.camel@gmail.com>
 <alpine.DEB.2.22.394.2006141456520.2849@hadrien>
 <1592158913.7336.48.camel@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <77d63ac2-dbb4-84c4-a690-fa27ff1aa0c6@infradead.org>
Date: Wed, 17 Jun 2020 09:37:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592158913.7336.48.camel@gmail.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 18:38:15 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 17 Jun 2020 18:38:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle issues
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

On 6/14/20 11:21 AM, Mike Galbraith wrote:
> On Sun, 2020-06-14 at 14:59 +0200, Julia Lawall wrote:
>>
>> On Sun, 14 Jun 2020, Mike Galbraith wrote:
>>
>>> On Sun, 2020-06-14 at 10:43 +0200, Julia Lawall wrote:
>>>>
>>>> What is your Linux distribution?
>>>
>>> openSUSE Leap-15.1
>>
>> Our CI already has an entry for openSUSE Leap.  We will look into it, but
>> if you have any further information about the problem, please let us know.
> 
> Executive Summary:
> 
> warning: Can't find macro file: /usr/local/coccinelle/bin/../lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/coccinelle/bin/../lib/coccinelle/standard.iso
> 
> I find those under lib64, apply symlink bandaid, proggy acks.
> 
> WRT the HEAD make install booboo..
> 
> git@homer:~/coccinelle> sudo make install
> mkdir -p /usr/local/coccinelle/bin /usr/local/coccinelle/lib64/coccinelle
> mkdir -p /usr/local/coccinelle/lib64/coccinelle/ocaml
> if test -f bundles/pyml/dllpyml_stubs.so; then \
>         /usr/bin/install -c -m 755 bundles/pyml/dllpyml_stubs.so \
>                 /usr/local/coccinelle/lib64/coccinelle; \
> fi
> if test -f bundles/pcre/dllpcre_stubs.so; then \
>         /usr/bin/install -c -m 755 bundles/pcre/dllpcre_stubs.so \
>                 /usr/local/coccinelle/lib64/coccinelle; \
> fi
> /usr/bin/install -c -m 755 spatch.opt /usr/local/coccinelle/bin/spatch
> /usr/bin/install -c -m 644 standard.h /usr/local/coccinelle/lib64/coccinelle
> /usr/bin/install -c -m 644 standard.iso /usr/local/coccinelle/lib64/coccinelle
> /usr/bin/install -c -m 644 ocaml/*.cmi /usr/local/coccinelle/lib64/coccinelle/ocaml/
> if test -f ocaml/coccilib.cmx; then \
>         /usr/bin/install -c -m 644 ocaml/*.cmx /usr/local/coccinelle/lib64/coccinelle/ocaml/; \
> fi
> /usr/bin/install -c -m 755 tools/spgen/source/spgen.opt \
>          /usr/local/coccinelle/bin/spgen
> /usr/bin/install -c -m 644 python/coccilib/*.py \
>         /usr/local/coccinelle/lib64/coccinelle/python/coccilib
> /usr/bin/install: target '/usr/local/coccinelle/lib64/coccinelle/python/coccilib' is not a directory
> make: *** [Makefile:332: install-python] Error 1
> 
> mkdir -p bandaid worked.
> 

Thanks, Mike.
It seems to be working now.

-- 
~Randy

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
