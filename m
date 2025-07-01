Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C79C7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qh17Ycg/H+AoUaTEvQvsrEfhQ00Gn1Mbpjo0o8gYDHU=;
  b=bU47g+S/gbNI1ElA3LUNbt0UcUnaD5Il99a4rD9R6PQFDRyt3UPkxcUE
   7IYOQxrHuyAyV3rr4mI5TNadHOkOkGixREozG5zXs4BWIG/ms218eNPa8
   C7fI8nsRLGMbSwDLHFKKPCApjjG0NyJvMOv+I4lDLSBO9e4/3r1SeaYKW
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229737358"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 10:09:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01D04E0AF1; Tue,  1 Jul 2025 10:09:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B871EE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 10:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qh17Ycg/H+AoUaTEvQvsrEfhQ00Gn1Mbpjo0o8gYDHU=;
  b=M3E6j7v5cCRLdocgrgRn1kZI5zymO3ePS6VrrjDfwiBw50Fn04ltZtN8
   UZ5wozwRaOUlBTYzXUT4VKZh3Bg7uTAJmTPoRJShhlrPnGr+4AexLS447
   qIZYKzm+/y54qyG/2BoXE+vzIcWmpm462WV9QAl+UOoBb1eJaQ427KRi7
   I=;
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229737342"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 10:09:25 +0200
Message-ID: <fa0a3e28-0e7f-4528-8786-a9347e9f4e82@inria.fr>
Date: Tue, 1 Jul 2025 10:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <80682a1c-b4c2-468e-84a4-c7c860d47e4a@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <80682a1c-b4c2-468e-84a4-c7c860d47e4a@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Excluding files from data processing?
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2829
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/fa0a3e28-0e7f-4528-8786-a9347e9f4e82%40inria.fr>

Have you checked if --ignore fits your use case?

Victor

On 01/07/2025 08:33, Markus Elfring wrote:
> Hello,
>
> The Coccinelle software supports to work with selected directories.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b00c5adb1a485321c88450bdaa9e0d9ff93123dc/docs/manual/spatch_options.tex#L249-259
>
> Header files can also be taken into account for some source code analyses.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b00c5adb1a485321c88450bdaa9e0d9ff93123dc/docs/manual/spatch_options.tex#L196-198
>
> Unfortunately, it can happen then that files would be found for which more
> desirable data processing can not be performed so far.
> (The amount of preprocessing code can occasionally be questionable for example.)
>
> I imagine that advanced file filters would become helpful (so that other software
> behaviour does not influence run time characteristics in undesirable ways).
>
> Regards,
> Markus
