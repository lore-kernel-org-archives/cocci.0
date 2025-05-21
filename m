Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3848C3ABC9
	for <cocci@archiver.kernel.org>; Wed, 21 May 2025 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=k1vS8JYdHK8Jjgi2uMmodG+xrs4nUZGVm9ArE19FMww=;
  b=Y8nGINTVc6spKLdHOFRBn9/Ooq1g2Z4NOZZnfXw8OastUlxPU9LBKPVV
   XaG9m6LTnycTyyI0na261O68O/mROCi0oVWjpfQqU/g4htNDyVmTO+WGc
   O67V9BT82OxW2ka6YghZLA1MLpzhc5ceoxtWy+pdbDiOlI5jiMXwEPi4F
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223169478"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2025 13:59:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9675E0CCF; Wed, 21 May 2025 13:59:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6526DE0131
	for <cocci@sympa.inria.fr>; Wed, 21 May 2025 13:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k1vS8JYdHK8Jjgi2uMmodG+xrs4nUZGVm9ArE19FMww=;
  b=ReHIfX3VlnXPS9PitUceYymZ4+jLsyBocHDdJpF7Xqv2Wolj4F1fjRDe
   m+xlT5OrbUlpDE0Ag4Sa8dxvdn/P3z31HB6Ug2VQ3P+O13QPYrE/UX/Az
   Ltwv9JXKJDNJpr926+a/b1NfhgeEW1cWIIrbQnpeeTyIoexrPZfmFrQWJ
   o=;
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223169459"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:58:59 +0200
Message-ID: <ed4c614b-82da-41c9-bd28-1bd5e57f3b2b@inria.fr>
Date: Wed, 21 May 2025 13:58:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Olaf Hering <olaf@aepfle.de>
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
 <6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
 <fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2743
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/ed4c614b-82da-41c9-bd28-1bd5e57f3b2b%40inria.fr>

I'm thinking the issue is simply due to weird dependency issues that are 
documented in the file I mentioned. If you'd like me to help you, please 
provide me the information I asked for.

Victor

On 19/05/2025 17:50, Markus Elfring wrote:
>> It depends on your current setup and what you want to achieve, …
> Did you stumble on undesirable understanding difficulties?
>
>
>> … and the output of `spatch --version`.
> I informed you that also this program call variant can not work any more
> with my Linux software distribution because the library for PCRE1 became outdated
> and the corresponding package vanished therefore.
>
> * I assume that the usage of regular expressions might not be required for some
>    command variants.
>
> * The program can eventually be built without PCRE support (for a while).
>
> * Olaf Hering showed how the PCRE2 support could be activated.
>    https://lore.kernel.org/cocci/20250319083051.2862-1-olaf@aepfle.de/
>    https://sympa.inria.fr/sympa/arc/cocci/2025-03/msg00161.html
>
>
> Regards,
> Markus
