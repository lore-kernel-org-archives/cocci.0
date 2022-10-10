Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F967C433FE
	for <cocci@archiver.kernel.org>; Mon, 10 Oct 2022 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eskVtOgL7bY6QfiMNNhHvyXaWF3azmx3nXsZb/WusTI=;
  b=RwUhdmh0Si70Ygjqhzhuv6zuXp420pxLElMlnaEc8+RpehGXbacd0udR
   0AnblMqNVZT7TYJqR9H/frPYlNVxeoyOtbdKW4aKREXVzIMtMHtvefnq0
   gyqKkcRCdO3wIGOHQsvqxTsSVyczpEvYrIkPtrRzaVFLFpGFiC611cAQx
   c=;
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
X-IronPort-AV: E=Sophos;i="5.95,173,1661810400"; 
   d="scan'208";a="56909874"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Oct 2022 19:45:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DD219E0290; Mon, 10 Oct 2022 19:45:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 849F4E0121
	for <cocci@sympa.inria.fr>; Mon, 10 Oct 2022 19:45:48 +0200 (CEST)
IronPort-SDR: 63445a4c_KvxmyLSnRNKcPVRMqaqe/pDy8lHghtsZMmtxYKrqoWnaD0g
 RkV1CsKVIG7PIuB5kynFoUUDyh96OsOR7E9j8ZA==
X-IPAS-Result: =?us-ascii?q?A0AoAQA9WURjhwMP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YIjgVcuBAtFhE6QZzGEKIcYhyWMLAsBAwENPwECBAEBhQUChHQCHQcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEZCRcHDgULBSKFa?=
 =?us-ascii?q?A2CNSkBg2QBAgIBIx0BAREmAQQLCxoCJgICVwYNCAEBgnmCbQEDDSMHrXWBM?=
 =?us-ascii?q?oEBgggBAQaETh8sIlOBXAmBESwBjzV6JxCBVUSBPIJMBzA+hESDV4JmlG+FU?=
 =?us-ascii?q?yYEDgMZKx1AAgELQjUYAxQDBSEHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGE?=
 =?us-ascii?q?wUCAk00CAQIBCskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTG?=
 =?us-ascii?q?BsZAQUyJw4JIRwKBBoNBQYTAyBvBQo4DygvaSsdGweBDCooFQMEBAMCBhMDI?=
 =?us-ascii?q?AINKTEUBCkTDy0HKXEJAgMiZQUDAwQoLAMJIR8HKCQ8B1g6AQQDAhAiPAYDC?=
 =?us-ascii?q?QMCJFlzAi8RFQUDDRcmCAU3GwQIPAIFBlITAgoSAxIPBidJD0o+OxcInmhWg?=
 =?us-ascii?q?SmiF58XNAeCG4FGgUkMjTWRHQYTLpZoDgaSCpcQp2+BdySBWzMaJIM2TgMZD?=
 =?us-ascii?q?44gGYQMii0/NDsCBgsBAQMJhUcBAYVMAQE?=
IronPort-PHdr: A9a23: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
 XmLxuM=
IronPort-Data: A9a23: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
 D3QFrAc/vR8/32xedsu2w==
IronPort-HdrOrdr: A9a23:3iwHCaMz20Bo1sBcTuWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,173,1661810400"; 
   d="scan'208";a="56909872"
X-MGA-submission: =?us-ascii?q?MDFY/EGQfTpX3NXWXx8gsKIvV6jEXz8hy6gxN3?=
 =?us-ascii?q?t4VjoUksvmnWY5OWJ9LR94wfL+AUEVio7dW0ViVzt4QQSqW/gFxY2EZq?=
 =?us-ascii?q?zCI027+/hjOxQrSn2VVStpMzrYeT/DyKx3zj3TeHzeIQwupS11IDhsAe?=
 =?us-ascii?q?a0kyLQ20wYTh8ENl0t6S3ggA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 19:45:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665423946; bh=OZtDa8ohUVBlsMKiTGLXAh+aXqGrAA4Ebr5Gi/c2ecM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d23994XCWAPcMFPf77qKSzd5OFzAe9k2RPQLzig4evNFAg0x9owZj9cqv/t9s7X6h
	 cKmS0IFNoLkq+XPHWM6oK1E3EM9+WCfFSjqbPuMxQ383qLFzAafkUzespuG5vCnWZz
	 Q0o3yd5mdjuo7MmnTVSzzmVbY6uckSXRXXopNsuxm2aojwZ1o4afFRT3uWJ/zVwB2z
	 AFevzz2nXiCQG8Ih+brj4MofK13nP3NbzA5FghGfOVr+3wEAhFoSBa6DWf3v2mnZJu
	 +Rh0bafiWcyDfEA4s+PBHIPe84g4paqdn8XBYljQvRfb638sCOIQAzCf8h7yajINhJ
	 v90pTvxQQbB4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBVh-1pKqZb2iGL-00f61B; Mon, 10
 Oct 2022 19:45:46 +0200
