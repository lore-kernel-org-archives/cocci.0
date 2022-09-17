Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9183ECAAD3
	for <cocci@archiver.kernel.org>; Sat, 17 Sep 2022 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=E6lQNbWOmeEFHmQSBb8ZTBHmvS0iKPMY3j/nTJdUQ2s=;
  b=XzqtqMNW3RHFIg1eYvyt5UUr+9d4cqtjVRN45HMsWBpHj8CvI9qYM6DJ
   2Wt4PX3cGR8QmjGo6yUuK2FVrIw3FGkSOC6yFdUB1roQILGb0OHknzz0k
   tQAmGO8v8JIfKkry/B5/7YrIxmAj+a/Co4zvNnhD4iqChmWbFMyj1Fi2g
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,322,1654552800"; 
   d="scan'208";a="53225127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2022 08:40:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 96EDFE019E; Sat, 17 Sep 2022 08:40:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B0DE5E0157
	for <cocci@sympa.inria.fr>; Sat, 17 Sep 2022 08:40:46 +0200 (CEST)
IronPort-SDR: 63256bee_vD/kRjTFxwV3lGgAuR+l3cSJsosPqj88YPyLEVbeh+qvN+j
 kaqNJwqQqvRCLgBrkkL0HnwSkbcIwKIW7+k+qKw==
X-IPAS-Result: =?us-ascii?q?A0CEAAB0ayVjhk7ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIjgVcuBAtFhE6QbimEJocXhySEWodRCwEDAQ0/AQIEAQGEewoCh?=
 =?us-ascii?q?GoCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEXC?=
 =?us-ascii?q?RkHDhAFIoVoDYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnmCb?=
 =?us-ascii?q?QEDDSMHqQ2BMYEBgggBAQaETh8sIlKBXAmBESwBi3uEKCcQgVVEgTwMgnc+h?=
 =?us-ascii?q?F2DPYJmlQeEASYEDgMaKx1BAgELQjUDFQMUAwUkBwMZDyMNDQQWBwwDAwUlA?=
 =?us-ascii?q?wICGwcCAgMCBhMFAgJNOAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEF?=
 =?us-ascii?q?QIQCAIIJhcHExgbGQEFMicQCSEcCgQaDQUGEwMgbwUKOw8oMzU5Kx0bCoEOK?=
 =?us-ascii?q?igVAwQEAwIGEwMDIgIQKjEUBCkTEi0HK3MJAgMiZwUDAwQoLAMJIR8HKCY8B?=
 =?us-ascii?q?1k6AQQDAxAiPQYDCQMCJBNIdwI3ExUFAw0ZJggFIxYeBAg+AgUGwTefBzQHg?=
 =?us-ascii?q?haBQ4FHDJ5LBhMug2QBkwEOBpIJLYcJE49BIKdFgXckgVszGiSDNk4DGQ+OI?=
 =?us-ascii?q?BmEDIotPzQ7AgYLAQEDCYVHAQGFQgEB?=
IronPort-PHdr: A9a23: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
 cXT0r3+InFO/oCMlSPzL9fZIoSLPSh4WSc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3xidoKu6Fzs7A6wf5HhhzvGV7skDUtV00zEX/kB9WHVpmwKj5q
 STdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+VvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,322,1654552800"; 
   d="scan'208";a="53225122"
X-MGA-submission: =?us-ascii?q?MDEg4HU843orMYvPv67+dRK7vcp3Er6T8gTDDQ?=
 =?us-ascii?q?Ou/8J+ROyfb67niM1bA4e1ygNiktHACX7ZMB4zRUcLXj5a+tPkrq/nAK?=
 =?us-ascii?q?T17u2MnmoJMvlP5y1dXfe/lcGL7xzxCLl2QEQRGdJOCqgDTjwlLKAPQK?=
 =?us-ascii?q?66w8jOKKPxSHDsFGDghVeYgA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 08:40:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1663396831; bh=E6lQNbWOmeEFHmQSBb8ZTBHmvS0iKPMY3j/nTJdUQ2s=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=gwZd/+KAJLkGwVRy4MfAz+fAbGLQBAEgJljNLWDJYoowOQ5dY1jpIAA1wl5uB4OFk
	 1HVD3KEZDOX4tXfMY3i3tuitrkGnEpJxrebUi5X3tJhr14wFqVQs9DiT9nXLQ4sLkG
	 OF3K0iZUpJPsVwpJhefeX0BajeRQ0BGSXXdQehWbXR0sNldP4Lr/9SVu4evvA5bwF9
	 dXZhB6aa1nXuYn0MlEcW0WFI5ReQTi/uD09RLqxHIfnfCzMn3D7kDm9U8rZXZBqJaq
	 2ASyxfqyOsoikwZ6XHgvNYTIn0KpTOIAt01/6obp7pSiWRifNDe9F7pBpzdpbqOx0I
	 UqiIzTO1+1Y5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1ov75543tJ-00M6G7; Sat, 17
 Sep 2022 08:40:31 +0200
