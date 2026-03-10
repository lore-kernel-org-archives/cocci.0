Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05018FCC9A4
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 00:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=x24WZ2obWhhtdu+N9LYBguLVYOBFNP1zYQWyBIFfQdQ=;
  b=XgwINpW4yYNttHz5EpjaDGSOifkoPDw5FiCnGmR/oI2R8H0EXVxRoTcA
   qqbqUybNb6OjrxYlLIJjtBFXZwT6V5szpTfSHlNIzLPR/SptwgfCy1R/y
   YfX47OMB4DrPGZirgVL5GcpLeMSNZgil5+Yrxb6/aoKF6Ixr5gf61BzD+
   k=;
X-CSE-ConnectionGUID: q4rOh5b8Q3yPFZ0UJbldpA==
X-CSE-MsgGUID: GZK+5f/lQ9qXRnmRPHo+/Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,111,1770591600"; 
   d="scan'208";a="266987144"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 01:10:58 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6136A816A5; Tue, 10 Mar 2026 01:10:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 39C26816A1
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 01:10:54 +0100 (CET)
X-CSE-ConnectionGUID: BEhI4R0yTXCbdgll2K1oDw==
X-CSE-MsgGUID: 7KsyKsrjRUK3zBmr43TqpQ==
IronPort-SDR: 69af618f_5Ww6+gB2tQo9J1mTBJyxoeYEqMAc11rNOsnnGOMsQxeVGJx
 KRQZTcARGozvgig8eB6OY0wMc8gpaZHqAFy4CgQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.23,111,1770591600"; 
   d="scan'208";a="266987132"
X-MGA-submission: =?us-ascii?q?MDFvvMZpfJuj7BqMKci055SpBUlZSC5CQwWKNp?=
 =?us-ascii?q?bbg2au4LiiRq5dJgFOng9OQrBbcXqM022PIE7PcekbY9aD9zVV+z/kd2?=
 =?us-ascii?q?Hy18QvBdmzmNCcbvHvBRiaUg9xrj+m7Q8PHWm1Jn/vPEwEcwP4XbTb1+?=
 =?us-ascii?q?Gvh0LKUfhgXuLhcMdb/SRJWg=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 01:10:55 +0100
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id D5E6B40277;
	Tue, 10 Mar 2026 01:10:53 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
	by mailhub-2.u-ga.fr (Postfix) with ESMTP id D20ACFF853;
	Tue, 10 Mar 2026 01:10:53 +0100 (CET)
Received: from [192.168.1.87] (unknown [87.89.124.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 5CBD8400E6;
	Tue, 10 Mar 2026 01:10:53 +0100 (CET)
Message-ID: <1c546ad7-14f8-4695-9754-32a020f8a082@imag.fr>
Date: Tue, 10 Mar 2026 01:10:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoyang Liu <tttturtleruss@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Julia Lawall <Julia.Lawall@inria.fr>, Shuah Khan <skhan@linuxfoundation.org>
Cc: cocci@inria.fr, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260308100851.341-1-tttturtleruss@gmail.com>
 <87v7f5vv9x.fsf@trenco.lwn.net>
 <ae8dda71-9e25-4f3b-ab95-1b00809ade37@gmail.com>
Content-Language: en-US, fr
From: Nicolas Palix <nicolas.palix@imag.fr>
Organization: LIG
In-Reply-To: <ae8dda71-9e25-4f3b-ab95-1b00809ade37@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via submission-587 ACL (41)
Subject: Re: [cocci] [PATCH] docs/dev-tools: fix a broken URL in
 dev-tools/coccinelle.rst
Reply-To: Nicolas Palix <nicolas.palix@imag.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3361
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/eZ0DZkl-OwVHnnt6Ppr_xA>

Hi,

Maybe we can just throw away that section of "Supplemental 
documentation" and its link ?

Nowadays, there is much more SmPL provided, and the rst file
describes better and up-to-date information.

Would a link to
https://www.kernel.org/doc/html/latest/dev-tools/coccinelle.html
be useful to point to latest version ?

Sincerely,

Le 09/03/2026 à 17:28, Haoyang Liu a écrit :
> 
> On 3/10/2026 12:10 AM, Jonathan Corbet wrote:
>> LIU Haoyang <tttturtleruss@gmail.com> writes:
>>
>>> The original supplemental documentation for coccicheck is
>>> https://bottest.wiki.kernel.org/coccicheck, which redirects to a not 
>>> found page,
>>> thus change it to https://bottest.wiki.kernel.org/coccicheck.html,
>>> which adds a suffix to original URL to make it direct to the right page.
>>>
>>> Signed-off-by: LIU Haoyang <tttturtleruss@gmail.com>
>>> ---
>>>   Documentation/dev-tools/coccinelle.rst | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/ 
>>> dev-tools/coccinelle.rst
>>> index 2b942e3c8049..f73ccf5397f3 100644
>>> --- a/Documentation/dev-tools/coccinelle.rst
>>> +++ b/Documentation/dev-tools/coccinelle.rst
>>> @@ -61,7 +61,7 @@ Supplemental documentation
>>>   For supplemental documentation refer to the wiki:
>>> -https://bottest.wiki.kernel.org/coccicheck
>>> +https://bottest.wiki.kernel.org/coccicheck.html
>>>   The wiki documentation always refers to the linux-next version of 
>>> the script.
>> I'll apply this - a working URL is better than a broken one.  But is
>> there really nothing better to link to than a page that warns "OBSOLETE
>> CONTENT" at the top?
> 
> Dear Jon,
> 
> Unfortunately, I do not find any other documents about this script, so I 
> have to use it even though it's obsolete.
> 
> Sincerely,
> Haoyang
> 
>>
>> Thanks,
>>
>> jon
> 
> 
> 
> 

