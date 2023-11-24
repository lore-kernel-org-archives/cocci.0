Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E31C61DF4
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mGFIVQmVT38s/H0NWGZDPXwjUVmQxjIH24hliCZc7cA=;
  b=KgibsEXcS54cJrVLRdr+BUk8qT/wH9o+cny/m43XJam4HjpNjkjBjYWc
   tLNtUadrC05G1X8evU1H9IsqbqbvBxa9mbW1Mlgsg2vfm3VOYj89i0FBc
   Wr4y1laaDR4upvnQr6MphccNUYC1frAdeFO7cIOl3b6ZKKTsX9agExxhW
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.04,224,1695679200"; 
   d="scan'208";a="138336126"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 13:59:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CFCCEE0CCF; Fri, 24 Nov 2023 13:59:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D0666E004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 13:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mGFIVQmVT38s/H0NWGZDPXwjUVmQxjIH24hliCZc7cA=;
  b=UlH3OJ0S9u/mN6B/P5qGP5QM+fu2YM+5FGPrDb+OEJDeo2649vDpelfG
   KCP0XdICltqE3fqJ0BZyjQ4nk3SfyKsAMv+WB2AM+tZYHzCi+VPQjXwmp
   OOdraDrhHPEkW/vjgsSE9wjd37OU6BCfOKO1B5/W4nVwhk5k+QJ275f53
   g=;
X-IronPort-AV: E=Sophos;i="6.04,224,1695679200"; 
   d="scan'208";a="138336113"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 13:59:11 +0100
Date: Fri, 24 Nov 2023 13:59:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ee749bea-9fdc-40c6-818f-7c14cb705586@web.de>
Message-ID: <1c6770aa-c9e8-566-3a28-e9cb36e2f85b@inria.fr>
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de> <alpine.DEB.2.22.394.2311240807170.3349@hadrien> <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de> <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr> <d36b547b-a4d2-4e0d-a028-fb9237f99f2e@web.de>
 <d22bd929-b0cb-1b1d-9c8d-3e2e9e1e024@inria.fr> <087e1c6a-31d2-4205-8afc-5925cc01b20e@web.de> <ee749bea-9fdc-40c6-818f-7c14cb705586@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1153730488-1700830750=:3364"
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1333
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/1c6770aa-c9e8-566-3a28-e9cb36e2f85b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1153730488-1700830750=:3364
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 24 Nov 2023, Markus Elfring wrote:

> > Test result:
> > Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch test-example-20231124.cocci example-Julia_Lawall-20231124.c
> > …
> > (<coccilib.elems.Location instance at 0x7ffbc3d2b910>,
> >  <coccilib.elems.Location instance at 0x7ffbc3d2e500>)
>
> This test case shows that the script rule “display” was executed only once.
> The found source code places were accordingly passed in a single data structure.

This is normal. There is one match.  So all of the positions that are part
of that match are collected together.

>
>
> Please compare the software behaviour once more also according to following
> test files.
>
>
> @initialize:python@
> @@
> import pprint
>
> @find@
> identifier target;
> position pos;
> @@
>  goto target@pos;
>
> @script:python display@
> places << find.pos;
> @@
> pprint.pprint(places)
>
>
>
> void my_test(void)
> {
>  if (1)
>     goto x;
>
>  if (2)
>     goto y;
>
>  if (3)
>     goto z;
>
>  x:
>  y:
>  z:
>  test = 0;
> }
>
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch ../janitor/use_common_code17.cocci three_questionable_gotos.c
> …
> (<coccilib.elems.Location instance at 0x7f8bd82e6050>,)
> (<coccilib.elems.Location instance at 0x7f8bd82e6730>,)
> (<coccilib.elems.Location instance at 0x7f8bd82e8640>,)
>
>
> Would you ever similarly like to receive position information in one sequence
> instead of separate record sets?

No.  One can import many kinds of metavariables into a python script.
Each execution of a python script is with respect to a unique snapshot of
metavariable values resulting from a single match.

julia

> Can a more consistent data grouping be achieved for such use cases?
>
> Regards,
> Markus
>
--8323329-1153730488-1700830750=:3364--
