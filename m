Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71F1C282D1
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=I1Muupcpy+OM9bjik9PXq7Ryx61fO0zb5gU8UKxppt8=;
  b=TpXlIOJ1PMMRbCmqYZIQXkj3fKBF+4u5YcvG6e46H0VesoQ5BAZmQPXJ
   fFBjWUqKb0HB/uinRJXq/2Hc/xxhrWMTFt1bIgwPXh58ftjEV5mboaavo
   2l6KhU3tTSwutJUjqAQyv/CzolWu6XA/d15gYMNL1uZh4MFH7NX6McApa
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211490440"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:08:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 595C4E0D2B; Thu,  6 Mar 2025 10:08:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C81EE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 15:06:59 +0100 (CET)
IronPort-SDR: 67c70902_r+JehAooSa/QnbXCcq0QAoGaCVXuyWzqWclmoH31/ZJLZxy
 rocLF1edvpP9mvBeibmCLKxUIL2eIIJnEQbxJ/A==
X-IPAS-Result: =?us-ascii?q?A0EFAAA/CMdnfKveVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDgVczBFOEVoh8hlOCIQOLdoVRjE2BQD4PA?=
 =?us-ascii?q?QMBCwEBQgIEAQEDBDiESAKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABASIZBw4SKYV7DYJiAYEkYQIFAzsBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAixeAQEBAQIBEhEdARsdAQMMB?=
 =?us-ascii?q?gUVAwICJgICIhEBBQEcBhMihRABAw4jAwOiIoEFQopEeoEVBQIWgQGCDQbaX?=
 =?us-ascii?q?QoZKA1sA4FiAgcJAQqBBi4BhHQpTg6COB0BhVIZg316J4IoglCBNzg+gh+Ba?=
 =?us-ascii?q?xApg1uCaQSCL4FpAYEpghSHHIVighUieIU1BBJXbIJKjlcIBzEJCRMGCgJLC?=
 =?us-ascii?q?woSAwQDBAQBAgsTCQMDAg4CCAMCCAYZAT8SBBMKDQsHBR8KCAwRCigDIgQOK?=
 =?us-ascii?q?w8DWzQBCAYCAgQEAgQCCgIJAgIIBwIUAwIEBAIBBRIDCwEFBgUBAQQJDgICA?=
 =?us-ascii?q?wMCAgEIAgIBAQITAQQDAQcCAQQDBQMKAQEBAgEEFAYDBQMDBwMEAgMCBgIEB?=
 =?us-ascii?q?QUCAgMDAgMBAwMCAQIDCRAPFgICAwQCBgIBBCYCARUFAgMEAgIHAgIDAQIBA?=
 =?us-ascii?q?gICBAIEAgIGAwkIAQICBwECAgIDFQIFAQQJAwMFEgwgAwICAgIDBwoDBQIBA?=
 =?us-ascii?q?QIEAwMDAwwNBwIDAQIBAwUDAQIBAgkDBgICAwMEEhkFAwIPAwIBBQQCCBALB?=
 =?us-ascii?q?wEBDxQFBAkFFQMGAgMDFgsEBQMDAwEMDw4CAgsDFwUBAQcBAw0IAwQEAgMDC?=
 =?us-ascii?q?QIBEAEDBAIJAgQBAgoCAgICAgQBAQUEAgQDAgUCAgEIBAMDAw0EAwgIAwUDD?=
 =?us-ascii?q?BICAgIJAgMBAgMDAwQNCB0FCRELAgkDBA0CBAICAQYDBgoGFAECEgICBgwEA?=
 =?us-ascii?q?wMIAwIDAgEBAgICARECCQgNBQkFBgICFQMCAwgBCQMRAhQBBgIIAwcBAQQCA?=
 =?us-ascii?q?goRCgEBAgIBBiUCAQECExMHAwgCAgICBhYMAQUHAwcPBQUEAgIWAwMRBAQQA?=
 =?us-ascii?q?gIDAwIBARQGFQEFAgMGCwEGAQIFBAIDBAISAhETAwMEBgMBAgoNAgICCQoBB?=
 =?us-ascii?q?QQDBwUCHwMDAgIFCwIIAgIFAgUHAwkOAQIFAwQJAhQCEAICAggWAgICBRwBA?=
 =?us-ascii?q?iYCBAECAQIBAgECAQoBAgIOCQMENQYRBAIDAwIOAQICCwECAgQCAwEEBwkDA?=
 =?us-ascii?q?wkKBwEKDQcCCggJEAECAhADAgICAgYHDgMCEw8FBgYCCgcNCwIBAgIVAgMJB?=
 =?us-ascii?q?gMFCgMHBAoNAhUCFQUDIAIICQsCBxECBRIDDgUDAgIRBAIDAwUDAQcBFwMHC?=
 =?us-ascii?q?AICDAICAgIFAgUCBRcRDQQDAwMCCAEEFQYDCQgqGxIBAQUBCQIDAgMECAMDA?=
 =?us-ascii?q?wIGDAsCAQcIAwMGCwgJBgMCBwgZAwUEAwcFCyECBgMCBAUEAQUCEw0CAxkCB?=
 =?us-ascii?q?gMGEQkMAgYIBwkDBwEBAQICAggBBgUSAgMEAgUEBAEBCAMDBAYCAQMBAQICA?=
 =?us-ascii?q?QQJAgECCgIICgEJEwQDCAMDAwMDBQECAggEEQUFAgEFChMMCgYDBgMEAgICC?=
 =?us-ascii?q?wcCAwMDAgcBCyMCAQMCAgUCAgEFAwICBgQDAgEBCQIDAggBAgIBAgICBAEHA?=
 =?us-ascii?q?QQHBgEBAgQCAjYCAQMJAgUBAQ4CAgQCAgECAgIEAgQBAgYLBAUNAQECAQICA?=
 =?us-ascii?q?QEBBAEIAwEBAQICAwMFAwUIDw0BARcLHQMEBQICAQEBAQITAgIBCwECAQEDG?=
 =?us-ascii?q?gIBAwMEAQsCAQEEHwQWAgICAgIEAwICAwICCxMlAQIDBQMTAgEBBAIBAgIFB?=
 =?us-ascii?q?QUBAwQREwkBAwIFBAICBgIEBgoCBwQCGgQCAgIBAwQGAwECCAICBwQCAwYDA?=
 =?us-ascii?q?gIBAgIHGAICGQEDAQECAgIEAgICCQoEBQQEBAMCAgIBDAEBAwECAwICAgIBA?=
 =?us-ascii?q?wICAQECAwECBQEFDQISAgEDEQgEAgIHAgIjDwsBAQIBAQIGBgIDAwMKAwEKA?=
 =?us-ascii?q?QIBAQIGAgECFQUCAgECBQECAwMEKx0CCQMjDwMLCQgTPQwHMgQ2ARQUByuBA?=
 =?us-ascii?q?BOgdzqEOgYBAXoTMB0uNiolQAspApJvg1ABjwChBgeEHqIVl0UMkwWIMJBNo?=
 =?us-ascii?q?3oBhQwCCgcGESMSgTkKKYFcTSODN08DGQ+OIYN6yQslNTwCBwEKAQEDCYVDJ?=
 =?us-ascii?q?hOJbDSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2RNIOKjFu+rH5L8iN8HRp1G33nBQXh8ji2hC6mlwRA09TyVXrb
 HJoB19726KtN9xYgBdpTnkAsO9qBznhPtICOUqTNOftUzdyROVxeNZnPLfKkzbalDDH4dmvM
 8KAspD4Z/LfCNHZK7BkWqF+r0bsaO6Gc6T9IDj5kYoYgdwdal64gt1TiqdGFZnXRRLCPMCeK
 a0145oo36Pdx0sAPhTxUNrYwEAnbD2fV7dACLuziRG1DWz
