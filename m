Return-Path: <SRS0=zB/R=2X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBC3C3276D
	for <cocci@archiver.kernel.org>; Thu,  2 Jan 2020 22:19:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253BB21582
	for <cocci@archiver.kernel.org>; Thu,  2 Jan 2020 22:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YuWmvSAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253BB21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 002MIqWt000405;
	Thu, 2 Jan 2020 23:18:52 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B5A3873E2;
	Thu,  2 Jan 2020 23:18:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0AAA26104
 for <cocci@systeme.lip6.fr>; Thu,  2 Jan 2020 23:18:51 +0100 (CET)
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 002MInnn003336
 for <cocci@systeme.lip6.fr>; Thu, 2 Jan 2020 23:18:49 +0100 (CET)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
 by pb-smtp20.pobox.com (Postfix) with ESMTP id C80EDADE1D
 for <cocci@systeme.lip6.fr>; Thu,  2 Jan 2020 17:03:49 -0500 (EST)
 (envelope-from dyoung@netbsd.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
 :subject:message-id:mime-version:content-type; s=sasl; bh=oq+/sd
 QUsT4sSFjiKKv70CgrPbg=; b=YuWmvSAnEqt8ac0Nug0XbswJlSrJzBBPFQ0Sj0
 jbe76bRHpRlNhEdrtIQY6UUhugfekur4fzXywaKKPChCBQp9HNt2NpBOy/Ca//lz
 4VLhMaZXnqMbpw9Bxuo0Jo1dNjLQGe6FBJN9lFdD9HU0kMUd7wvZEVuQB/93R71x
 DZtLM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
 by pb-smtp20.pobox.com (Postfix) with ESMTP id A6EF3ADE1C
 for <cocci@systeme.lip6.fr>; Thu,  2 Jan 2020 17:03:49 -0500 (EST)
 (envelope-from dyoung@netbsd.org)
Received: from elmendorf.whitecoralislands.com (unknown [67.173.96.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CCE9ADE1B
 for <cocci@systeme.lip6.fr>; Thu,  2 Jan 2020 17:03:46 -0500 (EST)
 (envelope-from dyoung@netbsd.org)
Received: by elmendorf.whitecoralislands.com (Postfix, from userid 1000)
 id 1850B1BF051; Thu,  2 Jan 2020 16:03:45 -0600 (CST)
Date: Thu, 2 Jan 2020 16:03:45 -0600
From: David Young <dyoung@netbsd.org>
To: cocci@systeme.lip6.fr
Message-ID: <20200102220345.GF17258@pobox.com>
Mail-Followup-To: cocci@systeme.lip6.fr
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Pobox-Relay-ID: BFA13F36-2DAB-11EA-8E51-B0405B776F7B-71664428!pb-smtp20.pobox.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 02 Jan 2020 23:18:54 +0100 (CET)
X-Greylist: Delayed for 00:14:53 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 02 Jan 2020 23:18:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] transforming arguments to statement macros?
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

I have a semantic patch that renames parameters and local variables
called `index` to `idx`.  It renames most occurrences, however,
it does not know how to handle a macro that expands to a block:

#define HGOTO_ERROR(maj, min, ret_val, ...) {                           \
   do_something(maj, min, __VA_ARGS__);                                 \
   ret_value = ret_val;							\
   goto done;								\
}

I'd like for every occurrence of `index` in the HGOTO_ERROR() arguments
to change to `idx`, HGOTO_ERROR(..., index, ...) -> HGOTO_ERROR(..., idx, ...),
but spatch leaves those occurrences alone.

Can I write an isomorphism or something to force spatch to process each
occurrence of HGOTO_ERROR(...) as if it was either the function call
`hgoto_error(...);` or the block `{ (void)(...); goto done; }` ?


Dave

-- 
David Young
dyoung@pobox.com    Urbana, IL    (217) 721-9981
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
