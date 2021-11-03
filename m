Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43632C433EF
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 12:27:49 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6900E61076
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 12:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6900E61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1802290"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 13:27:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6036CE006A; Wed,  3 Nov 2021 13:27:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC729E004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 13:27:44 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AYzumtRHgTz6ZTV81/8Gzf51Gf7VMhN3EVzX9CrI?=
 =?us-ascii?q?Zgr5DOp6u447ldBSGo6k31RmRBM6CsagMy7KP9fy6ASpYudfJmUtBWaQEbwUCh?=
 =?us-ascii?q?8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV?=
 =?us-ascii?q?6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+Mgi6oR/NusULjoduN7g9xgXUqXdMZ?=
 =?us-ascii?q?+ha2HlkKF2Nkxrg/Mu84IJv/yFNsP896sBMVrn3cb4lRrJCFjQmNG415MzvtRb?=
 =?us-ascii?q?dSAaE+2URXGYLnBdWGgbJ9B71UIv/vSv8rep9xTKVPdbqQrAuWDSt9LlkRRn1g?=
 =?us-ascii?q?yoaLTE58WXXisttjKJHpR+quhJyz5LIbIyTKfFzZb3Wc88ESmVdX8ZRTy1BDZ2?=
 =?us-ascii?q?6b4sTFOoKIOJUo5Dgq1cSsReyAA+hD/7txDBVnH/7xa403eouHg7IwQIuAdwOv?=
 =?us-ascii?q?nTWo9rpO6kfSvy1zLDSwDnfc/9b1zXw5Y7VeR4hu/GMWrdwfNLWx0Y1DQPFjUi?=
 =?us-ascii?q?QqZf4ND2a0uQNvXKb7+tmVeKglmUqrAZ/rSK1xscvl4nJnZgZxF/A9SV32oY1J?=
 =?us-ascii?q?Nu4SEFgbN+qDpRfrDuWOJZoTc47RWxjpSk1xKEct5GhYCgK1IooxwTZa/GffIW?=
 =?us-ascii?q?F/x3uWeWTLDtlmn9rd6yyihas/EWu1OHxWMi53EpJoydLj9XAqm4A2RPT58SaT?=
 =?us-ascii?q?vZw/Fus1zaS2w3T5OxJL0Y5nrfYJZ452rM8iIcfvEbZEiL0hkn6lrKae0E69uS?=
 =?us-ascii?q?y6enqYa3qq5uSOoNulw3zPKojltaiDegkLAQCRXaX9OS62bb+50P2Wq9Kgeczk?=
 =?us-ascii?q?qTBsJDVO8AbpqmhDg9Q1YYj9gq/Ay2o0dsGhnYLNk9Kdwyfg4joPVHBPuz4AO+?=
 =?us-ascii?q?hj1ixkjpn3fLLMqP7DpnQKnXPjq3tcLR+5kJEzQo819Ff55ZaCrEbJ/LzX1f8u?=
 =?us-ascii?q?tvCAR8jMAy03v3nBM9y2IMaV2KPGK6ZMKXdsVKT6OMgPfKDaJUItznjM/Ql/eL?=
 =?us-ascii?q?hjWclmV8BeqmkxYcYaHekEft6IkWUemHsg9cEEWcSpAUyVu3qiFuYUT5SfXm+R?=
 =?us-ascii?q?aw85isjAoK8EYjDXpytgKCG3CqjGp1ZfG5HBUqIEXfsbIiFWvYMaCeJLc97iDM?=
 =?us-ascii?q?IT7mhS4k71RGvrgD20bRnLvCHshEf4LD+0Nl8r8naihg28XQgDdmZ0mjLS2hrl?=
 =?us-ascii?q?2cMbz4wxqF250JnnASty6991tlRD99O/LtkVgkgNJjTh7hfAsrxRxmHU9OHUle?=
 =?us-ascii?q?gTf25DDt3Qt9nkIxGWFp0B9j31kOL5CGtGbJA0uXTXPTcF4rD0nK3K8svkx4uO?=
 =?us-ascii?q?4E+glNgTsYdbAVOZ4Z68BXPQZHEmQOVmvTyHZk=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3Afi5Ojqw/gvm1chuWZFV6t+dixyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDMm1GBVmGpNCj+ObPrZZDGkc4hzPIS+8EJQscfXydIxOVdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OlULW?=
 =?us-ascii?q?cYEideCc9IMsfoUI78wIGqtUw6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kurP8b1FMXbPYewSD4pZUc/L73V4d/Gprg/x9a6p0hUR/011lm/hUwc9OqIf2Z?=
 =?us-ascii?q?AMnJKzKl8wCXhMeHywW0ahuoe+feyLj4aR/yGWfLieymqwwZK0sBqUT/e18AEl?=
 =?us-ascii?q?V5PkAIXYMaAqCjqS42tqTTuBzj8AnBNvqOYkFszdhyyvYBLAoW/j+rw/i8YcNh?=
 =?us-ascii?q?3FtkpkbRbCGc5BMMXw1MUqed0YaYhFKHM1rtfmMrXzZXz18iVuzmbAR9zGLmVQ?=
 =?us-ascii?q?1iKyF3MH9f9uXWYNKk0zeqm+uwogwOTlCXPT39NZP2inEai7zcSLHtEY6Ebql6?=
 =?us-ascii?q?rh1jVfVymF75Ng+PbekiaHRt6J8c4s3x48oFu4GsqU4skCmJjU4dwPtu2aK53b?=
 =?us-ascii?q?wRPIJe9DXK2ixJm78/AuTQGQJJtKEQLTKq+duLQEXOpS1cx8FyNChXHB5iZ5Qy?=
 =?us-ascii?q?1tMkQ6PBA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgLpLnaNWxuzuH8BcTuWjsMiBIKoaSvp037Dk?=
 =?us-ascii?q?7TEVdfUnSL36qynIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21?=
 =?us-ascii?q?HHEGgB1+ffKlTbckWSygce79YFT0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArl?=
 =?us-ascii?q?vg1QpTgBUdAc0+/zZzzwLnFL?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DMBQD3f4Jhh07ASNlaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgVkCg3Y6MYRHiCWGR4F3MYsIhweKFoF7CwEDAQ0SASsBAgQBAYI?=
 =?us-ascii?q?NgnUCglMCHQcBBDgCDQECBBUBAQUBAQECAQMDBAETAQEBDA0OCDokhWgNgjUpA?=
 =?us-ascii?q?YNkAQICASMVCAEBESYBBAsLGgImAgJXBg0IAQGCbYJVAQMOJa1BgTGBAYIIAQE?=
 =?us-ascii?q?GhEcfLCJRgVoJgRAqAY0ceicQgVVEgTwMgkcwPoRFgxiCZdEpMweCC4EsgTkLn?=
 =?us-ascii?q?SAGFC2VZA4GkTCWDqYqgg+BZjMaJIM4URkPjiAZhAyKLEAzOAIGAQoBAQMJhUc?=
 =?us-ascii?q?BAYtiAQE?=
