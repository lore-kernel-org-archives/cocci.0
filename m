Return-Path: <SRS0=WeMo=3E=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F0CC33CB1
	for <cocci@archiver.kernel.org>; Wed, 15 Jan 2020 15:53:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1BA2187F
	for <cocci@archiver.kernel.org>; Wed, 15 Jan 2020 15:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lhg/63xW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1BA2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00FFrOCe009235;
	Wed, 15 Jan 2020 16:53:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 88D8277F5;
	Wed, 15 Jan 2020 16:53:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4341577E3
 for <cocci@systeme.lip6.fr>; Wed, 15 Jan 2020 16:53:22 +0100 (CET)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00FFrHII027032
 for <cocci@systeme.lip6.fr>; Wed, 15 Jan 2020 16:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579103597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHVO0IbIjUqE/IczQrtE4DLgxfySsamNzRtgovU1fiM=;
 b=Lhg/63xW6H3VcjvZP/b9g06mDcpkzo9RnElX9vk1qHDR6VHzpv97ImwWRQwpnyzq8rlbAK
 necS9lZr/NYBzyQBkL39X5StxOjBFy5t3V8vKTr9q4X/ci0X20c6Eo51gOqJb8i+HJtrDs
 GsBZUwatb4P2/5ASkKoYOvLDDoS+cvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-dssjqkSMOr64orLqNgrMSw-1; Wed, 15 Jan 2020 10:53:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AE861173A8E;
 Wed, 15 Jan 2020 15:53:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
 by smtp.corp.redhat.com (Postfix) with SMTP id A3A45811E0;
 Wed, 15 Jan 2020 15:53:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Wed, 15 Jan 2020 16:53:12 +0100 (CET)
Date: Wed, 15 Jan 2020 16:53:10 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20200115155310.GA9716@redhat.com>
References: <20200115112540.GA18161@redhat.com>
 <alpine.DEB.2.21.2001151308380.5079@hadrien>
 <20200115153035.GA9172@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200115153035.GA9172@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dssjqkSMOr64orLqNgrMSw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 15 Jan 2020 16:53:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 15 Jan 2020 16:53:17 +0100 (CET)
Cc: Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] Q: does spatch understand typeof?
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

On 01/15, Oleg Nesterov wrote:
>
> Another question...

Oh, and another one ;)

http://coccinelle.lip6.fr/docs/main_grammar006.html mentions
"typeof(expr/ctype)", but I failed to find any doc/example of
how can it be used in SPL.

Could you explain it?

Oleg.

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
