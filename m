Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDC4C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=H21fvQtQ7WtagqXZixGpBpqK/Mf2KBTn3BMn7sI6Xwo=;
  b=EwDLQo5M3TOQKih//Ah3so01VGbvEW2A54i7jCUYGEE/qLM/k/c6BQGB
   2UCyteCap4PaRb2xMCb7oQe/XHQzky3KVUknJdC5AyGvvBzASvJ7t0uQH
   +8PQz5cRGGBlbzmWUn8OXrimctsKPanWercv/T+FKkcbgS0I/m5i/+wV1
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161861421"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:56:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A01B2E0035; Tue, 16 Apr 2024 14:56:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6BBCEE0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 14:56:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H21fvQtQ7WtagqXZixGpBpqK/Mf2KBTn3BMn7sI6Xwo=;
  b=aNM5L+VcxO66+rnB0hrRLAaQ7ltle4u+tjVsgiIcGM/6+KSsIiVloa8h
   6T5/bjbuUhkdmon2C/f4fRUxnH/0MxnwhPqEEHqJrqp5Pz9sASMNsGN47
   eaViXdS0DYtY1iFSc2drIjE5rWOAbjxAEf3P5NybCbo0e6bzoSQz4uMLB
   c=;
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="84954712"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:56:51 +0200
Date: Tue, 16 Apr 2024 14:56:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
cc: Markus Elfring <Markus.Elfring@web.de>, 
    Michael Ellerman <mpe@ellerman.id.au>, 
    "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
    "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
    Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <3711cad3-a627-4a6e-8769-ce916c1919ee@csgroup.eu>
Message-ID: <3f22920-9543-efd1-a32a-477ae18a2b2a@inria.fr>
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de> <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse> <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu> <33a38d7e-26da-46e0-90d4-7137f9ec0c90@web.de>
 <3711cad3-a627-4a6e-8769-ce916c1919ee@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-563611295-1713272210=:3643"
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1666
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/3f22920-9543-efd1-a32a-477ae18a2b2a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-563611295-1713272210=:3643
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 16 Apr 2024, Christophe Leroy wrote:

>
>
> Le 16/04/2024 à 14:14, Markus Elfring a écrit :
> >> This is explicit in Kernel documentation:
> >>
> >> /**
> >>    * kfree - free previously allocated memory
> >>    * @object: pointer returned by kmalloc() or kmem_cache_alloc()
> >>    *
> >>    * If @object is NULL, no operation is performed.
> >>    */
> >>
> >> That's exactly the same behaviour as free() in libc.
> >>
> >> So Coccinelle should be fixed if it reports an error for that.
> >
> > Redundant function calls can occasionally be avoided accordingly,
> > can't they?
>
> Sure they can, but is that worth it here ?

Coccinelle does what the developer of the semantic patch tells it to do.
It doesn't spontaneously report errors for anything.

julia
--8323329-563611295-1713272210=:3643--