X-Talos-CUID: =?us-ascii?q?9a23=3AMldhA2g7GMuG1DYl2DFbSdYs9jJubCCN/n7hD2i?=
 =?us-ascii?q?DF39MGIC4VUDKv41iup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AaCvnGw56nGBesPlfMlYTrkmjxoxmvaWhMkURyq4?=
 =?us-ascii?q?CovijFgxaFC+wlRG4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="110628035"
X-MGA-submission: =?us-ascii?q?MDERN//+Xz6v4Zz13MltEQBkllAAu3562iEmfO?=
 =?us-ascii?q?LWJfu4Ep+LwiziRa4s3y1cyoqscwS8BUF6ZUGPxj/PfloaBxPQiAWeJ0?=
 =?us-ascii?q?tlJoyxnxyS00wf4yX+RBsEfJkVGBzvbUOM9WwpAvDzwoabCaGulnSJON?=
 =?us-ascii?q?00UIUvxHiLG6Q2EUmnRouNYg=3D=3D?=
Received: from mail-qk1-f171.google.com ([209.85.222.171])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 15:06:58 +0100
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3cf3afc2bso61749585a.0;
        Tue, 04 Mar 2025 06:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741097216; x=1741702016; darn=inria.fr;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1Muupcpy+OM9bjik9PXq7Ryx61fO0zb5gU8UKxppt8=;
        b=ibjwquz67/2q9MSEecsxMmF0GffF+4jeCBP1Hn1BUMTSI/+9RXqRTkfhpmwtMm1Z7G
         +S7uf3HyofwbM6idwmesiOXoLftrr65dbsd2EmdVh/GPAajbwVi7ffLGB1lkxA6+3Cjs
         HCkxb6yK1MJabyPpNwQbAivDn5jfD40SszmJqlxOVR10e6gQpdDtCORfcQ1d8qxoNHit
         oa+YVxczf0hnwN3Ul9BN4+rRCUeEBQLYatSBHdRAzOQz3xInlyq+kqAT4BOmKbTweNoj
         HzfcMDAZrZrAp4VU9+P52npGiu1cKqg/46EfmDWHDNrQM3ho9lz8ZvN5MIraOYzPB9a9
         ZoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097216; x=1741702016;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I1Muupcpy+OM9bjik9PXq7Ryx61fO0zb5gU8UKxppt8=;
        b=fXmPff66vo61WGlKxKROgereYurr0owgUGCCYhq6zuT6w9wnWQIqXSjUHQhxYhvFE7
         LCwXDoafKJz7JafiQq5iIBB2fKLNBmvPF82LX3mG7mlyqtZjt2ycqDCLOA656HXw3sJt
         F8vuBppqorBswImAwSmsaNsbBt73/qYhcWN5Kh4yIcXFA5RWWdgW+Y/mkusB6X1ss5Au
         brze5YE/CWL0pjt0EBQ0srBqRUT5hAmJWZC1H5e5duyoQ6Tyk7CaRtx0mhD05kBEHpMM
         KA3nwfp1s8WLUK3Xxojo1ZPNO/n79Y7W56F9Egx6RUmyclDcEcDSnI7pPwo+X3y0DU1A
         Kulw==
