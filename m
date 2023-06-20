Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3887EB64D7
	for <cocci@archiver.kernel.org>; Tue, 20 Jun 2023 21:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GUzZTqcz2EkevWiEAOl8szsI/SjV9TXD8pu1StJv1KU=;
  b=mN0ovBab8v3Ssd5k9XNY43A068ZwZdF9tYSHngtlFZMH6/uj+RofH3nh
   NcXIhDzK8oYqy5YZkiaHLNPo0DASN3n2lsyh4yl9mBPCzNNyA3HU7KYcH
   MC9ce8ZMXAkDXKKwzhYotz45jdodPazIbnfWU0INV/xnCRYWAArApDV9/
   8=;
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
X-IronPort-AV: E=Sophos;i="6.00,258,1681164000"; 
   d="scan'208";a="113865042"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2023 23:56:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 05DABE03AC; Tue, 20 Jun 2023 23:56:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 73A71E0157
	for <cocci@sympa.inria.fr>; Tue, 20 Jun 2023 23:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GUzZTqcz2EkevWiEAOl8szsI/SjV9TXD8pu1StJv1KU=;
  b=rEMl2/+QFfQPCL8TouV3RpFJCzmoOymhN8wINyYpH8CYfvvMvfQhTXGO
   q+e0N/Tk9prCm1GfFc1TzMS25wrxII1UbB+frnKPPhO/YaDaMRJCj69sf
   JqXS+X2+KXVf20O1bt4c6ROfBq/YEsE7arINGrstYtbKxmXKMcQn13hLx
   M=;
X-IronPort-AV: E=Sophos;i="6.00,258,1681164000"; 
   d="scan'208";a="113865035"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:56:07 +0200
Date: Tue, 20 Jun 2023 23:56:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <f8fd4d59-74d7-50ed-e82a-db50b09ffd@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2306202355070.3024@hadrien>
References: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net> <cfd5ba59-f9f4-8c33-1482-e31cb8af4e24@web.de> <f8fd4d59-74d7-50ed-e82a-db50b09ffd@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Strange spatch behavior while patching an array of
 structs
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1204
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/alpine.DEB.2.22.394.2306202355070.3024%40hadrien>



On Tue, 20 Jun 2023, Eric Wheeler wrote:

> On Tue, 20 Jun 2023, Markus Elfring wrote:
>
> > > Is this a bug, or an error in my understanding of SML?
> >
> > I got the impression that there are some factors involved for further possible improvements.
> >
> > Would you like to try any more SmPL script variants out?
> >
> > @replacement disable ptr_to_array@
> > identifier R, X;
> > @@
> > +rotor_cal_min(
> >  R
> > +)
> >  ->
> > -cal[0].
> >  X
>
> Interesting, I hadn't considered breaking an expression on multiple lines
> like that to splice what I want.  Thanks for the hint!

It probably doesn't matter much in this case, but it can be useful for
maintaining the original whitespace.

julia

>
> -Eric
>
> >
> >
> > Regards,
> > Markus
> >
>
