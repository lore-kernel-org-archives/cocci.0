Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE28C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DBwo+LauXnGw05ArgfTal77e/TD9zdwnZO6VSYh+kKI=;
  b=mC2QezRY4QIbOubKTv+tPN/naGpI0iYHaWZ262MNsueLnWEaY2Jg3Fqi
   4yUZ8ZPtysZk/KUUzGj4FvyWi5/GONskI814hVC8SiPrSRGXmrP+BqUlg
   uzl9qKAKilXDXg6FwGpy09/Ly2r9LsiNUzUDK3IA5trlgizWSAriyLR07
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
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25856079"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 14:00:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A3A94E0048; Sun, 13 Mar 2022 14:00:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E269E0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 14:00:21 +0100 (CET)
IronPort-SDR: T47CgYfz2bT5TAbp5zhDc4a+3DAHotGNw7pyQmoxOe9lZlg+Tc822j8LBID6XdAo+Rg9pGu5sK
 O/Wq3P6bCnOc+SWTpAyAgpE1VpZsRHEtoP51oxX9V5yDR9P1o/G2NdjvMMGspwM0FmWlGsJWYC
 hv1q7SwkDUsdAf1wuODrrPpBkaK4e0EQ2uGIGLWM8HEfQ4mTD4If0iJTJWSoaTBCImQ6Y6AXc1
 IhngVatkozSyKTAiTrH6sW7Qk5IEuPb0FRNNFNoCFnVn7NfIO5BsisZ/s8ROYHuPviyxYJNfOB
 JqgFGFZSNpYTwz8CrCKb+4Xi
X-IPAS-Result: =?us-ascii?q?A0BrBQDn6S1ihwQP49RaHgEBCxIMQIFcgiaBVSsEC0SEV?=
 =?us-ascii?q?JBqMYsjhxaKJ4F7CwEDAQ0+AQIEAQGCEoJ1AoQkAh0HAQQ2BA0BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIDBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLB?=
 =?us-ascii?q?IF0CzQNgjUpAYNkAQICASMdAQERJgEECwsaAiYCAlcGDQgBAReCaYJlAQMNJ?=
 =?us-ascii?q?a4+gTGBAYIIAQEGhEgfLCJSgVsJgRAtjU16JxCBVUSBPAyCQAcwPoRFgxqCZ?=
 =?us-ascii?q?ZcFgTGBam6/JXo0B4ISgTqBQAueCwYULpY6DgaRaZZXpnuBewmBcjMaJIM4T?=
 =?us-ascii?q?gECAQINAQICAwECAQIJAQECjh0MDQmEA4osQDQ4AgYBCgEBAwmFRwEBjRwBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 J7DmfCrQAo=
