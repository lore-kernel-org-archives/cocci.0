Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E54CC61D97
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=r5gP0tdWZBJm54xly3SD6WJAD+FFBLa2B/X4uZwkdBk=;
  b=P3sRHhTNO+b9SOg70+53sWPRuSDzdoalWrVpXWJ9ljEmPjsJ7HS7xPKn
   dj7QJ5E7l2NU/o/BI59tErjiN5/YeEFKcVOrXWRAJ7v6Xb96iadfNqXnp
   O5vjOGsTeNK5N9D6AtpJB4FWpafszrspwwDs8suP3ZZEyiI7/Gv2kEMpx
   U=;
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
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137958053"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 18:28:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6C02E0CCA; Wed, 22 Nov 2023 18:28:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 98FD9E0AF1
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 18:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r5gP0tdWZBJm54xly3SD6WJAD+FFBLa2B/X4uZwkdBk=;
  b=n9mD1DBFN3jGc/wGApKCCP31qpKCSc1LtydlUHOdBt3HE37jwNXiNUGT
   y10AjRlr2+xHaYr/YiMncemCz3tlNO17UqKc45kkdEDETzW1voKmDEAa0
   SjMOzV8Zl5n/8EtdXzQYJfgtWaAl5f/rcJo+b1sCf/Qdwc0TAWT4WSs+6
   k=;
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137958042"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 18:28:08 +0100
Date: Wed, 22 Nov 2023 18:28:07 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
Message-ID: <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1307
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/43f969f3-94a5-6cd2-74a1-ae46f74de331%40inria.fr>



On Wed, 22 Nov 2023, Markus Elfring wrote:

> Hello,
>
> Some statements in if branches correspond to exception handling approaches.
> Would you become interested to detect a few statements from the last if branch
> in a generic way (with the means of the semantic patch language)?

Normally that would be an if without an else that ends in a return.  So

if (...) {
  ...
  return ...;
}

The ... on the second line will be allowed to go over gotos.

julia


>
> Regards,
> Markus
>
