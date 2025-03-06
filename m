Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985E7C282D1
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FXyrFeh8iw8nkg9quS25u1pEn/e0t0eT9s6YNTK4C5g=;
  b=lH7LL5hG6Aoh0+uE498iTa/FhTcHZvX2mGjbYECE3S/7xjyaBApuQ8+r
   FlBD/yysZ42yYTmqE86z6oq5Ze+AXlGntqRa0CtFcwTNyApSrze6S6KFj
   qESL+U6whlZH669MbPQIrd/KSfOqgSEXuTzaIgvxkhdUIN1nqcLeMQqWb
   4=;
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
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="211543743"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 13:19:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EECBDE0264; Thu,  6 Mar 2025 13:19:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2CD8AE0260
	for <cocci@sympa.inria.fr>; Thu,  6 Mar 2025 13:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FXyrFeh8iw8nkg9quS25u1pEn/e0t0eT9s6YNTK4C5g=;
  b=k8efExAUJEbPaRRdgWjtGcmNdSws+HiPIkT7xUFMb1xkkiLQ9ZHv5n8H
   3TY3PAr/UKIK2q+SAx4I1SLON5MJ/Tk6Bc+zyl6bI/SJlZRVtOyjyqguP
   Bm3+bSQ0LnfOll4945VGFrkCHB0mGBF/AaRUzmRWV3aF/1Ccbr7hLOfJg
   0=;
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="211543742"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:19:32 +0100
Message-ID: <045a20a2-5c87-4853-aa33-5579df4423fe@inria.fr>
Date: Thu, 6 Mar 2025 13:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>,
 Danikka Jelski <cmj136@scarletmail.rutgers.edu>
Cc: cocci@inria.fr
References: <CABDMBwh_LRL+Dxz94caz+ybJT5MLP9usBs12fLeDHaTSnOES3A@mail.gmail.com>
 <14e44e1b-e35d-4cc9-ac76-2e4c05c15849@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <14e44e1b-e35d-4cc9-ac76-2e4c05c15849@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Modifying BPF map definitions?
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2566
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/045a20a2-5c87-4853-aa33-5579df4423fe%40inria.fr>

Hi Danikka,

Thanks for your interest!

I don't have an answer for you right now, but I just wanted you to know: 
Markus is known to send unhelpful emails to newcomers, so feel free to 
ignore him if his emails don't make a lot of sense. He is not a 
maintainer. I do agree that text is usually preferred over pictures, but 
don't sweat it too much.

Victor

On 06/03/2025 13:13, Markus Elfring wrote:
> …
>> Specifically, I was trying to modify BPF map definitions, and I encountered an issue when applying a patch:
> …
>> The error I get is:
> How do you think about to share any additional information as text
> instead of linked pictures?
>
>
>>      Can you provide any guidance on how to properly match and modify this struct in Coccinelle?
> I observed that another transformation approach gets accepted
> (also together with the software version “1.3-00043-gcca22217d”).
>
>
> @replacement@
> @@
>   __uint(type,
> -       BPF_MAP_TYPE_ARRAY
> +       BPF_MAP_TYPE_PERCPU_ARRAY
>         );
>
>
> I am unsure under which circumstances a subsequent software version will become able
> to generate patches accordingly.
>
> Regards,
> Markus