IronPort-Data: A9a23:4yVJoqinBYxpvYW1ILna4cp1X161cBYKZh0ujC45NGQN5FlHY01je
 htvDWyAOvmJNzH0fo1+aouwoxsPsJGEzd8xHQRtpX83EShjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+JSEYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Npl7I61b1sRLLP2tKc5XUNmTAV4FvJdweqSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUM1bf7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzYUFjGpu3p8XdRrYT
 +QkewhTLwjcXz5OEUo7BIsUnvykukCqJlW0r3rM+PZpujGNpOBr65DpOcXcftiiV8RQlFyR4
 GPA5WXwRB8AXPSUzjGO81q3l+rXlGX6XpgTHfu27JZXbEa7w2sOFFsJWFH9rfTRZlOCt8x3c
 l4R3HYWv7YI2A+PQIPDADm+iyGfh0tJMzZPKNES5AaIw6vSxg+WAGkYUzJMAOAbWN8KqS8Ci
 wfVxIm1bdB7mOLFECLHnluBhW7qYUAowXk+iTgsYSZtDzPLhYY1khvFR8t5eEJepoCrRWioq
 9xmhBI+irQViccN2+CD81nDkVqRSnXhSwko+kPIU2jj4g4RiG+Zi26AuQazARVoddjxory9U
 J4sxZH2AAcmU8jlqcB1aL9RdIxFHt7cWNEmvXZhHoM66xOm8GO5cIZb7VlWfRk1bZ9dImW0O
 x6P6Wu9AaO/2lP1PcebhKruWqwXIVTITouNug38M4YfPMMrHON51HsyNRPPt4wSrKTcufhiZ
 cnCKJjE4YcyUOo+hDuwW+oH17I3jikxrV4/trirpylLJYG2PSbPIZ9caAXmRrlgsMus/VuJm
 /4CaZri40gOCIXWP3iMmaZOfABiBSZgX/je9ZcIHtNv1yI9RQnN/deKneh+E2Gk9owJ/tr1E
 oaVARYJlgCg2SWZdW1nqBlLMdvSYHq2llpjVQREALpi8yFLjV+H4PhNep0pU6Mg8eA/n/d4Q
 +NbKdqNCLJDR22fqTgaaJD8qq1kdQiq3F7fYXD6PWJnJ5MwFRbU/tLEfxf08HdcBCSAtfw4/
 ++q2DTdTMdRXA9lFsvXNKmiwgrp73gQke5/RWXSJdxXdBm++YRmMXKjkfI9Zc0BcE2Ryjyf3
 geQIBEZueiU/95rqoaU3/jcot7wQeVkH0dcE23K1pqMNHHXrji53ItNcOeUZjSDBmn6z6WVY
 7kHxf/LNvBazk1BtJBxEuowwK8zu4nvqrtdwlg2FXnHdQ3yWLZnP2XAwsRF8KFAn+cLtQyzU
 0OJ299bJbTQZJK7SgFMflJ9Y7TRz+wQlxnT8e8xfhfw6hh3y7zbA09cCB+B1X5GJ7xvPYJ5m
 uos5JwM5wqkhkZ4O9qKlHkNpWGLM2BGTKgt8J0XWde5hg0uw1BEQJrdFi6vvMDRMYoRaBFyL
 2/GnrfGipRd2lHGLSg5G0/N6uwB154AjxZHkQ0ZLFOTl9uZ3fI60XW9K9jsoti5E/mG7w5yB
 oSvH0hyOLnI4DpiwsRON4xp98etGzXBknEdCXNQ/IEac6VsfnPAJisxNI5hOWgHpnlEcGEzE
 K6wkQ7YvPWDQC019jQ/UwhpppQPiDC3GhLqwKiaIihOI3X2jfcJTENjiarkZiYL2f8MuXA=
IronPort-HdrOrdr: A9a23:Hn9ceaMHicNTFcBcTuWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25856071"
X-MGA-submission: =?us-ascii?q?MDF3jdzjSqOsZ347XaksAof2Pv0nB9GN6N5n7V?=
 =?us-ascii?q?OqZmlymw6UCXFyP7Eq+acUoB5CA3jbyPAorwcDZfXt0AgJb3yzNT1AyH?=
 =?us-ascii?q?VdUCXPR4hYPycsSWQlCMKX+TiOQCFKlnuGOXKZihNlmhJ6uWo5HxOcYH?=
 =?us-ascii?q?E7qx33QbACfY6S2H9jfbT1yA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 14:00:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647176420;
	bh=DBwo+LauXnGw05ArgfTal77e/TD9zdwnZO6VSYh+kKI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IRwxLhOb7cYr9yL/eGg8YO04Nucr8vfRHuhOTyEiCkk2jX0F04KdEON+1WwyUC+Ur
	 GI4VuNPKtrLwu/4Em5mixEkZgz6g/9Q6L+V0INevbtHt2/k4E/PCsNmlRl3GTlC4EV
	 OC9vooQk2GwZC3hNTN1YGQFXrhuX6dRf829dk1CU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.179.181]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1nt3rh3T1C-00k0D0; Sun, 13
 Mar 2022 14:00:19 +0100
