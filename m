Return-Path: <SRS0=tDau=5O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D09C43331
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 07:22:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A10520748
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 07:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WOVV8fRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A10520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02T7M4MA022841;
	Sun, 29 Mar 2020 09:22:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4869F7750;
	Sun, 29 Mar 2020 09:22:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B0B3766CB
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 08:47:21 +0100 (CET)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:b42])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02S7lJoD013953
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 08:47:20 +0100 (CET)
Received: by mail-yb1-xb42.google.com with SMTP id o70so5902362ybg.10
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9jl+BpbHZ/7r9CkbFROQ9el447QHzytPcgY1mfe7n2I=;
 b=WOVV8fRn0QHeIZLcDiHRypp+CZ74Q7ALHPvHpNEf9Y72LLtBAWPEWhdu1+WfMmSslm
 UWERIzqxKzdnY73jCAj7ReOrGf9m58xY5hJxs0UaAj7e2o8D0tsas4KPyi2OOFj72j42
 NcPNtcWWUeBSr0/fk6cAAnyzC0H1eLxJaBRjwjuZc4J6XKHlXGGVoUX1KsEM0hbZByjM
 IyS69XD5dopcswpVYiQCH5U4YbxNbvaNyXdpA2Jymn71KM7rMcTt02v5bCIDEmmRiPqa
 K+m9WQstmHWeSar87A5wR2lcItFBo/9UVt4aYJC3p7uxeZDf6bMcSe5NkkFbByv2Dkpq
 0dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9jl+BpbHZ/7r9CkbFROQ9el447QHzytPcgY1mfe7n2I=;
 b=CB10TnsTGK5N4CvJJYIGro6EuqDILdn2/6DkWLLNDl/jIswDOwaVW0M/3t1jnI5Fr1
 PWt0c7aApj+6o+CY0zCSDvqbEY/iWdLWXZepcygnCWKaDeH++Ah6a0mQwxEnC5JyNh5U
 tF3ZvnF0pz4Op9K50NAZS50wJAJiKbWQQ8PcLy8PcnAnN8WPKCT134BMkuKfZ2KcM+uO
 +7SRT+6369F0MA/Ooy1+GCzT1rnzCt/c96/JWWGoqEHJO2R1LAUUcO5yNBcaijrLW4b4
 31HZ6Blx27TalHYCncRmCLyy5zKL8WZlIKyModBC3910O9Vf6WMW51IM/7joatTpN7j5
 aucQ==
X-Gm-Message-State: ANhLgQ0pbvhSTJQuqTDk1uq2Wr/JNloIPwRx20FAE5EwrajbP8I5/wzl
 Xbzu7tv7bECujRW1M3oy/rqyQubD7yMqp9DCDyJtOg==
X-Google-Smtp-Source: ADFU+vszhRv5ayaRSxIAK9LsFFYzkpzCnkWSEHJUDdkTE99yJa1AGlFn/ETcRFmuPn19IzHAqxLW++TFE8J8+cyA28Q=
X-Received: by 2002:a5b:4ce:: with SMTP id u14mr1565259ybp.518.1585381638995; 
 Sat, 28 Mar 2020 00:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
In-Reply-To: <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
From: Michel Lespinasse <walken@google.com>
Date: Sat, 28 Mar 2020 00:47:06 -0700
Message-ID: <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 09:22:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 28 Mar 2020 08:47:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sun, 29 Mar 2020 09:22:02 +0200
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>,
        Liam Howlett <Liam.Howlett@oracle.com>, Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Coccinelle <cocci@systeme.lip6.fr>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [PATCH v3 05/10] mmap locking API: convert mmap_sem
 call sites missed by coccinelle
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

Hi Markus,

On Sat, Mar 28, 2020 at 12:37 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> > Convert the last few remaining mmap_sem rwsem calls to use the new
> > mmap locking API. These were missed by coccinelle for some reason
>
> Will the clarification of this software situation become more interesting?
>
> > (I think coccinelle does not support some of the preprocessor
> > constructs in these files ?)
>
> I suggest to omit this information from the final change description.
> Would you like to help any more to find nicer solutions
> for remaining open issues?

So, from a practical perspective I think coccinelle has filled its
purpose for me - it got 99% of the job done, and I had to do the last
1% by hand which is not ideal, but really not too bad either. Also, by
using coccinelle I think reviewers can appreciate that the
change is purely mechanical, and reproduce it on their end if needed,
which facilitates the review process greatly.

I would be interested to find out why coccinelle wasn't able to do the
last 1%, but only as part of a long-term learning process on getting
better with coccinelle - I don't consider it a blocker for short-term
progress on this patchset.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