X-IPAS-Result: =?us-ascii?q?A0DMBQD3f4Jhh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAgVk?=
 =?us-ascii?q?Cg3Y6MYRHiCWGR4F3MYsIhweKFoF7CwEDAQ0SASsBAgQBAYINgnUCglMCHQcBB?=
 =?us-ascii?q?DgCDQECBBUBAQUBAQECAQMDBAETAQEBDA0OCDokhWgNgjUpAYNkAQICASMVCAE?=
 =?us-ascii?q?BESYBBAsLGgImAgJXBg0IAQGCbYJVAQMOJa1BgTGBAYIIAQEGhEcfLCJRgVoJg?=
 =?us-ascii?q?RAqAY0ceicQgVVEgTwMgkcwPoRFgxiCZdEpMweCC4EsgTkLnSAGFC2VZA4GkTC?=
 =?us-ascii?q?WDqYqgg+BZjMaJIM4URkPjiAZhAyKLEAzOAIGAQoBAQMJhUcBAYtiAQE?=
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1802248"
X-MGA-submission: =?us-ascii?q?MDF0WELfsdk6Wvd4Nbw1cNvSAIlPin9zi4bX1G?=
 =?us-ascii?q?bsKLPseKftqdduAwCIGD8+lpj++rfxE5295bnE8sseJYiHo3q9QCmkrM?=
 =?us-ascii?q?JtRwYbzkM/J0tS36ptKNZwqjkMVzuymDpsQYnCH5+uvFt4yAkLNKfXmv?=
 =?us-ascii?q?QvPa+eabIy6Cf17pzOBOm2GA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 13:27:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1635942442;
	bh=WYp0MfRP83Mm+pJZpaflgdhFqj3lObFdxx5hGKlHfZ4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fTN5lLQrsXUpNkboda9OlaiKkITNFLh8NmtSLfvpOLxF2cDAay9B7JsAODaN548w2
	 ExmJ06F05fOJqISSqpo78YWDLelwOQXIXwAocYmOKuLooLwu31P0LF4hGeucVeHja+
	 xhiyoj4DLw0uJCXrjMct6t9wpB21PTptCkoYq1tw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.102.25]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLc6-1m8Me02A9y-00ZvnX; Wed, 03
 Nov 2021 13:27:22 +0100
