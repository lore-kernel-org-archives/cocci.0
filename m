Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A793EC433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=t5/RxYpwLmosEE77pzQYYSBrRUoAHhXPsmHozjrf3T0=;
  b=Qyr4V4t8bm5T3nJdUJiiH89EqCErIlwtsSA9KNkhzPzen/OyWC5WmUpL
   tu1tTZbkH6CdxvRovaAwgzAiu1FKLk8tB/z20Asa5kbyaina7Vfbt0BK9
   xpIWWoKQGrv+uKzICakdSDK5I88egbJIA29ej7so8sjq8t+LArZBVk9Tf
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27014795"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 18:00:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 94117E020F; Sat, 19 Mar 2022 18:00:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C2B85E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 18:00:43 +0100 (CET)
IronPort-SDR: jB97mdlN/Z+62b052lh7r25ZRy9uJyFYlhpohDDlsqbkPgncbutsWwjPe8TmnRQZtEf2Jlsz0u
 g96vwyv6lnsM4QMNLjwOlw8YmwFAqBk4kArAyX7kCJFlgTAW9qlPVkZpaY0Y8mIl5mnBt9Iya0
 +mOHUaakYKc1AWOpDu+jdmB9jDxEGm7R1dUa/ppbru75mnYRxC5LSB2my0mALGDaYzRU4eeZHK
 r8MCzUhvCIw5dDmXjvhgmdieK0bjm/T3yQWlycis97XcMiPWxfMvND2R1hMifFCnpaPBd1aqhh
 IZ/HqflG0HjYaAaJ9lEXCSVe
X-IPAS-Result: =?us-ascii?q?A0BkBQD0CzZi/0Xcza1aHgEBCxIMQIQCB4FNAQEBKQQLl?=
 =?us-ascii?q?AuBdy4Dnl8LAQMBDUEEAQGCEoJ1AoQ0Ah0GBjQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBgQgsAWMBZwGBTgGBeQYEPYI1KQGDYwEBAQECATo/E?=
 =?us-ascii?q?AsYLlcGgxeCdiGtAniBM4EBiXuBPI5JJxxAgU2BPIMDPopEBJkKX1FpRaJun?=
 =?us-ascii?q?haDU59eBhQulkmRdZZbpwKBPzklgVkfFBoIJgqDJU0BAgECAQwBAgIBAgECA?=
 =?us-ascii?q?QIBCAEBAgGdDCEBAQFpAgYLAQEDCY9OAQE?=
IronPort-PHdr: A9a23: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
 V6m
IronPort-Data: A9a23:kWNax6L4u/NVdc8/FE+R6pMlxSXFcZb7ZxGr2PjKsXjdYENS3zRWm
 2JJDGGOPP3YajCgf95+ad6x9kxX75DczIJjTlQd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFrc4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhuf9r0
 99I64WLeDgAYeqSiMsZdiBhKnQrVUFG0OevzXmXtNzVwlLGfnbozu8oCkwqVWEa0r8oWicUr
 aFecmpVKE7S7w616OrTpu1EjcMoJ8jDOIIEpmomwC7ZAPsiTIqFRajWjTNd9G1v3pkSQqeED
 yYfQXl2TwzGMz0QBnkOLqoOx96No1ivWTIN/Tp5ooJsvzaInVMhuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrS3zTOa+3aorv3OmCnhUcQTEqe5/7hkmjWuKnc7DQ1QWES7rPS9h1T4Xd9DQ
 6AJxsYwhY4d7lehS4fkZCyHiSHD4A4zX/9pKtRvvWlh1ZHoywqeA2EFSBtIZ9onqNI6SFQW6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFb7zg8L1FDz0z
 irMqiUi71nysSLp//7rlbwkq2jwznQscuLTzl+PNo5CxlonDLNJn6TytTDmAQ9ode50jjCp5
 RDoYfS24uEUFo2qnyeQWugLF7zBz6/bbGKB3wY+TsJxrGXFF5ufkWZ4u20WyKBBaZlsRNMUS
 BWO52u9GrcMVJdVUUOHS9ntVZ97kviI+SXNW+/UY9dKb4JwcgTCpHgGWKJj9zuFraXt+IlhU
 aqmnTGEVi9LV/44kGLoG4/wE9YDn0gD+I8afrijpzzP7FZUTCX9pW4tPATcY+YnwrmDpQmJo
 d9TO9HTm0dbUfbieW/a7o4eIFQHNz49CIyv855bceuKIwxHHmA9CqaLneh7I9E8w/1YxrXS4
 3Wwek5E016h13fJHgW9dSwxYr3YW5si/2kwOjYhPAv21iF7M5qv9qoWa7A+YaIjqL541fdxQ
 vRcI5eAD/1DRy7p4TMYaZWh/oVueA7y1VCKPjG5e34yYJ5tSgjE4Jnicxe2rHsCCS++tM0fp
 by811qBHcFZH1k7UJ/bMav9wUmwsH4RnPNJc3HJetQDKl/x9IVKKjDqiqFlKc87KSLcmmmQ2
 TGQDEpKvuLKuYI0rYfE3PjWs4ezHuJiNUNGBG2Hv62uPCzX82f/k49NVOGEIWLUWG/uofjwY
 PUTwu78PfADkUwMtYdgSu45waU77trphrlb0gU9RimQNQz2U+85LynUx9RLu41M2qRd51m8V
 HWPzcYGa7+HD8XoTQwKLw0/Y+Xei/xNwmvO7e44KVnR7TNs+ObVSl1bOhSB1H5HIL1uPN93y
 OstopdLuQmvzBc1MtuLii1OsWKBMiVYAakgs5gbBq7tixYqkwseOsaEV3aquZzfOc9RNkQKI
 yOPgPSQjbprxn3dLyg5G0/L0LcPnp8Joh1LkQEPfgzbhtrfi/Yr9xRN6jBrHB9NxxBK3u8b1
 rKH7KGpyXFiPguEhfSvm0ipC0dMGx2U90j80R0PmXGxo4xEkIDSBDVVBApP1BlxH6Fgkvxz+
 LCD1H2jXCnqccz10zF0X0N5wxAmoRqd6SWa8P1K3K25810SZTv+nrToaHUIphbjDNl3gkDbz
 QWvECCcdoWjXRMtT2YH50V2GFjepN1o5ICPfB25wJ40IA==
