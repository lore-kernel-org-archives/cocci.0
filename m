Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5C9C43334
	for <cocci@archiver.kernel.org>; Thu, 14 Jul 2022 09:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=kU3LmHGC6Ymaplpu3+FuIh4sM87o+0iCDA4aDuyOqyQ=;
  b=UVncQJYggClxXarTVs5UkMUmaAQNAZdkFYgig+PT1u+j4YG7b21wU6e0
   cVhGbRmlfJCV3S6EAdetIGuhKYRGB41kKIzOEwDLN5JqtGn59VKCZE2wI
   SUIochmZFK3AzHyPEIeGOLwPyMeapfPvt7HS+gs5LKquHq1fdHhC4+x9s
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.92,269,1650924000"; 
   d="scan'208";a="45583132"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2022 11:39:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4B222E02D7; Thu, 14 Jul 2022 11:39:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 78601E0260
	for <cocci@sympa.inria.fr>; Thu, 14 Jul 2022 11:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kU3LmHGC6Ymaplpu3+FuIh4sM87o+0iCDA4aDuyOqyQ=;
  b=RtZ4bu3ReRlo2JRKNt72W0v6i1JAJqbXVoDkFY4LRop2Wc1tCC6fS/Ei
   2nGeEXtg7BRYQMF20sRmxvqdnpEiBuzrMsfSl7ydodWuFmG6vQ1q+8ZEW
   k04ydetBvd5o0PgD6tyBQC/79SMD7PCn2AGohF+2Qja15JKba1Oqx/n0I
   M=;
X-IronPort-AV: E=Sophos;i="5.92,269,1650924000"; 
   d="scan'208";a="19331798"
Received: from 150.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.150])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:39:06 +0200
Date: Thu, 14 Jul 2022 11:39:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc: Coccinelle ML <cocci@inria.fr>
In-Reply-To: <220714.86bkts2fz9.gmgdl@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2207141138450.3019@hadrien>
References: <220714.86bkts2fz9.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1801635871-1657791546=:3019"
Subject: Re: [cocci] How do I disable formatting for the "+"-side of a rule?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 491
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/alpine.DEB.2.22.394.2207141138450.3019%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1801635871-1657791546=:3019
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Thu, 14 Jul 2022, Ævar Arnfjörð Bjarmason wrote:

> How do I stop coccinelle from turning my "{ 0 };\n" into
> "{\n\t\t0\n\t};\n"?
>
> I haven't been able to find in the docs how to disable formatting on the
> "+"-side of a rule. I have a rule like:
>
> 	@@
> 	type T;
> 	identifier I;
> 	@@
> 	- T I;
> 	+ T I = { 0 };
> 	... when != \( I \| &I \)
> 	- memset(&I, 0, ...);
>
> Which produces the expected results as far as the patch is concerned:
>
> 	diff -u -p a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> 	--- a/builtin/for-each-ref.c
> 	+++ b/builtin/for-each-ref.c
> 	@@ -20,7 +20,9 @@ int cmd_for_each_ref(int argc, const cha
> 	 	struct ref_sorting *sorting;
> 	 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
> 	 	int maxcount = 0, icase = 0;
> 	-	struct ref_array array;
> 	+	struct ref_array array = {
> 	+		0
> 	+	};
> 	 	struct ref_filter filter;
> 	 	struct ref_format format = REF_FORMAT_INIT;
> 	 	struct strbuf output = STRBUF_INIT;
> 	@@ -52,7 +54,6 @@ int cmd_for_each_ref(int argc, const cha
> 	 		OPT_END(),
> 	 	};
>
> 	-	memset(&array, 0, sizeof(array));
> 	 	memset(&filter, 0, sizeof(filter));
>
> 	 	format.format = "%(objectname) %(objecttype)\t%(refname)";
>
> But I'd like for that to be e.g.:
>
> 	struct ref_array array = { 0 };
>
> Which is a common idiom both in this codebase (git) and elsewhere.
>
> Usually I can find an answer in one of the coccinelle.git's *.cocci
> files, the man page, or the grammar PDF, but in this case I've come up
> blank...

Try --smpl-spacing.  I'm not sure whether it affects newlines, though.

julia
--8323329-1801635871-1657791546=:3019--
