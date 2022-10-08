Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42EBC433F5
	for <cocci@archiver.kernel.org>; Sat,  8 Oct 2022 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EPJ46ULcc789XqHG/j1dS2BntWEB6/pvnvg7rY+e59k=;
  b=vc1gM8V8+RB4C6o+6CymWEMArCrSqEe8kpHi/UPBYPUuFMk8tfkBQrri
   zKimtbnTKsU8aGQFpkd9Mn65mtFEkc+jGzxI/+2biej4/2+BOo96iSyDm
   EFLlplCYcmKfIc9tsLKEu5pihawmH/BxXTUTVWIWuH0Pki0Lh+Wi6z0/E
   A=;
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
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56599492"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2022 11:15:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 21529E02A3; Sat,  8 Oct 2022 11:15:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CAEFAE0121
	for <cocci@sympa.inria.fr>; Sat,  8 Oct 2022 11:15:38 +0200 (CEST)
IronPort-SDR: 63413fba_w3aSVDNEwlvjXR/BWH7p9y0vR4+f1LKQ8Y+hxUqkRPTrze1
 9ssDqxG8BxUbU5y90teYTLhE6FAxmcxyCkvckuQ==
X-IPAS-Result: =?us-ascii?q?A0DFAACjPkFjhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIjgVcuBAtFhE6QZzGEKIcYhyWMLAsBAwENPwECBAEBhQUChHQCH?=
 =?us-ascii?q?QcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEZCRcHD?=
 =?us-ascii?q?gULBSKFaA2CNSkBg2QBAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ5gm0BA?=
 =?us-ascii?q?w0jB6smgTKBAYIIAQEGhE4fLCJTgVwJgREsAYtONoMveicQgVVEgTyDAz6IG?=
 =?us-ascii?q?4JmlHGFTCYEDgMZKx1BAgELQjUDFQMUAwUhBwMZDyMNDQQWBwwDAwUlAwICG?=
 =?us-ascii?q?wcCAgMCBhMFAgJNNAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQC?=
 =?us-ascii?q?AIIJhcHExgbGQEFMicOCSEcCgQaDQUGEwMgbwUKOA8oL2krHRsHgQwqKBUDB?=
 =?us-ascii?q?AQDAgYTAyICDSkxFAQpEw8tBylxCQIDImYFAwMEKCwDCSEfBygkPAdYOgEEA?=
 =?us-ascii?q?wIQIj0GAwkDAiJYdgIxERUFAw0ZJggFNxsECDwCBQZTEwIKEgMSDwYnSg9KQ?=
 =?us-ascii?q?D2cI4MXozOfFzQHghuBRoFJDJ5SBhMug2STBA4GkgqXECCnT4F3JIFbMxokg?=
 =?us-ascii?q?zZOAxkPjiAZhAyKLT80OwIGCwEBAwmFRwEBhUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5fbnJ6+rvK0FrMlAmF9uk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56599489"
X-MGA-submission: =?us-ascii?q?MDF84ifJIAGJSeg2W59RcGE7eB37jVf2rGtjxd?=
 =?us-ascii?q?d/IpsX1TFuwOMwd0ZxXc2ROZGc/DFRfY1jaFZ90IHazxKRIqhVc2XZax?=
 =?us-ascii?q?+KDUoOswV7ejG9j+oXCyv88X/F8/ChTDAkRfDm8w+bkX1B+mGFS26MBK?=
 =?us-ascii?q?7yl31UpfWjMENu6WL7KxWDhA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 11:15:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665220537; bh=CrS3/Fm3Qq3bYLAMwWP5aYxEmtPhSjwVcKwh883XxWQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OuiKPPDJe4X9LguzUW7z6lRU0j21ZHB3ufVrSaJmhsvRvPl8niNR3bCs1A9R/xi79
	 VtnYeWtonA4gTVIO0NSm3s03cdNJVbHP8rdJ9Yrq4eNULBpVRtkGaBI66pg98fBmRh
	 0EYmvqe81X9+4m/vZS8rGWpJI/9R0iUOHX+ac2ZV7YoowJmKaMXTDxRoxgGjxufzqU
	 D6u09tD9Fpfo3PkSZLJ/x3cyeK+jh/Qb2wTMWyW8OcT76I5msz3R3CTE9sWJBxEyGw
	 myklJb95FJ/rDhpZCNG3KboiJT++sFDJkFv+1jYcBrHvxbA3WYHMasYVLb4x88mC+m
	 NVSscMhnsOq3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOUtm-1oXmXm3c7i-00PzFZ; Sat, 08
 Oct 2022 11:15:36 +0200