IronPort-HdrOrdr: A9a23:Svr8DaFmXDtX9GenpLqE7MeALOsnbusQ8zAXPiFKOGVomq7xra
 +TdZsguyMc5AxxZJhko6HkBEDiewK7yXcW2/h0AV7KZmCP0wbFEGgh1/qE/9SKIVydygcy78
 ddmndFYuHYB1ISt7eY3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27014792"
X-MGA-submission: =?us-ascii?q?MDGIU7cebwI9t7WywazQQMTd/Gm4kM3ZG9h1e5?=
 =?us-ascii?q?IqCR2yMmjYIzVi1qTz3jszS6uvUI0QrAvo4g6K7ge5BvYz3qwAlA+Bev?=
 =?us-ascii?q?auwfg/E4MWPqvsIkumnC2Kfs5fXBOVDV9Rhvy8N6gzVUhD9xufbJjbB+?=
 =?us-ascii?q?IEaOvlk5qYGup6suFcZhIL4w=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 18:00:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 5A27881;
	Sat, 19 Mar 2022 10:00:38 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5RHsneTAiVSd; Sat, 19 Mar 2022 10:00:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 4290C40;
	Sat, 19 Mar 2022 10:00:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 4290C40
Date: Sat, 19 Mar 2022 10:00:35 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <66b66e5a-c024-7d0b-c84c-d780d5ce41f6@web.de>
Message-ID: <6a41b56e-84bb-ead8-87c3-6d2d4421df7c@ewheeler.net>
References: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net> <alpine.DEB.2.22.394.2203190922070.3204@hadrien> <66b66e5a-c024-7d0b-c84c-d780d5ce41f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Bug with '*' to display a match on the subsequent rule.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 246
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/6a41b56e-84bb-ead8-87c3-6d2d4421df7c%40ewheeler.net>

On Sat, 19 Mar 2022, Markus Elfring wrote: 
> > You can't mix * and + in a single semantic patch.  The patch you get would
> > be strange.  There would be a + for the code that you want to add and a -
> > for the code that you want to highlight.
> 
> 
> How do you think to provide a better error message from the Coccinelle software
> for a questionable mixture of SmPL data processing indicators?

Its true, that would be nice.  I spent 20 minutes trying to figure out 
what I had wrong with my SmPL.  I had added the * for debugging and forgot 
about it.  After reducing it down to nothing it became clear that '*' was 
the issue.

A friendly error like "You can't mix * and + in a single semantic patch.  
The patch you get would be strange" would be useful ;)

--
Eric Wheeler



> 
> Regards,
> Markus
> 
> 
