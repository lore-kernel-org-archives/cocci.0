Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AF6C19F32
	for <cocci@archiver.kernel.org>; Wed,  5 Mar 2025 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vN9RsOM9w1Ta2OcodrGTCSnu8bj52DWvF1ogcLjUyJM=;
  b=K9SNibktEex9YPk8eZrUOe951Y4Z8EO0tmGNhmZBIa6k418hUEVV9u9d
   erhTBvjH5TIgxK4EsS5toOCZIO8uhcdUe3utVNiNU7y/rVWIiThTaBCCq
   kXiVOQHU5X+oK6Fc/n1ArXSAKirBGdyKO/se6EpbqYLDHkQc/8GBOuaBB
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="211318106"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2025 13:15:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 364F7E0D1D; Wed,  5 Mar 2025 13:15:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BF592E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 13:15:32 +0100 (CET)
IronPort-SDR: 67c84061_i/1NBVSM3+nju1E3mIOh3Rc8cYm3VHocPz848avR5/d7qxX
 ro2ms1/fEwSLO4UVpL7JreGc80GvPye/+p+TeDQ==
X-IPAS-Result: =?us-ascii?q?A0EzBgDzP8hng07ASNlaHgEBCxIMQIQXYhtaMwQLSIQaP?=
 =?us-ascii?q?I9PgXQwhDuPCwOEb4QGg1QPAQMBDTkIAQIEAQEDBIR2BgICAosWAh4HAQRHA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQE6Bw47hXsNgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CDTpEAQEBAgEMFx0BAREmAQQLCQIaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ+AYIvAQMOIwcNkmmcRYEygQGCDAEBBtpcHywiV4FlAwaBGoYagmMBh?=
 =?us-ascii?q?VIZO4NCeicPgVVEgTwLgkcxPoJhBYFdg1uCaYIzhEBnmgaOXFJ7HANZLAFVE?=
 =?us-ascii?q?xcLBwWBKRAzAyAKNBQdAhQNDxAGEARqBTQKNzqCC2lJOgINAjWCHiRYgitqB?=
 =?us-ascii?q?AWBJII3hD2EQoI/UYJCghFxbwMDFg8Bgx93HINMdzuEch1AAgELbT03BgMLG?=
 =?us-ascii?q?wY9oW07hEOBOZkKr1M0B4I4gWaBYwyKKZU1BhMvg3ABk1UOBpJ9LphQIo1jm?=
 =?us-ascii?q?y6CIYFcMxokgzZPAxkPjiEZH4NCM8gmQjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 /ogxLTlMcIMO4e910EwMjFH
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qFe5R63GV3+xmTft5GU/BwqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:bfQjiWCN3zF+F6X6Eyh6qXZLFOIMSWPc0mv3JGOKFj83T5TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AV2Ty6g5TpJ2ceOSpCgUZXRkGxoxU6paEB18dj68?=
 =?us-ascii?q?p+OSOJDNaAzabgGueF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="110727555"
X-MGA-submission: =?us-ascii?q?MDHZwZkiVglfONbo4NOy890bA1I1/6Cku3s2o7?=
 =?us-ascii?q?uWddAP0k+UUyVE3s9eE7RGmpA8Jk40FqNZF60XuuUV06ljm/Z3TlDaBS?=
 =?us-ascii?q?e/qItanQIJG1f8ff6IH94T3t3ee3ag+1nHQSm4cWJgz2K9cQLc/US8Gk?=
 =?us-ascii?q?v4mBGb0V5AbtB944irTj7QOA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:15:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741176875; x=1741781675; i=markus.elfring@web.de;
	bh=vN9RsOM9w1Ta2OcodrGTCSnu8bj52DWvF1ogcLjUyJM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qVwJPx/y4WCQsTW5x9jGetYyVflxE8dsDy1VFIlVZCLlNM2xXX/BSXqg/LwMt3Cy
	 nxwR0GtcxRhljx5e/DmXH4ErVg5D4LzqfbYp4dVQGlqdaG49x2hQH0IIgzkpEKPbN
	 0ucGZqbExRMcMxdvEdoFCSrB4Z+MvthP0C+WVk0QS3xAwqqS6RbpA9BuPDagJhpvo
	 srIKnZV3HX1XsFqpMEJwZRWLC+1HpDxPbgF8HUXbia4ISXOZ55shnxUSqYJVxATZK
	 5jwoCDVvOO3lJSiQsPx5r/ab1WOIIRvjqFvW/sP3v88rgWnNsYYjBLEOa+yqc7U7R
	 njq4LhSB6ZMWWcobdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOQy-1tauUT2X3i-00Q3r9; Wed, 05
 Mar 2025 13:14:35 +0100
