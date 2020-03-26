Return-Path: <SRS0=Jo+R=5L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7076AC43331
	for <cocci@archiver.kernel.org>; Thu, 26 Mar 2020 14:04:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB35206F6
	for <cocci@archiver.kernel.org>; Thu, 26 Mar 2020 14:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+7GuzXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB35206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02QE4FWJ002955;
	Thu, 26 Mar 2020 15:04:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0401F780C;
	Thu, 26 Mar 2020 15:04:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 257BF77FC
 for <cocci@systeme.lip6.fr>; Thu, 26 Mar 2020 14:56:07 +0100 (CET)
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02QDu5qn001614
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA256 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 26 Mar 2020 14:56:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585230964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88eUjflRcwmSSWvPRfQg+6bwWoJ2678bQo929jibops=;
 b=L+7GuzXj+9xi1SVBg+NxFkZnx+qFxcmr3rK5+x5urGqzSy6LDC0zMA+lf7i7Rf7suvvBiw
 b+/5PPOYTO2nuCZwky5vMw5Fv7dObhi303utA7pO0jHJBv6xHtjaBiWpxvpBL6UYL7kN3+
 tJStMnaK4wbAUXUvmf2S1XnVSBvK2sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-AAWCI-RUNIWn_WJ9EQ3guA-1; Thu, 26 Mar 2020 09:56:00 -0400
X-MC-Unique: AAWCI-RUNIWn_WJ9EQ3guA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 840648010FD;
 Thu, 26 Mar 2020 13:55:57 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97151CDBC4;
 Thu, 26 Mar 2020 13:55:56 +0000 (UTC)
Date: Thu, 26 Mar 2020 21:55:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200326135553.GM3039@MiWiFi-R3L-srv>
References: <02c6dfa8-0e13-d1d7-e335-ad8f1a3ecb1f@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <02c6dfa8-0e13-d1d7-e335-ad8f1a3ecb1f@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 26 Mar 2020 15:04:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 26 Mar 2020 14:56:06 +0100 (CET)
X-Mailman-Approved-At: Thu, 26 Mar 2020 15:04:14 +0100
Cc: Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Liam Howlett <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>, Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Coccinelle <cocci@systeme.lip6.fr>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [PATCH 4/8] mmap locking API: convert mmap_sem call
 sites missed by coccinelle
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

On 03/26/20 at 02:41pm, Markus Elfring wrote:
> > Convert the last few remaining mmap_sem rwsem calls to use the new
> > mmap locking API. These were missed by coccinelle for some reason
> 
> I find such a software situation unfortunate.
> Should the transformation approach be clarified any further?

Should be this one:
Documentation/dev-tools/coccinelle.rst

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
