Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADE3E7716D
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lAfqafsxwrqLArJ1cwO4NK3iIDoMu1BiTOyHhDVtA1I=;
  b=WMZ4JxuHTsNhsjhl6A+rY+Wsu76GhAB4QyaXK/uEG2q2P4qzYl8Z7pyW
   AEB/x5D6e3mblPceoBuVYBuenKsMVXfvTzAh2H9mE6mr+xPpNWbpwr5JN
   MIqSQS+ShUBhFMIF/LYzXHtsKXLSW7fmJGAyuZi7EHq14IhgkhqAx4ehl
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421243"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1DE72E0D1D; Wed,  4 Dec 2024 23:28:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 522F1E00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 09:01:54 +0100 (CET)
IronPort-SDR: 67458071_fW/Hk/Epuroi06TEJ8JjUms8VOx0SGDssay533j1ckIFkzU
 VKU2pS+t8/WOuLDMj4mlN97dM+Uph5vqHD9IfLQ==
X-IPAS-Result: =?us-ascii?q?A0EBAADCf0Vng3yFCqpaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYJDfYENBFMthCmIHYcwgiEDhDuND?=
 =?us-ascii?q?4p3gVaBfg8BAwELAQE7CQQBAQMBA4FJgnFGAneJZAIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBOQcOO4V7DYJiAYEJG3QBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBASICAQEBAQEBAQEBAQEBAQEBAQEBFwINfgEBAQMSEQQLA?=
 =?us-ascii?q?Q0BATcBDwsYAgImAgIzAQUBHAcSAgEBHoJfAYIwAzEDEQaiJQFugQVCikMBA?=
 =?us-ascii?q?QF4fzOBAYIMAQEG2yYNbIFkAwYJAQqBBi4BiEsBhVAZGyCDQnonG4FJRIEVJ?=
 =?us-ascii?q?wuCeD6BUk2Bez44gw6CaYJEgTEJg1UlTYRnAoI9gQ2DfolRdYNaiThSexwDW?=
 =?us-ascii?q?SERAVUTFwsHBYEpISwDgXlOf4E2KIEpAUKCTkqDLoFeBTcKPYJKaUs6Ag0CN?=
 =?us-ascii?q?oIkJFmCTYElBAWDa4ELg15lLwMDAwOCEYErhhgdQAIBC209NwkLGwY9oSABR?=
 =?us-ascii?q?oNBBgEBDYEAJAgEHS5gHlJWkkEUgzyaaJUPhCSKNYFhlTIGDwQvhASNBYY6F?=
 =?us-ascii?q?JJ6iC+QTCKNXpUWXAGFCwIKBwYRI4FEOoFcMxoIGxWDIk8DGQ+OIRmDYcgzQ?=
 =?us-ascii?q?zQCATgCBwEKAQEDCZBqAiYHBYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 NWzyyBWOXlp43y9FFFbJcvlNn6xvr8x4+n1sTPC
IronPort-HdrOrdr: A9a23:/2gL2KM7xLSsHMBcTmCjsMiBIKoaSvp037Dk7TEPdfUnSL3tqy
 nIpoVs6faUskdnZJhEo7u90ca7MAvhHPJOkPgs1PKZLXnbUQiTXfpfBOnZskTd8kTFn4Y2ut
 YHT0E9MqyPMbETt7ec3ODSKadc/DDoytHVuQ6T9QYWcShaL45n9BlwEQuWHwlbQwNcFYMlGJ
 f03Kt6jgvlV3BSQMrTPAhnYwEBnb32fVDdDyLuyyRXjTVnIFiThYLSIly93hMTWTtU3PMH3k
 KAuyLWooWP2svW9jbsk0vS65hdkMH9jv9tLoi0se4+bhXA4zzYFriI3Na5zUUISDXF0idYrD
 AEmWZDTqBO108=
X-Talos-CUID: 9a23:WSQbhWFAqeWYzVlZqmJA8UEzPZl0TUbl1U72Kl65DnxSd4WaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Ao8HwIw3CiCx3x30ujtiloN91BDUjwYWwT3oLgck?=
 =?us-ascii?q?6i4qHCHdcfG+lqGjve9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,185,1728943200"; 
   d="scan'208";a="195788731"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDHmK7uIv2hZDpJsDVxXMkOSrEc2qWr4Cx0NIP?=
 =?us-ascii?q?a5Pn4J5MbLdnJZuTAWrZMEVsWXP1q03hqr4zjOAPNR5MweaGGSfHAK4v?=
 =?us-ascii?q?GrZfc5D7zXGDzaRz0DacFIG9S8UMPMCAhlVTtUCSooR4rm13D80zwpQ1?=
 =?us-ascii?q?NUoeoC1iU2Yvb7qZMFbj8U+Q=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 09:01:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732608111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAfqafsxwrqLArJ1cwO4NK3iIDoMu1BiTOyHhDVtA1I=;
	b=csKc3vbD/KVIxH8sMHksChGWOsLklc5qnNYTiZ06uO9+oQIeZPUduehHMc7FjTT7tiwBf2
	KC4gFkzYjQF4A79s6XN4RKU8Q9EfwwdbD7TNUwVmS55x+NznjZ+TSWwQPH+PtocC8VkUiB
	Bni8uqkx+rXIoEMgvplPAreomBDWvZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-qatuEFgCOF6pkD_TxG1HhA-1; Tue, 26 Nov 2024 03:01:49 -0500