Message-ID: <9d042e6a-6d93-4ae4-8373-28b9dec21867@web.de>
Date: Wed, 5 Mar 2025 13:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
 <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xz927XuN+dy2MzwEWFmWxNyf3scK2QK3WwvGUP6+iFc0rGUk62+
 4cBG06YgVkrsQSP7oz2GxkjorzrbEe/+yD99qrKbbrN6r4/IGiNzM2c5QFhdv+Ly1HpAoFV
 o8rtyc4teA7X4Je6sy9ECjv9ObROXAcJv55ghu0oB33hD2tbtVundyy1MzNHWooMwFEFZu5
 CmnGqxkaNfAKVHRpzUZuw==
UI-OutboundReport: notjunk:1;M01:P0:Oy7sG1MKKpI=;JNu2zC9KnC1wTlorr60/eeRODji
 Twvn6Tjrl4ER+r2013vtqMYFWVlvLZXzO0mFQHQfyjI9f6lVP6Gkb0dLwr61wUah9a+fRo6KF
 CQH9f+WuwktSsLCezC9KSIWt74cIqVMecpXzmTKQwf/HAspIHRV67TvuuE8jN0uZbKAeej/+z
 k4vozN3jP6fBUz+KgntPvDueV642U0/djQnAPKVUxRPWpMHdK+iS4L72u9HelQbvCxPZGduYS
 DMiJm+a4CIayWj6kwQEhCWadgxOZdll4RinYa27znlaEcYEZhNvl8oOC1V5Q517Jw/bKLphRd
 +iT9jjowUhXdNe1gpaW9LU7bqar9wue49Ds9Sw5OKluJ/tYI9SaYKU81NHmY3gTNw9Hii6wyM
 uHWLZezEF7LLauwnwW2fiDGMbOZVs7AWkXI3eKgEzUmjPQiMFoFGMAxrJ8LgonMePMEFcvimL
 BMD1Lr5JU76qouQy+9tvXN0+36/YUfuV64mBzT/9eSXhTyovsnKWwkLKZ7pLlVM8xO7W7eWMP
 SZAe5k1CjHH1KvCkOa0aq+P3inEo8GOAYh6Z6KbdKIL5UAu+CIMV7Qt/cjMhfYY0rvttdZtn8
 yeTlgCEntMkGug43gsgV88lWouf3iUhKA+wZssgGAqT5yiVhkgtslUVpE7PtNRTnXuRv0g0rM
 9UH6blSj67Wgh20slE8jaiZ4ozl3VWHwsEZTWyk3c8W+8gFvHwEmjdNMgVFcTPUtPuz3tu057
 +5tw+5H9JRqiXJeakXtbLCJz3opmeQUVgrMz+z+rsnf3jcHsob+HvlJaED1oQJWmRIHPrtldJ
 fQpHfNld4/1kM768BP6JxshhNTUuzTyH26YvOsq3JACnjh18PIJ3hgJokME8yKdO0uy0ydRDZ
 iedtvaJbEHRvGO0k/ga/jzyvKYLF3VOi8U1jhdFHNW47e6v7MCZriGhwXBDKYDs2q7diyist2
 DaP2oQT7wTnUjfbVM6sS4dLuwe5c85UEGEIfAUkaqb5OeDfiaKN/jjtvEsDqUSdSdm2i67jrZ
 emCa0gwpvqExfAQCAGwzEcI/vKhxwRHKW9wITHzXDovhJ1afLYCrKJL/gY/F0qwXpUeL06uCp
 jBRSfztoSNVtpM/ZxewybtJ+BJLELgDrcoVKEUc6s0Gh+sG2kOQVGIGrJpBhvS7i71OkoSwmm
 w2Mj2QTs7Y0r+eeSgAG3z5gU0ADZ4FK1GtsYOfYPsq+l0JbdSGB3V7YX46ohLp/iZ/Wmc5yjC
 ioOqMs9hXgm54NBaTOhHJLsdfQv47MIeeggCLQhAksjnD+cdktcyyuxsihlgQojf5WVDA8t8p
 9y3ySv28w/BgaIcb3Lk9AjaaOS2WfPOPncDshEqdi8aGl0mkGlMEZPOQt89zDDKoem1d8pPmw
 hha8NFd33dxZva4qDJ89SwxdbrRz7LCZ4GNmUvBeVUoCbjzMLtw2VdQRPcstdxL6r7GtUoSLr
 t4QRoLg==
Subject: Re: [cocci] video: au1100fb: Move a variable assignment behind a
 null pointer check in au1100fb_setmode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2541
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/9d042e6a-6d93-4ae4-8373-28b9dec21867%40web.de>

> Anyway, none of that applies here, because this is just pointer math.
Which data processing do you expect to be generally supported at the discu=
ssed
source code place (according to the rules of the programming language =E2=
=80=9CC=E2=80=9D)?
https://en.cppreference.com/w/c/language/behavior

Regards,
Markus
