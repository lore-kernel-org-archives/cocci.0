Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11A0C77B61
	for <cocci@archiver.kernel.org>; Sun,  9 Apr 2023 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/XxL2YQ7mwgsHIuRErZtpjcuXpumOdbWZSudzFSHabc=;
  b=QceECl5nGEYU/mMJNk6P0LheAq1dc1fBEGCZbGT4bRKujykZrwhP7AyC
   svOpEt3JbA1hNQaKeeMomp/qJT8B4YRHJNGybAfzo3J27VY5TZ5kQo6uJ
   6bxoiu+THeFr1HXz9agIuh5hrG35eokPyRjMUXohLcDEIrsG7BwdtXQxD
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,331,1673910000"; 
   d="scan'208";a="102222876"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Apr 2023 20:45:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3E62E7312; Sun,  9 Apr 2023 20:45:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BEC97E72F8
	for <cocci@sympa.inria.fr>; Sun,  9 Apr 2023 20:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/XxL2YQ7mwgsHIuRErZtpjcuXpumOdbWZSudzFSHabc=;
  b=eIOB1h1Us779OYQPy+T9qjOaam7h0KVwq9znefhJWY9UpHVB7CqMg8pe
   x0lMURKQjs2ajr76jlG5xyK30kBD957WRJhFQLlCdVHxKm5uYtk1pyPao
   8hUceYFup9FCEYep+pvdEo6IEIp5ASTSZjp8/3TQ/pRL8JhQTcqL5/7YB
   M=;
X-IronPort-AV: E=Sophos;i="5.98,331,1673910000"; 
   d="scan'208";a="102222873"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 20:45:28 +0200
Date: Sun, 9 Apr 2023 20:45:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Message-ID: <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de> <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-725807146-1681065928=:3028"
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1016
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304092044020.3028%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-725807146-1681065928=:3028
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 9 Apr 2023, Markus Elfring wrote:

> Hello,
>
> I tried the following SmPL script out also on the source files from
> the software “Linux next-20230406”.
>
> @display@
> expression action, input, target;
> identifier member, var;
> type t;
> @@
> (
> *t var = \( &input->member \| action(..., &input->member, ...) \);
>  ... when != input
>      when any
> |
> *target = \( &input->member \| action(..., &input->member, ...) \);
>  ... when != input
>      when any
> )
> *if (input == NULL || ...)
>     return ...;
>
>
> 31 source files were found where it was tried to determine the address of
> a data structure member (which includes a pointer dereference)
> before a null pointer check.
> I imagine that such code should be reconsidered once more and improved accordingly.
>
> How do you think about to achieve any adjustments in this design direction?

Setting var to &input->member does not cause any immediate problem.  If
there is a dereference of &input->member that can happen at run time
that would be a problem.

julia
--8323329-725807146-1681065928=:3028--