Message-ID: <fb101290-3ec7-9170-9fec-43e1b5f54c52@web.de>
Date: Sat, 17 Sep 2022 08:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <20220916061923.29759-1-yuancan@huawei.com>
Content-Language: en-GB
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220916061923.29759-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZYKQi3F+RXkbUhgn3+BMzmJ8K1C1rdviT9YG/utj/SC2NV93MWM
 0copNtqDm9Oooc+SQAfMn1qcrX9gIVWSXLTRclVfojc+4YsLX99RfwN5o6g9+A09qj0xQZV
 TaZQc6dRx5oL+HPvUaduIApeYDDOlPABzmBiuk8jr6Hos+TvEp5vErN+DQNGXciVytRdBKL
 +2vpDjFT7Kh2y2fJPEp8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mKlmraVS700=:uaaHnVyXPflKUh4HIOIbMI
 baRLTwDsTf+qZg/KwW3x6php19vvqvYFbkEDU/FS+i8vOK2W59DDcUljOy3PZmBdb2JHjNhtp
 rU1kXJfrslfWfVkY7zZc183mGJhYfm3RH5B4nS1mru+lrHufEbfCoaWiw+1xr2jZoF4NBdMSJ
 VA8uqb51YLQidrjOU5pWu+5PbZ6ZJwzKUGdzQTICRu36tcUXHR0vjdzvVDlDbnkGC4aCqexp1
 UCqzZO55hpljuH+iuSD1IzOQ/LVAAHuTphYx6dedUhpUDI39gwJd9lh4O8rWHz2Rm8xFzP2se
 3coeoEfGodb48sRuj1CeBXPI0DlSsLFDMgV/c/0Cd7AWf7j6IlbM8rrI1AJCqxyqi2I7xLsHB
 hY50MabW0l0myPTd9wTGYjvnB2B5uF3RxX0EtzrotcD+THYM3FfgwWVoF8HyBeVUAi8AdILpz
 PXkkzjY3A3LOiO67OLzMsqlxdGhmiMFL0lSA9sLmGdv95CjDAAs4ik51fVPvP/HT9i4YZIi4U
 YfK3bvsckUJ1cUFYXdJHxdxbji96QhIqm88o5TS7/INK/7EvGp4es8lEcM3ttk0FMTyNSxz9J
 hGOwjNOMR+Tpa6LPeIxwiw8xcDAia6peGbI8DAzklc/LaTY5gzoh21gkSnSPNi9voDv6I+q1a
 Seo21HTWkmyYY73dXFH3Zln0yumh67TsvkPmUjLx1IJgzlZdvbOgeVj7IryCxL+/okHMAfViX
 pt/hL4dL+48Eq8Rvq7GwNRnb2YbQJz5iL/PtiAXwnecWziWvYnVuvKuGsxS3nPa+vTxW8MwNV
 AqS0Wg/6VPREKPJsAQgexrlK2hnAbZG3sbC99GuOCNAZEylBS8exIj6meZTYJMRmeUuJnqg7u
 B6rnU8HH6wgiXGwMlC6co+M4UWbbY1jyArHfVl9CrGzx7sDJ2Hp8hH7mkH1BUy/TASj0piQu7
 a0i20jhUnWIxnO0Xo+irlRWrCcEpsE8SznBoetaCa6It4HwgRLEN+Kj4fyWBQDsTpc24KDjUP
 EwuV/kHKSE48aUItlODsUXmbOgfb3uO+jt9RvQvEL7JFiDbgmBSak6YKqV12uZKO7pPjmzFk6
 e3Kula9wFk/lvDg7uIhjbYfGHSM5hEjlxRA1gNPNvRLPZe2O4ww3RWIM3Gdx+oQneVojqxlVz
 Vx1yJb80iQcAAOpQdkR6XWQNXZ
Subject: Re: [cocci] [PATCH 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 553
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/fb101290-3ec7-9170-9fec-43e1b5f54c52%40web.de>


> Find mutex used without init, and point out the
> place the mutex is allocated.


I find this commit message improvable.


Would you get into the development mood to generalise and extend the source code
search pattern besides proposed adjustments for the handling of spin locks?

How many data structures would need further initialisations after some memory
was allocated?

Regards,
Markus