X-Forwarded-Encrypted: i=1; AJvYcCW1cIcgxhPzazMQZht+BeY0lkMntCRNgsvci2uRFseQhj7oM3zJ0yQTPIUayTMF/VGXCLfb7AQ=@inria.fr, AJvYcCWeHtOs43E+bximroJV/Q7lrjZReVhE0AqVprz5JosvVCsrX8cOqTgfmaAlFcAsRdNbIAvYx1bglvB3Nto=@inria.fr
X-Gm-Message-State: AOJu0YyyLWMqTB2AXOChHgQkOuGeRNyGe56Njs3AZiOBM6D+7nAbQFqg
	4EuYsINAHQmviufUC/gHXJMNg60cUTCmiSai5kkBatEB0Sao2235
X-Gm-Gg: ASbGnctxdahMXh/m8rFwlGol3vjj4+SrR049x3MOffMTOxk90SZVrVKtAagtSmr5/qD
	+C0V3TYGp6wNaMv86zZkXpBYzMPhPHM8JJ9mMDGibUgF6guOYjilRgkfNaRO8wnti+KknZ3Waza
	IokHW8bCPdE4AWxLhsroznbrDGBjnVpVq/m19iHlVTdN1ZP1HknbDVGeRwArWYUUvc34jt3h8X6
	6zzQtGKWnqMh0Y5CIn34kLUtAdCiJBeMJhNXoLV+SAjHB1BnlprScXz+JkoqPNqQLXhLJzHODDg
	UBC1n5vypH1rW5BDS+33mwKgB/rIUh6w1kRwq7DC/QZi8nRqChN1rC1B4t2gHKxf2udDuI3Qk9g
	Bkibh8jU7T/TJJHn0Bkee4g==
X-Google-Smtp-Source: AGHT+IGApDbbAFIVP4UAhuK4gruOfc1K42rEtfDe0QgRcGiarlFw8FydgN2j9mXLeJC52LhY80Pv6w==
X-Received: by 2002:a05:620a:424e:b0:7c0:c1d0:d0b4 with SMTP id af79cd13be357-7c39c60ea81mr2948041985a.40.1741097216179;
        Tue, 04 Mar 2025 06:06:56 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cca94sm66581446d6.77.2025.03.04.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:06:55 -0800 (PST)
Date: Tue, 04 Mar 2025 09:06:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgzones@googlemail.com>, 
 Serge Hallyn <serge@hallyn.com>, 
 Jan Kara <jack@suse.com>, 
 Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, 
 linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 cocci@inria.fr, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Christian Hopps <chopps@labn.net>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <67c708ff63eac_257ad92942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250302160657.127253-9-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-9-cgoettsche@seltendoof.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 10/11] skbuff: reorder capability check last
Reply-To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2545
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/67c708ff63eac_257ad92942d%40willemb.c.googlers.com.notmuch>

Christian G=C3=B6ttsche wrote:
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> =

> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore=

>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited=

>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit=

>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> =

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Similar to Paolo's response to patch 7: these networking patches
should probably go through net-next.

> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b1c81687e9d8..7ed538e15b56 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1566,7 +1566,7 @@ int mm_account_pinned_pages(struct mmpin *mmp, si=
ze_t size)
>  	unsigned long max_pg, num_pg, new_pg, old_pg, rlim;
>  	struct user_struct *user;
>  =

> -	if (capable(CAP_IPC_LOCK) || !size)
> +	if (!size || capable(CAP_IPC_LOCK))
>  		return 0;

Not sure that this case is relevant:

Unlike most other capable checks, this does not protect a privileged
operation and returns with error for unprivileged users.

It offers a shortcut to privileged users to avoid memory accounting,
but continues in the comon case that the user is not privileged.

So the common case here is to generate denial messages when LSMs are
enabled. size 0 is not likely, so swapping the order is unlikely to
significantly change the number of denial messages.

>  =

>  	rlim =3D rlimit(RLIMIT_MEMLOCK);
> -- =

> 2.47.2
> =



