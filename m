Return-Path: <SRS0=SyX8=6E=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CB8C3815B
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 15:55:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED01206DD
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWBY2FRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED01206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03KFtc4D017244;
	Mon, 20 Apr 2020 17:55:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 978A87763;
	Mon, 20 Apr 2020 17:55:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4EB997459
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 17:55:37 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03KFtYr6011718
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA256 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 17:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587398134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrEkH6iAd1DawKMNVl/jNSX6vmhyRqncJmww9H98BXw=;
 b=jWBY2FRouEMqy9De5HzvdyyCooGm5Lq9orggGQ0Ip0ZtOdlAEkWFr1WguEhe9B1PoYsEcx
 RwvMFYHYUhrZe4Gl0R25mS+bSIemIsg28OJt0reEb0VOfQM7A9voySXHZnBaTXlfU7ApYF
 qs7BcJf9jghwAV5/uNHjh+cGVe+LN3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-1xe7ri4BNcSGSzSjiIqpww-1; Mon, 20 Apr 2020 11:55:32 -0400
X-MC-Unique: 1xe7ri4BNcSGSzSjiIqpww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CC00107ACC9;
 Mon, 20 Apr 2020 15:55:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D3C15C1C5;
 Mon, 20 Apr 2020 15:55:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A75AE11358BC; Mon, 20 Apr 2020 17:55:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
References: <eeb90865-05a7-cdf3-fd27-cf190c2d53ca@web.de>
 <87imhugt3x.fsf@dusky.pond.sub.org>
 <281aceca-f26f-7def-a77c-d5dcc72d3e6c@web.de>
 <87ftcyfcx8.fsf@dusky.pond.sub.org>
 <a603dd22-22b7-930a-4e2d-4ff623b76c59@web.de>
Date: Mon, 20 Apr 2020 17:55:29 +0200
In-Reply-To: <a603dd22-22b7-930a-4e2d-4ff623b76c59@web.de> (Markus Elfring's
 message of "Mon, 20 Apr 2020 16:47:21 +0200")
Message-ID: <87h7xeb18u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 17:55:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 17:55:35 +0200 (CEST)
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

>>> * How many software implementations use identical type definitions
>>>   and function-like macros?
>>
>> I don't know.
>
> Can it become interesting to find more about such usage patterns out?

Rule of thumb: for every user reporting an issue, there are several more
suffering quietly.  How many more?  I don't know.

A better estimate of how widespread such use is might be useful, but I
can't provide one.

>> For what it's worth, it's valid C.  Unless I'm mistaken,
>> Coccinelle tries to support as much of C as it possibly can.
>
> How do you think about limitations for corresponding software
> development resources?
>
>
>> The QEMU project can certainly work around this Coccinelle
>> bug / restriction.
>
> Which adjustments will be chosen?

Rename either the typedef or the macro.  More complicated than it
sounds, because both conform to naming conventions.

>>> * How will the evolution be continued around Coccinelle?
>>
>> Is this a question about Coccinelle's future?
>
> Yes, of course.
>
> Are we trying to influence further development anyhow?

I'm trying to help the Coccinelle project by reporting an issue, no
more, no less :)

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
