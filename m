Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F7DFA373E
	for <cocci@archiver.kernel.org>; Tue, 25 Oct 2022 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FQl2ovxtUiSBcwP9UiVAIa5OZ/FN9BmKLzSTOjdrgUM=;
  b=bl0EZPTk3tSNT8cPgXbwMNH5FBJq62twgtso+O5bxk9Zu29zGOgZM2Oq
   Ym0dVUIgvbvHsEEqdBHkmiF6VsnmTh4tDT8133RbHK45GOHDhXFn/48or
   aJWLBqkdUtWIfFn7uF4d0tMXwkhi28tAjTcSJnrR421mbZHajiR9iGchD
   E=;
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
X-IronPort-AV: E=Sophos;i="5.95,213,1661810400"; 
   d="scan'208";a="71494988"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2022 22:44:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63ECFE0130; Tue, 25 Oct 2022 22:44:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 221CAE004E
	for <cocci@sympa.inria.fr>; Tue, 25 Oct 2022 22:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FQl2ovxtUiSBcwP9UiVAIa5OZ/FN9BmKLzSTOjdrgUM=;
  b=CzAbu4DPzuOvRrAHPnSow+hr7Hnd4zwsF8dKQe8FEo+YeoxxAVRizSgT
   dl7zghjli0fFiDX4yCjFsGsIoeFA5gxmHkDMJ1rkHCVC3aUh+fgLor51c
   8q/3BxsqJyX6BHwHECjRnhVuME8kKiLVWzH1HxAsrNMoZpihJpETYVo0I
   4=;
X-IronPort-AV: E=Sophos;i="5.95,213,1661810400"; 
   d="scan'208";a="35539344"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 22:44:44 +0200
Date: Tue, 25 Oct 2022 22:44:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr, Thierry.Martinez@inria.fr
In-Reply-To: <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210252244280.2973@hadrien>
References: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>  <3ee3239d-4b72-9239-893e-b08acbae7df9@inria.fr> <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2114674681-1666730683=:2973"
Subject: Re: [cocci] No longer possible to build with system dependencies?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 689
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210252244280.2973%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2114674681-1666730683=:2973
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 25 Oct 2022, Jan Tojnar wrote:

> On Tue, 2022-10-25 at 16:54 +0200, Julia Lawall wrote:
> >
> > This problem should be fixed now.
>
> Thanks, d9ce82a556e313684af74912cf204bb902e04436 fixes the issue for
> stdcompat but it still does not work for pyml.
>
> If I remove the `/dev/null` redirection from pyml’s configure test, it
> reveals the following error:
>
>     File "configure_test.ml", line 2, characters 0-0:
>     Error: Syntax error
>
> Looking at the contents of `configure_test.ml`, the square braces do
> not appear to have been transferred:
>
>     Py.Class.init ~parents:
>
> Apparently, three braces are sufficient to make it work but why that is
> the case eludes me. m4 language is simply beyond my comprehension.

Thanks for the feedback and the suggestion.

julia
--8323329-2114674681-1666730683=:2973--