Message-ID: <aee7f53b-63d2-2312-4702-7f65bc43b705@web.de>
Date: Sun, 13 Mar 2022 14:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
 <caf9ec38-c627-711d-885d-b975cc914fca@web.de>
 <alpine.DEB.2.22.394.2203131056330.18925@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203131056330.18925@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y9pY9HEQxSSDYBLqZK0Fa5hTMXLCBVgQjE6N/ZQMel5Hop+aRLf
 JK/tNTkVoTb2YZWg8PB75QCBwoYbKWxxwGyJXhy/cDNYDlQcbU4R8CnToCkewgudgczyBOK
 G11smOL6iA5PE2VwjDYXoc8kyL8jH4QIKAPIcu5OH0IghgiYnIEuc2yxwo77MI77p/IQ0O9
 +6anzgzUGRo2KZ4AEV3MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A6X+Y9vsej0=:yjP5vyazHJMVXXWkzoIQ9k
 F8KgG3hPAVMOIcHWgWoHDdl2hKmymzer+ubRaVWf2i8EvXR/94+hZSIXpU8xLBcaJrDPKOaL/
 os5lG9pucy4w4WJXfaORqZAnIYDVKAYRCNr3pkwRPHxK6ua8ngGwKSpxDFtAms8IxHgAgywQL
 ROJ1o3PPOWDJDTIJ0xZacYx7fzMxgc7Nk28RrUoy55+C6KLS41QeR5FAi3znP8bDCFc442Rn0
 LgkKWzYnpEyJkJ3/lvTfG39tHArX66QBdtcTEW2kA14xLwUGPQN31ygt+g5op0ZO786vw8l0i
 3uOwWtEhVEmbF+dsZq6P8GWA7EWo2L/jOu5Zo/KD/YF8x9nowzTn6W50I/VyGtNcKbBIxDN0l
 uKoNVvLstLjgin2xiFzlAvp+6amSUeTC/gBuuCX9of7bxJKC+0BVEiidsh+Tf+yXkQT6hWm+g
 9+EgvGZszQo52652q0w5mzdyH4i+qeA3HRK6+aaF9f8X59cR/rVecn5N1tZzWrjdNjjCBm41n
 F6SwyEsrPEvXj8JB+KmKc2SbqHfUPW4USIlrmu0SrZZU2UmfMhr0knqCxnbd00SQQ6ze1gojt
 cM8NDlheVBRkMyjhEdS+Rae+rVpCk8zIw07CvNY1xJttJbSO6Ibl1u/mAl809e/r4thCqEGkl
 P+dIb5+w2ylTnRFFZUf2dBnCIYcF29AiIDHLXhKAwxQz05owTOoIEA+dLOD9LqmqNxP1IFkDH
 epPnRyodueqo7zqcWRuO6IjoFoy10ATNMbtZGI/dSCSDyEEJfyOrOi1TGxdsKD7Iu4gwx7YJK
 2XcGUSJ1Z31l1jLZ0HPVN7C4HmCtmehDFUzciUi/EWLQ2/3/BCAUuddsOwEvW36VeFmE8aXck
 nUC286IWLtiiDCPlorNfgYV33YBW/F6+RfvfJiDWmF6F95h5zzMArjJEFdgXaWQYY438z0x0/
 4vELwORWAW/estL5WNUsZXcJluWGvhdkG6+nHHf2wVGPnThVf5WTLAKiBSVSM7Sllrs2LOhUY
 TkQVvnyTNXYD0WjvqPS6+gbJ7o2nNdDOwW23R33HBHdUj44j3RJ6h6UwF7oAy7NARwXaJwAwp
 HNq+1yajsRX+9Q=
Subject: Re: [cocci] Can Coccinelle concatenate or append to existing string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 217
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/aee7f53b-63d2-2312-4702-7f65bc43b705%40web.de>

>> Will another test result for a SmPL script like the following trigger a=
ny further
>> collateral evolution?
>>
>> @addition@
>> @@
>> =C2=A0void f()
>> =C2=A0{
>> =C2=A0foo("foo"
>> +=C2=A0=C2=A0=C2=A0 "_bar"
>> =C2=A0=C2=A0=C2=A0 );
>> =C2=A0}
> Maybe this would be a good thing in principle,


Will the chances grow to improve Coccinelle software components
so that similarly simple source code adjustments will become directly supp=
orted?



> but I don't think it would be the desirable solution in Eric's case.


I am curious how the extended transformation approach will look like.



> He should just use python to construct the string he wants.


Other scripting languages (OCaml for example) can provide further design o=
ptions.



> In that way, the user will better be able to connect the output to the s=
tring
> that is found in the code.


How many development efforts would you like to invest for expressing desir=
able changes
in a succinct way?

Regards,
Markus