X-MC-Unique: qatuEFgCOF6pkD_TxG1HhA-1
X-Mimecast-MFC-AGG-ID: qatuEFgCOF6pkD_TxG1HhA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a0d30c06so7903145e9.1
        for <cocci@inria.fr>; Tue, 26 Nov 2024 00:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608107; x=1733212907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAfqafsxwrqLArJ1cwO4NK3iIDoMu1BiTOyHhDVtA1I=;
        b=aip/+fB1/sLQL5IgV1HI7M+nk/42oe90WVXeCmd2YLvEgmHDxkou3EBzG2a1Jw6fhj
         1CUTo4YAN7ezJln013Rf7MwDESZqHBWe/MDDwuKbqobRptFO90NXCaW+IdEbFDtf928P
         5EDdOFKRqDfSqJznxmwQ84Ur9Lp2VDFSTUp2JExLP0QhFI7TRD6uoQr7LL6ah7RC+ocd
         S9ZWvyQNo3741EPOswg6e7HblS+rQ9pBzRlOYxOeEcCj2kjQcik2Iv2M0o/vO09NFsnE
         y8cQgZJ9Uw7/8He9J5eMO+3oMLkIKlCiDg0BwjiUD4i9UWQKT9XJpCS0TfUSHqayae6r
         kFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/KNNwhU02QgkbcJ8j044KKMI7nJv9/FBjMHKD7Q/c3euLbSt4AwMJRkDU6Y/QzIbu2/0/jg==@inria.fr
X-Gm-Message-State: AOJu0YzHK+Az1xLoLXKbB3BxJ+Z73sT2camE2S/xqUUWDWzLcyRnJg3E
	HR2EISvt4WJdif1BhgSpHsurpDesf8JCs2KghjK3170JJFedZFoCfSIDUppX6cIvdnLCdt4eAXY
	qKRG8hUnQwFEhZX4NcOfN9AQCBKi0277fjDvDZfNtBwg=
X-Gm-Gg: ASbGnctzUHnSwQDEGXuUwzRIKoxfEUiNrC36CYhEnskwjDbxnfZIYVy78d+WTqFVkvg
	K1jW3+iQVdJm8aROx/P8W6/EI43fq4wQwhH585qI9qYxnXxSmms2jjJgF126pxfBJQ2X+q+cy3m
	1H1rvytH+MJd1w9lBoUMmYqmjxbTjFnTG/aHY2iEAY/M1EQRBvyguP2jtAzknO01eOdiMOiY9qi
	085c1p97aNVw2K/S7jSMkR43hLSjrC+gIy3NphCd3+5dpT9euRQc4Qqu0de3KzZ5xmOookGZH2v
X-Received: by 2002:a05:600c:5253:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-434a4dfa99emr15576525e9.0.1732608106705;
        Tue, 26 Nov 2024 00:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Zs+v/tKW0ky58iJbPzmLtmmXAe1KS/DiR3119yAT3rtX8xL7zpJ9OBnWLqLvIaKIGk8HBA==
X-Received: by 2002:a05:600c:5253:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-434a4dfa99emr15576215e9.0.1732608106313;
        Tue, 26 Nov 2024 00:01:46 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafedbcsm12725815f8f.41.2024.11.26.00.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:01:45 -0800 (PST)
Message-ID: <afe444bb-5419-47db-8b2e-b51945dae752@redhat.com>
Date: Tue, 26 Nov 2024 09:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cgzones@googlemail.com, linux-security-module@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Serge Hallyn <serge@hallyn.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, cocci@inria.fr
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-6-cgoettsche@seltendoof.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241125104011.36552-6-cgoettsche@seltendoof.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NP106hepBjJ7DV4qLbNuAvINGj1cJ8Q7fyQnUYiNjGY_1732608107
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 07/11] ipv4: reorder capability check last
Reply-To: Paolo Abeni <pabeni@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2147
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/afe444bb-5419-47db-8b2e-b51945dae752%40redhat.com>

On 11/25/24 11:39, Christian Göttsche wrote:
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  net/ipv4/tcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..bd3d7a3d6655 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3406,8 +3406,8 @@ EXPORT_SYMBOL(tcp_disconnect);
>  
>  static inline bool tcp_can_repair_sock(const struct sock *sk)
>  {
> -	return sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
> -		(sk->sk_state != TCP_LISTEN);
> +	return (sk->sk_state != TCP_LISTEN) &&
> +	       sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
>  }
>  
>  static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)

The code change IMHO makes sense, but the commit message looks quite
unrelated to this specific change, please re-word it describing this
change helps capability validation.

Additionally it looks the net patches don't depend on other patches in
this series, so it would simplify the merging if you would resubmit them
separately targeting the net-next tree explicitly (add 'net-next' in the
subj prefix).

Note that the net-next tree is currently closed for the merge window, it
will reopen around ~2 Dec.

Please have a look at:

https://elixir.bootlin.com/linux/v6.12/source/Documentation/process/maintainer-netdev.rst

for more details.

Thanks,

Paolo