Message-ID: <e7ffb768-0e18-d3c3-0727-e5328564d537@web.de>
Date: Wed, 3 Nov 2021 13:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <b2aa6f7a-2169-143c-59c4-bab1830126bf@web.de>
 <40d3e13c-0b1c-cf12-efd9-007532039d72@web.de>
 <alpine.DEB.2.22.394.2111031256000.3289@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2111031256000.3289@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ypVPtnLWWakyU+jjI/EybusDT549pawHYO4Rgg6AZBNRm/7ul7l
 RyYdt25Fs2KlZWfEViVFlr9AWdz9sJpIJACkzeQX/DwRXbcIob0B1ZtHRakNBJSs6DVg7Vx
 yhPs+RYYAtP0lliCLgov0GqdMsw5w4jjk5w4gr/3pMzUK09QwM+G9R5N1B41O9foK2o4qnM
 f43Jl7twS6wkG8VGzjk3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ds3xJgiJ7Pc=:hbs3L4t/eKqoO1m4tQJGIF
 eQXbQRgz331J83QYN64eF+IwphobJGoxu+2XaOA/GvbWmE/lPW/KgR33ME11AiFC8uHjerUW9
 iG/RLRackbOekrJ+hRQSAuyekbxe+WZrRbpmM8rUKtqvxjWvKr/c9GIwbGf2lXw8D455+SeYO
 OuaEUyYDyAq0aTG/R/a1SYeOlbe2IkI6m3XSao6kWFdi7dHcmUQxX8OWtTmH1xvQAvbZtj8o7
 E4LykmMYT/JEYuG1LG4LrcZQfrazpiiaseD96JpQe1mlmAk3iSXQXxMAgfcJZ++2oc4fXYbba
 E5cQshDdRfHi22VPqByeJ0GFdzoycs7fsYJmxiOUEpxZ/mzIO7ZQM1yN+ned1J8c9SafDmHbj
 wLWT3b5trj7f14AYnMsh5wp+G73+mFj/HC1G1pC759SZtb1z+BPXsYUW2kqHF+xqVlfGhFXSq
 dChc8jzlYzQRAq42qRqg6Hes1LWIkqVpzl1H34ie21Ig6BaXjZWJe4XWDt6sNCn0qWss4KMgd
 BJ4CCeUDrt2zS3c5UmntRhZwH7ihDALh5nq/9Un/Gcp5BGrFPZSfzWkKMlGfJg2//2z3Y3X4o
 AWkC7TZ4WM8H3MBl8gmCW7NfeluCAVNYCi3KiIULP8OuEPa2uidzbK0tdOuMStWYZ/nWRw2/Q
 4wYrMg6WxuLi130A258PHQ8OFi/ynvV7Fh2bf4zPgksBrcczBEC3Yt8nOhz9F9unMFNHum1o7
 xnT+5SqjMTA3+KdSDvv7vneZC59uhZjRmnT4JdP2mU3lGcVSzs3rziE3Btz6OYNQgVqR84r1y
 TXhxIuXcU3HJdMnEPGDZC4w0UiONLIhOGiJYZliQR1qOtyNXtq7XSs6tHGlHmJAMhGclk6Rkv
 MQxV1c1/oZpopsak2BYYHEI14XTm2Q52iSN5zEPORpWl3X2iGnqMPlgvO+65Fg7FmoUT0cx09
 qlI+AgscupmS0TxZ1Z934GU64SFB9CZXHPSIke/oUTU9lFs/qoJFULQ6c6+oNgpPQu35oJU83
 WOhjxt1pOtIEOFdBae8niDie0fSor6tjkAjiEdUkJV81YtTN6fP9MDI+vd+1XtaxBj5Q5ncIh
 llAAaTsCSTZBng=
Subject: Re: [cocci] Checking parts of binary computations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 61
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/e7ffb768-0e18-d3c3-0727-e5328564d537%40web.de>

>> Source code places should be found then where one binary operator is ap=
plied
>> at least for computations so that their values will be stored somewhere=
.
>> But I guess that it is unclear then how many code would be matched by
>> the metavariable =E2=80=9Cleft_ex=E2=80=9D (and/or =E2=80=9Crigth_ex=E2=
=80=9D).
>> Is such a system detail improvable anyhow?
>
> Coccinelle parses the code according to the standard precedence rules.
> So there is no ambiguity.

Will such information become relevant for another extension to
the software documentation?


> bo will match whatever is at the root of the parse tree.

I find such feedback also improvable.

I imagine that a parse tree root can be different from the node
which represents a binary computation.

Regards,
Markus
