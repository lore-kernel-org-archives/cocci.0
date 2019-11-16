Return-Path: <SRS0=bJuE=ZI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE7C432C3
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2019 01:01:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDA2206D5
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2019 01:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDA2206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAG117R7029572;
	Sat, 16 Nov 2019 02:01:07 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3308677CC;
	Sat, 16 Nov 2019 02:01:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 64C9377C5
 for <cocci@systeme.lip6.fr>; Sat, 16 Nov 2019 02:01:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAG1134I017353
 for <cocci@systeme.lip6.fr>; Sat, 16 Nov 2019 02:01:03 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.68,310,1569276000"; d="scan'208";a="412064964"
Received: from ip65-46-187-134.z187-46-65.customer.algx.net (HELO hadrien)
 ([65.46.187.134])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Nov 2019 02:00:31 +0100
Date: Fri, 15 Nov 2019 20:00:29 -0500 (EST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <94301b9c-a397-ae04-c617-92679f4bb018@web.de>
Message-ID: <alpine.DEB.2.21.1911152000170.8961@hadrien>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
 <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
 <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
 <94301b9c-a397-ae04-c617-92679f4bb018@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1173424402-1573866031=:8961"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Nov 2019 02:01:07 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 16 Nov 2019 02:01:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>, Coccinelle <cocci@systeme.lip6.fr>,
        git@vger.kernel.org
Subject: Re: [Cocci] git-coccinelle: adjustments for array.cocci?
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1173424402-1573866031=:8961
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 15 Nov 2019, Markus Elfring wrote:

> > --- array-released.diff	2019-11-14 21:29:11.020576916 +0100
> > +++ array-reduced1.diff	2019-11-14 21:45:58.931956527 +0100
> > @@ -6,24 +6,10 @@
> >   	r->entry_count = t->entry_count;
> >   	r->delta_depth = t->delta_depth;
> >  -	memcpy(r->entries,t->entries,t->entry_count*sizeof(t->entries[0]));
> > -+	COPY_ARRAY(r->entries, t->entries, t->entry_count);
> > ++	memcpy(r->entries,t->entries,t->entry_count*sizeof(*(t->entries)));
> >   	release_tree_content(t);
> >   	return r;
> >   }
>
> It took a while to become more aware of software development challenges
> for the safe data processing with the semantic patch language also
> at such a source code place.
> https://github.com/git/git/blob/3edfcc65fdfc708c1c8f1d314885eecf9beb9b67/fast-import.c#L640
>
> I got the impression that the Coccinelle software is occasionally able
> to determine from the search specification “sizeof(T)” the corresponding
> data type for code like “*(t->entries)”.

It can determine the type of t->entries if it has access to the definition
of the type of t.  This type may be in a header file.  If you want
Coccinelle to be able to find this information you can use the option
--all-includes or --recursive-includes.  It will be more efficient with
the option --include-headers-for-types.

julia

> But it seems that there are circumstances to consider where the desired
> data type was not automatically determined.
> Thus the data processing  can become safer by explicitly expressing
> the case distinction for the handling of expressions.
>
> Adjusted transformation rule:
> @@
> type T;
> T* dst_ptr, src_ptr;
> T[] dst_arr, src_arr;
> expression n, x;
> @@
> -memcpy
> +COPY_ARRAY
>        (
> (       dst_ptr
> |       dst_arr
> )
>        ,
> (       src_ptr
> |       src_arr
> )
>        ,
> -       (n) * \( sizeof(T) \| sizeof(*(x)) \)
> +       n
>        )
>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1173424402-1573866031=:8961
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1173424402-1573866031=:8961--