Message-ID: <42b73e8d-15d8-d406-0c0a-49c06c52f74a@web.de>
Date: Sat, 8 Oct 2022 11:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Kees Cook <keescook@chromium.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
 <e7757758-6882-9f3e-749e-276a0e972a5d@web.de>
 <alpine.DEB.2.22.394.2210081059500.3287@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2210081059500.3287@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Vu0eE5e8i1AX+eBHA+OzrN34am2aF4W6NGxIV5FKVIeJIvjWTtN
 5u9/Ij8jGMrGkpJiyml8bboogNRKaaY5gyo2gKGmnPhGLFi198DXtJChX9+s2hxQFIQVOhn
 bft7qKLZ/YEV14vaYDq/DbfxKlxxBWxNubeHkETVPzoVJrcNg0uiDiS6KnWTBthZW38hvw+
 ib23ozJvC/uXxonQqM4lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jeVBduGmziU=:4LlJPlDmLV2IFJhCiUrXcE
 pLqnFX3Howy8aHnuTJFyMzmCHOasDRYtT8IRkegrMTHVHmiVjRH/du6hl3NG5UfF84kfHwK4j
 KD1BduEC0BB7ZYmjkDahkrHhEC1jZzLYYIHaKm8LCP2ZCH9bbONuBOGHzFu+cCuVARsB0ZYkc
 LfOOZg7Am4XI2n43piImwcvPB7W3pBMg0mmzImeMq/BfWS7eSI1iNxUv9EPodsrL37g1w5IlQ
 qTgCfZ9ZErb6Erj30VPT5njkjVDIhe+rEp4fJyIqI7kC5vkK/k5DZiUq9U+qfW9Yeemes+ySq
 sqGg1UCS7Ui8+aBi76QGCs9Fl+VjRHj+MJLcM19WPn5rYgACm78zEH6yTYeRh2vQ/QqSdkeIf
 z2cfQ9iFAZtY6dQ9Pn1Q0jwPnZHdJYNFr2eWtN0Q+j4SJ4jMXG+pgHCPMYwjNIipreJePtAgp
 Ai5f9n5KTehtbIP8is8G3FT56dbsDepRza/V08BPkIjdcXoFplAVsL7P0h2+DOdxTAARZ3dFM
 jbhDffa7r4AaQ7nRdTuH4sQD79vC0QTfa4pND2NWMkOjvfy+7GMke/Kwcndv/5NmjtTOpBBVH
 5FnPc42rBiIX6KaWzWSofgCK8eBT2RaseDcp+1F2MwTvCJ8piMwgwGsiK5SNA9J9cetF+bgWj
 QCIiTad0VY3bgCW1vpE2D/XV5eacHSxMwfhGN/uJDTLSru/8vQ7l2591S5QLZAPOw5ORO6Oyt
 d3KLMGhHr9hDuLVaWhqWCdMM9DTkWxXlxLuUC9dXd6isX+a/mUaRCHx5P9Wx1uAsEr6BkgQHB
 63Dua0hnvTZw44gFPxaIynggvbHBrX+A8Kq8RN79YQkRNVn5A1kUT6ZScPFNYmje5WzTmpBvb
 cPUznVKa7dJFNS6qwYD8WmK5hJQUdD2SHZ34zKXhJNNtQia2xMFAZb4PwlX9qHmXUwQuinUKZ
 /YWNLUTqVY2kpKMQm9XQZVKCAA046vfph9/0WZI3GHCK3u+iWTc7FGa+prMlELFl2nTwhDHfn
 0nwD6EUyDN7T+QPr6BjjxHqJnjyRMcrhpFcSDXDYy+G5zfcJgGrThmsNNkpvDPVBcTNHO5pHr
 YgVjrfU4PRFOkhez91HBIxREszya0JZRqmcXfOkJgwbrWUgMOqhrLe0RRcDm9YTFEdVxO4a55
 gI7lxw5xnIqe5j7Q4N+oHN5BTBDuTCGWbTdr99mKGSbsJR/H6dLm1HfLsXd6pjx+cGbMUUgsh
 6tuWIEw8eXoAVMuyzzgNZENn1Fjtu6DtfKBSIOuCXlTc03Tz2/ZnYFDgv8WIAfPxIuMxGISIV
 komajTP7spEaquiHJNjNg78WVkpdpmbLY2bXMuCvN5rkk5ChFBgmI0tTEDKXBTzwDzwljH30W
 qnR+8pSjIccWMX3Gc15CNX7gSRqHV9O3MwmEcUx4BSOhuYcwTRWbBAlpGeRTzHGzVYrxac0Wn
 uXMXjcI8RrgyD2I8J/1YcECfS2ooogYTJksB3kEuN00eYxA2+I13kcuGWHxWDBRTP4H5IiBQh
 vfRqIU+bokNCW7g80mr2byLFxrndjEy5e6aOmsYyKnffA
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 621
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/42b73e8d-15d8-d406-0c0a-49c06c52f74a%40web.de>

>>> - x = e;
>>>   ... when != x
>>> ? x = e';
>>>
>>> The ? will stop the match if the thing is found,
>>
>> Does such an SmPL code indicate a need for a double check of the affected C source code?
> No idea what the question means.

I guess that another wording variant will help.



> But there should not be any extra overhead for using ?

I imagine that the handling of optional items will trigger special run time
consequences according to such data processing.
The impact can become clearer, can't it?

Regards,
Markus
