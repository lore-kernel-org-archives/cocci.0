Return-Path: <SRS0=SyX8=6E=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C04C3815B
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 15:21:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212E6206B9
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 15:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKYmzntT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212E6206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03KFLaxX021630;
	Mon, 20 Apr 2020 17:21:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D3E157834;
	Mon, 20 Apr 2020 17:21:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 69BA97459
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 16:29:46 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03KETiIl029709
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA256 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 16:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587392984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+AZN+bOVr4lqKHcln5HjQTCBVwoSpl2i43tDw1zfaFA=;
 b=hKYmzntTcNvymwlTnAwbxd+BqaFHoo60Hpn87T6pc2ouCB2rhQzSr1FOYmZVGV7IhHZ3zJ
 xs2Ll5EKU0SBsC8hKT28qg2Olm2eWwU+uU0dZ8FpXbphtC1zdeTCJlz2+I6A+0fO1+unaJ
 XyT49+k/fOttyv05zJuyq6XEEaSRupU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-Og-DowTHNJ6I9mil35pZlg-1; Mon, 20 Apr 2020 10:29:42 -0400
X-MC-Unique: Og-DowTHNJ6I9mil35pZlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FA8D193578E;
 Mon, 20 Apr 2020 14:29:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6491260C80;
 Mon, 20 Apr 2020 14:29:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D208111358BC; Mon, 20 Apr 2020 16:29:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
References: <eeb90865-05a7-cdf3-fd27-cf190c2d53ca@web.de>
 <87imhugt3x.fsf@dusky.pond.sub.org>
 <281aceca-f26f-7def-a77c-d5dcc72d3e6c@web.de>
Date: Mon, 20 Apr 2020 16:29:39 +0200
In-Reply-To: <281aceca-f26f-7def-a77c-d5dcc72d3e6c@web.de> (Markus Elfring's
 message of "Mon, 20 Apr 2020 16:08:29 +0200")
Message-ID: <87ftcyfcx8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 17:21:36 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 16:29:46 +0200 (CEST)
X-Mailman-Approved-At: Mon, 20 Apr 2020 17:21:32 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Function-like macro with the same name as a typedef
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

Markus Elfring <Markus.Elfring@web.de> writes:

>>>> * spatch seems to have trouble parsing
>>>>
>>>>     ARMSSE *s = ARMSSE(opaque);
>>>>
>>>>   where ARMSSE is a typedef, and ARMSSE() is a function-like macro.
>>>>   Yes, I know that's in rather poor taste.
>>>
>>> I am curious for the safe handling of related software development challenges.
>>>
>>>
>>>> * Workaround #1: rename the typedef to ARMSSE_
>>>
>>> Will adjustments become more interesting also around such name space issues?
>>
>> I'm not sure I understand your question.  Can you elaborate?
>
> Do we come along the need to adjust (or even improve) two software areas?
>
> * How many software implementations use identical type definitions
>   and function-like macros?

I don't know.  For what it's worth, it's valid C.  Unless I'm mistaken,
Coccinelle tries to support as much of C as it possibly can.

The QEMU project can certainly work around this Coccinelle bug /
restriction.

I'm reporting it because I've found Coccinelle useful.

> * How will the evolution be continued around Coccinelle?

Is this a question about Coccinelle's future?

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