Message-ID: <5353312a-8d31-b05e-5fb2-a24e00bea389@web.de>
Date: Mon, 10 Oct 2022 19:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com>
 <9c2e72af-e465-aa35-a631-c4f9762143f9@web.de>
 <CAHmME9qUWo2=fpyGdRjO0n4wvm2z=Y2sR8hi57vp8eDrJ4VV_Q@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAHmME9qUWo2=fpyGdRjO0n4wvm2z=Y2sR8hi57vp8eDrJ4VV_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iBbWy/Jk+3ZIunC/8BSN9PiTIBkijHO81IEZDK4pAhk9/R44/b/
 oi1eeU4W10/dGoGlgVpODNxTyK+fj7+0X/ysCScfxMaz6KffuoyoKxpYtgqp8tTyXB1BCdu
 7kaTx+9XZ5y+6t/4wlL4dkLqXgoCjLGeMRr3O3SGViCa/Ttlxt5vQgts+vrDOjrzpfCLMMR
 nlni5yrITnvQakNYjcT9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mEOW+hMgtMQ=:ud0NioB3G5m0VZvDstWIyU
 a7p+oqQ6vXKIzixeL+VW5QobMs/dpaE1dwgTblD+Xgt1LuCVbccXgjQIu0NkBVmqqLlikOE1t
 Iix/Jl8b4WEbNHHzMqaFQDozpRv6LecR1imOrImdmahYv/OvAhag24VqmK1zUJS/on0LB00X6
 fRQR7MjlznMc81zQwMVEhhxtB1bXekAGEYTQ3NFRl47uyQdh/Q/qMuQVVjAeS2JPUTKFS7S5u
 BOIc//+hAtCj/5b14MB+WkyolxE0NsEid6YI8Quulpu+Tu2k9rfb/lWQOszNqAQp2Szlmn6JG
 aCvIFj2ibn/n81369Fcd3qIkvFSlUCwu20VaEEluw8Iu5hvqyYMvFi/x9alLUKXLV+KoreZrO
 HwNQbVDxhcd+Qb07Ads/S+Nq+dt8HPRMfi3+nGli/tfi0TxOxpT0SUiFKrETgpd7mhZg1jA/F
 okXTFHNIl2Wc4f5rIMYp+Ea62YOt/BhNyYzNnqrFGsIVOwVkL75+bWadfvAt4OJhFahF7hroz
 kN2Dz+uBcdBldY4jAwR2GVGwEqdaWxAXyx+9c+D9Xth7mIAebBVyxubZEavLVv5q91oDoNk/O
 +UlBgEG5KViEfsGGVSOPRreH29wgSGh0neb5jXMZQ1Vdy8/7SrUv++vENv57jDzrtugsGo329
 VJ0eqUsVpuDqTlUwgIhmeMOEI0lqP1aDrmbNCd95ng402A2hdYTnbNJWW/N3avn+jrUmb8plM
 s8WONEDZhUfPC6ztI3BpAnjcW8Q2Y3BL8k6v/M+eV8rdjOAkT9e7Ob7VdawecB44FVGTiwAp2
 ihEm/0Mgrx3ESQrDCgxe0Rsjm90jjfsLe4Up86h8jv1tCgQWyq8TZynD8eQFTcs+LHtI7T1CA
 wn02zgm5BdKsZ7Rp73tlQ8Bii1M73JrQ8McBM4PHGHrMwwHZD6tmL9aBLOr78y+yFkldiXFTd
 hMxRDA9gGIwa7OiW4cm0RMnOpADNAgJ14tNl0gOjxS5Y01faZkCt28nKgWN/2dVG1b1vvedrw
 t/mZOfmZQ5nIA9OOxoWzy9+xXsz2uOQI1vjyRnJzzJCRFrfs49yD98WEwUHjB/T0hkXNk/rLG
 e+lm9XFHMY8j/TeSO9lQDSCzbu12wdwsLaO/saXfxwhvHAPdQ8D9651QQF++UvXig/siUebaE
 9bBZM+CKnMgyE5i126iV9NOeKmhow5t4Me4ZJQc5oinhZ2/k57cRHbmsP5dHLd5MpDwKX+Zvw
 aVvFsq7jjwLtF4GlvcPIntUS5Ejjnp+jj6j6lItRSczYy/v8Fu86RtoWnUXO64po2+hck/npx
 xypYIuo3GfRej78c17CSirQmnhxsWPtuKu9fpTvNWPkv7ccog1DveWeP3Ix3xmXmRukhk6ree
 qcdhMm22fQ6QBjbxcInNGr0MmhSHaGqXDsQyPTNUT3INP/pUc/iUVLaNCpoaVN42ghyotBAXO
 NTlV+TutQfUiZN8A6kPMldo40pwfqN2YaCITbQ1o3GEJSNi4EpxArI7JMeJGKKbS17Tujd3Pl
 WTc81RuSofiOGCmM+n+XhuEKlUx/NrVF24yH7Yd7CIfro
Subject: Re: [cocci] Replacement of random functions for Linux
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 644
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/5353312a-8d31-b05e-5fb2-a24e00bea389%40web.de>

>> @replacement1@
>> identifier to_be_replaced =~ "^(?:get_random_(?:int|u32)|prandom_u32)$";
>> u16 target;
>> @@
>>  target =
>> -         to_be_replaced
>> +         get_random_u16
>>           ()
> Any reason why you leave the () on the next line?


Yes, of course.

The parentheses should indicate as another context information
that a macro/function call should be adjusted, shouldn't they?


>> @replacement2@
>> u16 target;
>> @@
>>  target =
>> (
>> -         get_random_int
>> |
>> -         get_random_u32
>> |
>> -         prandom_u32
>> )
>> +         get_random_u16
>>           ()
> Comparing the two, the regex one is definitely easier to write
> multiple rules for.


The application of advanced regular expression can occasionally become
more appealing than other design options for SmPL constraints.

It seems that you do not need to use SmPL inheritance here.


> Is there a difference in speed?


Probably, yes.



> Will the regex one filter --dir,


I suggest to take another look at the documentation for spatch program parameters.



> or do I have to use the latter one for that?

I find your development concern unclear.

Regards,
Markus
