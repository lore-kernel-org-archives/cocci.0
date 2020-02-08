Return-Path: <SRS0=lWmI=34=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6ADC35250
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 16:07:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FC721741
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 16:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FC721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 018G7Hwq020058;
	Sat, 8 Feb 2020 17:07:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E1AB377ED;
	Sat,  8 Feb 2020 17:07:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D88877718
 for <cocci@systeme.lip6.fr>; Sat,  8 Feb 2020 17:07:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 018G7FBc020291
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 8 Feb 2020 17:07:15 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,418,1574118000"; d="scan'208";a="435083659"
Received: from abo-105-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.105])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Feb 2020 17:07:15 +0100
Date: Sat, 8 Feb 2020 17:07:14 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-2?Q?Ond=F8ej_Sur=FD?= <ondrej@sury.org>
In-Reply-To: <70EEB3FF-CB74-4DA5-9F59-08E72604E312@sury.org>
Message-ID: <alpine.DEB.2.21.2002081706220.2211@hadrien>
References: <70EEB3FF-CB74-4DA5-9F59-08E72604E312@sury.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1843604558-1581178035=:2211"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 17:07:17 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 17:07:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing the type casting
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

--8323329-1843604558-1581178035=:2211
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 8 Feb 2020, Ondřej Surý wrote:

> Hi,
>
> I have a code like this:
>
> ```
> static inline void
> freestruct_in_nsap(ARGS_FREESTRUCT) {
>         dns_rdata_in_nsap_t *nsap;
>
>         REQUIRE(((dns_rdata_in_nsap_t *)source) != NULL);
>         REQUIRE(((dns_rdata_in_nsap_t *)source)->common.rdclass == dns_rdataclass_in);
>         REQUIRE(((dns_rdata_in_nsap_t *)source)->common.rdtype == dns_rdatatype_nsap);
>
>         nsap = source;
> ```
>
> and due to various combination of a C standard requirement and enforced cppcheck rules, I can’t change it to a saner workflow for a legacy code.
>
> But I am trying to replace the specific type case with a generic structure, so it will look like this:
>
> ```
> static inline void
> freestruct_in_nsap(ARGS_FREESTRUCT) {
>         dns_rdata_in_nsap_t *nsap;
>
>         REQUIRE(source != NULL);
>         REQUIRE(((dns_rdatacommon_t *)source)->rdclass == dns_rdataclass_in);
>         REQUIRE(((dns_rdatacommon_t *)source)->rdtype == dns_rdatatype_nsap);
>
>         nsap = source;
>
> ```
>
> These are my rules currently:
>
> ```
> @@
> type T;
> expression source;
> @@
>
> - REQUIRE(((T *)source) != NULL);
> + REQUIRE(source != NULL);
>
> @@
> type T;
> type R;
> identifier common, rdtype;
> T *target;
> expression source;
> @@
>
>   REQUIRE(source != NULL);
>   ...
>   REQUIRE((
> - (T *)
> + (dns_rdatacommon_t *)
>   source)->
> - common.
>   rdtype == ...);
>   <+...
>   target = source;
>   ...+>
> ```
>
> the first one works like a charm, but the second rule fails with:
>
> ```
> init_defs_builtins: /usr/local/bin/../Cellar/coccinelle/1.0.8/bin/../lib/coccinelle/standard.h
> plus: parse error:
>   File "cocci/rdata.spatch", line 21, column 22, charpos = 251
>   around = ')',
>   whole content = + (dns_rdatacommon_t *)
> ```
>
> I must be missing something very obvious as just removing the type works, but adding the `+ (dns_rdatacommon_t *)` line makes the rule fail.

Coccinelle is not able to infer typedefs in casts.  So you should add to
your list of metavariables the declaration:

typedef dns_rdatacommon_t;

julia


>
> Thanks,
> Ondrej
> --
> Ondřej Surý
> ondrej@sury.org
>
>
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1843604558-1581178035=:2211
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1843604558-1581178035=:2211--
