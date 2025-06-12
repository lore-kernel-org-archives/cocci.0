Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1351CC71136
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Impajoak0kJSJXqQLXp7m7eDnC69gx2g/jbuAeR5hcQ=;
  b=nqcsqRxMeruH9Op/fYd16MC9OR6mujssKk7ExhIZDvLb43DIu7C2KUoL
   gHk40ctlpMtpc4l7JhkxcgjaskShW3PYHL3CX8qEegIYJHqL/ubeJenFN
   0+suCa7MRWWZqzbnEnFs+FkDrfGl1u1rZAg1ERwDTJ6WWiyinX0goAthr
   E=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226930184"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 18:04:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81813E0AF1; Thu, 12 Jun 2025 18:04:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1518DE0157
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 18:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Impajoak0kJSJXqQLXp7m7eDnC69gx2g/jbuAeR5hcQ=;
  b=vqbi0rkRbgN0nU7g5zuLkuxy4iqLAug6Vb7qtLujXHh17MA76CZ+2zTr
   ZepQxMrOJik/p8n5qI39LkJNpsGF5PlXZvjBNJnvtoGcvMILAMxHUwqwu
   Pmdu48MfSQZrk7VTrn1QQum9JAtfw3LdSFsQtYh/shuYO/XnmufNPulWR
   k=;
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226930174"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 18:04:45 +0200
Date: Thu, 12 Jun 2025 18:04:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
cc: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <PH0PR11MB5095C3973BFA25B12C97E2A4D674A@PH0PR11MB5095.namprd11.prod.outlook.com>
Message-ID: <a0f1dfba-55b6-06a-246b-adb94af39a18@inria.fr>
References: <90822099-5434-4421-a611-785511926ecb@web.de> <alpine.DEB.2.22.394.2506101739440.4658@hadrien> <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de> <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de> <cc827ab9-6e22-89f2-2e79-a844c7e1f1a2@inria.fr>
 <PH0PR11MB5095C3973BFA25B12C97E2A4D674A@PH0PR11MB5095.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1336163114-1749744285=:3462"
Subject: RE: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2781
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/a0f1dfba-55b6-06a-246b-adb94af39a18%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1336163114-1749744285=:3462
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 12 Jun 2025, Keller, Jacob E wrote:

>
>
> > -----Original Message-----
> > From: cocci-request@inria.fr <cocci-request@inria.fr> On Behalf Of Julia Lawall
> > Sent: Thursday, June 12, 2025 6:03 AM
> > To: Markus Elfring <Markus.Elfring@web.de>
> > Cc: cocci@inria.fr
> > Subject: Re: [cocci] Checking another deletion of redundant null pointer checks
> > (with SmPL)?
> > I have no idea what is the program rg, but the problem is already fixed.
> >
> > Julia
>
> Ripgrep, https://github.com/BurntSushi/ripgrep
>
> It’s a rust-based alternative to grep. Its very fast, always recursive, and has a bunch of nice quality of life features for scanning as it will obey common repository ignores (and doesn't attempt to traverse below .git, .hg, etc).

Thanks.

It may be that we are now only using git grep for performance critical
things (at least for git repositories), so perhaps git lets you choose the
grep you want?

julia
--8323329-1336163114-1749744285=:3462--
